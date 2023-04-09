## Showing off some Home Assistant blueprints

Ever since I moved into my new (first!) house a few months ago, I've been diving head-first into the world of smart home automation, particularly with Home Assistant. I've been having a blast, and I've learned a lot. I've also been using a lot of blueprints, which are a great way to get started with automations. I thought I'd share a few of my favorites.

(Full disclosure: GitHub CoPilot wrote the majority of that opening paragraph. Everything after "particularly with Home" was autocompleted. AI is truly going to take my job, both as a programmer and as a writer...)

I've put off writing this blog for a few weeks, mainly because I've been so distracted with learning the blueprints (plus a hundred other side projects). But after challenging myself and writing three blueprints of increasing complexity in three days, I figured this would be something worth sharing (and certainly not just a shameless attempt to draw attention and traffic to my specific posts on the Home Assistant Blueprints Exchange...)


### [Determine a user's name from a given user ID](https://community.home-assistant.io/t/determine-user-name-from-a-user-id/549189)

This was the first blueprint I wrote, which, in hindsight, could be a script (you'll notice that a lot of these walk the fine line between reusable blueprint and one-off script).

I've been messing with Alarmo, a great Home Assistant integration that allows you to monitor the state of various sensors and treat them as a roll-your-own alarm system. One thing I added was a mobile notification, sent to both my phone and my wife's phone, when the alarm goes off, that offers the ability for us to respond with the deactivation code.

The problem was, there was no way of knowing which of us (me or my wife) responded to the notification, so there was no way to know which of us provided the deactivation code. (Side note: Actually, my wife and I had different personal codes, and Alarmo already manages determining who disabled the alarm based on which code was provided. As a result, I don't actively use this blueprint anymore.)

After poking around online, I learned that responding to a notification does provide the ID of the user who replied, and combined with a code snippet I found that can determine a user's name based on their ID, I figured this could work.

The blueprint is fairly simple. Setting it up as a script, you indicate where you want the calculated result (a text string, the user's name, such as "Nate") stored (such as an input_text helper entity). When calling the script, you pass in the user ID as a parameter, and can then pull the result from the helper entity in a later step.

I purposefully left this blueprint simple and generic rather than making it hyper-specific to determining notification respondents, in case there are other use cases for it.

As this was my first blueprint, I learned a lot about how to write them, thinking about them as generic macros rather than hyper-specific scripts, the differences between fields and inputs, and the different types of selectors.

For fun, here's some notes I took (unedited):

```
Blueprints:

i.e. for a script
- input is something that will be tied to that script (once set when making the script, it's locked) (configuration)
- field is something that is passed into the script when it's called (runtime variable)
Ex. I want this script to update this particular device with a number - device would be an input, number would be a field

Selector actions can't be used as fields, only as inputs
https://community.home-assistant.io/t/use-input-fields-in-script-as-sequences/452683/9

Domains:
https://community.home-assistant.io/t/list-of-all-domains-entities/148059/6

- Recommended to redeclare all inputs as variables for a script run
- Actions can't be converted to variables, have to be referred to by !input name


Automation vs script
- Having an automation call just a script is bad design
- Scripts are meant for processing different input. If the input never changes, just use an automation
```


### [Set guest code for door lock](https://community.home-assistant.io/t/z-wave-zigbee-set-temporary-guest-code-for-door-lock/549520)

Probably my favorite blueprint, this one will set a temporary "guest" code on a ZigBee or ZWave smart door lock. This, like a lot of these blueprints and scripts, is thanks in large part by integrations that do a lot of the heavy-lifting (specifically ZHA-Toolkit and Keymaster here).

This blueprint will allow you to set up a script that will set a temporary code for a specific amount of time (both provided as inputs when the script is called) on a door lock, triggering specific actions when the code is enabled and disabled.

The hardest part of making this blueprint was the "on enabled" and "on disabled" action inputs, utilizing selectors for the blueprints to allow users to customize actions when building a script with the blueprint.

I used this script just the other day to set a 24-hour code for a visitor, and it worked flawlessly. I'm already thinking about improvements, where you don't need to provide a code at all; instead, a random, non-conflicting code will be generated for you.


### [Aqara H1 Rotary Dial](https://community.home-assistant.io/t/aqara-h1-rotary-dimmer-switch-dial-media-controls/551917)

This one was also fun, and a lot easier since it was largely lifted from a similar blueprint I found on the Blueprints Exchange to turn an IKEA light remote into a programmable "anything" remote.

The Aqara H1 Rotary Dial is a ZigBee dimmer switch that looks like a giant clickable volume knob. Support for it is still in beta in ZHA, but thanks to another developer, I was able to get it paired and interacting with Home Assistant.

The dial was originally intended to dim and control lights and shades, but I knew I wanted to use it to control my whole-home audio system with Home Assistant. So, borrowing the IKEA remote blueprint schema, I was able to draft up a blueprint that would allow users to make an automation that maps the different controls on the device to different actions in Home Assistant.

Specifically, there's two blueprints I made for this device. The [first](https://community.home-assistant.io/t/aqara-h1-rotary-dimmer-switch-dial-remote/551909) allows users to set whatever action they want on each of the five controls of the device, while the [second](https://community.home-assistant.io/t/aqara-h1-rotary-dimmer-switch-dial-media-controls/551917) specifically locks the device to controlling a media player, with pre-defined controls already baked into the blueprint.

I use the latter currently, with the dial mounted on my wall next to my control panel tablet, where it controls the playback and volume of my home speakers playing music from Spotify.


### Conclusion

I'm working on more blueprints at the moment, although as I mentioned before, I'm still struggling with what should be a blueprint versus a one-off script. Anyone who knows me knows that I have a (bad?) habit of writing excessively reusable code, even when it's only going to be used one time. Case in point, I'm starting to get a handle on not having every automation in Home Assistant simply trigger a script, since the majority of those scripts will only ever be used in one scenario (there's just so many ways to do any one given thing in Home Assistant! No wonder this was written in Python...)

Anyway, I don't know how interesting this has been, or if I'll get around to writing a second post like this. If not, make sure to follow me (can you do that?) on the Home Assistant forums, where I'll be sure to share any new things I cook up!
