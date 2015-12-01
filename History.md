## Introduction ##

Maashaack started as one big framework, grabing a bit from .NET, from Java,<br>
from everywhere in fact, but just taking the good stuff ;)<br>
<br>
ActionScript from its ECMAScript origins does not really have a framework<br>
you know JavaScript was mostly used for web glue and needed to stay small<br>
so AS since day one kind of evolved like that, with the only difference that because<br>
of Flash, you also got a Flash API on top of the builtins.<br>
<br>
It's also a bit part due to the flash community and Adobe themselves,<br>
the community have a tendency to duplicate the same kind of projects with 2/3 dev<br>
instead of joining forces with 10 dev on 1 project,<br>
and for Adobe, well... they got a lot of dev but working on the Flex framework,<br>
which not exactly something that you could call <b>pure AS3</b>.<br>
<br>
Wether you like it or not the situation is like that, nothing wrong or good about it,<br>
but still I and few others think that AS3 would deserve such big framework.<br>
<br>
So, voila maashaack started like that, with the idea of being a big framework,<br>
but the more the thing grow, the more I was seeing a big monster instead of<br>
the original idea.<br>
<br>
Lesson learned: to do a big framework, you have to pull out the big guns,<br>
be a dozen people team, work 10h+ everyday on it and keep doing it.<br>
<br>
<br>
<h2>The Big Refactor</h2>

We still want to do a big framework, but we gonna do it a bit differently :).<br>
<br>
We gonna apply the <b>divide and conquer</b> principle.<br>
<br>
Instead of having one big project that contains-all end-all, we gonna split it<br>
in smaller independent projects, that you can start in a week-end, finnish in few weeks<br>
and glue them all together in a framework.<br>
<br>
And this is done !!<br>
<br>
check this small post about <a href='https://plus.google.com/117271975527324598054/posts/WQGMmwMj3Bi'>Framework and Modularity</a>

We are here, we are modular now :)<br>
<br>
See an <a href='Code101#Introduction.md'>introduction</a> to the new structure.<br>
Look here to understand a <a href='ProjectStructure.md'>project structure</a>.<br>
Choose your style: <a href='Code101#maashaack.md'>maashaack</a> (all in one) or <a href='Code101#maashaackSA.md'>maashaackSA</a> (split in categories).<br>
And <a href='Build.md'>Build</a> either <a href='LocalBuild.md'>locally</a> or <a href='MetaBuild.md'>globally</a>.