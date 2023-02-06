## DartVCR: A powerful, feature-packed HTTP VCR for Dart and Flutter

While writing the test suite for the [EasyPost SDK for Dart](https://pub.dev/packages/easypost), I realized I needed a
way to record and replay HTTP requests to avoid spamming the EasyPost API with test-mode HTTP requests.

After a quick Google search, I was surprised to see that there wasn't already a go-to HTTP VCR for Dart.
There's [a few](https://pub.dev/packages?q=vcr), but they all were either hyper-specific to a particular API or
framework, or too bare-bones to be useful. There wasn't an equivalent
to [VCR for Ruby](https://github.com/vcr/vcr), [VCR.py for Python](https://vcrpy.readthedocs.io/en/latest/usage.html)
or [Polly.js for Node](https://netflix.github.io/pollyjs/#/).

So, I took it upon myself to create one. I call it [DartVCR](https://pub.dev/packages/dartvcr).

## What is a VCR?

Most are probably familiar with a physical VCR, allowing you to record and replay video. A VCR for programming is a
similar concept, allowing you to record and replay HTTP requests.

My co-worker at
EasyPost [wrote a great blog post](https://www.easypost.com/blog/2022-10-04-vcr-the-must-have-companion-for-api-testing)
about what a VCR is and why you might want to use one. TL;DR: it's a great way of testing your code without spamming the
API with test-mode requests, as well as controlling inconsistencies in your test suite; since the VCR will always return
the same response from a recording, your test suite will always receive the exact same data back from any HTTP call it
makes.

## Writing a VCR for Dart

This wasn't my first go at working with a VCR tool. At EasyPost, we use VCR tools
in [all our client libraries](https://www.easypost.com/docs/libraries), so I'm familiar with the concept and how they
work.

For the Java and .NET client libraries in particular, there were no viable existing VCR tools,
so [we had to write our own](https://www.easypost.com/blog/2022-10-04-vcr-the-must-have-companion-for-api-testing#:~:text=Our%20own%20VCR%20solution%20for%20Java%20and%20C%23).
I was the lead developer on EasyVCR for [Java](https://github.com/EasyPost/easyvcr-java)
and [.NET](https://github.com/EasyPost/easyvcr-csharp), the latter of which was a huge influence when it came time to
write DartVCR.

I won't tread over the same ground as my co-worker's blog post, which explains some of the backstory behind EasyVCR's
development. Essentially, several years ago, Martin Leech ported the basic record/replay capabilities of the Ruby VCR
gem (cited by most VCR utilities as the original HTTP VCR) to .NET in his [Scotch](https://github.com/mleech/scotch)
project. EasyPost forked Scotch in 2022, adding a number of new features and bringing the project up to date with
the latest .NET standards and versions. Thus, EasyVCR was born.

The .NET library and all its features were then ported to Java, and recently, now ported to Dart.

(For the record, DartVCR is unaffiliated with EasyPost, hence the naming difference.)

## Features

DartVCR has all the features of its ancestors, including everything you could want from a VCR tool:

* Record and replay HTTP requests
* Censor sensitive data (e.g. API keys, credit card numbers, etc.)
* Alter how a request is matched to a recording (e.g. ignore query parameters, headers must match exactly, etc.)
* Simulate delays in HTTP requests (including replaying the delay from the original recording)
* Setting and enforcing expiration dates on recordings (e.g. recording only valid for 30 days)
* Easy integration with the existing Dart HTTP client for universal compatibility

## How it works

### Basics

At its core, the `DartVCRClient` extends the normal `Client` class from
the [`http` package](https://pub.dev/packages/http), simply overriding the `send` method with a custom implementation.

Because the `DartVCRClient` is a subclass of `Client`, it can be used anywhere a `Client` is expected.

To get started, import the `dartvcr` package and create a `Cassette` object, which will store all recorded HTTP
request-response pairs to a JSON file on disk. In a test suite, it's best to use a different cassette for each unit
test.

Pass this cassette into the `DartVCRClient` constructor, along with a `Mode` enum
value (`Mode.record`, `Mode.replay`, `Mode.auto` or `Mode.bypass`; more on these below).

Then, use the `DartVCRClient` anywhere you would normally use a `Client`.

```dart
import 'package:dartvcr/dartvcr.dart';

// create a cassette to handle HTTP interactions
var cassette = Cassette("path/to/cassettes", "my_cassette");

// create an DartVCRClient using the cassette
DartVCRClient client = DartVCRClient(cassette, Mode.record);

// use this DartVCRClient in any class making HTTP calls
// Note: DartVCRClient extends BaseClient from the 'http/http' package, so it can be used anywhere a BaseClient is expected
var response = await client.post(Uri.parse('https: //api.example.com/v1/users'));
```

A VCR client can be set to one of four modes:

- `Mode.record`: Make real HTTP calls, recording all requests and responses to the cassette. If a recording already
  exists for a given request, it will be overwritten.
- `Mode.replay`: Replay all requests from the cassette. If a recording does not exist for a given request, an exception
  will be thrown.
- `Mode.auto`: If a recording exists for a given request, replay it. Otherwise, make a real HTTP call and record the
  request and response.
- `Mode.bypass`: Disable any recording or replaying, and make real HTTP calls.

### VCR

Users can create multiple instances of `DartVCRClient` with different cassettes and modes, allowing them to record and
replay different sets of HTTP requests. However, re-constructing a `DartVCRClient` each time they need an HTTP client
can be tiresome or impractical, especially if they are using advanced options (see below).

To simplify this, the `VCR` class can be used as a singleton to manage switching between different cassette files and
modes, while maintaining the same set of advanced options.

To get started, construct a `VCR` object (with optional advanced options, see below). Then, insert a cassette into the
VCR, and set the VCR to the desired mode.

A `DartVCRClient` instance, configured with the correct mode and advanced features, can then be retrieved via the
VCR's `client` property.

To remove the current cassette from the VCR, call the `eject` method. Users can swap out the cassette at any time, and
the VCR will automatically update the `client` property to use the new cassette.

```dart
// create a VCR
var vcr = VCR();

// create a cassette and add it to the VCR
var cassette = Cassette("path/to/cassettes", "my_cassette");
vcr.insert(cassette);

// set the VCR to record mode
vcr.record();

// get a client configured to use the VCR
var client = vcr.client;

// make a request

// remove the cassette from the VCR
vcr.eject();
```

### Advanced Options

All the additional features available in DartVCR are accessible via the `AdvancedOptions` class, which can be passed
into the `DartVCRClient` and `VCR` constructors.

```dart
import 'package:dartvcr/dartvcr.dart';

// create a cassette to handle HTTP interactions
var cassette = Cassette("path/to/cassettes", "my_cassette");

// create a set of advanced options
var advancedOptions = AdvancedOptions();

// create an DartVCRClient using the cassette and advanced options
DartVCRClient client = DartVCRClient(cassette, Mode.record, advancedOptions);

// create a VCR using the advanced options
var vcr = VCR(advancedOptions);
```

#### Censoring

One of the most important and impressive features of DartVCR, in my opinion, is the ability to censor recordings. Since
the request and response pairs are recorded to a JSON file in plaintext, it's important to hide any sensitive data,
especially if these cassettes are committed to a public repository.

When censoring is enabled, specified data will be detected and replaced with a placeholder, in both the request and
response. Users can indicate what data to censor, such as a specific header or query parameter, a JSON key in a request
or response body, or even a specific element of a URL path. Users can also specify if the censoring engine should take
into account case sensitivity.

To get started, create a `Censor` object, and add any number of `CensorElement`s to it. Pass this `Censor` object into
an `AdvancedOptions` constructor, and pass that into the `DartVCRClient` or `VCR` constructor.

```dart
import 'package:dartvcr/dartvcr.dart';

var cassette = Cassette("path/to/cassettes", "my_cassette");

var censors = Censors().censorHeaderElementsByKeys(["authorization"]); // Hide the Authorization header
censors.censorBodyElements([CensorElement("table", caseSensitive: true)]); // Hide the table element (case sensitive) in the request and response body

var advancedOptions = AdvancedOptions(censors: censors);

// create an DartVCRClient using the cassette and advanced options
var client = DartVCRClient(cassette, Mode.record, advancedOptions: advancedOptions);

// create a VCR using the advanced options
var vcr = VCR(advancedOptions);
```

Note that censoring is done before the match engine runs, meaning matches will be determined based on the censored data.
For example, two requests could be identical other than having different API keys; if the API keys are normalized by
censoring them, those two requests will now match exactly. This could lead to unexpected behavior if unaccounted for.

#### Matching

When in `Mode.auto` or `Mode.replay`, instead of executing a real HTTP call, DartVCR will instead look for a recorded
request with the same data as the current request. If a match is found, the response from the recording will be
returned.

Users can specify how the matching engine should behave, by passing in a `MatchRules` object into the `AdvancedOptions`
constructor.

The following rules are available:

- `byBody`: Match requests by their bodies. If the request bodies are not the exact same, the requests will not match.
  Users can also specify a list of body elements to ignore when matching.
- `byHeaders`: Match requests by their headers. Users can indicate whether the set of headers must be exactly the same,
  or simply all headers from the current request must be present in the recording (but more can be present).
- `byHeader`: Match requests by a specific header.
- `byMethod`: Match requests by their HTTP method.
- `byBaseUrl`: Match requests by their base URL (scheme, host, and port).
- `byFullUrl`: Match requests by their full URL (scheme, host, port, path, and query parameters). Users can indicate
  whether the query parameters must be in the exact same order.
- `byEverything`: Match requests by all of the above rules.

These rules can be daisy-chained together during the `MatchRules` construction process. If multiple rules are activated,
all rules must be satisfied for a request to be considered a match.

To get started, create a `MatchRules` object, and activate any number of rules. Pass this `MatchRules` object into
an `AdvancedOptions` constructor, and pass that into the `DartVCRClient` or `VCR` constructor.

```dart
import 'package:dartvcr/dartvcr.dart';

var cassette = Cassette("path/to/cassettes", "my_cassette");

// Match recorded requests by body and a specific header
var matchRules = MatchRules().byBody().byHeader("x-my-header");

var advancedOptions = AdvancedOptions(matchRules: matchRules);

// create an DartVCRClient using the cassette and advanced options
var client = DartVCRClient(cassette, Mode.record, advancedOptions: advancedOptions);

// create a VCR using the advanced options
var vcr = VCR(advancedOptions);
```

#### Expiration

While replaying HTTP requests can guarantee data consistency, sometimes it is important to re-record the HTTP call to
ensure that the data used in your test suite is still valid. That's where expiration settings come into play.

Users can specify how long a recording should be considered valid, by passing a `TimeFrame` and `ExpirationAction` into
the `AdvancedOptions` constructor.

The `TimeFrame` object represents a duration of time, which will be used to timestamp each recording in a cassette.
A `TimeFrame` object can be constructed for a specific combination of days, hours, minutes, and seconds. There are also
a few pre-constructed `TimeFrame` objects available, such as `TimeFrame.month3` for 3 months, `TimeFrame.never` for
never (a recording will always be considered expired), and `TimeFrame.forever` for forever (a recording will never be
considered expired).

The `ExpirationAction` enum represents what should happen when an expired recording is found. There are three options
available:

- `ExpirationAction.warn`: Log a warning message, but continue to use the expired recording.
- `ExpirationAction.throwException`: Throw an error, and do not use the expired recording.
- `ExpirationAction.recordAgain`: Silently re-record the HTTP call, and use the new recording.

To get started, create a `TimeFrame` object, and pass it into an `AdvancedOptions` constructor, along with
an `ExpirationAction`. Pass that into the `DartVCRClient` or `VCR` constructor.

```dart
import 'package:dartvcr/dartvcr.dart';

var cassette = Cassette("path/to/cassettes", "my_cassette");

// Any matching request is considered expired if it was recorded more than 30 days ago
// Throw exception if the recording is expired
var advancedOptions = AdvancedOptions(
    validTimeFrame: TimeFrame(days: 30), whenExpired: ExpirationAction.throwException);

var client = DartVCRClient(cassette, Mode.replay, advancedOptions: advancedOptions);
```

## Summary

I quite enjoyed writing DartVCR, using the great work my co-workers and I had done for EasyVCR, and learning Dart during
the process of porting .NET code to Dart. I've been using DartVCR in my own projects, and I'm quite happy with the
results so far.

DartVCR is available on [pub.dev](https://pub.dev/packages/dartvcr). I hope you find it useful!

If you have any questions, comments, or suggestions, please feel free to reach out to me on
the [project's GitHub page](https://github.com/nwithan8/dartvcr).
