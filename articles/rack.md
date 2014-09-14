---
slug: rack
title: Rack is functional programming
date: 2014-01-05
category: ruby
---

## Rack is functional programming.

I've been learning about Rack recently. "a standard interface for servers". In Ruby ~2007, all the servers were "like CGI" but had idiosyncracies.


[Yehuda Katz: From Rails to Rack: Making Rails 3 a better Ruby citizen](http://confreaks.com/videos/242-goruco2009-from-rails-to-rack-making-rails-3-a-better-ruby-citizen)

Because the interface is so simple, it lets you do all kinds of crazy things, which the original authors might not have intended. Middlewares are tiny rack apps, stacked together between the server and your app.

  - you can change values of requests
  - you can add new content or headers on the way out.
  - you can intercept requests, and conditionally direct some requests to one Rack app, others to others.
    - in fact, the Rails router is built around this concept.

the coolest middleware that I've seen so far is rack-application_stats, which will enable the new (in Ruby 2.1) object creation tracer and return an interactive table which shows where objects are being allocated in your system.

But the other thing that is really cool about Rack is that it is functional programming.

consider similarities between these three snippets of code:

```
  RackApp.call(env)
```

```
  lambda { |env| ... }.call(env)
```

```
  # javascript
  function(env) {
    return( [200, {}, ["Some data"] ])
  }.call(env)
```

The Rack interface is identical to Ruby's  (and even Javascript's) interface for invoking an anonymous function


Also, the way that the methods can be chained, is just like function composition.


```
def reverse_upcase(string)
  string.upcase.reverse
end
```

```
(* sml *)
fun reverse_upcase = reverse o upcase
```

```
# a rackup file
use Rack::Debugger
use Rack::ContentLength
run Rails.application
```

In every case, the earlier functions get values by calling the later functions, and they return their results to even earlier functions.

I think it's really cool that in trying to make something simple, reusable, and portable across a number frameworks, the authors of the Rack API used (intentionally or not) a functional programming technique.
