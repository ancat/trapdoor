# trapdoor

trapdoor monkeypatches `ENV` so any secret values are available when asked for by name (i.e. `ENV['SOME_SECRET']`) but are hidden when requested in bulk (i.e. `ENV.to_h`, `ENV.inspect`, iterators). This was designed to be a drop in replacement for codebases that use `ENV` to hold secrets but also use developer tools that may cause these values to be accidentally logged. 

## Installation

1. Add to your Gemfile and install with bundle, or `gem install trapdoor`
2. `require 'trapdoor'`

## Walkthrough

Let's start by inspecting the environment in the repl. We can see `SECRET_API_TOKEN` and its value.

```
> ENV
 => {... "SECRET_API_TOKEN"=>"987tfghjo0987yt"}
```

After loading `trapdoor`, let's tell it to hide this specific value then inspect the environment again.

```
> ENV.hide "SECRET_API_TOKEN"
> ENV
 => {... "SECRET_API_TOKEN"=>"**REDACTED**"}
```

But we can see this value can still be accessed just like before:
```
 > ENV['SECRET_API_TOKEN']
 => "987tfghjo0987yt"
 ```
 
Additionally, we can call `ENV.start_smuggling` to start redacting all new environment variables. This can be useful if you insert sensitive variables into the environment afterwards so that any non-pre loaded values are redacted.
