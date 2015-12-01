## Introduction ##

Considering that [ECMAScript 4 specification](http://www.ecmascript.org/) is not final
the simple answer would be "you can't", but being the impatient kind I say "f\*ck it".

Right now we have a good subset of ES4 impersonated as ActionScript 3 (AS3),
the good folks at Adobe are actively participating in ECMA TG1 and seems to have
the will to not add incompatible features.

Let's target AS3 code, and then refactor later, at least it would be a good
use of that good yer old svn, but let's do it with a grain of brain.

## Details ##

let's establish some rules, you would not think we gonna code all that in the wild
not thinking about forward compatiblity do you ?

  * rule #1
> embrace ECMAScript, you're not coding Java or .NET here, so as a first rule
> never ever fall in the trap of thinking AS3 is ever related to those other guys.

  * rule #2
> the one big thing missing in ECMAScript (ES3, ES4, any version) is a framework,
> meaning reusable code in the large, as a rule of thumb any general algorithm,
> classes, utils, whatever... that can be synthetized to pure AS3 code without depending
> on any Flash player, AIR player API, would simply fall back in a general code repository,
> which is ~~ES4a~~ **x4a** (codename of [maashaack](Framework.md)).

  * rule #3
> don't force rules into the language, AS3 is like the tip of the ES4 iceberg,
> don't implement something as Java-like iterators when you know ES4 will add
> its own iterators and generators, implement simple and effective API being able to be
> used in the wild now and refactored and/or optimized later.

  * rule #4
> don't write framework code for the sake of writing framework code, write applications,
> things you can use now, and then synthetize the generic parts into the general framework,
> not the other way.

## Current State ##

  * we write AS3 based applications
  * the general part of these applications are isolated and refactored into x4a.
  * ~~as soon as ES4 will be official and implemented in at least 2 environments
> (JS2 in Firefox and AS4 in Flash Player for example) then refactor again.~~ this sadly will never happen.