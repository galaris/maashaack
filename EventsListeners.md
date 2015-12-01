# EventListeners #

<a href='http://creativecommons.org/licenses/by-sa/3.0/'><img src='http://i.creativecommons.org/l/by-sa/2.0/uk/88x31.png' alt='Licence Creative Commons' /></a> author : Marc ALCARAZ ([ekameleon](https://code.google.com/u/109962507657971592081/))



## Priority ##

When you register an event listener with the **addEventListener** or the **registerEventListener** method of the **system.events.EventDispatcher** class you can apply a priority over your event listener.

The priority is designated by an uint value( an integer > 0 ).

The higher the number, the higher the priority. All listeners with priority **n** are processed before listeners of priority **n-1**.

If two or more listeners share the same priority, they are processed in the order in which they were added.

The default priority is **0**. This feature is native in the flash.events.**package of the FlashPlayer 9 et 10.**

```

import system.events.Event ;
import system.events.EventDispatcher ;
import system.events.EventListener ;
import system.events.Delegate ;

function debug( e:Event, msg:String ):void 
{
    trace ( "debug " + e.type + " message -> " + msg ) ;
}

var listener1:EventListener = new Delegate( this, debug , "listener1") ;
var listener2:EventListener = new Delegate( this, debug , "listener2") ;
var listener3:EventListener = new Delegate( this, debug , "listener3") ;
var listener4:EventListener = new Delegate( this, debug , "listener4") ;

var dispatcher:EventDispatcher = new EventDispatcher() ;

dispatcher.registerEventListener("test", listener1, false, 3) ;
dispatcher.registerEventListener("test", listener2, false, 1) ;
dispatcher.registerEventListener("test", listener3, false, 2) ;
dispatcher.registerEventListener("test", listener4, false, 1000) ; // high priority

dispatcher.dispatchEvent( new Event("test") ) ;

```

The result of the previous script in the output panel :

```
debug test message -> listener4
debug test message -> listener1
debug test message -> listener3
debug test message -> listener2
```

## Remove ##

If you need to remove an event listener, that has been added before, you can use the **removeEventListener()** or the **unregisterEventListener()** methods of **system.events.EventDispatcher**.

```
import system.events.EventDispatcher ;
import system.events.EventListener   ;

import examples.events.DebugHandler ;

var dispatcher:EventDispatcher = EventDispatcher.getInstance() ;

var one:EventListener = new DebugHandler("one") ;
var two:EventListener = new DebugHandler("two") ;

dispatcher.registerEventListener("onLogin", one ) ;
dispatcher.registerEventListener("onLogin", two ) ;

var removed:Boolean ;

removed = dispatcher.unregisterEventListener( "onLogin", one ) ;
if ( removed ) 
{
    trace("The event listener 'one' has succesfully been removed.") ;
}

dispatcher.dispatchEvent("onLogin") ;

removed = dispatcher.removeEventListener( "onLogin", two.handleEvent ) ;
if ( removed ) 
{
    trace("The event listener 'two' has succesfully been removed.") ;
}

dispatcher.dispatchEvent("onLogin") ;

```

The first time, the triggered event will be only caught by the **DebugHandler** named _two_ . The second time when the two listeners are unregister no event is dispatched.

To complete this example we can read the content of the **DebugHandler** class :

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

## Batch ##

With the **system.events.EventListenerBatch** class you can handle several **EventListener** as one **EventListener**.

```
import flash.events.Event ;

import system.events.Delegate ;
import system.events.EventDispatcher ;
import system.events.EventListener ;
import system.events.EventListenerBatch ;

var action1:Function = function (e:Event):void 
{
    trace ("action 1 : " + e.type ) ;
}

var action2:Function = function ( e:Event ):void 
{
    trace ("action 2 : " + e.type ) ;
}

var listener1:EventListener = new Delegate(this, action1) ;
var listener2:EventListener = new Delegate(this, action2) ;

var batch:EventListenerBatch = new EventListenerBatch() ;

batch.add( listener1 ) ;
batch.add( listener2 ) ;

EventDispatcher.getInstance().registerEventListener("test", batch) ;
EventDispatcher.getInstance().dispatchEvent( new Event( "test" ) ) ;
```

Result of this script :

```
action 1 : test
action 2 : test
```