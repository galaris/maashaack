# Remove listeners #

  * [HomePage](http://code.google.com/p/maashaack/)
    * [Returns events](events.md)

## Description ##

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