---
title: For Beginners
---

People ask me a lot how they can best get started with programming, functional programming, or Haskell specifically. Of course, I think [my book](http://haskellbook.com/), which was written for beginners, is a great place to start, but people have different needs. I'm going to try to collect here the things that I have personally found most helpful for getting started with programming and with Haskell. It's an opinionated collection. It might not be perfectly suited to your needs, but these are things that worked for me.

# Table of Contents  
[What to Do First](#what-to-do-first)  
[Books](#books)  
[No Monads for You](#no-monads-for-you)  
[Blog Posts and Tutorials](#blog-posts-and-tutorials)  
  - [Lambda Calculus](#lambda-calculus)  
  - [Haskell Basics](#haskell-basics)  
  - [Functional Patterns](#functional-patterns)   
  - [Awesome Typeclasses](#awesome-typeclasses)  
[General Programming](#general-programming)  
  - [Git](#git)

# What to do first

OK, you're here looking at a Haskell-ish blog already so maybe you don't need this advice. But. Just in case.

This [Getting Started](https://haskell-lang.org/get-started) guide will help you get set up quickly. For more in depth instructions, as well as guides in foreign languages, try the [Learn Haskell repo](https://github.com/bitemyapp/learnhaskell) maintained by Chris Allen.

I do recommend you just get [Stack](http://docs.haskellstack.org/en/stable/README/) right off the bat and look through some of its documentation. The documentation for it is thorough and clear. Chris Allen and I also made a [video about using Stack](https://www.youtube.com/watch?v=sRonIB8ZStw). The video is long, but that's because we cover a bunch of weird edge cases that you may never encounter. There are time stamps in the information that you can click on to get what you need.

If you are itching to see how a project is set up in Haskell, try Chris's [How I Start: Haskell](http://howistart.org/posts/haskell/1) article and enjoy processing some CSV data.

# Books

When we're talking about learning resources, I am very opinionated. In the course of writing our Haskell book, I have read most of the other Haskell books. I recognize that not everyone's judgments here will be the same as mine, but these are what worked best for me (totally new programmer with not a lot of math background):  

  - [Haskell Wikibook](https://en.wikibooks.org/wiki/Haskell): The wikibook is free, which is awesome, and it really starts from the basics and works its way up in a nice progression. It has some exercises, although you'll want more. You can get more exercises by doing [cis194](http://www.seas.upenn.edu/~cis194/spring13/), the [99 Haskell Problems](https://wiki.haskell.org/H-99:_Ninety-Nine_Haskell_Problems), and the [NICTA course](https://github.com/NICTA/course), among other things. All of those are free. The wikibook does have uneven coverage -- some topics aren't covered enough and some parts are not as well written as others, which just follows from it being a wikibook. However, I found many parts of it very clear and reasonably easy to follow.  
  - [Haskell Programming from First Principles](http://haskellbook.com/) by Chris Allen and Julie Moronuki: Sure. It's my book. This is how I learned Haskell, so it covers thoroughly all the things I didn't know, which was everything. It assumes no particular background knowledge besides some familiarity with high school level algebra. It goes from the lambda calculus through monad transformers, parser combinators, and exception handling, so it covers more than enough to get you working on your own projects in Haskell (or other functional languages). It has quite a few exercises.  

  - [Haskell: The Craft of Functional Programming](http://www.haskellcraft.com/craft3e/Home.html) by Simon Thompson: Ah, this book is not free, and it's not perfect, but I do love this book. It has quite a few exercises, and I found them interesting and challenging without making me want to hurl the book through the window.

# No Monads for You

A lot of people who have experience programming in other languages think the big thing they need to learn about Haskell is monads and try to start there. So, here are my suggestions for beginning monads:

- The [Eightfold Path to Monad Satori](http://dev.stephendiehl.com/hask/#eightfold-path-to-monad-satori)  

- The [What Are Monads Fallacy](https://two-wrongs.com/the-what-are-monads-fallacy)  

- [How Would You Explain Monads to a Haskell Noob](https://www.quora.com/How-would-you-explain-Monads-to-a-Haskell-noob-who-is-reasonably-experienced-in-other-languages-but-has-no-formal-maths-education/answer/Andrea-Ferro)

# Blog Posts and Tutorials

Good, good, now that you've decided to forego learning about monads until you have a better understanding of types, typeclasses, functors and all that, here are some blog posts and tutorials from around the web that I found helpful. Even if you are working through a book, getting the same lesson presented differently, with different wording and examples, can help.

## Lambda Calculus

Wait, what? I know. If you'd told me as a senior at university suffering through formal logic that, at the age of 40, lambda calculus would suddenly become very relevant to my interests, I'd surely have scoffed. But it's true! Haskell is a lambda calculus, so understanding it in its simplest form (not easiest, but simplest in the sense of "without all the fancy syntax") can help tremendously. We started our book with a chapter on lambda calculus, but here are some other ways to dive in:

- [A Lambda Calculus Primer](http://ebzzry.github.io/lambda-calculus.html)  

- [Functional Programming Through the Lambda Calculus](https://www.cs.rochester.edu/~brown/173/readings/LCBook.pdf) OK, so this one is more than a blog post, but I found it very readable. The example code is in Pascal but is well enough explained with reference to lambda expressions that I didn't find it problematic. Even getting through only the first two chapters will boost your functional programming skills by quite a lot, I'd think.

## Haskell Basics

Some of the posts listed here go beyond basic function application and types. You may find you only understand half the post the first time you read it (or less sometimes, if you're like me!). That's cool. What I did is bookmark them and keep coming back to them as I learned more and I was able to recognize how much progress I was making by seeing how much more I understood each time.

> It's a mindset change. I wish I'd known this earlier as it would've saved me frustration and doubt, but you kind of need to unlearn what you think you know about coding, then go back to the basics.     
-- [This person has the right idea.](http://japgolly.blogspot.com.au/2014/06/a-year-of-functional-programming.html).  

- [Haskell Syntax is Terse](https://www.fpcomplete.com/blog/2012/09/ten-things-you-should-know-about-haskell-syntax)

- [Haskell Basics](https://www.schoolofhaskell.com/school/starting-with-haskell/introduction-to-haskell/1-haskell-basics) This is the first lesson in the School of Haskell, and it covers a lot of fundamentals, including (important!) how to read GHCi error messages.

- [Function Application and Definition](http://slpopejoy.github.io/posts/2014-11-27-FunctionApplicationDefinition.html) This one covers _a lot_, but there is a ton of examples that help if you follow along with them.  

- [Haskell Functions Take One Argument](http://blog.tmorris.net/posts/haskell-functions-take-one-argument/) Well, speaking of terse, Tony Morris can be a bit terse himself, but I think this post makes its point clearly.

- [Types & Kinds](http://slpopejoy.github.io/posts/2015-04-10-Types.html) Again, a lot of examples here to help you understand the points.

- [Sum Types](https://www.schoolofhaskell.com/school/to-infinity-and-beyond/pick-of-the-week/sum-types) This post is a good, not terribly jargon-filled overview with some very nice examples. It's mostly about sum types with just a bit about product types at the end, presumably because product types seem to be more common in other languages.

- [The Algebra of Algebraic Data Types](http://chris-taylor.github.io/blog/2013/02/10/the-algebra-of-algebraic-data-types/) This link goes to Part I. There is a Part II and Part III, each covering slightly more advanced topics, as well as a video of a talk the author gave on the subject.

- [Currying is Delicious](http://argumatronic.com/posts/2016-06-17-delicious-currying.html) I wrote this one, and like some of the ones above, it goes a bit beyond reading basic type signatures. But it's important to understand currying, and as you get around to understanding _kind_ signatures as well, it'll help you understand functors, which will eventually help you understand the legendary Monad.  
- The Haskell Wiki is, like most wikis, uneven in quality and helpfulness, but [this page](https://wiki.haskell.org/Common_Misunderstandings) has some nice tips and explanations of some common syntactic mistakes.

<!-- sectioning: http://stackoverflow.com/questions/10131300/partial-application-with-infix-functions -->

## Functional Patterns

- [Function Composition and the $ Operator](http://lambda.jstolarek.com/2012/03/function-composition-and-dollar-operator-in-haskell/)

- A nice concrete example of [what recursion is](https://www.quora.com/How-should-I-explain-recursion-to-a-4-year-old/answer/Aaron-Krolik), including the base case.

- I also like these two posts from John D. Cook about recursion: [Understanding Recursion](http://www.johndcook.com/blog/2010/03/30/understanding-recursion/) and [Understanding Recursion Part II](http://www.johndcook.com/blog/2012/08/14/understanding-recursion-ii/). "Recursion is about solving a problem in terms of smaller versions of itself." I am going to disagree somewhat with Cook and, apparently, Paul Graham (*if I may be so bold*), and say that I did find it helpful to trace the invocations of recursive functions a couple of times (and we do that in the Recursion chapter of our book), but it's quite correct to say that once you understand what's going on, you will suddenly find that you almost never write recursive functions yourself and so you don't think about the process anymore. Instead, you just use `map` or a fold or something and the recursion is built in. Well, at any rate, I found understanding the step-by-step process of how recursive functions work helped me understand what those functions were really doing, especially with folds.  

- These [slides from Gabriel Claramunt's talk](https://github.com/lambdaconf/lambdaconf-2016-usa/blob/master/All%20about%20a%20Fold/All-about-a-fold.pdf) about folds illustrate how folds work well enough that I think they're helpful even when you aren't listening to him talk.

- [Map, Reduce, Fold](http://www.joescii.com/2013/09/09/map-reduce-and-fold-for-the-programmatically-imperative/) Yeah, the examples are in Scala, but I found I could follow them even though I don't know Scala, and I found the recommendations for when to use `map` and `fold` useful.

- [Interactive Demonstration](https://stevekrouse.github.io/hs.js/) of `map` and folds.

## Awesome Typeclasses

The problem with most blog posts about functors, applicatives, and monads is less that they have analogies to food items and more that they miss the point that all of those big typeclasses are generalizations of basic patterns. What we want to do is apply and compose functions in the presence of *structure*, and these are ways of doing it. None of these typeclasses are magic, and they all exist to solve common programming problems. They're things you [might well have written yourself](http://sean.voisen.org/blog/2013/10/intro-monads-maybe/), but in Haskell, we've just pulled them out into typeclasses to make them reusable with a lot of different types of structure. I mean, I say "we" but obviously this was done by smarter people than I am. 

They did that with monoids, too, and even though you're thinking "monoid" sounds like some unfortunate disease, it's a pattern you're familiar with -- addition, multiplication, and list concatenation are all monoids. 

The [Typeclassopedia](https://wiki.haskell.org/Typeclassopedia) is one of the things people told me to read when I was a beginner, and it was way over my head. However, once you're ready for it, it's an invaluable source of information about important typeclasses. You might try going through it as you're working through the NICTA course. Heh. 

<!-- ## Example Tutorials

I'm getting a little bit ahead of myself here, it seems, going from "Haskell basics" to full-blown, end-to-end examples of Haskell in practical use. But it can be difficult to stick with learning Haskell if you don't get a feel for what it's like to use it to *do stuff.* I'm going to try to limit this to examples that I think are useful for beginners to follow along with.  

- I haven't tried the code yet in this [`wreq` tutorial](http://conscientiousprogrammer.com/blog/2015/12/04/24-days-of-hackage-2015-day-4-wreq-web-client-programming-with-notes-on-lens-and-operator-syntax/), unfortunately, but it's so thorough.  -->


# General Programming

## Git

If you don't already know git, you need to. One thing I'd like to note, because this wasn't very clear to me for a long time, is that git is not GitHub. I use git mostly from the command line, so for me, when I move a repository from GitHub to Gitlab (or vice versa), I change the address of what I'm pushing to and pulling from, but the commands themselves don't change. The first time I moved something from GitHub to Gitlab, I didn't realize that would be true, and I thought I'd have to learn new things. Every experienced programmer is probably shaking their heads at me now, but if putting this out in public will prevent any one person from having the same fear, then so be it. That said, I highly encourage you to learn git from the command line. Here are some places to get started.

[Read this first](http://blog.plover.com/prog/two-things-about-git.html), because it's reassuring and also has links (at the bottom) to the two best sources of understanding git's underlying model that I know of. I don't have a preference between them. I strongly urge you to familiarize yourself with the underlying structure of git. Having that model in your head will help you diagnose problems when they arise and use a search engine to find commands that you need. It's hard to search for git commands if you're not sure what you need to do, and having an idea of the underlying structure helps you know what you need to do.

[This doesn't explain very much](https://medium.freecodecamp.com/git-cheat-sheet-and-best-practices-c6ce5321f52#.ibfvkofmv) about git's underlying model, but is a good, quick starting point that explains the most commonly used commands, and it'll serve as a good reference as you're learning.




<!-- git problem-solving: http://blog.plover.com/prog/git-reset-disaster.html This is about solving a problem you might never have or not have for a long time, it's true. So why beginner? Because it explains a process for how to solve a problem using terminal commands and git that actually teaches you some useful and valuable things about terminal commands and git that you can use for other purposes, too. It's not the first thing you should read to learn git, but when you've got some of the basics down and are looking to learn more, this one is good. (p.s. MJD's blog is generally a goldmine of knowledge made accessible.) -->


<!-- add this if/when done (might PR with fixes?) https://ci.haskell-lang.org/tutorial/operators
 -->
