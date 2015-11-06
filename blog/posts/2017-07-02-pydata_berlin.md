---
title: Pydata Berlin 2017
tags: data conference
---

I have been out of the loop regarding data science related trends
after I left my previous company.
My current job requires no data science; 
that was intentional, partly due to a feeling that 
industry's uses of *data science* isn't particularly *"good"*.
They tend to be big corporations who want to better protect their monopoly and assets
(ie. big financial companies, insurance, Google)
and also have a *corporate*, rather than *human* stance to ethics and morals.
The main reason why I was attracted to this conference 
was because there was a panel discussion exactly that topic. 

So here are some of the highlights of this conference.

## Catering Foods!!!

I'm usually a happy carnivore but I've always wondered why there are 
not more conferences that do a vegetarian or vegan only selection.
It feels like it would be:

 * more cost effective, 
 * caters to people with dietary restrictions without infringing on others
(ie. meat eaters can eat vegetarian foods as well)
 * and is better for the environment.

This is the first conference where the food was all vegetarian 
(and there were vegan options for variety)
and it was *surprisingly* tasty... 
tastier than other conferences with meat selections.
And even if it wasn't tasty, 
it would be better for all the reasons I listed above.
So please... conferences make your food meatless...

## Trends in NLP

Last time I looked at anything related to natural language processing was probably in 2015. 
I had missed the *revolution* into deep learning, 
which is becoming quite trendy.
Actually, I had been exposed to using deep learning in university
as one of my professor brought it up in our neural networks course
to do machine translation...
At that time it was still an academic "toy" rather than enterprise software.
Anyways, it's nice to see it gaining more traction now.

Also, there was a talk about convolutional neural networks 
as a dimensionality reduction technique
(interesting use case with processing on phones and less powerful devices).
It was a technique I was familiar with in computer vision, 
but it was interesting to see it for text processing now as well.

Lastly, the most interesting NLP related "newness" (to me)
was with [*Multitask Learning*](https://en.wikipedia.org/wiki/Multi-task_learning), 
which is basically associating auxilliary behavioural data 
with text processing.
For instance, doing automatic "chunking" of text 
with the pauses in a person's typing.
I thought that was a pretty interesting way to pseudo-label data
without needing an "expert" annotator.

Of course, many of the problems with NLP still persists:

 * getting quality annonated data
 * cross domain model training (ie. social media posts are very different than newswire)
 
But it seems like deep learning, 
[transfer learning](https://en.wikipedia.org/wiki/Transfer_learning) 
and multitask learning 
are the new ways that researchers are attacking these problems.
 
## Cybersecurity and Data Science?
 
One of the keynotes was a talk by Verónica Valeros 
who is a security researcher about doing data analysis for the massive volume 
of data to help with monitoring cyber attacks.
It seems like this field is lacking in "data" specialists 
when there are many problems that seem to be in the domain of *data science*.
I guess it's interesting to me because it combines two fields which are of interest to me.
 
## Fairness, Biases and Ethics

There were several talks that touched on different aspects of these topics on the second day.
I particularly liked that there was discussion on how we are supposed 
to codify things that are *morally ambiguious* in a model.
For example, how is a self-driving car supposed to react in a situation 
similar to the [Trolley Problem](https://en.wikipedia.org/wiki/Trolly_problem)?
Or how do we quality if a system or algorithm contains systemic bias 
when we can't agree on how to qualify these things as a society?
In some ways I'm quite excited by the prospect of philosophy,
which has been so underappreciated,
taking a more important role in detemining technological progression.

Also, there were some practical talks regarding how to make a system more fair.
For instance, one starting point to an exploration to determining whether bias exists
in your model is to use the *legal definition* as a baseline.
For example, 
if a model clearly distinguishes different levels of intelligence for difference skin colour,
then we can say that this is problematic because *race* is a legally protected class of people.
This will help with the moral ambiguity of questions like:
*"At what point would it be discrimination?"* or
*"Is it discrimination if we have a model of intelligence based on 
'A' students and 'C' students? 
They're also clearly disinguished groups of people who need to be protected!"*
Using the legal system as a framework seems like a good start,
but another suggestion was to also add a "Machine Learning Code of Conduct"
which lays out specific questions or checklists to go through to determine biases.
Questions like : *"Is this fair?"*, *"Would we be ok if this leaked into the press?"*... etc.
is an extra level that an organization can take to critically think about "fairness".

There were also useful equations that I was not familiar with to determine bias.
For example, the concept of [Disparate Impact](https://en.wikipedia.org/wiki/Adverse_impact)
is nicely codeable into an equation for matrix calculations.

Lastly, there seems to also be a paradoxical challenge with requiring more data
to enable better models for reducing bias.
For example, the problem with facial detection working poorly with people with darker skin
can be attributed to the bias dataset of faces, which is predominantly light-skinned.
Also, it is difficult to normalize for confounding factors of racial or gender discrimination
if we do not track the user's race or gender.
So although I'm normally a data privacy promoter,
it feels like potential *lack* of data could be a problem if we want 
to detect and solve the problem of systemic bias being reflected in our modelling.

## Conclusion

It was an interesting conference with much refreshing of concepts.
And I'm really happy that there are lots of smart people who are also now 
seriously talking about ethical issues with machine learning and data analysis.
