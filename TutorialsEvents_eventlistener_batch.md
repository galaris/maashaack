# Batch your event listeners #

  * [HomePage](http://code.google.com/p/maashaack/)
    * [Returns events](events.md)

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