---
layout: post
title:  "A Follow-up: World of Warcraft Classic"
date:   2019-08-24 17:16:50 +0000
categories: blog
tags: gaming warcraft followup
---

![WoW Classic](/images/wowclassic.jpg)

Over three years ago, [I wrote an article]({% post_url 2016-04-15-is-wow-afraid-of-legacy %}) about my suspicion that the World of Warcraft team was afraid of creating their own legacy servers. In it, I suggested that they were not only worried about the engineering effort and maintenance costs behind running two vastly different versions of the game, but also, on some level, fearful of just how positive a response those servers might receive.

Well, if my hypothesis was correct, Blizzard must be absolutely shitting themselves with terror right now. It turns out all they needed was a little push from the community, because in late 2017 they finally announced WoW Classic. Since that announcement, the hype around the release has only gotten stronger. Now that we’re mere days away from release, the original World of Warcraft—which Blizzard’s top brass seemed so confident [we didn’t actually want](https://www.youtube.com/watch?v=0Wrw3c2NjeE)—is experiencing the kind of resurgence other companies can’t even pay for. 

Since the initial run of servers went live for character reservations on August 12th, Blizzard has added (or will add before launch) over a dozen additional servers. One can assume they were added out of necessity; it seems that even once they conceded to actually offering a Classic version of WoW, they still couldn’t believe anyone actually wanted to play it. Now, the numbers speak for themselves. The servers are filling up before the majority of players, who likely wouldn’t have bothered reserving their characters ahead of time, even log in for the first time. By all accounts ([including their own](https://old.reddit.com/r/classicwow/comments/ct08c7/welcome_to_the_rclassicwow_subreddit_ama_with_the/exi4fyg/?context=3)), WoW Classic is more massive than Blizzard expected.

I won’t spend this article gloating about how right the community was about the demand for Classic. While I intend to play it for a good, long time, everyone will eventually reach a point with it where the nostalgia has worn off. Myself included. We’ll have seen the expansive world, relived the peaks and valleys of joy and pain, and remembered both how we loved and why we hated old-school MMO design. We’ll be ready to move on. I hope Blizzard learns a few things from this massive initial success, however, and eventually releases Burning Crusade and Wrath of the Lich King-era servers as well.

## A Link to the Past

Instead, I want to congratulate Blizzard from an engineering perspective. They have managed to achieve something near-miraculous with Classic: they brought the future back to the past. For those unaware, Blizzard essentially had three options to bring a legacy version of WoW to market:

1. Stand up the old server software and release the 1.12 client from 2006 and let the players deal with the known bugs, exploits, security holes, and lack of modern integrations (e.g. with the Battle.net client).
1. Use the 2006 code, but fix all known exploits and security issues and add the necessary integrations.
1. Take the modern code and re-implement the 1.12 logic and systems.

It’s option #3 that I didn’t consider in my original article. Actually, that’s not entirely true—the idea passed my mind as I wrote it, but I discarded it. It was so absurd, so unrealistic, and so expensive that I assumed such a thing was fiscally irresponsible. That’s the option they ended up going with. I only have myself to blame for this lack of foresight; after all, I even said before that Blizzard has vast resources and talent at its disposal. Their engineers considered the available options and chose the one which made sense to them.

But why? Why risk the millions of possible regressions that come with trying to force a newer system to emulate such a complex old system, especially one where the nuances of the system are a critical part of the experience? There are a few talks from Blizzard engineers on this topic, but perhaps the most appropriate one is the “[Restoring History: Creating WoW Classic](https://www.youtube.com/watch?v=hhKkP8LryYM)” panel from Blizzcon 2018. In this presentation, the engineers don’t give a strong reasoning behind their choice of direction. They briefly gloss over some pros and cons, but I imagine most folks at that panel didn’t care too much about the engineering behind Classic. So, we’re left to pick from the crumbs and make assumptions.

## Blizzard: A Gaming Enterprise

Blizzard Entertainment, the game studio underneath the parent company Activision-Blizzard, has over 5000 employees. They are a $700 million dollar business. Obviously, this is massive. Compared to their size at WoW’s launch in 2004—around 400 people—the scale of their operations has grown by an order of magnitude. They’re playing in the big leagues now, and they’re on the same turf as many major corporations. As a result, it only makes sense to think of them from a corporate perspective, and what’s the most important thing to corporate IT? Infrastructure.

Infrastructure maintenance, stability, and growth are among the foremost concerns of corporate engineering teams. The rise of platforms like Kubernetes, DevOps and SRE roles, and cloud computing has demonstrated how pivotal infrastructure is to the success and resiliency of a company. Blizzard is surely no different. While it’s impossible to know what their infrastructure looks like today, I guarantee it’s nothing at all like how it was 15 years ago.

Teams move away from old infrastructure because they outgrow it, sure, but they also move away because of the flaws. Lack of scalability, technical debt, security holes, dead technologies; any of these alone are perfectly valid reasons to update your infrastructure. I imagine Blizzard, a company with zero experience in MMO infrastructure in 2004, had all these and many more. To a team operating at this scale, returning back to the ancient “broken” infrastructure would be poisonous to the entire ecosystem. The entire platform is at risk if a single component is weak.

Infrastructure was almost certainly the reason Blizzard chose to use the modern WoW code as a starting point. The team simply could not take the risk of running ancient servers, designed for hardware and networks that are no longer available, on their systems. They couldn’t expose their customers to the Internet of 2019 with a client from 2004. The cost/benefit analysis was likely very conclusive: it’s cheaper and safer to just throw programmers at the problem.

## Eventual Consistency

Throw programmers at the problem they did. A year passed between the initial announcement and the first playable demo at Blizzcon 2018. I presume they waited until they knew how to solve the problems before announcing the project, so it’s reasonable to say that by late 2017 they had chosen to re-implement Classic’s logic on the modern architecture and had learned how to import the old data structures. This means that the year between Blizzcon 2017 and 2018 was almost certainly spent entirely on game systems.

This alone was not enough. Famously, Classic had a lengthy closed beta period and several public stress tests where players were finding bugs left and right. Many of them were indeed regressions introduced by the modern engine. Especially interesting were the defects found that were also defects in the original game. The above-linked panel from Blizzcon 2018 demonstrates one of them: a missing texture on a lamp, defective for 15 years—long enough that, like most unfixed bugs, it became a feature. Of course, passing through the fog of time is hard for even the best of us, so many of these “bugs” were actually intended behavior.

Indeed, Blizzard could not have simply left the recreation of 15-year-old logic to fading memories and speculation, so they created an internal version of the game as it truly existed in 2006. At a small scale, without being publicly exposed, they were able to use the old 1.12 server as a rubric of sorts. It served as the authoritative guide for the nuances of the old systems.

In a very intelligent move, Blizzard used a combination of internal testing, player testing, and the original systems to check their re-implementation. This allowed them to use their modern infrastructure for the live game, while still eventually ending up at a ruleset so very close to 1.12, even down to reproducing bugs and long-surpassed architectural limitations. While I have no doubt that more bugs will be found when the game goes lives on August 26th, this “eventual consistency” approach is, in hindsight, certainly the correct approach for a company like Blizzard.

## Grats!

So, congratulations are in order. Blizzard has managed to satisfy two camps of people notoriously difficult to satisfy: ops teams and players. While it remains to be seen how stable the launch is, the beta and stress test periods have already shown us just how good a job they’ve done with the authenticity of the systems. What seemed to me like an absurdity turned out to be the perfect solution. I think there’s a lesson to be learned in there somewhere.

Also, to whomever spoke up at Blizzard and pushed hard for the investment into Classic, I specifically offer you my thanks. Without you, the company may still be telling us just how much we think we do, but we don’t.