---
layout: post
title:  "The Cyborg Strategy"
date:   2022-02-21 04:25:50 +0000
categories: blog
tags: quality development operations
excerpt: "Transforming legacy software with... cybernetics?"
---

Imagine you live in a dystopian cyberpunk future full of technological implants capable of enhancing your abilities beyond the capacity of a normal human. You can get bionic eye implants to improve your sight, ear replacements to give you the sensitive hearing of a dog, artificial blood and organs to supercharge your athletic performance, and a potent cocktail of drugs which unlock and amplify your mind. Eagerly, you snap up all these opportunities. Before long, over half your body is cybernetic. At what point, after all these "upgrades," are you no longer yourself? Where is the threshold across which you become something else entirely?

Over three years ago now, I wrote an article titled [The Inertial Deathblow]({% post_url 2018-06-12-the-inertial-deathblow %}) where I theorized that having decision makers mired deep in their own inertia is a critical hindrance to a competitive business. Time has only strengthened my experience here—since the original article, I've watched some very promising projects get flushed because of a few myopic leaders. Once those folks left or were removed from decision-making roles, I watched as newer and better solutions flourished.

One thing continually struck me as odd, though. I alluded to this at the end of that first piece: the "correct" option is usually to build on top of the old stuff... **_sort of_**. But that's not what I saw. Let me show you why it didn't happen that way, and at the same time you'll come to understand what I mean when I say "sort of."

## Legacy Resists Change

Instead of happening _within_ the old code, all that cool new stuff was created entirely _around_ it. Sometimes modules would get broken off to live somewhere near the old behemoth and speak its arcane, dead language, but most of the time the developers of the shiny modern systems avoided it like the plague. If you've worked in software engineering for long, you'll already understand why this happened, but if not, let me explain.

<div style="float: right; padding: 10px 10px 10px 30px; min-width: 200px; max-width: 300px;">
<img src="/images/katamari.jpg" />
</div>

The first iteration of any system is almost always a monolith, especially when it's being written by a start-up team and/or by newer developers. Monoliths are not, inherently, bad. In fact, from an architecture perspective, I'd wager all solutions should begin as "trivial monolith" and only become more complex as necessary from there. However, monolithic applications have some key weaknesses. One of the most impactful is the tendency for them to slowly acquire their own gravity. As they grow, and as things get bolted onto them, they act as Katamaris, growing bigger and sucking up more and more things until eventually they become their own little planets with complex ecosystems.

The sheer force which can be exerted by a large monolithic application is unmatched. Skilled developers can defend against it, but most shops don't exclusively employ folks trained in the art of anti-gravity. These systems can create vast wells of tribal knowledge, which makes them resistant to training and documentation. Since all the application logic lives in one place, devs tend to store all the data in one place too, creating monolithic databases. These behemoths are huge single points of failure often only mitigated by vast, expensive backups and wasteful failover clusters. Straddling all this is the inertia created by having such a large, tightly-knit system. Despite the technical debt it generates, it was created as a single infallible unit and, by its very nature, has tightly interwoven its various units and created omniscient dependencies which become nearly impossible to unwind.

As a result of this tendency, it becomes very challenging to change the monolith. Often, logic within it depends so strongly on other pieces of itself that it cannot be meaningfully reused anyway—so developers don't. They just write new code which does functionally the same thing any time they need to interact with a piece of the legacy system. However, as hinted earlier, these monolithic systems have their own arcane language. They often do not present any sort of API at all; the monolithic logic directly manipulates its components. So, if your external software wants to interoperate with the system, it must either:

1. Directly manipulate the monolith's components as well, causing the new software to take a transitive dependency on the monolith anyway. It must "play nice" with the monolith and access the system the same way, but without being able to use the same code modules due to a spider web of internal dependencies. Or...
1. Throw away the old system and reimplement it from scratch. Or...
1. Carefully operate on the monolith, excising and enhancing pieces of it to create an API where one never existed before.

It's this third option which we're going to focus on as the superior strategy.

## A Cybernetic Organism

Perhaps the most important lesson to learn about monolithic systems is that they were almost never intended to be so gravitational. Do not make the mistake of hating the original developers—instead, try to understand them. Put yourself in their mindset. Why would they have created the application/service/system the way they did? What forces were acting on them which kept them from making better decisions? When were these decisions made and how does that affect the context? Answering these questions will help you avoid making the same mistakes, sure, but it will also inevitably lead you to a dire conclusion.

> All software, long-enough lived, will eventually become a monolith.

It is crucial that you understand this; otherwise, it cannot be countered. All designers, developers, and stakeholders on a piece of software must keenly grasp this truth. The mitigation requires cooperation from everyone, from the architects and product owners through the most entry-level engineers. 

Armed with this knowledge, you will grok a universal law: **monoliths are a part of software systems and must be handled**. They emerge from well-intentioned systems after years of bolt-on additions, quick 'n dirty hacks, inexperienced teams or developers making poor or uninformed decisions, and late night crunch time. Whether it was designed as a monolith or was once a tiny little microservice, the unyielding entropy which bloats and contorts software in the real world nudges it ever closer to its fate.

So, how do you handle monoliths? Many junior devs will argue for scrapping the whole thing and starting from scratch. This works for trivial applications, unimportant systems, or for companies with ludicrous amounts of expendable capital, absolutely. But, most commonly, an application which became a monolith evolved that way because it was too massive and integral to the business. Even if you tried to run the new system in parallel with the old, the chance of introducing critical regressions at that scale of change nears 100%. 

No, the answer is not to scrap the monolith. You must instead replace its organs with cybernetic enhancements.

## Living Tissue Over a Metal Endoskeleton

Fundamentally, all units within a piece of software can be replaced... eventually. The nature of most programming languages means that coming into a given unit of logic, you have a few inputs:

* "Global" state (e.g. global variables, static fields)
* Module-level state (e.g. instance fields/properties)
* Local state (e.g. parameters to the unit, variables in the unit scope)

...and a few outputs:

* Side-effects on shared (global or module) states
* I/O operations
* Return values

Well-written code will likely be very careful about how these inputs and outputs flow through a unit, usually tending toward a functional style, but sadly not all code is well-written. Legacy, monolithic code very often tries to manipulate any state it can legally touch, all across the application, without any consideration to how those side-effects might affect anything else. This makes the proposition of trying to replace any given unit a daunting one. Often, it can feel impossible to unwind the various layers of dependencies a method might take. However, **it is possible**. You just have to be willing to accept some compromises and commit to a vision. And, in the spirit of _agile_, make sure each iteration is bringing its own value, because you never know when conditions will change and your vision will get shelved.

### Thought Exercise

Let's take a close look at a fairly trivial example (**WARNING: intentionally bad code ahead**):

```csharp
// This code is intentionally very bad in so many ways
public AssetOperationEvent CreateAsset(AssetViewModel asset)
{
    using (var repo = Repositories.CreateRepository<AssetRepo>())
    {
        var newAsset = this.AssetConverter.MapViewModelToModel(asset);
        var img = repo.LoadImage(asset.Image);
        img = ImageHelpers.Validation.SizeLimiter(img);     // throws if invalid
        if (newAsset.Name.Trim().Length > 0)
        {
            repo.SaveImage(newAsset, img);
            newAsset.ImageData = img;
            repo.SaveAsset(newAsset);
            return AssetOperationEvent.Successful(newAsset);
        }
        else
        {
            throw new InvalidOperationException("Name is required");
        }
    }
}
```

If you've been tasked with creating a new Asset Management REST API, but the old asset-related functionality in the monolithic application must persist, how would you approach it? Would you...

1. Move the asset creation logic into a library which can be shared by both the API and the monolith?
1. Rip the logic out of the monolith entirely, put it into the API, and have the monolith call the API?
1. Change the front-end to call into the new API instead of the monolithic back-end when creating assets?
1. Rewrite the asset creation code in the API, have it integrate with the same tables as the monolith, and maintain both code paths?

Seriously, stop reading for a minute and decide which one you'd choose. I'll wait.

---

Have you decided? Good. Let's break down the pros and cons of each of these options.

**Option 1**: <span style="background-color: rgba(50,50,0,5);">_Move the asset creation logic into a library which can be shared by both the API and the monolith_</span><br />
If you picked this one, you're going to end up unwinding spaghetti for a long time. Your library is going to have to introduce a new transitionary [DTO](https://en.wikipedia.org/wiki/Data_transfer_object) between `AssetViewModel` and `Asset`, know about the repository class (and therefore the database connection), contain all of the image validation (which isn't necessarily only used here), discover and reimplement the implied business rules enforced by exceptions that could be thrown by your transitive dependencies, and so on. Going down this road is a path to pain. That being said, it's also one of the only options which keeps you from needing to rewrite the business logic, which lessens the chance of regressions.

**Option 2**: <span style="background-color: rgba(50,50,0,5);">_Rip the logic out of the monolith entirely, put it into the API, and have the monolith call the API_</span><br />
This might seem like the most straightforward approach at first glance, but you're still saddled with needing to understand and reimplement various layers of business rules which are not immediately obvious. On top of that, you've also introduced another network hop—calls to create an asset now must travel from the front-end, to the back-end, to the API, and back again. Perhaps a single additional hop isn't so bad, but when this gets out of hand, [it can be catastrophic](https://www.youtube.com/watch?v=gfh-VCTwMw8). This isn't even considering that, assuming your new API is following some semblance of best practices, you'll also need to worry about service-to-service authentication and authorization.

**Option 3**: <span style="background-color: rgba(50,50,0,5);">_Change the front-end to call into the new API instead of the monolithic back-end when creating assets_</span><br />
Perhaps the "cleanest" of the four options (in the sterile sense), this option still requires that your new API reimplement all of the business rules, and as we've found, this is not trivial. It can also create fragmentation on your front-end application as those developers hack in branching paths for each of the operations your API supports vs. the ones it doesn't yet. However, it removes the need for multiple back-end code paths, and doesn't introduce an extra network hop.

**Option 4**: <span style="background-color: rgba(50,50,0,5);">_Rewrite the asset creation code in the API, have it integrate with the same tables as the monolith, and maintain both code paths_</span><br />
Frankly, it turns out that most of the other options are going to have you rewriting a significant portion of the asset creation code anyway. Unfortunately, this option introduces the highest amount of additional maintenance cost. Now you've got two separate, completely distinct logical paths trying to implement the same business rules against the same backing tables. They must target the same tables, or else operations against the API won't show up in the monolithic application and vice versa. Any deviance between them could violate business rules and cause hard-to-diagnose errors in either system. Maybe the most damning disadvantage of this approach is that it doesn't do anything to discourage the monolith. Since both code paths continue to exist, the default one will continue to be the monolith's version. Your new logic will always just be a copycat.

---

None of these options are ideal, but they all have something in common. They create a new component which does the same thing, but better in some way. Boiling them down to their best aspects, you wind up cutting out the capability from the old thing and hooking up all the connective tissue to the new. Hence the name: _the Cyborg Strategy_, an approach based in maintaining legacy systems by slowly upgrading them, unit by unit, towards a fundamentally different architecture.

## Looking In the Mirror

The important part of this strategy isn't just ripping functionality out from a monolith and replacing it with a newer, better, modular component. It's the idea that over time, more and more pieces of the system will work this way, all while maintaining the veneer of the old system. At the beginning of this article I asked, "where is the threshold across which you become something else entirely?" The philosophy behind this approach is that eventually, you'll reflect back on the old code and realize that it's not the same application anymore—like our hypothetical cyborg looking in the mirror and realizing they're no longer truly human.

<div style="float: left; padding: 10px 10px 10px 30px; min-width: 200px; max-width: 300px;">
<img src="/images/terminator-mirror.jpg" />
</div>

I've made this whole thing sound pretty amazing, but this strategy is not without its downsides. The act of surgically removing the "organs" of your old code gets easier as more and more units are removed, but early on it can be a massive investment fraught with compromises. You'll often find yourself taking less desirable routes—like in our trivial example above, you might need to reimplement small pieces and find ways to keep it all working together without bringing down the house of cards. 

These compromises are acceptable so long as you're continuing to bring value with each surgery, but what about when you can't? What about those scenarios so intertwined or fragile that you can only remove large, interlocked chunks at a time? In these situations, I'll cite Martin Fowler, from his article _[Is High Quality Software Worth the Cost?](https://martinfowler.com/articles/is-quality-worth-cost.html)_:

> The annoying thing is that the resulting crufty code both makes developers' lives harder, and costs the customer money. ... High internal quality reduces the cost of future features, meaning that putting the time into writing good code actually reduces cost.

Code that can only be operated on in massive, expensive chunks is absolutely _overgrown_ with cruft. At some point, the value proposition for that surgery overwhelms any counter-arguments. There's no way that your legacy code could simultaneously be so easy to maintain and update that it remains cheap to do so, yet so hard to split apart and modularize that it must be tackled in huge projects. They're mutually exclusive. 

The mechanics of pitching this value to the business are out of scope here—a topic for another article. Maybe I'll write that one in 2025. Nevertheless, you will find yourself at a point where your path leads you here: removing and replacing components of a legacy application with augmented pieces in order to evolve it toward a better architecture over time. Your objective is to look back on yourself and your team and realize that the application you started with is gone, replaced by the cybernetically enhanced version you've been piecing together over months or years.

## Sacrifice 👍

Once you've finally created a cyborg, what should you do with it? It still wears the face of the application it used to be, and probably still hosts some amount of the original logic, but most of the truly valuable pieces have been modularized. Ultimately, there are three possible fates for this wayward hybrid.

1. **Continue supporting it until deprecation**. There is a strong argument for keeping it alive, serving its original purpose until the business no longer needs it. You'll continue paying technical debt on those leftover bits, but eventually, conditions and requirements will change enough that the app can be retired. New systems can come in and take advantage of the APIs you've created in a harmonious way, the extracted logic continuing to provide value for years.
2. **Transplant everything that remains into a new, more suitable form**. By the time you've reached this stage, the facade of what the app once was is now vestigial. All of the value generation occurs elsewhere. There is even more value to be gained by "finishing the job" and moving the leftovers into a more accommodating form, essentially just continuing the augmentation you've been doing until almost 100% of the old code is gone.
3. **Sacrifice the old shell**. This is a good opportunity to revisit the original business needs served by this hybrid system. You may find that it's time to cast aside the potentially ancient assumptions that fed into its creation and start fresh with a new set. After all, the valuable parts have been removed and can now be leveraged by the new shell.

Which option is correct for you depends on the requirements, the application, your roadmap, and more. You've painstakingly bought yourself these opportunities. Choose wisely.

## Finale

Did I abuse the whole "cyborg" metaphor too much? Obviously _I_ don't think so, but I'm biased. I wrote the damn thing.

I'm aware that these ideas aren't new—though I haven't read them yet, I know there are books [by Martin Fowler](https://www.amazon.com/dp/0134757599) and [Michael Feathers](https://www.amazon.com/dp/0131177052) which cover these topics in much greater detail, I'm sure. However, I wanted to share and express my philosophy and mindset behind how best to break down monolithic legacy applications. It's a topic about which I have a lot of passion and, I believe, some unique perspectives. 

I truly hope this helps someone wrap their head around an often overwhelming and difficult problem, and gives them some hope that it can be done. If you want additional reading, I recommend checking out everything I've linked within the article—there are some amazing resources out there on this topic, since it's something almost every engineer runs into during their career.

Next time, I'm going to follow up on another of my teased articles and discuss how certain hiring practices and team structures feed into failure and promote the development of these nasty monoliths.