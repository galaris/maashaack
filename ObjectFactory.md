# The lightweight container #

<a href='http://creativecommons.org/licenses/by-sa/3.0/'><img src='http://i.creativecommons.org/l/by-sa/2.0/uk/88x31.png' alt='Licence Creative Commons' /></a> author : Marc ALCARAZ ([ekameleon](https://code.google.com/u/109962507657971592081/))



## 1 - The ObjectDefinitionContainer class ##

The **system.ioc** package contains all important classes and interfaces to deploy the inversion of control pattern in your applications. The **system.ioc** package is dependent on the **core** and **system** packages.

[![](http://maashaack.googlecode.com/svn/gfx/framework/packages/system.ioc.png)](http://code.google.com/p/maashaack/source/browse/#svn%2Fpackages%2Fsystem_ioc%2Ftrunk)

The kernel class in the **system.ioc** package defines the **lightweight container** implementation with the **IObjectDefinitionContainer** interface. This class is the super class of the **ObjectFactory** class.

**members inspection**

| **Members** | **Description** |
|:------------|:----------------|
| numObjectDefinitions:Boolean | Indicates the numbers of object definitions registered in the container. |
| addObjectDefinition(id:String, definition:IObjectDefinition ) | Registers a new object definition in the container. |
| clearObjectDefinition() | Removes all the object definitions in the container. |
| clone():| Returns a shallow copy of the object. |
| containsObjectDefinition(id:String) | Returns true if the object defines with the specified id is register in the container. |
| getObjectDefinition(id:String) | Returns the object definition register in the container with the specified id. |
| removeObjectDefinition(id:String)	| |Unregisters a specific object definition in the container. |

**example**

```
import flash.text.TextField ;
import flash.text.TextFormat ;

import system.ioc.ObjectDefinition ;
import system.ioc.ObjectDefinitionContainer ;
import system.ioc.ObjectFactory ;

var container:ObjectDefinitionContainer = new ObjectFactory();
 
var context:Object =
{
    id         : "my_field" ,
    type       : "flash.text.TextField" ,
    properties : 
    [
        { name : "defaultTextFormat" , value : new TextFormat("verdana", 11) } ,
        { name : "selectable"        , value : false                         } ,
        { name : "text"              , value : "hello world"                 } ,
        { name : "textColor"         , value : 0xF7F744                      } ,
        { name : "x"                 , value : 25                            } ,
        { name : "y"                 , value : 25                            }         
    ]
}

var definition:ObjectDefinition = ObjectDefinition.create( context ) ;

container.addObjectDefinition( definition );

trace( container.containsObjectDefinition( "my_field" ) ) ; // true
trace( container.getObjectDefinition( "my_field" ) ) ; // [ObjectDefinition]
trace( container.numObjectDefinitions ) ; // 1

var field:TextField = (container as ObjectFactory).getObject("my_field") as TextField ;
```

In this example we initialize an object definition with a single generic object that will generate with the factory a specific instance of the TextField class. This simple technique can be injected at any time of the new definitions of objects by hand in the factory with the method **addObjectDefinition()**.

## 2 - The ObjectFactory class ##

The **ObjectFactory** class is the main class of the dependency injection engine defines in the **system.ioc** package. This class defines in the same object a container and a factory used in the application to create all objects and dependencies between them.

This class has a rich heritage, with several levels of inheritance, which provides several important features :

  * ObjectFactory - ObjectDefinitionContainer - CoreAction - Task

This class implements the interfaces :
  * **system.Cloneable** : use the classical clone() method to generate a shallow copy of the factory.
  * **system.process.Runnable** : Initialize the content of the factory with the basic run method (design pattern Command).
  * **system.process.Action** : The factory can be initialize in a global process and can be include in a sequence or batch group of complex processes.
  * **system.process.Lockable** : Lock the singleton lazy initialize process.
  * **system.ioc.IObjectDefinitionContainer** : defines all the methods to create and manage the object definitions in the container.
  * **system.ioc.IObjectFactory** : defines all the methods to create and manage the objects in the factory.

**usage**

```
new ObjectFactory( config:ObjectConfig = null , objects:Array = null )
```

**example**

I will illustrate the use of the factory based **IoC** with a simple collection of generic objects defined in an **Array** object.

These generic objects allow the initialization and the injection of several **object definitions** in the factory and allow the automatic creation of objects with a "**singleton**" scope during the initialization of the lightweight container.

```
import system.ioc.ObjectFactory ;

var objects:Array =
[
    {
        id    	: "my_format" ,
        type  	: "flash.text.TextFormat" ,
    	  arguments : 
        [ 
            { value :"Arial"   } , 
            { value :24        } , 
            { value : 0xFEF292 } , 
            { value : true     } 
        ]
    }
    ,
    {
        id         : "my_field" ,
        type   	 : "flash.text.TextField"  ,
        properties :
        [
            { name : "autoSize"          , value  : "left"        } ,
        	{ name : "defaultTextFormat" , ref    : "my_format"   } ,
        	{ name : "text"              , value  : "HELLO WORLD" } ,
        	{ name : "x"                 , value  : 10            } ,
        	{ name : "y"                 , value  : 10            }
    	]
    }
    ,
    {
        id           	 : "root" ,
        type         	 : "flash.display.MovieClip"  ,
        factoryReference : "#root" ,
        singleton    	 : true ,
        properties       :
        [
            { name : "addChild" , arguments : [ { ref:"my_field" } ] }
        ]
    }
] ;

var factory:ObjectFactory = new ObjectFactory() ;

factory.config.root = this ;

factory.run( objects ) ; 
```

In the previous example the generic object "**objects**" is a basic **Array** who defines the setting of the **IoC** factory with tree **object definitions** :

  * **my\_format** : this definition defines a specific setting to create **flash.text.TextFormat** instances with the factory. This definition use a **constructor injection** to initialize the new object.
  * **my\_field** : this definition defines a specific setting to create **flash.text.TextField** instances. This definition use a **setter injection** to initialize the new object.
  * **root** : this definition creates a singleton reference in the application who target the main timeline reference defines in the IoC factory configuration. This definition use **setter injection** to attach a reference defines with the object definition "**my\_field**".


The object definition "**root**" use a specific strategy defines in the **IoC** factory to target the main timeline reference of the application. The **IoC** factory must target the main timeline manually with the script :

```
factory.config.root = this ;
```

We initialize the **factory.config.root** property of the factory to allow the **#root** magic reference in the **object definitions** of the **IoC** container.

The **IoC** factory has several types of strategies to create an object in the application with an object definition. We will discuss in the next chapter on object definitions.

The above example will display very fast a **TextField** on the stage of an animation.

This example illustrates the use of a "_programming layers_" which can isolate each object of an application and work quietly on each of them regardless of their dependencies with each other.

The lightweight container and the framework are responsible for creating the objects and put them in touch with each other.

**attributes inspection**

| **Members** | **Description** |
|:------------|:----------------|
| config:ObjectConfig | Defines the optional configuration of the object factory. |
| objects:Array	| Contains all generic objects to defines the object definitions in the factory with the run() or create() method.|
| singletons:HashMap | The Map of all singletons references registered in the IoC factory.|

**methods inspection**

| **Members** | **Description** |
|:------------|:----------------|
| clone()     | Returns the shallow copy of the object.|
| containsSingleton(id:String):Boolean | Indicates if a singleton reference is register in the factory with the specified id.|
| getObject( id:String ):| Creates and returns an object with the specified id.|
| isDirty():Boolean | Indicates if the factory is dirty, must flush this buffer of not lazy-init singleton object definitions.|
| isLazyInit( id:String ):Boolean | Indicates if the specified object definition is lazy-init.|
| isSingleton( id:String ):Boolean | Indicates if the scope of the object definition is "singleton".|
| removeSingleton( id:String ):void | Remove and destroy a singleton in the container.|
| run( ...arguments:Array ):void | Run the initialization of the factory with new object definitions and create the not lazy-init singleton objects. You can lock the singleton building with the lock() method.|

The **ObjectFactory** class implements the **system.process.Lockable** interface. You can lock the **run()** method and fix the singleton auto-build process :

```
factory.lock() ; 
factory.run( objects ) ; 
factory.unlock() ;

trace( factory.isDirty() ) ; // true

factory.run() ;

trace( factory.isDirty() ) ; // false
```

The **isDirty()** method returns a boolean (true or false) to indicate if the factory contains singletons in its internal buffer and it must be flushed.

This behaviour is useful in complex factory configurations who need different sources of **object definitions**.

When the **lock()** method is invoked we can fill the locked factory with the **run()** method.

When all object definitions are defines in the factory, to flush it we must invoke the **unlock()** method before the **run()** method.

The factory is a task and implements the **system.process.Action** interface.

You can registered the two signals "**startIt**" and "**finishIt**" who indicate the begin and the end of the run process (only if the factory is unlocked). You can use a complex task with a sequence (**system.process.Chain**) or batch (**system.process.BatchTask**) to combine factory with other tasks and other processes in your application.

**example**

```
import system.ioc.ObjectFactory ;
import system.process.Action ;

var start:Function = function( action:Action ):void
{
    trace("start") ;
}

var finish:Function = function( action:Action ):void
{
    trace("finish") ;
    factory.getObject( "root" ) ;
}

var factory:ObjectFactory = new ObjectFactory() ;

factory.startIt.connect( start ) ;
factory.finishIt.connect( finish ) ;

factory.objects = 
[
    {
        id    	: "my_format" ,
        type  	: "flash.text.TextFormat" ,
    	  arguments : 
        [ 
            { value :"Arial"   } , 
            { value :24        } , 
            { value : 0xFEF292 } , 
            { value : true     } 
        ]
    }
    ,
    {
        id         : "my_field" ,
        type   	 : "flash.text.TextField"  ,
        properties :
        [
            { name : "autoSize"          , value  : "left"        } ,
        	{ name : "defaultTextFormat" , ref    : "my_format"   } ,
        	{ name : "text"              , value  : "HELLO WORLD" } ,
        	{ name : "x"                 , value  : 10            } ,
        	{ name : "y"                 , value  : 10            }
    	]
    }
    ,
    {
        id           	 : "root" ,
        type         	 : "flash.display.MovieClip"  ,
        factoryReference : "#root" ,
        properties       :
        [
            { name : "addChild" , arguments : [ { ref:"my_field" } ] }
        ]
    }
] ;

factory.config.root = this ;

factory.run( objects ) ; 
```

### 4 - The system.ioc.factory singleton ###

In the **system.ioc** package you can find the factory constant, this singleton reference defines an unique, simple and fast instance of the **ObjectFactory** class to use in your applications.

**example**

```
import system.ioc.factory ;
import flash.text.TextField ;

var objects:Array =
[
    {
        id    	: "my_format" ,
        type  	: "flash.text.TextFormat" ,
    	  arguments : 
        [ 
            { value :"Arial"   } , 
            { value :24        } , 
            { value : 0xFEF292 } , 
            { value : true     } 
        ]
    }
    ,
    {
        id         : "my_field" ,
        type   	 : "flash.text.TextField"  ,
        properties :
        [
            { name : "autoSize"          , value  : "left"        } ,
        	{ name : "defaultTextFormat" , ref    : "my_format"   } ,
        	{ name : "text"              , value  : "HELLO WORLD" } ,
        	{ name : "x"                 , value  : 10            } ,
        	{ name : "y"                 , value  : 10            }
    	]
    }
] ;

factory.config.root = this ;

factory.run( objects ) ; 

var field:TextField = factory.getObject("my_field") as TextField ;

addChild( field ) ;
```

### 5 - Debug the IoC factory ###

To debug the **IoC** factory you can use different modes based on the **system.logging** package the basic **logging engine** defines in the system package of **Maashaack**.

**example**

```
import system.ioc.factory ;

import system.logging.LoggerLevel;
import system.logging.targets.TraceTarget;

///////////////

var target:TraceTarget = new TraceTarget() ;

target.includeLines = true ;
target.includeTime  = true ;

target.filters      = ["*"] ;
target.level        = LoggerLevel.ALL ;

///////////////

var context:Array =
[
    { 
        id        : "test" ,
        type      : "String" ,
        arguments : 
        [
            { value : "hello world" } 
        ]
    }
    ,
    { 
        id         : "object" ,
        type       : "Object" ,
        properties : 
        [
            { name : "label" , value : "hi world" }
        ]
    }       
    ,
    { 
        id               : "test3" ,
        type             : "String" ,
        factoryReference : "object.labels" 
    }
] ;

factory.run( context ) ; 

// test a valid 'id' in the factory

trace( factory.getObject("test") ) ;

// use the logger object defines by default in the factory

trace( factory.getObject("test1") ) ;

//  use trace when a warning log message is invoked

factory.config.useLogger = false ; 

trace( factory.getObject("test2") ) ;

// Disabled all evaluation errors with the throwError flag

factory.config.throwError = true ; // enabled all errors

trace( factory.getObject( "test3" ) ) ;
```