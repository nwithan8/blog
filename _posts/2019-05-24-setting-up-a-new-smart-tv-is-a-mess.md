## Setting up a new smart TV is a mess

I just recently purchased a new 43-inch TCL Roku TV to hang on the wall in my bedroom.

I won’t go into detail about the 72 hours of tough decision-making and choice-balancing I endured to land on my particular choice ([this one](https://web.archive.org/web/20200812041823/https://www.amazon.com/TCL-43S425-Inch-Ultra-Smart/dp/B07DK5PZFY), if you’re that interested). Instead, I’ll skip ahead to the fun times I had trying to set everything up from scratch, from installing all the necessary apps to signing in to a million different accounts… and what a crap shoot it is.

I’m not a huge fan of Roku, but I have experience with them, having used a Roku Premiere as my main streaming device in my college apartment a little over a year ago (as a middle ground to not confuse my roommate with my Kodi-all-the-way HTPC approach to cord-cutting). Thankfully, that means I had previously set up a lot of these apps under my Roku account, so signing into my Roku account to set up the new TV installed almost all of the apps I would have otherwise had to hunt down and search for and install individually. So props to Roku for that feature.

The real mess came with signing into all my accounts. Unlike Google and Amazon, Roku does not seem to store login credentials for most apps in the cloud, so while the apps automatically install, I still have to open each app individually and log in for the first time. And that’s where the real pain comes in.

There’s not really a good way to explain this, so I’ll just publish some notes I took regarding each app and its experience.

**Hulu** – Like many apps, Hulu has a central browser-based login system. A code pops up on screen, you visit hulu.com/activate on another device, enter your code and sign into your account, and your streaming device is now linked to your account. A lot of cable subscription-required apps also use this system. (Admittedly, for me, the Roku app asked me as I was installing all my apps if I wanted to sign into Hulu, and then passed those credentials down to the TV app. Oddly enough, Hulu was the only service it offered for me to do this for). **6/10**

**Netflix** – For arguably the most popular streaming app, it amazes me that Netflix sticks with the much more difficult on-screen keyboard approach to logging in. Rather than visiting a web page, users have to fumble around with their remote to type in their email and password on the app’s login screen.

Quick pros and cons of the on-screen keyboard:

- Great shortcuts – not just for .com/.org/.net email endings, but common email accounts like @gmail.com.
- No cursor, so a mistake = hold “delete”
- The keyboard is shifted left rather than front and center on the screen, so it feels cramped.

Netflix’s weak login process really surprises me, given that its Android app is one of the few apps that actually utilizes Google Smart Lock. I understand that this is a Roku device, but having such a simple, instantaneous login process on a phone and then having such a terrible login process on a smart TV is baffling. **3/10**

**HBO NOW** – This app actually offers the option to either sign in using an on-screen keyboard or through a web page, given that some people may have standalone HBO accounts while others may need to link their cable subscriptions (honestly though, a web-based login should just be the default). Unfortunately, the web-based login did not work for me for one reason or another, so I was forced to use the on-screen keyboard. **5/10**

Quick pros and cons of the on-screen keyboard:

- Not QWERTY. You would think this would make it easier to find letters, but it actually made it more difficult for me. That probably depends on the person.
- Cursors included, so you can easily go back and correct your mistake.
- No .com/.org/.net shortcuts
- The keyboard “pops out” from the UI, but does a nice job of keeping with the dark color theme of the HBO NOW app.

**Amazon Prime Video** – This is by far the worst experience I had of all the apps. Users are forced to use an on-screen keyboard to sign in to their account on the TV, after which a code pops up on screen. You then visit a web page on another device, where you have to sign in to your Amazon account (and, like me, possible have to get a second two-factor authentication code texted to you/the Prime subscriber to complete the login process). You then type in the code from your TV into the web page. Why do you have to sign in to your Amazon account on the device if you’re just going to have to sign in again on the web browser? Who the hell knows. **2/10**

Quick pros and cons of the on-screen keyboard:

- QWERTY keyboard
- No cursor
- The design matches the Amazon Fire TV color scheme with grey and yellow (not necessarily the Prime Video app’s grey and blue). Either way, it’s a pretty ugly, quasi-photorealistic design (think pre-iOS 7 iPhone).

**PlayStation Vue** – This is kind of a weird one, and I probably only know this because I’ve had to set this app up on a variety of platforms before. Rather than one activation web page, PlayStation Vue has a specific activation web page for Roku, Apple TV and PS4 devices, following the standard login-code-done process. But for Android TV and Amazon Fire TV, users are forced to use an on-screen keyboard to enter their login. Why the inconsistency? I could speculate that because Android and Amazon Fire TV (Android at its core) have built-in browser support, Sony might have thought it would be easier for users if they kept the login process on-device in an embedded browser window. As I’ve said, on-screen keyboards are terrible, so you might want to reconsider, Sony. I’m sure they’ll get around to it as soon as they get around to not making their login page look like hot pixelated garbage. **5/10**

**ESPN** – This one is kind of cool. The app, thankfully, uses the standard code-based web page activation process, but there’s actually two accounts people will need to sign into on the app – one for their ESPN account to sync their favorite sports teams and preferences, and one for their cable subscription to watch live sports. Users have to manually select each section individually and follow the login process, but what’s cool is the codes. Both sections give you a different code, but ask you to visit the same web page, espn.com/activate. Depending on which code you enter, you’ll be redirected to either the ESPN account login page or the cable subscription login page. That’s a smart, simplified process, where users only have to remember one link, and the codes will automatically determine your next step. Props, ESPN. **7/10**

**CNNgo** – I didn’t even have to sign in to this app, thanks to Single Sign-On. SSO, for those that don’t know, is supposed to be a simple, centralized system for logging in to apps that require cable subscriptions like CNN. If the app developer supports it (which I have first-hand knowledge that CNNgo does; unfortunately, it’s not as widely used as you’d think), the device maker, in this case Roku, stores your cable subscription credentials and automatically passes them in to any app requesting them. iPhone users [might recognize](https://web.archive.org/web/20200930222504/https://www.cnet.com/how-to/how-to-set-up-single-sign-on-on-ios-10-apple-tv/) this as the “TV Provider” section in their Settings. For my case, it’s good to know that Roku supports SSO, and I can only hope more app developers decide to implement it, because it makes the sign-in process a literal one-and-done. **10/10**

**YouTube** – Now we’re starting to get into the more unique methods of signing in. For YouTube, you used to have to manually type in your login using an on-screen keyboard which, you know, sucks (especially if you have two-factor authentication on a smart card like me). Instead, now you open the app on your smart TV, open the YouTube app on your phone, tap on your profile picture in the top right corner, and it will automatically pass in your login credentials to the TV. Behind the scenes, this means the TV is broadcasting a request for login credentials, and the YouTube app is sniffing and responding to such requests. Could this be potentially abused? I would think so. Does Google have something in place to prevent this? I would hope so. Nevertheless, very cool. **9/10**

**Spotify** – Similar to YouTube, no email and password required for this setup. Simply open the Spotify app on your phone or computer, cast some music to the TV (you’ll have to be on the same WiFi network), and your credentials are automatically passed along. If that doesn’t work (as it didn’t for me, at least this time; it has in the past), you can also use an on-screen keyboard to login in or visit a web page and enter a code. Spotify gives you options. **8/10**

**Google Play Movies** – This was hands down the coolest login process. Like YouTube, you open the app on your TV and on your phone, but rather than sniffing WiFi, the app will request access to your microphone and begin listening to low frequency tones emitted by the TV to transmit a code to your phone to link the device to your Google account. This works even with your phone off WiFi (come to think of it, this may be what is happening during the YouTube setup, rather than WiFi sniffing). This is an amazing use of low frequency communication, and makes the login process very simple. After the code is transmitted, users complete the sign-in process on their phone. If two devices communicating with pitches that you can’t hear scares you, you can also manually enter the code on a standard login web page. **9/10**

As we’ve seen, the whole TV setup process can be grueling because, while some apps are willing to implement new technologies like Single Sign-On and low-frequency communication, others are convinced that having users click away on their directional pads and try to type in their email and password is the best experience possible (looking at you, Amazon). I know, thankfully, that we only have to login once on each of these apps, but as someone who frequently has to set up multiple new Fire TV Sticks, Rokus and Android TVs for friends and families, I think it’s high time developers start considering the end login experience for their users.

