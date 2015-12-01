# Delegate the event listeners #

<a href='http://creativecommons.org/licenses/by-sa/3.0/'><img src='http://i.creativecommons.org/l/by-sa/2.0/uk/88x31.png' alt='Licence Creative Commons' /></a> author : Marc ALCARAZ ([ekameleon](https://code.google.com/u/109962507657971592081/))



The **Delegate** class is an event listener, that is included in the system.events.**distribution.**

It acts as a proxy to any method of any object that you want to use as a handler for the events.

```
import flash.events.Event ;

import system.events.BasicEvent ;
import system.events.Delegate ;
import system.events.EventDispatcher ;
import system.events.EventListener ;

var listener:Object = {} ;
listener.toString = function():String
{ 
    return "listener" ;
} ;

var debug:Function = function( e:Event ):void 
{
    trace("debug :: " + this + " : " + e.type ) ;
}

var listener:EventListener = new Delegate( listener , debug ) ;

var dispatcher:EventDispatcher = EventDispatcher.getInstance("myDispatcher") ;

dispatcher.registerEventListener( "onTest" , listener ) ;

dispatcher.dispatchEvent( new BasicEvent("onTest", this, "Hello World") ) ;

```

The **Delegate** class was originally implemented by Mike Chambers for Macromedia **mx.events** package in **FlashMX 2004**.

The **Delegate** class can be used with the static method **create** to create a proxy with a specified scope object and a specified method. The result of the static **create** method is a new virtual **Function**.

```
var listener:Object = {} ;
listener.toString = function():String 
{ 
    return "listener" ;
}

var method:Function = function()
{
    trace (this + ".method(" + arguments + ")" ) ;
}

var proxy:Function = Delegate.create( listener , method, "arg1", "arg2" ) ;

proxy("arg3", "arg4")  ; // listener.method(arg1,arg2,arg3, arg4)
```

In **Maashaack**, the **Delegate** class can be instantiate with the **new** key word and implements the **EventListener** interface.

This class is very useful to create an event listener with all scope object and all methods that you want.

```
var listener:Object = {} ;
listener.toString = function():String 
{ 
    return "listener" ;
}

var method:Function = function()
{
    trace (this + ".method(" + arguments + ")" ) ;
}

var proxy:Delegate = new Delegate( listener , method, "arg1", "arg2" ) ;

proxy.run("arg3", "arg4")  ; // listener.method(arg1,arg2,arg3, arg4)
```

**Note :** In AS3 the "Traits implementation" lock in the class the scope of the methods. Only dynamic objects and prototype methods can change the scope. This problem is the same with the Function.call and Function.apply methods.