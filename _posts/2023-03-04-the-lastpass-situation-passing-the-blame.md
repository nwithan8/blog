## The LastPass Situation: Passing the Blame

In August, LastPass, a very popular password manager, suffered a massive security breach.

Initially, the company was suspiciously reluctant to reveal any significant details about the situation, releasing a [pithy statement](https://blog.lastpass.com/2022/12/notice-of-recent-security-incident/#:~:text=Update%20as%20of%20Wednesday%2C%20November%2030%2C%202022) in November with little more than a vague description of an attack on their systems.

In December, the company [released more details](https://blog.lastpass.com/2022/12/notice-of-recent-security-incident/), revealing that the attackers had gained access to the company's own password vault (aside: good for a password manager company for using its own product, I guess) and stolen its Amazon Web Services credentials. From there, the attackers was able to access the company's storage systems and download user password vaults.

Now granted, these vaults are encrypted with each user's own master password, but the only thing standing between a LastPass user's passwords and the attackers right now is a single password. And, unfortunately, there are plenty of people out there who still use things like "password123" as their password.

So, why am I writing about this now? Well, while the damage has already been done, and many a technology writer (including myself) have made their typical pleas for people to dump LastPass and move to a different platform (BitWarden is my personal favorite), the news that continues to trickle out about the LastPass breach is fascinating and horrifying.

Let's get through the news and dissect it.

## Oh no, Plex!

On Feb. 27, LastPass [revealed more details](https://arstechnica.com/information-technology/2023/02/lastpass-hackers-infected-employees-home-computer-and-stole-corporate-vault/) about how the attack occurred, specifically regarding how the attackers were able to gain access to the company's AWS credentials.

According to the company:

> This was accomplished by targeting the DevOps engineer’s home computer and exploiting a vulnerable third-party media software package, which enabled remote code execution capability and allowed the threat actor to implant keylogger malware. The threat actor was able to capture the employee’s master password as it was entered, after the employee authenticated with MFA, and gain access to the DevOps engineer’s LastPass corporate vault.

The DevOps engineer was apparently one of only four individuals who had access to the corporate password vault.

The "third-party media software package" was later confirmed to be Plex Media Server, a popular media server software. Now, while LastPass didn't explicitly say "Plex" in its statement (and who knows, it could have been Emby or something else), the wording of this statement seems calculated.

This is a carefully-crafted red-herring (and we'll see why in a minute). While disclosing that the exploit was due to a vulnerability in another piece of software, especially one as popular as Plex, is important to spread the word about the issue, this inherently comes off as passing blame. LastPass here is trying to distract from their own mistakes by pointing out that Plex apparently has a major vulnerability in it.

What's more, [comments and a statement from Plex](https://www.reddit.com/r/PleX/comments/11dsx8e/plex_vulnerability_used_to_steal_corporate/jad1tkk/) following the news revealed that LastPass [hadn't yet contacted them](https://forums.plex.tv/t/plex-remote-code-execution-exploit-used-in-lastpass-breach/832727/11) regarding the bug. As far as anyone knew, Plex had a major exploit floating around in its software and was unsure how to fix it.

And LastPass' distraction worked. In groups and forums, people stopped talking about LastPass' security issues and started talking about Plex's. I had fellow Plex enthusiasts asking me if I knew anything about the vulnerability, and whether running Plex in a Docker container versus directly on Windows protected them from the vulnerability. (I would imagine the DevOps engineer was running Plex on their personal Windows machine, an odd choice for sure). Others said they were jumping ship over to Emby and Jellyfin.

While LastPass wasn't off the hook, it had successfully shifted the blame to Plex, dragging that company down with them into the mud.

## The table turn

Until a few days later, when Plex had seemingly gotten in touch with LastPass to discuss the vulnerability.

And it turns out, the vulnerability, a bug in the Camera Upload feature that allowed remote code execution, had already been fixed. [Back in May 2020](https://www.pcmag.com/news/lastpass-employee-couldve-prevented-hack-with-a-software-update).

> Unfortunately, the LastPass employee never upgraded their software to activate the patch. For reference, the version that addressed this exploit was roughly 75 versions ago.

Yep, turns out, Plex had done nothing wrong in this situation. The blame, once again, fell squarely on LastPass' shoulders.

## A security company that can't secure itself

Alright, so let's recap what happened.

We have a senior DevOps engineer at LastPass, a company whose entire business is based on security.

This engineer likely works all day with security software and sensitive information.

They're a senior-level employee, presumably with a lot of industry experience. Heck, they're one of only four people with access to the company's own password vault.

And yet, in a stunning display of incompetence, the following missteps occurred:

- LastPass allows this engineer to use their personal computer to connect to the company's VPN and conduct company business.
- This senior engineer with years of experience in security does not consider the threat vector they are opening up by using their personal computer to access the company's VPN.
- This senior engineer with years of experience in security is running Plex Media Server on their personal computer (again, why? Get a dedicated server, dude), which is connected to the company's VPN.
- This senior engineer with years of experience in security does not consider the threat vector they are opening up by using their personal computer to access the company's VPN while running extra software like Plex.
- This senior engineer with years of experience in security actively ignores security (and feature) updates for their personal Plex Media Server for **three** years.
- This senior engineer with years of experience in security does not detect a keylogger on their personal computer (I'll give a pass on this one, they're meant to be undetectable, but ...)
- This senior engineer with years of experience in security doesn't have malware protection running on their personal computer capable of detecting and removing a keylogger.

Put it all together, and we have a senior engineer, with years of experience in security, who regularly deals with security-related software, at a company that builds and sells a security product, who does not stop and consider the threat they are introducing by using their personal computer to access arguably the most critical sensitive data in the entire company, while running a piece of popular network-connected software that has more than three years of un-applied security updates.

And then, when the inevitable happens, they try to blame Plex, the only actor in this situation that actually did their job correctly. Astounding.

LastPass, understandably, hasn't commented on the situation since this new information has come to light (they've got enough egg on their face as it is), but it's pretty clear that there was a severe breakdown in policy and security at the company. One can only hope that this engineer's use of their personal computer was an isolated incident, and not the norm. I don't personally know if LastPass provides its employees with company equipment; if not, they definitely should now. As for the engineer, I'm sure they'll be flooded with security trainings in the coming weeks, if they haven't been fired already.

## What's the takeaway?

From the start of this whole situation, LastPass has been trying to downplay the severity of the breach, from their very first nothing-burger statement. And as more and more information comes out, they're constantly having to backtrack on their previous statements or admit that their earlier wordings were misleading or half-truths.

And now we have LastPass trying to pass the buck off to Plex because of a vulnerability in their software. And lo and behold, that also turns out to be a half-truth; Plex *did* have a vulnerability in its software, three years ago when this security expert ironically decided to stop caring about his own personal security.

Let's be clear, LastPass absolutely knew that the issue was because Plex was outdated when they released their statement, but carefully decided not to reveal that the "unforeseen vulnerable software" was actually laziness and/or incompetence on the part of their own employee.

I would have absolutely **loved** to have been a fly on the wall when that call between the LastPass team and Plex went down. Plex engineers, hurried and anxious to learn what massive vulnerability is apparently floating around in their code, only to find out that this so-called "security expert" hadn't done the basic due diligence of keeping their software up to date, and took down their entire company down with them.

The takeaway here is quite simple, and should be fairly obvious since it's the same exact things literally every CISO or IT department has been telling their employees for years:

- Don't use your personal computer for work.
- Keep your software up to date.
- Don't use LastPass.


