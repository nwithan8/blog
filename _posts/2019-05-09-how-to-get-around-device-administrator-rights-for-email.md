## How to get around “Device Administrator” rights for email

_Don’t let your organization decide how you use your phone, just because you want to read some emails_

___

I’ll be heading back to college pretty soon, and the other day I was going through the usual motions of setting up my college accounts and passwords.

When it came to adding my college email account to my mobile phone (specifically adding it alongside my personal email in my Gmail app on an Android device; I’m not going to download an entire new Outlook app just for one email account), I ran into a common problem: the university wants too much control over my personal device.

As I’ve experienced at other colleges and some businesses, my college wants me to use the built-in Exchange/Office 365 configuration in the Gmail app to add my email account (their [full tutorial is here](https://gsutech.service-now.com/sp?id=kb_article&sys_id=6f8108b9db581340601b502bdc96192b); sorry, not sorry, Georgia State).

My account, probably like a lot of college and business email accounts, is Office 365, and attempting to add the account through the “Outlook” option fails, leading me to use the “Exchange and Office 365” setup option. Everything seems to work fine, I put in my username and password, it connects and…

Wait, what’s this “Remote security administration” thing I have to enable? The email app becomes a device administrator?

Yes, granting this permission (which you have to in order to complete the email setup) allows the organization to enact and enforce certain security features on your phone. In my experience, this is more a “will” than a “may;” shortly after setting up this years ago with my University of Georgia email account, immediately it was forcing me to place a lock screen on my phone and encrypt my device. Not that I shouldn’t probably do both, but it’s my phone, and I should be the one to decide how I use it.

So screw you and your overreach.

Sure, this is probably for security for the college’s server, but no one is trying to hack into your intranet via my smartphone. And if they do, that’s not my problem.

Thankfully, there is a way around this, where I can read and send my emails without any excessive overreach from “big brother” college. But you likely won’t find it on any official tutorial from the college or from any IT manager.

It’s called IMAP, and it’s fortunately not too difficult to find or set up.

### Setting up IMAP

IMAP, or Internet Message Access Protocol, is a method of accessing and storing mail on a mail server. You may have also heard of POP3, another method of connecting to an email server; however, because of how IMAP communicates with the server, where any email you delete or archive is also deleted and archived on the server (meaning an email you deleted from one device doesn’t continue to show up on another device), IMAP is likely a better fit for your needs.

Most common email apps and providers like Gmail use IMAP, so we’re not doing anything hacky or different here. Instead, we’ll just manually configure this in our email client, allowing us to connect to the mail server but avoid any additional security enforcement.

First, we need to know the IMAP server address, port number and security type for receiving email, as well as the SMTP server, port number and security type for sending out email. The server addresses (and possibly the port number) vary based on what email service you use; [here is a list of the settings](https://web.archive.org/web/20230628174250/https://support.microsoft.com/en-us/office/pop-imap-and-smtp-settings-8361e398-8af4-4e97-b147-6c6c4ac95353?ui=en-us&rs=en-us&ad=us) for common email services like Gmail, Yahoo, AOL and Office 365.

For me, I opened my college email in a web browser, clicked on the gear icon in the top right of the screen and clicked “Mail” under “Your app settings” in the newly-appeared right sidebar. This should open a left sidebar with a number of settings categories for Mail. Select “POP and IMAP” under the “Accounts” section, which should then display the IMAP and SMTP server, port and security settings for your organization’s email.

For my purposes, I’m adding this account into the Gmail app on my phone, but the process should not differ too much depending on your device. Once you find the section for IMAP/POP3 or manual connection settings in your email app, you’re ready to set it up.

In the Gmail app, this means opening the left hamburger menu, scrolling to the bottom and selecting “Settings” -> “Add account”. Here, the app offers a couple popular pre-configured options, including a Google account, Yahoo and Outlook. Remember, we tried adding this account with the “Outlook, Hotmail, and LIve” option to no avail, and were forced to use “Exchange and Office 365,” which tried to control our personal phone’s security options.

Instead, select “Other” at the bottom. Type in your organization’s email address, and then tap “Manual Setup” in the bottom left corner of the screen. The next screen will ask if you want to use POP3, IMAP or Exchange. As I said earlier, IMAP is most likely the best choice for the average user. Select IMAP and begin filling out the required information, beginning with your email password.

On the “Incoming server settings” page, make sure to check the “Server” section. In almost all my experiences, the default server that comes up (usually based on what your email ends with) is incorrect; go ahead, try, you won’t be able to connect. Instead, make sure to change it to the server listed in your organization’s IMAP settings. Most of the time, this is usually Outlook’s standard `outlook.office365.com` server.

The same thing applies on the “Outgoing server settings” page, only this time it’s the SMTP server (usually `smtp.office365.com`; make sure to spell it right). Don’t adjust any other default settings. If your app asks if you want to require sign-in, choose “Yes.” Don’t worry, this doesn’t mean you’ll have to type in your email and password every time you open your email app.

The app should then ask you how often you want it to check for new mail and if you want notifications of new mail. This setting is up to you; I want to preserve my phone battery, so I only have it check once every hour.

Name the account for your app, and that’s it. Your mail should automatically by importing onto your device (if you have a lot of mail already, this might take a bit of time). You can test it by sending an email to yourself from your browser, and seeing the delay (if any) of it arriving on your phone.

All the functionality of your email account is there, with full sync (for instance, archiving a message on your phone will archive it on the server and all your other connected devices), but no organizational overreach into your own security habits.
