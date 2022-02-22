---
layout: post
title:  "The Cyborg Strategy"
date:   2022-02-21 04:25:50 +0000
categories: blog
tags: quality development operations
excerpt: "Transforming legacy software with... cybernetics?"
---

Imagine you live in a dystopian cyberpunk future full of technological implants capable of enhancing your abilities beyond the capacity of a normal human. You can get bionic eye implants to improve your sight, ear replacements to give you the sensitive hearing of a dog, artificial blood and organs to supercharge your athletic performance, and a potent cocktail of drugs which unlock and amplify your mind. Eagerly, you snap up all these opportunities. Before long, over half your body is cybernetic. At what point, after all of these "upgrades," are you no longer yourself? Where is the threshold across which you become something else entirely?

Over three years ago now, I wrote an article titled [The Inertial Deathblow]({% post_url 2018-06-12-the-inertial-deathblow %}) where I theorized that having decision makers mired deep in their own inertia is a critical hinderance to a competitive business. Time has only strengthened my experience here—since the original article, I've seen some very deep pits of failure develop in the various professional spaces I occupy. Once those myopic folks left, or were removed from decision-making roles, I watched as new and better solutions flourished. One thing struck me as quite odd, though, and it's something I alluded to at the end of that last piece.

## Legacy Resists Change

All of the cool, new stuff popping up happened almost entirely _around_ the old, existing code, as opposed to _within_. Sometimes these services would break off a module to live somewhere near the old monolith and speak its arcane, dead language, but most of the time the developers of this new code elected specifically to avoid it. If you've worked in software engineering for very long, you'll understand why this happened, but if not, let me explain.

<div style="float: right; padding: 10px 10px 10px 30px; min-width: 200px; max-width: 300px;">
<img src="/images/katamari.jpg" />
</div>

The first iteration of any system is almost always a monolith, especially when it's being written by a start-up team and/or by newer developers. Monoliths are not, inherently, bad. In fact, from an architecture perspective, I'd wager all solutions should begin as "trivial monolith" and only become more complex as necessary from there. However, monolithic applications have some key weaknesses. One of the most impactful is the tendency for them to slowly acquire their own gravity. As they grow, and as things get bolted onto them, they act as Katamaris, growing bigger and sucking up more and more things until eventually they become their own little planets with complex ecosystems.

The sheer force which can be exerted by a monolithic application is unmatched. Skilled developers can defend against it, but most shops don't exclusively employ well-trained devs. These systems can create vast wells of tribal knowledge, which makes them resistant to training and documentation. Since all the application logic lives in one place, devs tend to store all the data in one place too, creating monolithic databases. These behemoths are huge single points of failure often only mitigated by vast, expensive backups and wasteful failover clusters. Straddling all this is the inertia created by having such a large, tightly-knit system. Despite the technical debt it generates, it was created as a single infallible unit and, by its very nature, has tightly interwoven its various units and created omniscient dependencies which become nearly impossible to unwind.

As a result of this tendency, it becomes very challenging to change the monolith. Often, logic within it depends so strongly on other pieces of itself that it cannot be meaningfully reused anyway—so developers don't. They just write new code which does functionally the same thing any time they need to interact with a piece of the legacy system. However, as hinted earlier, these monolithic systems require speaking their own arcane language. They often do not present any sort of API at all; the monolithic logic just takes direct dependencies on its components. So, if your external software wants to interoperate with the system, it must either:

1. Directly manipulate the monolith's dependencies, causing the new software to take a transitive dependency on the monolith anyway, since it must "play nice" with the monolith and access the system the same way, but without being able to use the same code modules, or...
1. Throw away the old system and reimplement it from scratch, or...
1. Carefully operate on the monolith, excising and enhancing pieces of it to create an API where one never existed before.

It's this third option which we're going to focus on as the superior strategy.

## A Cybernetic Organism

Perhaps the most important lesson to learn about monolithic systems is that they were almost never intended to be so gravitational. Do not make the mistake of hating its original developers—instead, try to understand them. Put yourself in their mindset. Why would they have created the application/service/system the way they did? What forces were acting on them which kept them from making better decisions? When were these decisions made and how does that affect the context of them? Answering these questions will help you avoid making the same mistakes, sure, but it will also inevitably lead you to a dire conclusion.

> All software, long-enough lived, will eventually become a monolith.

It is crucial that you understand this; otherwise, it cannot be countered. All designers, developers, and stakeholders on a piece of software must keenly grasp this truth. The mitigation requires cooperation from everyone: from the architects and product owners through the most entry-level engineers. 

Armed with this knowledge, you will grok a universal law: **monoliths are a part of software systems and must be handled**. Many junior devs will argue for scrapping the whole thing and starting from scratch. This works for trivial applications, unimportant systems, or for companies with ludicrous amounts of expendable capital, absolutely. But, most commonly, an application which became a monolith evolved that way because it was too massive and integral to the business. Even if you tried to run the new system in parallel with the old (which is expensive in both people and hardware), the chance of introducing critical regressions at that scale of change nears 100%. No, the answer is not to scrap the monolith. You must instead replace its organs with cybernetic enhancements.

## Living Tissue Over a Metal Endoskeleton

Fundamentally, all units within a piece of software can be replaced... eventually. The nature of most programming languages means that coming into a given unit of logic, you have a few inputs:

* "Global" state (e.g. global variables, static fields)
* Module-level state (e.g. instance fields/properties)
* Local state (e.g. parameters to the unit, variables in the unit scope)

...and a few outputs:

* Side-effects on shared (global or module) states
* I/O operations
* Return values

Well-written code will likely be very careful about how these inputs and outputs flow through a unit, usually tending toward a functional style, but sadly not all code is well-written. Legacy, monolithic code very often tries to manipulate any state it can legally touch, all across the application, without any consideration to how those side-effects might affect anything else. This makes the proposition of trying to replace any given unit a daunting one. Often, it can feel impossible to unwind the various layers of dependencies a method might take. Here's a fairly trivial example (**WARNING: intentionally bad code ahead**):

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
1. Just rewrite the asset creation code in the API, have it integrate with the same tables as the monolith, and maintain both code paths?

Seriously, stop reading for a minute and decide which one you'd choose. I'll wait.

---

Have you decided? Good. Let's break down the pros and cons of each of these options.

**Option 1**: <span style="background-color: rgba(50,50,0,5);">_Move the asset creation logic into a library which can be shared by both the API and the monolith_</span><br />
If you picked this one, you're going to end up unwinding spaghetti for a long time. Your library is going to have to somehow also understand how to convert `AssetViewModel` into `Asset` (or create its own new DTO), know about the repository class (and therefore the database connection), contain all of the image validation (which isn't necessarily only used here), discover and reimplement the implied business rules enforced by exceptions that could be thrown by your transitive dependencies, and so on. Going down this road is a path to pain. That being said, it's also one of the only options which keeps you from needing to rewrite the business logic, which lessens the chance of regressions.

**Option 2**: <span style="background-color: rgba(50,50,0,5);">_Rip the logic out of the monolith entirely, put it into the API, and have the monolith call the API_</span><br />
This might seem like the most straightforward approach at first glance, but you're still saddled with needing to understand and reimplement various layers of business rules which are not immediately obvious. On top of that, you've also introduced another network hop—calls to create an asset now must travel from the front-end, to the back-end, to the API, and back again. Perhaps a single additional hop isn't so bad, but when this gets out of hand, [it can be catastrophic](https://www.youtube.com/watch?v=gfh-VCTwMw8). This isn't even considering that, assuming your new API is following some semblance of best practices, you'll also need to worry about service-to-service authentication and authorization.

**Option 3**: <span style="background-color: rgba(50,50,0,5);">_Change the front-end to call into the new API instead of the monolithic back-end when creating assets_</span><br />
Perhaps the "cleanest" of the four options (in the sterile sense), this option still requires that your new API reimplement all of the business rules, and as we've found, this is not trivial. It can also create fragmentation on your front-end application as those developers hack in branching paths for each of the operations your API supports vs. the ones it doesn't yet. However, it removes the need for multiple back-end code paths, and doesn't introduce an extra network hop.

**Option 4**: <span style="background-color: rgba(50,50,0,5);">_Just rewrite the asset creation code in the API, have it integrate with the same tables as the monolith, and maintain both code paths_</span><br />
Frankly, it turns out that most of the other options are going to have you rewriting a significant portion of the asset creation code anyway. Unfortunately, this option introduces the highest amount of additional maintenance cost. Now you've got two separate, completely distinct logical paths trying to implement the same business rules against the same backing tables. They must target the same tables, or else operations against the API won't show up in the monolithic application and vice versa. Any deviance between them could violate business rules and cause hard-to-diagnose errors in either system. Maybe the most damning disadvantage of this approach is that it doesn't do anything to discourage the monolith. Since both code paths continue to exist, the default one will continue to be the monolith's version. Your new logic will always just be a copycat.

---

None of these options are ideal. In my own personal assessment, only Option 1 is absolutely _wrong_. It takes on so much of the technical debt of the existing solution; while it will probably arrive at some solution, that solution will be compromised severely by the nature of the legacy code it tries to modularize. Option 4 is also not a great choice, but it's one I've made before. There are scenarios where the fact that two pieces of software happen to do the same thing in the same way _today_ doesn't mean they will necessarily continue to do so in the future. I call this the _use case rule_—if two units are serving the same business rule (or use case), they should share the same logic, but if they merely perform the same actions, it is not enough justification for sharing.

Option 2 or 3 is likely the "correct" answer. Both of them allow you to move the authoritative logic into a single location without having to inherit all the technical debt of the original solution. Option 2 runs the risk of creating more failure points and additional processing time due to extra hops, but in the absence of front-end developers dedicated to maintaining the monolithic app, this can reduce risk by shifting complexity into the back-end. On the flip side, perhaps that complexity should live at the front-end—if your new API is to become the authoritative location for creating assets, then shouldn't the client app call into it instead of the legacy back-end? Do you use compatible auth systems between the new API and the old monolith, or will there be an awkward bunch of handshaking required for the client to access the new API and the legacy service?

All of these solutions have something in common: they create a new component to the system. The best options do so by cutting out the capability from the old and hooking up all the connective tissue to the new. Hence the name: _the Cyborg Strategy_, an approach based in maintaining legacy systems by slowly upgrading them, unit by unit, module by module, towards a fundamentally different architecture. 

## Looking In the Mirror

The important part of this strategy isn't just ripping functionality out from a monolith and replacing it with a newer, better, modular component. It's the idea that over time, more and more pieces of the system will work this way, all while maintaining the veneer of the old system. At the beginning of this article I asked, "where is the threshold across which you become something else entirely?" The objective and philosophy behind this is that eventually, you'll reflect back on the old monolithic application and realize that it's no longer the same application at all—like our hypothetical person looking in the mirror and realizing they're no longer truly human.

Having the beating heart and organic brain of the legacy app but cybernetically enhanced skin, limbs, eyes, and so on remains a solid metaphor for what happens to software in this strategy. Certain components remain more challenging to excise than others, but as the amount of modularization increases, it becomes easier to operate on those core units. Slowly, all those omniscient dependencies and messy cross-cutting concerns fade away, and even those last few pieces can be reworked. The software evolves from a monolith to a fully modular, service-oriented system in much the same way that ...

TODO finish above