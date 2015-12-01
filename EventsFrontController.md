# Design pattern FrontController based on the W3C event propagation #

<a href='http://creativecommons.org/licenses/by-sa/3.0/'><img src='http://i.creativecommons.org/l/by-sa/2.0/uk/88x31.png' alt='Licence Creative Commons' /></a> author : Marc ALCARAZ ([ekameleon](https://code.google.com/u/109962507657971592081/))



## Generality ##

The **front controller** design pattern defines a single **system.events.EventDispatcher** object that is responsible for processing application requests.

The front controller centralizes functions such as view selection, security, and templating, and applies them consistently across all pages or views. Consequently, when the behavior of these functions need to change, only a small part of the application needs to be changed : the controller and its helper classes.

Example ([see the source](http://code.google.com/p/maashaack/source/browse/trunk/AS3/examples/maashaack/system/events/examples/FrontControllerExample01.as)) :

```
package examples 
{
    import system.events.EventDispatcher;
    import system.events.EventListener;
    import system.events.FrontController;
    
    import flash.display.Sprite;
    import flash.events.Event;    

    [SWF(width="740", height="480", frameRate="24", backgroundColor="#666666")]

    /**
     * Basic example to use the FrontController class and register an EventListener
     * and a simple function.
     */
    public class FrontControllerExample01 extends Sprite implements EventListener
    {

        public function FrontControllerExample01()
        {
            var controller:FrontController = new FrontController() ;
            var dispatcher:EventDispatcher = EventDispatcher.getInstance() ;
            
            controller.add( "type1" , this     ) ;
            controller.add( "type2" , listener ) ;
            
            dispatcher.dispatchEvent( new Event( "type1" ) ) ; // # action1 : type1
            dispatcher.dispatchEvent( new Event( "type2" ) ) ; // # action2 : type2
        }
        
        /**
         * Handles the event with an EventListener object 
         * (implementation with the EventListener interface).
         */
        public function handleEvent(e:Event):void
        {
            trace("# handleEvent : " + e.type ) ; 
        }

        /**
         * Handles the event with a basic listener function.
         */
        public function listener( e:Event ):void 
        {
            trace("# handleEvent : " + e.type ) ; 
        }

    }
}
```

## FrontController with a global multi-channel factory ##

You can defines a channel when you initialize your front controller :

```
var controller:FrontController = new FrontController( "myChannel" ) ;

EventDispatcher.getInstance("myChannel").dispatchEvent( new Event("type") ) ; 
```

This channel link your front controller with the **system.events.EventDispatcher** singleton with the same channel.

The **FrontController** class use the "locator" design pattern and can be use with the factory static method **getInstance( channel:String )**.

Example ([see the source](http://code.google.com/p/maashaack/source/browse/trunk/AS3/examples/maashaack/system/events/examples/FrontControllerExample02.as)) :

```
package examples 
{
    import system.events.EventDispatcher;
    import system.events.FrontController;
    
    import flash.display.Sprite;
    import flash.events.Event;    

    /**
     * This class provides an example of the FrontController class 
     * with this static method getInstance().
     */
    public class FrontControllerExample02 extends Sprite 
    {

        public function FrontControllerExample02()
        {
        
            var controller:FrontController = FrontController.getInstance( "myChannel" ) ;
            var dispatcher:EventDispatcher = EventDispatcher.getInstance( "myChannel" ) ;
            
            controller.add( "type1" , listener1 ) ;
            controller.add( "type2" , listener2 ) ;
            
            dispatcher.dispatchEvent( new Event( "type1" ) ) ; // # action1 : type1
            dispatcher.dispatchEvent( new Event( "type2" ) ) ; // # action2 : type2
            
        }
        
        public function listener1( e:Event ):void 
        {
            trace("# action1 : " + e.type ) ; 
        }

        public function listener2( e:Event ):void 
        {
            trace("# action2 : " + e.type ) ; 
        }
        
    }
}

```

## Use the fireEvent method to dispatch your events in the FrontController ##

With a **FrontController** object you can call the **fireEvent()** method to dispatch an event with no direct dependencies in your code.

Example ([see the source](http://code.google.com/p/maashaack/source/browse/trunk/AS3/examples/maashaack/system/events/examples/FrontControllerExample03.as)) :

```
package examples 
{
    import system.events.FrontController;
    
    import flash.display.Sprite;
    import flash.events.Event;    

    [SWF(width="740", height="480", frameRate="24", backgroundColor="#666666")]

    /**
     * This class provides an example of the FrontController class and this method fireEvent().
     */
    public class FrontControllerExample03 extends Sprite 
    {

        public function FrontControllerExample03()
        {
            var controller:FrontController = FrontController.getInstance( "myChannel" ) ;
            
            controller.add( "type" , listener ) ;
            
            controller.fireEvent( "type" ) ; 
            // # listener : [BasicEvent type="type" target=[object EventDispatcher] context=null bubbles=false cancelable=false eventPhase=2]
            
            controller.fireEvent( new Event( "type" ) ) ; 
            // [Event type="type" bubbles=false cancelable=false eventPhase=2]
            
        }
        
        public function listener( e:Event ):void 
        {
            trace("# listener : " + e ) ; 
        }

    }
}
```

The **fireEvent()** method can be use with :

  * A **String** parameter, the method dispatch a **system.events.BasicEvent** and the type of the event is the parameter value.
  * An Event object to dispatch in the frontController.

## Batch your event listeners in a FrontController with the same event type ##

The FrontController centralizes the event propagation in your application. The easy usage of the design pattern use a front controller to register one event type and one event listener. But in the **system.events.FrontController** class you can create a collection of **EventListener** objects with the method **addBatch()**

This method group your event listeners to handle all events with a specific type register in the front controller.

Example ([see the source](http://code.google.com/p/maashaack/source/browse/trunk/AS3/examples/maashaack/system/events/examples/FrontControllerExample04.as)) :

```
package examples 
{
    import system.events.FrontController;
    
    import flash.display.Sprite;
    import flash.events.Event;    

    [SWF(width="740", height="480", frameRate="24", backgroundColor="#666666")]

    /**
     * This class provides an example of the FrontController class and this addBatch method.
     */
    public class FrontControllerExample04 extends Sprite 
    {

        public function FrontControllerExample04()
        {
            var controller:FrontController = FrontController.getInstance( "myChannel" ) ;
            
            controller.addBatch( "type1" , new MyListener("listener1") ) ;
            controller.addBatch( "type1" , new MyListener("listener2") ) ;
            
            controller.addBatch( "type2" , new MyListener("listener3") ) ;
            controller.addBatch( "type2" , new MyListener("listener4") ) ;
            
            controller.fireEvent( new Event( "type1" ) ) ; 
            
            // [MyListener listener1] handleEvent : type1
            // [MyListener listener2] handleEvent : type1
            
            controller.fireEvent( new Event( "type2" ) ) ;

            // [MyListener listener3] handleEvent : type2
            // [MyListener listener4] handleEvent : type2
            
            controller.remove( "type2" ) ;
            controller.fireEvent( new Event( "type2" ) ) ;
            
            // nothing
        }

    }
}

import system.events.EventListener;

import flash.events.Event;

class MyListener implements EventListener
{

    public function MyListener( name:String = "" )
    {
        this.name = name ;
    }
    
    public var name:String ;

    public function handleEvent(e:Event):void
    {
        trace( this + " handleEvent : " + e.type ) ; 
    }

    public function toString():String
    {
        return "[MyListener " + name + "]" ;  
    }
}
```