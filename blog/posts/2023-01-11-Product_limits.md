---
title: Product Limits, You're Going to Need Them
tags: technology, product
created: 2022-10-05T11:38:12-04:00
modified: 2023-01-11T20:58:13-05:00
---

Limits on the product functionality
is often overlooked and added too late.
They tend to be considered after we run into problems with the API,
usually after a major incident where we ask
_"how could this have been prevented"_ in the incident review.
However, once users are accustomed to a certain way of calling the API,
it becomes _incredibly_ difficult to add the limit without annoying those users
(will likely involve getting them to migrate to a new API or you needing to set a custom limit on them,
which won't result any customer satisfaction either way).
And if they're paying users, than that might just sink your business.
So, it's good to set product limits early to ensure more predictable and manageable operations.

## Guidelines for Thinking about Product Limits

I like to come up with checklists on what to think about when it comes making sure I consider _stuff_
(not just product limits) when designing a new system.
These product limit questions are not meant to be exhaustive,
but just serve as a starting point for thinking about where to add limits.
In my experience, there are generally a few areas where these types of limits should be considered:

### API Level Limits

These limits are the ones that exists on the API.
Generally, these are the easiest to understand
as there are lots of examples of APIs that implemented these
which you can look at.
They usually involve some sort of limit on request and response.
Some useful questions you may want to ask yourself when thinking about designing a new API:

- Do we want to set a rate limit on the API? What do we want limit on? (ie. account rate limiting? session rate limiting?)

- For endpoints where we return a list of items:
    - What kind of pagination strategy can/should we use? (ie. cursor, offset/limit etc.)
    - How many results should we return as default on a single page?
    - How many results should we set as a max on a single request?
    - How far back do we allow users to paginate?

- What should our response SLAs be?

### Storage Limits

These limits generally deal with how long we store data
and potential contractual limits set on the data.
Storage and data access are not free,
so we should always consider trimming off the unnecessary data
and being explicit about the limitations on storage and access.
Some questions you might want to ask yourself about the data you're adding:

- What should our retention policy be? How do we enforce this?

- Do we want to set a limit to how many objects we store per account/user? How do we enforce this?

- Do we want to consider tiered access, where users can access data by certain APIs up to certain point,
  but require a different API or need to contact our customer support for data beyond that threshold?

- Should there be size limits for uploaded files?

- Should there be number of files uploaded for the user? account? session?

### Third Party Request Limits

We want to also consider limits when talking to downstream dependencies.
If you application will require a lot of network requests to downstream services,
then it would be good to think about the sort of interactions that are acceptable
which will affect some of the API contract requirements that we will have.
Some questions you may want to ask yourself as you inventory your downsteam requests:

- What sorts of timeouts make sense? Given our SLAs?

- If third party doesn’t return, what kind of degradation will be acceptable?
  Would having graceful degradation make sense?

### Data Synchronicity

Lastly, for systems that are OK with some level of eventual consistency,
we will want to consider how this affects the system
and what sort of delay we would be able to tolerate.
Some questions you may want to ask yourself about the behaviour of your APIs and data entities
related to synchronicity:

- Do we have any eventual consistency for data objects that we control? What kind of delay can we tolerate for this?

- Are there any interactions between our APIs that need to be _in-sync_?
  ie. API requests dealing with financial balance will likely require more synchronicity than uploading a profile picture.

- Can any of the entities that we control relax their current synchronicity?
  (not that we're necessarily going to do so,
  but just that the actual requirements for that object isn't as strict as it is currently implemented)

## Conclusion

I wrote this as an exercise to myself for thinking about product limits for one of the projects I've lead.
Hopefully someone else will find this useful as well.

<!--- 
Considerations

- Examples given on the program docs just specify entity limits. I’ve included other things like request timeouts and other product related SLA stuff (which arguably are also “product limits”, as it sets expectations on caller). It’s a question on scope… how much do we think these SLAs are important for availability?

_ For APIs that appear on web, we will likely want to follow some of Web’s SLAs (particularly in regards to the response time SLAs). 

_ I’m also thinking that there is not benefit (for us at least) to separating the API based on source that is calling it (ie. web, API, mobile etc). There might be benefits for other high priority apis (like authentication), but for us I think we can look at APIs as generally as possible.

- For newer services, it will be hard to figure out what our limits should be (as we don’t have established usage patterns). So for these, coming up with a limit based off of what we are expecting from the first iteration of the product should be fine. For example, for triage-assist-service, we can probably set our max limit to 20, as the only place where we’re using that service will only need 20 incidents. If the product changes, then we can consider changing this. Otherwise, we can probably also set an arbitrary larger limit (ie. 50), but the most important is that we’ve thought about and have set something relatively reasonable. 
-->
