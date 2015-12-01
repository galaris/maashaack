# Introduction #

  * [HomePage](http://code.google.com/p/maashaack/)
    * [Returns events](events.md)

To use the **system.events.EventDispatcher** class you must creates 3 objects : the dispatcher, the listener and the event.

To explain how **EventDispatcher** works, i start off with a suite of very simple examples :

**1 - Creating an event listener**

The EventListener interface must be implemented by your listener with the **handleEvent(e:Event)** method.

For example you can create a new class to debug the propagation of the events with all your **EventDispatcher** reference or singletons.

```
package examples.events
{
    import flash.events.Event ;
    import system.events.EventListener;
    
    /**
     * The DebugHandler class.
     */
    public class DebugHandler implements EventListener 
    {
    
        /**
         * Creates a new DebugHandler instance.
         */
        public function DebugHandler(name) 
        {
            _name = name || "default" ;
        }
        
        /**
         * Returns tne name of the debugger.
         */
        public function get name():String 
        {
            return _name || "" ;
        }
        
        /**
         * Handles the event.
         */
        public function handleEvent(e:Event):void
        {
            trace( "-------- DebugHandler : Event has been triggered." ) ;
            trace( "Event type     : " + e.type    ) ;
            trace( "Event target   : " + e.target  ) ;
        }
        
        /**
         * Returns the String representation of the object.
         */
        public function toString():String 
        {
           return "[DebugHandler name:" + _name + "]" ;
        }
        
        /**
         * @private
         */
        private var _name:String ;
	
    }

}
```

When this listener receives an event, it only displays the type of the event, the context of the event and the target of the dispatcher.

**2 - Registering an event listener**

Registering this listener for an event is extremely easy. At first you need to use an instance of event dispatcher (an instance who implement the **EventTarget** or **IEventDispatcher** class).

You can now create a new instance of the **DebugHandler** you just implemented and pass it to the **registerEventListener** method of the system.events.EventDispatcher class. This method requires two parameters to be set (the other parameters are optionals).

The first parameter is the **type** or the **event name** of the event for which you want to register the listener.

The second parameter is the listener instance.

```
import system.events.EventListener ;
import system.events.EventDispatcher ;

import examples.events.DebugHandler ;

var listener:EventListener = new DebugHandler();

var dispatcher:EventDispatcher = new EventDispatcher() ;

dispatcher.registerEventListener( "onLogin", listener ) ;
```

**Note :** you can use the addEventListener method of the class to register the handleEvent listener function

```
var dispatcher:EventDispatcher = new EventDispatcher() ;
dispatcher.addEventListener( "onLogin", listener.handleEvent ) ;
```

**3 - Dispatching an event**

To dispatch an event you call the **dispatchEvent()** method and pass in the **type** of the event as the first parameter to the method.

```
import system.events.BasicEvent ;
import system.events.EventListener ;
import system.events.EventDispatcher ;

import examples.events.DebugHandler ;

var listener:EventListener = new DebugHandler();

var dispatcher:EventDispatcher = new EventDispatcher() ;
dispatcher.addEventListener( "onLogin", listener ) ;

dispatcher.dispatchEvent( new BasicEvent("onLogin") ) ;

```