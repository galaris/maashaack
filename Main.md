welcome to maashaack.

[list all the wiki pages](http://code.google.com/p/maashaack/w/list)

We need to put some efforts to update the documentation,
some parts need to be rewritten.

So for now don't trust all our docs ;).

We've been pretty busy with job stuff, hence why the projects have not been updated that much the last 6 months or so.

So the actual battle plan is the following:
  * restructure all the documentation
  * clean what have to be cleaned, wether it's the doc or code or build etc.
  * make maashaack our different projects HQ and document that
> something we call our code galaxy
  * talk more about code
  * write more code

and try to seriously kick some butts (and ours first).

### what's happening now ###

TODO

### what's coming next ###

TODO

### what's have been done ###

  * we now mainly use [gclient](gclient.md) to define solutions, see [introduction](http://code.google.com/p/maashaack/wiki/Code101#Introduction).
  * we now use Flex SDK 4.5.1
  * we now target Flash Player 10.3 and AIR 2.7 (easy to backport if needed)
  * from now on we will always target the last stable version of Flash Player, AIR and redtamarin.
  * we removed any unnecessary svn::external and replaced by gclient DEPS
  * wer replaced svn::externals by SWC files in lib-swc for libraries dependencies
  * we now have 2 main solutions: maashaack and maashaackSA, again see [introduction](http://code.google.com/p/maashaack/wiki/Code101#Introduction).
  * we can sync different SVN path from one or more SVN repositories (we decided to not use GIT)
  * we have splitted the maashaack framework packages in small independent projects (see [/packages](http://code.google.com/p/maashaack/source/browse/#svn%2Fpackages)).
  * every project (or modules) have its own branches/tags/trunk
  * any projects can be local to the maashaack SVN repo or external (any other SVN repo)
  * every projects produce an independent SWC and/or SWF and/or ABC
  * every projects can build independently with a [local build](LocalBuild.md).
  * every projects can be build by the [metabuild](MetaBuild.md) from the solution maashaackSA.
  * we use conditional compilation in some part of the code instead of namespaces, see [ConditionalCompilation](ConditionalCompilation.md).
  * library eden cleaned and refactored, hosted on its own SVN repo.
  * library astuce cleaned and refactored, hosted on its own SVN repo (phase1, need a phase2)
  * all maashaack packages have been cleaned and standardised on the [project structure](ProjectStructure.md) and a [local build](LocalBuild.md)
  * all unit tests are passing (1700+)
  * all freshly compiled and current files can be found in [/libs/trunk](http://code.google.com/p/maashaack/source/browse/#svn%2Flibs%2Ftrunk).
  * we now save an history of our builds with a unique tag see [/libs/tags](http://code.google.com/p/maashaack/source/browse/#svn%2Flibs%2Ftags).
  * not all tags will be saved forever, we will only save tags that are considered stable.