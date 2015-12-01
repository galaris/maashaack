# LifeCycle of the objects #

<a href='http://creativecommons.org/licenses/by-sa/3.0/'><img src='http://i.creativecommons.org/l/by-sa/2.0/uk/88x31.png' alt='Licence Creative Commons' /></a> author : Marc ALCARAZ ([ekameleon](https://code.google.com/u/109962507657971592081/))



| **identify** | Can identify some Identifiable objects by assigning them automatically the id value of the object definition. |
|:-------------|:--------------------------------------------------------------------------------------------------------------|
| **lock**     | Active the lock process during the initialization of an object created by the factory. The object implements the system.process.Lockable interface. |
| **init**     | Indicates the name of the method to call to finish to initialize the object.                                  |
| **destroy**  | Indicates the name of the method to call to destroy a singleton object register in the IoC container.         |
| **dependsOn** | A list (Array) of objects identifiers registered in the factory who must exist before the current object is generated and initialized. |
| **generates** | A list (Array) of objects identifiers registered in the factory who must exist after the current object is generated and initialized. |
| **listeners** | A list (Array) of event listeners to register with the current dispatcher object (the object must implement the flash.events.IEventDispatcher interface) |
| **receivers** | A list (Array) of signals to connect with the object (if the object implements the system.signals.Receiver interface) or one or more of this methods (slots).|

## 1 - The "init" attribute ##

An **object definition** provides support for a generic initialization method to be specified. Use the '**init**' attribute, for example, the following definition:

```
import examples.core.User ;
import system.ioc.factory ;

var objects:Array = 
[{
    id   : "user" ,
    type : "examples.core.User" ,
    init : "initialize"
}] ;

factory.run( objects ) ;

var user:User = factory.getObject( "user" ) ;
```

...with pure code it is exactly the same as...

```
import examples.core.User ;

var user:User = new User() ;
user.initialize() ;
```

In the example, the object definition targets the **initialize** method defines in the **examples.core.User** class and this method will be invoked at the end of the initialization of the new object when generated via the **IoC** container. You can use a custom name to defines and target the 'init' method, this method is defined without arguments and returns nothing (**void**).

## 2 - The "destroy" attribut ##

An **object definition** provides support for a generic destroy method to be specified. Use the 'destroy' attribute, for example, the following definition:

```
import examples.core.User ;
import system.ioc.factory ;

var objects:Array = 
[{
    id        : "user" ,
    type      : "examples.core.User" ,
    singleton : true ,
    destroy   : "destroy"
}] ;

factory.run( objects ) ;

var user:User = factory.getObject( "user" ) ;

factory.removeSingleton( "user" ) ;
```

The **object definition** must be defines with the scope '**singleton**' in the factory to activate the '**destroy**' attribute behavior. To remove the singleton reference on memory in the **IoC** container we can call the method **removeSingleton()** and the '**destroy**' method defines in the **object definition** will be called at this time.