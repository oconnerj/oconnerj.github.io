---
layout: post
title:  "On the quality problem of today's software engineers"
date:   2016-03-31 01:47:15 +0000
categories: blog
tags: quality hiring development
---

<div style="float: right; padding: 10px 10px 10px 30px; min-width: 100px; max-width: 300px;">
<img src="/images/sad_programmer.png" />
</div>

Over the past few months (pretty much since I started a new job in October) I've been conducting a lot of interviews. This new company I'm working for is growing rapidly and has a desperate need for more developers. Normally, this is pretty straightforward: you gather some resumes, do some interviews, and narrow them down until you find a good candidate for the job. However, this company has a very refreshing point of view on hiring. It's a point of view I wish more companies could follow: we will not hire anyone unless we feel **110%** confident they'll be a good fit.

Now, that might seem obvious. "Who hires people that can't do the job?", you ask with a smarmy little smirk. "That's _why_ you're doing interviews." 

But you're wrong. You—the imaginary _you_ that I've invented as a straw man for my argument—are an idiot if you think that most companies aren't just hiring the _least stupid_ person that walks in the door, because they are. In many cases, they're not even bothering to make people write code in their interviews.

I could write an entire article about how a company ends up hiring people that are obviously not qualified for a job, but that's not what I'm most worried about. What I'm worried about is that in the nearly 6 months we've been doing interviews, we haven't been able to hire a single person.

## The State of Things

Since November we've interviewed at least 10 people for a Senior Software Engineer job. This person is expected to be very comfortable in C#, know ASP.NET MVC and Entity Framework pretty well, have experience in web development (preferably using Angular), and have a working understanding of SQL. That description applies to both our Level 3 position and our Senior position; the difference between the two is that a Senior is expected to have more experience and a set of intangible qualities that would make them a good leader.

Of those 10 people, only two of the applicants have even met the requirements for our Level 1 position. Let me stress that again: of the **ten** people that have applied for our Senior Software Engineer position, only **two** of them were even qualified for an entry-level position. What the hell?!

Some of these applicants were leads or seniors at their current/previous jobs. Some of them were barely-out-of-college kids who thought that playing around with a technology for a few hours meant that they had a firm grasp on its complexities. Yet eight of those applicants couldn't answer basic C# questions. Here's an example question from our interview checklist:

> "Tell me the difference between a reference type and a value type, and provide some examples of each. Why would you use a value type over a reference type?"

Only one of those eight could provide any kind of intelligible answer to that question. How does this happen? Who is going around applying for senior-level positions when they're barely capable of producing "Hello World"? Lots of people, apparently. The worst part is that most of these folks, I'd wager, have no clue just how much they suck.

## The Formula for Suck

Getting back into the "companies are hiring the least-stupid candidate" idea, imagine this for a second: you're a middle-tier manager at a company (let's call them Golden Persisting) and you need to fill a Level 3 Software Engineer position. You've only got a shoe-string budget, because upper management keeps telling you that your department is an expense and keeps chopping it in half. Instead of the market salary (`X`) you can only afford to pay a fraction of that (`0.75X` or less).

Naturally, all of the skilled candidates know they can make `X` instead of `0.75X`. Instantly you lose those folks. What you've got left are fresh-faced newbies, who are a gamble but will take lower pay, and people blowing smoke up your ass. Both of these types will overestimate their skill level, but dammit, you have to hire _someone_ or else you're going to miss your deadlines! To top it all off, if you wait too long to fill the position, upper management will cut it out of the budget, because you clearly didn't need it, right?

As a result of your need to make a hire and the lacking budget, you end up hiring the least stupid of those newbies or smoke-blowers. Now, that person has a higher-level position on their resume. They are suddenly "worth" that position. Once they decide they're ready to move up, they'll find that Golden Persisting has no opportunity for advancement. Suddenly, our under-qualified Level 3 developer is on the prowl for a Senior-level position.

That's how it happens. Well, that or any of the hundreds of similar scenarios that corporate development produces. Those fresh-faced newbies are likely to end up as the next wave of smoke-blowers as they find themselves in jobs they're not quite prepared for. The old smoke-blowers end up in management, usually due to their tenure in their lead positions. It's a vicious cycle of suck.

## The Fateful Eight

I wish I could sit here and tell you that this rampant quality problem has a simple solution. The issues are myriad, however, and there's little to no chance that most of them will ever be fixed. Let's look at a few of our fateful eight Senior Engineer candidates for some less-than-elegant examples of why this problem is endemic:

* One of the candidates attended a school infamous for its poor IT program and literally admitted he had never hand-written a line of code in his life; he had only copy/pasted.
* Another candidate spat out all the buzzwords, but when pressed to elaborate came up empty. He ended up being a Java-only developer who had never touched C# before.
* The most promising of the eight developers told us a story about how he made a "bold" move one night and ripped out half the codebase and replaced it overnight, without telling anyone about it. He mentioned that "it caused problems and bugs for months". He told us this story in response to a prompt asking for a time that he had taken charge and led the team.

At this point, you're probably asking a very relevant question: why didn't you filter these guys out before they even made it to the interview stage?

## The Problem With 110%

We didn't filter these guys out because in each and every case, their resumes and phone interviews were just fine. We tend not to give a lot of weight to a resume. After all, as we've seen a hundred times, a resume is usually more filler than thriller and its accuracy is dubious at best. Instead, we rely on a phone interview conducted by our in-house recruiter as the first line of defense. God knows how many potential candidates she's eliminated using the phone interview; I haven't asked and I don't want to know. The ten folks that we've interviewed in-person were people who passed the phone interview filter.

Our phone interview is no joke, either. We ask about 12 questions that run a gamut between basic C# to advanced topics, but there's only so much you can do over the phone. The questions have to be designed in such a way to prevent long, rambling responses (the recruiter is smart but she's no techie; she would have a hard time distinguishing the correct rambling answer from the wrong one), while also getting a quick gauge of which position they'll be recommended for. The Senior-level recommendations answer at least 8 of the questions correctly and (importantly) _do not_ try to BS the other four.

The only explanation I have for some of these folks is that they were googling the questions as the recruiter asked them. Honestly, though, some bad apples were always going to slip through. Phone interviews are not an amazing way to filter candidates, and we might as well not even look at their resumes for all the good they've done us. Ever since I started doing interviews I assumed that I would end up face-to-face with some stinkers occasionally... but an 80% stinker rate shocks me.

Now, finally, you can see the downside of only hiring candidates who fit in 110%. Our team is still woefully understaffed and overworked with no end in sight. The idea of taking the plunge and hiring some of the most promising of the candidates is looking better and better. Of course, if you take "most promising" and put a pessimistic spin on it, you get "least stupid".

## How We Can Do Better

I still wouldn't change the hiring policy for anything, though. The value of employing people who are [smart and get things done](http://www.joelonsoftware.com/articles/GuerrillaInterviewing3.html) far outstrips the cost of being understaffed. The question is, how can we do better? What can we—employers, educators, current and prospective engineers—do to improve the overall quality in our field?

If you're an aspiring engineer, allow me to pass some advice on to you. Be good at what you do and take pride it in, without being prideful. Teach yourself new things for the sake of it, because you have a passion for programming. Learn how to sell yourself without lying or exaggerating. And most importantly, _realize that everyone has to start somewhere_ and you're not ready to start at the top. No one has anything to gain from hiring a disingenuous developer into a position they're not ready for, not even you.

If you're an educator teaching programming to those fresh-faced newbies, don't just have students memorizing syntax rules for regurgitation on the test. Teach them how to apply what they've learned. Engage them in the power of code. Make them think like coders. There will always be students that show up just to get the degree so they can go earn a paycheck; don't spend too much time on them. Learn to spot the promising ones and get them involved, so that if they didn't already have a passion for programming, they might develop one.

And, for the employers out there hiring under-qualified dunces into positions way over their heads, let me tell you: I feel for you. I've interviewed them, I've worked with them, and I've been a victim of the smoke-blowers. I understand the corporate world; I know our departments tend to be the first to get cuts and the last to get appreciation. I encourage you to read [The Mythical Man-Month](http://amzn.com/0201835959), a classic tome of wisdom that too few in our industry actually take to heart. Remember that one great engineer is worth three average ones, and... well, have fun explaining to your bosses that you can't just hire a million monkeys to reproduce the works of Shakespeare without producing a million monkeys' worth of feces while you're at it.