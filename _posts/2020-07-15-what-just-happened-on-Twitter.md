## What just happened on Twitter?

UPDATE: Since Wednesday’s hack, Twitter has stated that they believe the hackers targeted approximately 130 accounts on the social media site. Media outlets are reporting that the hackers potentially took control of the accounts by accessing an employee admin panel and changing the email address associated with each account. Twitter is continuing to look into what information may have been compromised.

The original article is below.

---

For a brief 20 minutes, Twitter was a beautiful place of peace and harmony, because for a brief 20 minutes, every verified Twitter account couldn’t send out tweets.

So, what just happened in “The Great Muting of 2020”, and how did we get there?

At approximately 5:30 p.m. EST on July 15, several prominent Twitter accounts, including Elon Musk, Jeff Bezos, Barack Obama, Joe Biden, Apple and Uber appeared to have been hijacked, all sending out similar spam tweets offering a two-for-one Bitcoin exchange and providing a Bitcoin address. Immediately, users went wild with speculation (and a lot of memes and jokes, this is Twitter after all). Twitter’s support account later said it was aware of the incident and was investigating.

```
Massive Twitter hack underway by Bitcoin scammers:

– Bill Gates
– Elon Musk
– Joe Biden
– Warren Buffett
– Kanye West
– Michael Bloomberg
– Apple
– Uber
– Jeff Bezos
– Barack Obama pic.twitter.com/5uSngaBdrZ

— Breaking911 (@Breaking911) July 15, 2020
```

So, how did these accounts get hacked? Well, given the number of accounts involved, we’re likely not looking at a typical account hack here. Normally, a hacker will target a specific user and try to gain access to their account by tricking the target into giving them their password. The most common methods for this is either phishing emails and websites (getting the target to enter their credentials in a seemingly-legitimate web page) or by SIM-swapping (temporarily rerouting text messages and phone calls from the target’s mobile phone to the hacker’s phone by spoofing the target’s mobile SIM card). With that information, the hacker either has the original password or the ability to reset the user’s password and enter a two-factor text message security code. This is what happened to Twitter CEO Jack Dorsey last fall.

Here, it’s unlikely that the hacker took the time to trick all targets involved, especially when many of them (like Elon Musk, Bill Gates and Jeff Bezos) are technologically-savvy enough to not fall for phishing. Instead, this is shaping up to be a backend data breach at Twitter. The hacker likely breached Twitter’s own security and managed to collect credentials for dozens, possibly millions of accounts. It’s unlikely the hacker would gain backend access to Twitter and only make off with details for a few specific accounts. While we know the half-dozen or so accounts that posted the Bitcoin scam were hacked, we don’t yet know how many accounts may actually be compromised. There could potentially be millions of Twitter users with leaked passwords now. Twitter has yet to confirm the extent of the damage.

<img src="https://raw.githubusercontent.com/nwithan8/blog/master/assets/2020-07-15-what-just-happened-on-twitter-1.png" alt="And since it's multiple accounts, it suggests that it wasn't someone phishing or spoofing to get a specific person's account credentials. Instead, we're probably looking a data breach at Twitter and millions of accounts could have been compromised.">

So, how did the tweets get sent? The variation in the wording and timestamp of the scam tweets suggests it may have been someone semi-manually typing the messages rather than an automated process. I say semi-manually, because it’s unlikely the hacker was logging into Twitter.com as the targets and typing the tweets out in a web browser. More likely, the stolen credentials were used to create authorization tokens and secrets. These tokens and secrets are used to connect applications, from web apps to scripts, to a user’s Twitter account. The hacker could then run a script, switching through all the target accounts and posting the scam message.

Depending on how Twitter’s logging works, this method might actually make it harder to track down the hacker; at this point, though, Twitter is likely more concerned with how the hacker got account credentials more than how they sent the tweets.

So what does this mean for you? Well, as I said, we don’t know the extent of the damage yet and whether more accounts were compromised in the potential breach. Depending on how the authorization tokens were created (there’s “Read only” and “Read/Write” access types), the hackers could have access to things such as account details, associated phone numbers and direct messages.

**Changing your password is a must, as well as checking what applications have access to your account.** If the hacker created applications using your credentials, it should appear in the list of linked apps. You can visit “Settings -> Account -> Apps and sessions” to view all the applications that have access to your account. If there’s anything that you don’t recognize, you can select it and click “Revoke access” to remove it. You can also see when the application was first granted access to your account. This is a good practice to do even when there isn’t a potential hack, since there might be some old apps you don’t have or use anymore that you forgot had access to your Twitter account.

<img src="https://raw.githubusercontent.com/nwithan8/blog/master/assets/202-07-15-what-just-happened-on-twitter-2.png" alt="The Bitcoin hackers might be using stolen credentials to make apps to impersonate users & send tweets. Change your password and check what apps have access to your account and remove anything you don't recognize. Settings -> Account -> Apps and sessions">

**UPDATE**: [_Motherboard_](https://web.archive.org/web/20200806144134/https://www.vice.com/en_us/article/jgxd3d/twitter-insider-access-panel-account-hacks-biden-uber-bezos) reports that an image of an employee admin panel is circulating in the underground hacking community, suggesting that the hacker may have gained access to a Twitter employee’s account and used it to control the “hacked” accounts. Twitter is reportedly removing the image and even suspending Twitter users who are posting it, claiming it violates their terms of service. If this is the case, then account credentials may not have been leaked after all. I would still advise checking your connected apps and consider changing your password, just to be safe.

Of course, that wasn’t the end of it. Once everyone got all their memes posted and [#hacked](https://twitter.com/search?q=%23hacked&src=typed_query) was trending, Twitter attempted to mitigate the situation by preventing all verified (blue checkmark) accounts from sending out new tweets. This not only suggests that there was concern on Twitter’s end that more accounts had had their credentials stolen, and they shut down tweeting capabilities to stop the hackers from posting, but it was also quite funny. For a brief moment, Twitter was a completely different place. It was a night and day difference on my personal timeline, with no big-name pundits, brand accounts or media outlets (except for those who figured out how to use retweets to send help messages).

<img src="https://raw.githubusercontent.com/nwithan8/blog/master/assets/2020-07-15-what-just-happened-on-twitter-3.png" alt="Oh get over yourself">

It was “power to the people,” until 20 minutes later when every verified person flooded my timeline with “I’m back” messages. It is interesting that Twitter can apparently flip a switch and stop all verified users from sending tweets. That gives a bit of insight into how Twitter’s backend works, that verified users are categorized differently from non-verified users, and can be given or rescinded specific permissions instantly.

Long story short, change your password, check your apps, and let’s all beg Twitter for another round of non-verified bliss.

<img src="https://raw.githubusercontent.com/nwithan8/blog/master/assets/2020-07-15-what-just-happened-on-twitter-4.png" alt="Trying to think of something profound and viral-worthy to say while verified people can't tweet. Realizing that it's not the verified people that are holding me back from going viral. oof.">



