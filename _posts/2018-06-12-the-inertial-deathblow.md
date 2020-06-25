---
layout: post
title:  "The Inertial Deathblow"
date:   2018-06-12 23:20:15 +0000
categories: blog
tags: quality development operations
excerpt: "The story of how putting inertia-bound individuals into leadership spells doom for your team, and potentially your business as a whole."
---

In my career up to this point, I've had the pleasure (and sometimes displeasure) of working with a huge swath of individuals from all walks of life. I've worked with fresh-faced kids straight out of college with a ton of passion; grizzled veterans; smoke-blowers with few actual skills; flighty wizards who could fix anything in a day, if you could just get them to focus—the list goes on. However, nothing makes me more sad than the folks so bogged down in their own inertia that they've lost their ability to be creative. Here's how brainstorming sessions go with these people:

> _You:_ "Let's consider using Docker for this service." <br />
> _Them:_ "No, we can't do that." <br />
> _You:_ "Why not?" <br />
> _Them:_ "Because, we've never done that before. Besides, Docker isn't proven technology."

It makes me want to pull my hair out when someone dismisses an idea out of hand like this. Solving problems in the software industry is all about choosing the right tool for the job. Innumerable factors go into that choice, but you _must_ be willing to consider any solution, or you're not doing your due diligence. To be clear, I'm not trying to dismiss the benefits of using familiar solutions, or rock-solid and time-tested tech stacks. It's just... those are _considerations_ that factor into the decision you make, not road blocks themselves.

Technology advances. New stacks have benefits that old ones lacked; after all, they were put together by someone to solve a problem. If it's popular and well-supported, it's solving that problem for a lot of people. True, you can solve pretty much any problem with any tech stack. There are shops out there supporting petabytes of data and thousands of users on top of ancient mainframes and COBOL. However, as a business grows, the problems grow and shift alongside it. Sometimes you have to give up the old comfortable tools and move on to something that is better suited to solving the problems you have _today_ instead of the problems you had _five years ago_.

Let's put aside some of the other reasons you should consider moving away from aging tech stacks, like the inability to hire anyone. I want to focus on this: if a company gets enough of those inertially-bound people in decision-making roles, it's a deathblow for the business. The company's problem-solvers are stuck in the past, which means the business can't grow. Any attempts to grow are met with...

1. **Resistance**. _"Our servers can't handle that!"_
1. **Failure**. _"We wrote 20,000 lines of code over the weekend to reinvent the wheel, but there were some bugs, so it didn't work at all and we were down for 4 hours."_
1. **Sluggishness**. _"I estimate about 6.5 months to complete this project. What do you mean our competitors did it in two weeks?! There's no way!"_
1. **High cost**. _"We'll need to buy two new VM hosts so we can spin up the six new servers dedicated to this service. They'll be idle 75% of the time, but we'll really want all six servers at peak load, so we need six."_
1. **Resignation**, the worst one of all. _"Sure, whatever, we'll get it done. Just hack some shit together and ship it. It doesn't matter, the architecture is fundamentally broken anyway."_

I wish I were making these up, but I'm drawing from (exaggerated) real-world experience here. At no point in these conversations did anyone else recommend making changes to the tech stack to strike a better balance between the available hardware and the current-day workload requirements. Any time I brought it up, it was shot down. Why? "We can't do _that_. We've never done it before. It's not proven technology."

Innovation is the lifeblood of companies in competitive markets, and inertially-bound people are the enemy of innovation. Look, I get it. I really do. Change can't happen overnight, and it's often expensive in terms of manpower, capital expense, or both. But, if you don't make room for it, you're going to quickly end up as the last horseback cavalry unit in the era of unmanned drone strikes.

Anyway, enough ranting for now. Next time, I'm going to dive into a little more depth and talk about some of the causes of career inertia, how to avoid it yourself, and how to make those judgment calls on when to go with something new instead of leaning on an old stack. Spoiler alert: despite everything I just said, 90% of the time the correct answer _actually is_ to build onto the old stack... sort of. You'll see what I mean.