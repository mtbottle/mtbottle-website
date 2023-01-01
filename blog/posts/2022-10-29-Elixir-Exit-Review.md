---
title: Elixir: An Exit Review
tags: technology
created: 2022-10-20T23:00:01-04:00
modified: 2022-10-27T22:52:43-04:00
---


I've resigned from my job at `$COMPANY_THAT_USES_ELIXIR` recently.
And in my next role, Elixir will not be my primary programming language.
Here are some of my thoughts after working with it for 3 years.

## Introduction

Elixir is a language that is based off of Erlang.
This means that it uses the BEAM,
which is the Erlang's virtual machine
and also follows Erlang's OTP design principles.

I went into the job not knowing much about the language,
other than the fact that it was 1. functional
and 2. saw that it was hyped on places like `lobste.rs`
and our favourite orange tech news aggregation website.

## What I liked

### Pattern Matching and Guards

This simple feature makes programming so much more fun.
I've mainly used this to substitute for conditionals.
For example, handling different response statuses can look like this:

```elixir
def handle_resp(%HTTPoison.Response{status_code: 200} = resp), do: ok(resp)

def handle_resp(%HTTPoison.Response{status_code: 403} = resp), do: forbidden(resp)

def handle_resp(%HTTPoison.Response{status_code: 400} = resp), do: not_found(resp)

def handle_resp(%HTTPoison.Response{status_code: status} = resp) when status >= 400 and status < 500 do
  user_error(resp)
end

# handles all other responses, including 3xx, 5xx
def handle_resp(%HTTPoison.Response{} = resp), do: retry()
```

I've found this to be a super elegant way of differentiating the code paths
without creating too many levels of indentation.
Pattern matching is also super useful to get specific items from maps and more complex data structures too.

### Pipes!

In particular, the structure of pipes naturally follows the order they're executed.
This makes it _so_ much easier to read the code.

For example, in a standard declarative language, you might write something like this:

```elixir
last_func(
    third_func(
        second_func(
            first_func(
                param
            )
        )
    )
)
```

But with Elixir, this can be written much more elegantly:

```
param
|> first_func()
|> second_func()
|> third_func()
|> last_func()
```

More languages should adopt this.

## What I'm not sure about

### GenServers (and OTP design generally)

I was super excited to learn [about OTP](https://www.erlang.org/doc/design_principles/des_princ.html)
and building applications based on multiple processes.
It's a unique concept with interesting design implications.
Thinking in terms of processes, their lifecycles
and designing your data around immutability
was a fascinating adventure into something completely unique
from the standard object-oriented or even functional world.

Although this was intellectually interesting,
I don't think I've actually seen it used to its full potential
as we seldom needed to code our own GenServers.
So admittedly, although this was an interesting excursion into a new idea,
I'm not sure I have seen a particularly notable usage of OTP.

### Interns Struggle to Onboard

Throughout my 3 years at `$COMPANY_THAT_USES_ELIXIR`, I've found that interns,
especially those that are on their first 4 month term with us,
really struggle to grasp the language as quickly as other more common languages
like Javascript or Python.
I'm not entirely sure if my anecdotal evidence is indicative of anything,
but it does suggest that there might be something different with Elixir
that makes it harder for new coders to get started.
Some of my theories for why it's harder:

1. Students are more likely to learn OOP at school
1. OTP architectural design doesn't translate well to more mainstream languages/patterns
1. Elixir pattern matching, control flows and error handling 
   also doesn't translate well to more mainstream languages/patterns,
   which means that prior programming experience doesn't map as well to patterns used in Elixir
1. Four months is not long enough to get a good handle
   on the idiosyncrasies in the language

I've found that interns on their second or third internship with `$COMPANY_THAT_USES_ELIXIR`
tended to handle the tasks much better.

## What I didn't like

### "with" Statements

I've actually grown a bit more ambivalent with this construct over time.
I started to _really_ hate this construct when I ran into some debugging annoyances.
For example:

```elixir
with {:ok, data}      <- function_call(params),
     {:ok, more_data} <- function_call2(),
do
  whatever_here()
else
  {:error, :timeout} -> {:error, :error_in_with_statement}
end
```

It is impossible to know whether the `timeout` came from `function_call` or `function_call2`.
So it's incredibly hard to trace this call when all you see is `{:error, :error_in_with_statement}`
(not to mention that Elixir's debugging tools are not great).

One way to get around this is to actually annotate each line like this:

```elixir
with {:this_line, {:ok, data}}      <- {:this_line, function_call(params)},
     {:that_line, {:ok, more_data}} <- {:that_line, function_call2()},
do
  whatever_here()
else
  {:this_line, {:error, :timeout}} -> 
    add_some_metrics(:this_line)
    {:error, :error_in_with_statement}

  {:that_line, {:error, :timeout}} -> {:error, :error_in_with_statement}
end
```

This is a reasonable to separate which line caught the error,
but makes the code more repetitive (ie. `this_line` and `that_line` are repeated 3 times).

I think that `with` is powerful when you really want to handle a class of errors the same way.
Arguably, `timeouts` _should_ probably be handled the same,
but we still need to differentiate where they're coming from for observability.
We can probably use the clunky appended signifier to handle the error in the same way,
but differentiated for observability purposes:

```elixir
with {:this_line, {:ok, data}}      <- {:this_line, function_call(params)},
     {:that_line, {:ok, more_data}} <- {:that_line, function_call2()},
do
  whatever_here()
else
  {line_signifier, {:error, :timeout}} ->
    add_some_metrics(line_signifier)
    {:error, :error_in_with_statement}
end
```

It's still a bit repetitive, but gives us the observability for debugging.
Anyways, I've come to terms that this isn't _that_ terrible.
I'm not sure I _like_ it that much,
but I guess I no longer hate it.

### Lacking good third party support

My criticism here is probably more on my ex-company rather than something inherent to Elixir itself.

Elixir is still very immature,
and hence, there is a clear lack of support for things that
we take for granted in other more mature languages.

This was admittedly, one of the final contributing factors to making me leave `$COMPANY_THAT_USES_ELIXIR`
(there were several others reasons unrelated to Elixir).
I was no longer excited with working in Elixir
because third party libraries that we use _a lot_
were poorly documented,
hard to use,
missing features,
and there was little motivation in making it better
(or, this was relatively low on the _"developer experience"_ priority list).

Specifically, we use Kafka _a lot_,
but the choices were `kafkaex` (not super actively developed/maintained, and some known broken functionality)
and `brod` (written in Erlang, poorly documented and cryptic error messages).
Given how much we depend on Kafka
and with the size and reputation of the company,
I would say that it's a huge disappointment to not see investment in making our own Kafka-Elixir integration.

## Final Thoughts

Although I ended on a particularly negative point,
I really did enjoy coding in Elixir.
I will miss the elegance in some of the language constructs
but overall, I think I'll be happier to work in a better supported language.
I would definitely consider another job in Elixir
as I had enjoyed working in it more than other languages I've used in the past.
If I were to go back to `$COMPANY_THAT_USES_ELIXIR`,
I might even suggest taking ownership of (or forking) `kafkaex`
or create our own open-sourced Kafka library in Elixir.
It's just a shame that I only thought about this after I left the company.
