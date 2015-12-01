| **important:** this roadmap is deprecated, bare with us while we restructure all the projects|
|:---------------------------------------------------------------------------------------------|

## (maybe) ##

  * ui: basic layout library, mainly for debug/diagnostic tools
  * logger logic
  * console (redtamarin vs flash player, also console1)


## (v0.4.0) ##

**Diamonds Are Forever**

  * BigNumber class
  * Math library
  * Encryption library


## (v0.3.0) ##

**Goldfinger** (all about eden)

  * clean up eden code
  * add security features in eden
  * add sub-project to test eden files on the command-line
  * add inline errors in eden (line and column)
  * add blocking/unblocking mode for eden (blocking: throw errors, unblocking: no errors that block the execution of the parsing)
  * more serializers (WDDX, PHP, JSON, etc.)
  * ressources logic (load/save etc.)

## (v0.2.0) ##

**For Your Eyes Only**

done:
  * ADT (list, collection, map, queue, etc.)
  * event model based on W3C DOM 2/3
  * Comparator, Sortable, Comparable interface and implementations
  * build as `abc` for redtamarin
    * core.abc
    * maashaack.abc
  * new component core.swc
  * unit tests run on the command line
    * we dynamically generate ASTUce.exe
    * we run ASTUce, core, system, etc. unit tests
  * Process and Action engine

todo:
  * Environment class (refactor)
  * reflection API
  * finish and fully review all core objects: Strings, Arrays, Objects, etc.
  * define the common namespaces standard/optimized/experimental
  * URI class
  * reorganization of the documentation (wiki) -- started
  * explain the architecture
    * core : very low-level classes without dependencies
    * system : framework classes (which can have dependencies within the framework)
    * openscreens : flash platform related libraries (SWF, AMF, SOL, etc.)
    * libraries : 3rd party libraries (zlib, ogg, etc.)
    * explain the common namespaces standard/optimized/experimental
  * support and test for FP10


## v0.1.0 ##

**You Only Live Twice**

  * build based on ant
  * asdoc documentation
  * build as a swc for easy use
  * better setup for unit tests
  * standardize singletons
  * configurator logic
  * evaluator logic
  * serializers logic (refactor)
  * more unit tests
  * eden is now part of system
  * cli: utils for command line tools

tag: [0.1.0](http://maashaack.googlecode.com/svn/tags/0.1.0)