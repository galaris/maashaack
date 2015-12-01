# Multi-core EventDispatcher factory #

  * [HomePage](http://code.google.com/p/maashaack/)
    * [Returns events](events.md)

You can create instances of the **system.events.EventDispatcher** class with the **new** key words, but you can creates statically singleton references of the class with the static method **getInstance()**.

The big difference between the **flash.events.EventDispatcher** class and the **system.events.EventDispatcher** class are :

  * The method **registerEventListener** and **unregisterEventListener** to register **EventLister** objects and not only the functions.
  * The factory static methods **getInstance(channel:String)** defines in the **system.events.EventDispatcher** implementation to create global event dispatcher in your applications.

This approach has been taken, to be able to allow more than one global dispatcher instance per application.

The **getInstance()** method accepts a **channel** value for the dispatcher as its sole parameter, so you can easyily create as many dispatchers as you need and still easily identify them :

```

import system.events.EventDispatcher ;

var default:EventDispatcher = EventDispatcher.getInstance() ; // no value in argument
var user:EventDispatcher    = EventDispatcher.getInstance("user") ;
var debug:EventDispatcher   = EventDispatcher.getInstance("debug") ;

```

The String channel value of the singleton **EventDispatcher** reference represents a **channel** to dispatch the events in your application.

You can retreive the channel of the singleton reference with the read-only property **channel**.

```

var user:EventDispatcher = EventDispatcher.getInstance("user") ;

trace( "The channel of the user dispatcher : " + user.channel ) ;
```

To add listeners you now only need to know, which dispatcher is responsible for the events you need to handle.

In web applications, you can also use this to create a new dispatcher for each session of your application.

This feature is really useful to implement the **Design Pattern FrontController**.

You can remove singleton reference with the static methods **removeInstance()**.

```

import system.events.EventDispatcher ;
import system.events.EventListener ;

var logger:EventDispatcher = EventDispatcher.getInstance( "logger" ) ;
var user:EventDispatcher   = EventDispatcher.getInstance( "user" ) ;

var isRemove:Boolean = EventDispatcher.removeInstance( "user" ) ;
trace( "The 'user' EventDispatcher singleton is removed : " + isRemove ) ;

var logger:EventDispatcher = EventDispatcher.release("logger") ;
trace( "The 'logger' EventDispatcher is released : " + logger ) ;

```

The static **removeInstance()** returns **true** if the **removeInstance()** method can remove the specified global reference in the **EventDispatcher** factory.

You can clean in memory all the global references register in the **EventDispatcher** factory with the **flush()** method :

```
import vegas.events.EventDispatcher ;

var default:EventDispatcher = EventDispatcher.getInstance() ;
var user:EventDispatcher    = EventDispatcher.getInstance("user") ;
var debug:EventDispatcher   = EventDispatcher.getInstance("debug") ;

trace( EventDispatcher.getChannels() ) ;

EventDispatcher.flush() ;

trace( EventDispatcher.getChannels() ) ;
```