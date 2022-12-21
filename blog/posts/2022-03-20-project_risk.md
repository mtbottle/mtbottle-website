---
title: Project Risk and Time Estimation
tags: management
created: 2022-02-25T19:15:46-05:00                                              
modified: 2022-02-26T08:33:00-05:00
---

After years of leading projects,
I feel like I've finally stopped having an aversion to setting time estimates,
and have accepted that they're a necessary part of project management.
Giving these values always feel like I'm just
making up a number for the sake of putting in a deadline
(ie. _bullshitting_ my way through to project completion).
However a shift of mindset from being _accurate_
to doing better _expectation management_
made it easier to accept that forecasting a deadline
is not really that bad.

So this is an article about how I've come to not be scared off by work estimation.

## Why it is important to give a target completion

I will admit that giving a completion estimation
is in many ways,
_actually_ quite arbitrary.
There will be many factors that you will not be able to control,
like one of your team member's employment status
or unpredictable increase in oncall reactive maintenance.
So, deadlines can shift based on these factors.

However, the importance of giving a target completion,
(even when we all know that they tend to slip),
is that you can set some expectations to other people
in the organization about when they can expect a particular feature
to be complete.
For instance, the sales department will need to know when a feature
is ready to launch so that they know when they can start "selling" the feature.
Customer support will need to know when the feature will launch so that
they can collate the training materials required to train up customer support agents on that new feature before it it out.
We don't launch in a vacuum.
We have other groups relying on what’s coming.
If we miss our target, it will affect the delivery of these other dependencies.

## Is there value in work estimation?

I have yet to find a good technique to do work estimation in a project well.
Generally I found that the better you understand the problem/technology/code/team members,
the better your technical breakdown,
which means the better your estimate.
The more details you can get in your plan,
the better the estimate.

The work breakdown and estimation is generally a good start
as the initial estimate.
This is usually the number I'm most iffy about
because there are lots of caveats about the estimation.
For instance,
if you need to collaborate with another team
then the assumption is that there will be
_no friction_ between how the developers in each team work together.
Or there might be something that we thought was easy,
but has turned out more complex than initially planned.

So when I do time or work estimation now,
I usually give the work estimation
_with_ some sort of risk assessment.

## Time Estimation is about Risk Management

So this leads me to my central thesis:
time estimation is about expectation management is about risk management.
Using the transitive property on the previous statement,
_time estimation is about risk management_.

Project risks usually occur in 2 forms:

- Planning risk
- Execution risk

## What is planning risk?

Planning risk usually involves informational uncertainty that has the potential to affect the project deadline.

These risks may look like:

- unclear requirements (do I have everything I need to work on the project?)
- inherent complexity, or "the known landmines"; some projects have a piece that resists decomposition and/or is logically complex.  
- overly long or complex critical paths
- technology or tools that the team isn't familiar with
- scaling issues
- not enough people to work on the project (team too small for the project ambition)

## What is execution risk?

Execution risks usually involve emergent issues that come up as the project progresses.

These risks may look like:

- dependency on external team
- not enough people to work on the project (assigned people pulled into other company priorities)
- new unforseen requirements
- requirements being more complex than initially planned
- operational load or other non-project priorities

## How to use these risks with time estimates?

I no longer provide time estimates without their context anymore.
The initial estimate will include the work breakdown.
Then status updates (usually on weekly basis)
will include:

- known risks, their probability and impact (can we eat this risk?)
- any major decisions made in project and/or a specify risk item
- forecasted completion date (can be adjusted based on new risks)

Risk tends to change as the project progresses,
so risks early in the project
(like those risks that usually occur in the planning phase)
will get less risky as we get more clarity on their impact and resolution.
Execution risks may crop up unexpectedly,
so we need to highlight them and adjust timelines as they emerge.

When highlighting the probability and impact of risk,
it's worth thinking about the idea of materialized vs. unmaterialized risk.
For example,
integrating with a new vendor starts as an unmaterialized risk -
we aren't familiar with the accuracy of their documentation
and the reliability of their APIs,
but as long as we’ve done what we can with reading their documentation,
there’s not much else that can be done until we actually start integrating.
If, once we start tackling this integration,
we’re running into all sorts of problems,
that’s a materialized risk,
and requires more direct action/potential deadline adjustment.

This approach is more about _communication of expectations_,
and less about _accurate forecasting_.

## I've identified risks, how do I deal with them?

This is not an exhaustive list of things that I've done with risk
that I've identified in projects:

- being explicit about the risk and the potential effects of risk is the first step!
  unknown or untracked risks are the riskiest!
- getting more clarity on the risk will help derisk it
  (ie. scaling issues, if we can find some numbers to project the expected load, then we're derisking it)
- new process can also help derisk
  (ie. define cross team syncs to more frequently address cross team collaboration)
- recalibrate the projection,
  taking into account the risk
  (ie. given that we're not sure about the load requirements and the potential necessary steps to fix it,
  are we still confident about the project projection?)
- rescope some features
  (ie. we might be able to hit our target date if we don’t add a cache layer)
- for risks associated with landmines/critical paths, we can timebox, swarm or seek additional feedback
- wait and see.
  Sometimes we might want to wait a bit more to see how we progress
  (e.g. in the case where it seems like we’re slowly veering off forecast,
  we might call it out and give it a bit more time.
  While “do nothing” shouldn’t always be the default,
  it can be a legitimate choice when there isn’t enough of an impetus for concrete action yet.
- eat the risk and deal with it after the project.
  We need to ensure that track this risk and add it to our backlog.

## Conclusion

I've got a system that currently works for me.
Being explicit about risks helps to set the expectation to stakeholders,
and the regular communication builds trust with management.
Ultimately, I think this is what matters most in managing projects
in a corporate environment.
It's kind of a change from the start-up life,
where you just hack your way to a product.
But when you've got more moving pieces to juggle,
risk management is the key to giving better time estimates
for project completion.

---
_Acknowledgement:_
Thanks to Dennis Poon for helping me refine the ideas and thinking through planning vs execution risks.
