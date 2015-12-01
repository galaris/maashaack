# Command and Task Engine #

<a href='http://creativecommons.org/licenses/by-sa/3.0/'><img src='http://i.creativecommons.org/l/by-sa/2.0/uk/88x31.png' alt='Licence Creative Commons' /></a> author : Marc ALCARAZ ([ekameleon](https://code.google.com/u/109962507657971592081/))



## Introduction ##

The **process engine** provides general abstraction to create and manage asynchronous operations in your applications. It is include in the package **system.process**.

In the life cycle of the applications it's important to create custom and specific tasks and to use tools who allow to grouping them for concurrent or sequential execution :
  * loading external configuration files,
  * loading external swfs or modules,
  * loading pictures or sounds or animations,
  * invoking remote services,
  * invoking motion tween,
  * controlling the time-line of your MovieClip,
  * creating a pause,
  * and more...

While each of these operations are quite easy to handle on their own, it can soon become quite complex if you have to combine lots of these operations.

## Interfaces ##

The **system.process** package contains important interfaces to create your custom task :
**Runnable, Lockable, Priority, Action, Startable, Stoppable, Resumable** and **Resetable.**

### The Runnable interface ###

The **process engine** is based on the **Design Pattern Command**. A design pattern in which an object is used to represent and encapsulate all the informations needed to execute a method or task at a later time.

Using command objects makes it easier to construct general components that need to delegate, sequence or execute method calls at a time of their choosing without the need to know the owner of the method or the method parameters.

The **system.process.Runnable** interface defines the basic implementation to create a command.

```
package system.process
{
    public interface Runnable
    {
        function run( ...arguments:Array ):void ;
    }
}
```

The **run** method is the launcher of the command and all class who implements the **Runnable** interface must contains this method.

For example we can create a **Move** command to change the position of a specific display in your application.

```
package examples.process
{
    import flash.display.DisplayObject ;
    import system.process.Runnable ;
	
    public class Move implements Runnable
    {
        public function Move( target:DisplayObject , x:Number , y:Number )
        {
            this.target = target ;
            this.x      = x ;
            this.y      = y ;
        }
     
        public var target:DisplayObject ;

        public var x:Number ;
        
        public var y:Number ;
	    
        public function run( ...arguments:Array ):void
        {
            if( arguments.length > 0 )
            {
                this.x = arguments[0] as Number ;
                this.y = arguments[1] as Number ;
            }
            if( target )
            {
                target.x = x ;
                target.y = y ;
            }
        }
    }
}
```

We can executes this command at a time of our choosing :

```
package examples
{
    import examples.process.Move;

    import system.process.Runnable;

    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.utils.setTimeout;
  
    public class RunnableExample extends Sprite
    {
	  public function RunnableExample()
        {
            ////// Creates the shape
          
            var shape:Shape = new Shape() ;
          
            shape.x = 25 ;
            shape.y = 25 ;
          
            shape.graphics.beginFill( 0xFF0000 ) ;
            shape.graphics.drawRect( 0 , 0 , 40 , 40 ) ;
          
            addChild( shape ) ;
            
            ////// Creates the command
            
            var command:Runnable = new Move( shape , 250 , 160 ) ;
            
            ////// Execute the command in two seconds
                      
            setTimeout( command.run , 2000 ) ;
        }
    }
}
```

### The Lockable interface ###

The **system.process.Lockable** interface provide more extensive locking operations. This interface defines three important methods : **lock**(), **unlock**() and **isLocked**().

```
package system.process
{
    public interface Lockable
    {
        function isLocked():Boolean ;

        function lock():void ;

        function unlock():void ;
    }
}
```

This minimalist interface can be implemented by any class that requires in there life cycle many updates and many repetitive actions that could affect the performance by lowering all the application. We can use this interface too to lock event propagation for example.

**Example :**

Consider a class to defines a basic component that has multiple virtual properties (get/set). This component uses this properties to update this color, this size, etc.. When the user initialize all properties of the component after running modified each time a method to update the component.

To illustrate this concept I will create a visual class **examples.display.RectangleSprite** which lets you create dynamic graphics rectangular symbols, this class implements the interface Lockable.

```
package examples.display
{
    import flash.display.Sprite;
    
    import system.process.Lockable;  
    
    /**
     * This sprite draw a rectangle with a virtual width and height value.
     */
    public class RectangleSprite extends Sprite implements Lockable
    {
        /**
         * Creates a new RectangleSprite instance.
         */
        public function RectangleSprite()
        {
            super() ;
        }
        
        /**
         * The color of the rectangle shape.
         */
        public function get color():uint
        {
            return _color ;
        }      
        
        /**
         * @private
         */
        public function set color( value:uint ):void
        {
            _color = value ;
            update() ;
        }       
        
        /**
         * Determinates the virtual height value of this sprite.
         */
        public function get h():Number
        {
            return _h ;
        }
        
	/**
         * @private
         */
        public function set h( n:Number ):void
        {
            _h = isNaN(n) ? 0 : n ;
            update() ;
        }      
        
        /**
         * Determinates the virtual height value of this sprite.
         */
        public function get w():Number
        {
            return _w ;
        }
     
	  /**
         * @private
         */
        public function set w( n:Number ):void
        {
            _w = isNaN(n) ? 0 : n ;
            update() ;
        }          
     
        /**
         * Draw the display.  
         */
        public function draw():void
        {
            graphics.clear() ;
            graphics.beginFill( color , 1 ) ;
            graphics.drawRect( 0, 0, w, h ) ;
        }      
     
        /**
         * Returns true if the object is locked.
         * @return true if the object is locked.
         */
        public function isLocked():Boolean
        {
            return ___isLock___ == true ;
        }
     
        /**
         * Locks the object.
         */
        public function lock():void
        {
            ___isLock___ = true ;
        }
     
        /**
         * Unlocks the object.
         */
        public function unlock():void
        {
            ___isLock___ = false ;
        }
     
        /**
         * Update the display.
         */
        public function update():void
        {
            if ( isLocked() )
            {
                return ;
            }
            trace( this + " update" ) ;
            draw() ;
        }

        /**
         * @private
         */
        protected var _color:uint = 0xFF0000 ;      
     
        /**
         * @private
         */
	  protected var _h:Number = 0 ;
     
        /**
         * @private
         */
	  protected var _w:Number = 0 ;
     
        /**
         * The internal flag to indicates if the display is locked or not.
         * @private
         */
        private var ___isLock___:Boolean ;      
    }
}
```

The class examples.display.RectangleSprite defines the virtual properties color, h and w. This properties defines the color, the height and the width components to draw the dynamic shape. Each call to one of these properties will automatically start the **update**() method to refresh the view with the draw() method defined in the class.

The **RectangleSprite** class implement the **Lockable** interface and use only a little **Boolean** flag to switch between the locked and unlocked mode with the **isLocked**() method in the **update**() method :

```
/**
 * Update the display.
 */
public function update():void
{
   if ( isLocked() )
   {
       return ; // breakpoint
   }
   trace( this + " update" ) ;
   draw() ;
}
```

This break point with a return statement will be invoked if the method **isLocked**() returns true. This simple method can be deployed in any class.

Let's now a little bit of ActionScript code to illustrate this example :

```
import examples.display.RectangleSprite ;

var sprite:RectangleSprite = new RectangleSprite() ;

sprite.color = 0xFF00FF
sprite.w     = 200 ;
sprite.h     = 180 ;

sprite.x     = 25 ;
sprite.y     = 25 ;

addChild( sprite ) ;
```

Now we can run the compiled application, I get a rectangle on the stage and in the output panel we can read the following message :

```
[object RectangleSprite] update
[object RectangleSprite] update
[object RectangleSprite] update
```

The **update**() method is called three times when we defines the properties w, h and color.

In a small piece of code like this notion of optimization is not very important, but on a larger scale if we try to instantiate multiple objects we observe countless unnecessary calls the **update**() method.

Now, we can rewrite the example with the **Lockable** hack.

```
import examples.display.RectangleSprite ;

var sprite:RectangleSprite = new RectangleSprite() ;

sprite.lock() ;

sprite.color = 0xFF00FF
sprite.w     = 200 ;
sprite.h     = 180 ;

sprite.unlock() ;

sprite.update() ;

sprite.x     = 25 ;
sprite.y     = 25 ;

addChild( sprite ) ;
```

In the output of the flashplayer we can read the following message :

```
[object RectangleSprite] update
```

The **update**() method is called only once after the **unlock**() method to update the view of the display.

**Note** : In **AS3** we can find the **lock**() and **unlock**() method in some native class like **flash.display.BitmapData** but this class don't implements the **Lockable** interface.

### The Priority interface ###

The **system.process.Priority** interface is providing the priority of a specific task who implements this interface in the application.

```
package system.process 
{
    public interface Priority 
    {
        function get priority():int ;
        function set priority( value:int ):void ;
    }
}
```

The **priority** property defines the value of the priority. The priority member can be used to sort tasks in chains, batch, priority queues, etc.

### The Action interface ###


The **system.process.Action** interface provide a complete task implementation in the **system.process** package.

```
package system.process 
{
    import system.Cloneable;
    import system.signals.Signaler;
    
    /**
     * This interface represents the methods implemented in the Action objects.
     */
    public interface Action extends Cloneable, Runnable
    {
        /**
         * This signal emit when the notifyFinished method is invoked. 
         */
        function get finishIt():Signaler ;
        function set finishIt( signal:Signaler ):void ;
        
        /**
         * The current phase of the action.
         * @see system.process.TaskPhase
         */
        function get phase():String ;
        
        /**
         * Indicates <code class="prettyprint">true</code> if the action is in progress.
         */
        function get running():Boolean ;
        
        /**
         * This signal emit when the notifyStarted method is invoked. 
         */
        function get startIt():Signaler ;
        function set startIt( signal:Signaler ):void ;
        
        /**
         * Notify when the process is finished.
         */
        function notifyFinished():void ;
        
        /**
         * Notify when the process is started.
         */
        function notifyStarted():void ;
    }
}
```

The **Action** interface defines a command with a beginning and an ending. All tasks are based on this interface implementation.

The **Action** interface provide objects who use signals propagation with the **system.signals** engine to notify the start and the finish of the process.

All the task who implements the **Action** interface must contains two signals finishIt and startIt to connect slots (receivers).

**Example with signals and receivers :**

```
import system.process.Action ;

var finish:Function = function( action:Action ):void
{
    trace( "finish" ) ;
}

var start:Function = function( action:Action ):void
{
    trace( "start" ) ;
}

action.startIt.connect( start ) ;
action.finishIt.connect( finish ) ;
```

The **notifyFinished()** and **notifyStarted()** methods are invoked in the tasks to notify the beginning and the ending of the task process.

The running property is a boolean who indicates if the process is in progress.

The **phase** property is a specific value to indicates the current phase of the process, we can defines all phases of the process with the static enumeration **system.process.TaskPhase** :

```
package system.process 
{
    /**
     * The enumeration of all phases in a task process.
     */
    public class TaskPhase 
    {
        /**
         * The phase of a delayed task.
         */
        public static const DELAYED:String = "delayed" ;
        
        /**
         * The phase of a finished task.
         */
        public static const FINISHED:String = "finished" ;
        
        /**
         * The phase before the task has been started for the first time or (for restartable Tasks) also after it has completed its execution.
         */
        public static const INACTIVE:String = "inactive" ;
        
        /**
         * The phase of a running Task.
         */
        public static const RUNNING:String = "running" ;
        
        /**
         * The phase of a finished task.
         */
        public static const STOPPED:String = "stopped" ;
        
        /**
         * The phase of an out of time task.
         */
        public static const TIMEOUT:String = "timeout" ;
    }
}
```

All Action objects are **Cloneable**, we can creates a shallow copy of a specific task with the **clone()** method.

The basic implementation of the **Action** interface is the **system.process.Task** class, 100% of all **Action** in your application must inherit the **Task** class or you must be sure to implement the interface with the same code in your custom class.

### The Startable, Stoppable, Resetable and Resumable interfaces ###

The **system.process.Startable** interface is used when tasks need to be "running" to be active. It provides a method through which task can be "started".
```
package system.process
{
    public interface Startable
    {
        function start():void ;
    }
}
```

The **system.process.Stoppable** interface is used when tasks need to be inactive. It provides a method through which task can be "stopped".
```
package system.process
{
    public interface Stoppable
    {
        function stop():void ;
    }
}
```

The **system.process.Resetable** interface is used when tasks need to be reset.
```
package system.process
{
    public interface Resetable
    {
        function reset():void ;
    }
}
```

The **system.process.Resumable** interface is used when tasks need to be resume.
```
package system.process
{
    public interface Resumable
    {
        function resume():void ;
    }
}
```

All this basic interfaces are important to create complex tasks in your application.

For example in a **Chain** who is running, the user may be forced to stop the execution of the main process and the current task in the chain who implement the **Stoppable** interface can be stopped too.

Now if the user want resume the **Chain** main process, the current task can be resumed too if it's implement the **Resumable** interface.

This interfaces may seem simplistic but it can easily handle many tasks in a specific context of your applications.

## Basic Runnable implementations ##

### The system.process.Batch class ###

Batch processing is execution of a series of tasks in your application. A batch process can be used to automate much of the work.

A batch process performs an asynchronous list of commands and run it a single stroke.

Example, we create a little **Square** display class who implements the **Runnable** interface, the run method of this class invoke an "enterframe" event process to move the display to a specific position.

```
package examples.display
{
    import system.process.Runnable;
    
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.filters.DropShadowFilter;
    import flash.geom.Point;
    
    public class Square extends Sprite implements Runnable
    {
        public function Square( x:int=0, y:int=0, color:uint=0xFFFFFF )
        {
            this.x = x ;
            this.y = y ;
            graphics.beginFill( color ) ;
            graphics.drawRect(0, 0, 30, 30) ;
        }
        
        public var finish:Point ;
        
        public function run(...arguments:Array):void
        {
            if ( finish )
            {
                addEventListener(Event.ENTER_FRAME , enterFrame ) ;
            }
        }
        
        protected function enterFrame( e:Event ):void
        {
            var dx:Number = Math.round( ( finish.x - x ) * 0.3 ) ;
            var dy:Number = Math.round( ( finish.y - y ) * 0.3 ) ;
            x += dx ;
            y += dy ;
            if ( dx == 0 && dy == 0 )
            {
                removeEventListener(Event.ENTER_FRAME , enterFrame ) ;
            }
        }
    }
}
```

Now we can use this basic command/display objects in a batch :

```
package examples
{
    import examples.display.Square;
    
    import system.process.Batch;
    
    import flash.display.Sprite;
    import flash.events.KeyboardEvent;
    import flash.geom.Point;
    
    [SWF(width="740", height="480", frameRate="24", backgroundColor="#666666")]
    
    public class BatchExample extends Sprite
    {
        public function BatchExample()
        {
            var s1:Square = new Square( 50 ,  50 , 0xFF0000 ) ;
            var s2:Square = new Square( 50 , 100 , 0x00FF00 ) ;
            var s3:Square = new Square( 50 , 150 , 0x0000FF ) ;
            
            s1.finish = new Point( 600 ,  50 ) ;
            s2.finish = new Point( 600 , 100 ) ;
            s3.finish = new Point( 600 , 150 ) ;
            
            addChild(s1) ;
            addChild(s2) ;
            addChild(s3) ;
            
            command = new Batch() ;
            command.add( s1 ) ;
            command.add( s2 ) ;
            command.add( s3 ) ;
            
            // press a key to run the batch
            
            stage.addEventListener( KeyboardEvent.KEY_DOWN, keyDown ) ;
        }
        
        public var command:Batch ;
        
        public function keyDown( e:KeyboardEvent ):void
        {
            command.run() ;
        }
    }
}
```

When the user push the keyboard's key, the three square displays move in the same times, the batch run all this registered commands at once.

## Basic Action implementations ##

### The system.process.Task class ###

The **system.process.Task** class is an abstract implementation of the **system.process.Action** interface.

You can extends this class to defines your custom Action objects. The Task class contains all important methods and properties used in the task engine.

To creates your custom task you can override the empty **run()** method of the **Task** class and don't forget to invoke the **notifyStarted()** method in the begining of the process and the **notifyFinished()** method in the ending of the process.

The **notifyFinished** method is really important if the task is adding in a **TaskGroup** object, to notify the end of the current process and run the next process in a chain or a batch task object for example. Don't forget to invoke it in your custom tasks when your process is finished.

**basic example**

We create a basic Message class who extends the abstract system.process.Task class. We override this run() method and we must invoke the **notifyStarted()** and **notifyFinished()** methods to complete the custom task notifications.

```
package examples.process 
{
    import system.process.Task;
    
    public class Message extends Task 
    {
        public function Message( message:String )
        {
            this.message = message ;
        }
        
        public var message:String ;
        
        public override function run( ...arguments:Array ):void
        {
            notifyStarted() ;
            trace( message ) ;
            notifyFinished() ;
        }
        
        public function toString():String
        {
            return message ;
        }
    }
}
```

In all the next examples with use a little custom task with the class **examples.process.Message**.

### The system.process.Cache class ###

Enqueue a collection of members definitions (commands) to apply or invoke with the specified target object.

The **Cache** class is a helper to implements for example the **Load/Cache/Proxy** pattern, this pattern defines a simple logic to load an external source code (in an external swf for example) and not wait the end of the loading process to use it and invoke this commands immediately.

**usage**

```
new Cache( target:* = null )
```

**basic example**

```
import core.dump ;
import system.process.Cache ;

var object:Object = {} ;

object.a = 1 ;
object.b = 2 ;
object.c = 3 ;
object.d = 3 ;

object.method1 = function( value:uint ):void
{
    this.c = value ;
};

object.method2 = function( value1:uint , value2:uint ):void
{
    this.d = value1 + value2 ;
};

object.setPropertyIsEnumerable( "method1" , false ) ;
object.setPropertyIsEnumerable( "method2" , false ) ;

trace( core.dump( object ) ) ; // {b:2,d:3,a:1,c:3}

var cache:Cache = new Cache( object ) ;

cache.enqueueAttribute( "a" , 10 ) ;
cache.enqueueAttribute( "b" , 20 ) ;

cache.enqueueMethod( "method1" , 30 ) ;
cache.enqueueMethod( "method2" , 40 , 50 ) ;

cache.run() ; // flush the caching queue

trace( core.dump( object ) ) ; // {b:20,c:30,d:90,a:10}
```

**interface example**

We defines a basic **Speaker** interface :

```
package examples.process.cache
{
    public interface Speaker
    {
        function get name():String ;
        function set name( value:String ):void ;
        
        function sayHello( who:String = "unknow" ):void ;
        
        function sayGoodBye( who:String = "unknow" ):void ;
    }
}
```

Now we can create the basic **SpeakerUser** class, a concrete class who implements the **Speaker** interface :

```
package examples.process.cache
{
    public class SpeakerUser implements Speaker
    {
        public function SpeakerUser( name:String = "user" )
        {
            this.name = name ;
        }
        
        public function get name():String 
        {
            return _name ;
        }
        
        public function set name( value:String ):void
        {
            _name = value ;
        }
        
        public function sayHello( who:String = "unknow" ):void
        {
            trace( _name + " say hello " + who ) ;
        }
        
        public function sayGoodBye( who:String = "unknow" ):void
        {
            trace( _name + " say good bye " + who ) ;
        }
        
        private var _name:String ;
    }
}
```

We can defines now the **SpeakerCache** class who extends the **system.process.Cache** class and implements the **Speaker** interface :

```
package examples.process.cache
{
    import system.process.Cache;
    
    public class SpeakerCache extends Cache implements Speaker
    {
        public function SpeakerCache( target:Speaker = null )
        {
            super( target ) ;
        }
        
        public function get name():String 
        {
            return _name ;
        }
        
        public function set name( value:String ):void
        {
            enqueueAttribute( "name" , value ) ;
            _name = value ;
        }
        
        public function sayHello( who:String = "unknow" ):void
        {
            enqueueMethod( "sayHello" , who ) ;
        }
        
        public function sayGoodBye( who:String = "unknow" ):void
        {
            enqueueMethod( "sayGoodBye" , who) ;
        }
        
        private var _name:String ;
    }
}
```

Test now the cache proxy in a basic example :

```
package examples
{
    import examples.process.cache.Speaker;
    import examples.process.cache.SpeakerCache;
    import examples.process.cache.SpeakerUser;
    
    import system.process.Cache;
    
    import flash.display.Sprite;
    
    public class CacheExample extends Sprite
    {
        public function CacheExample()
        {
            var speaker:Speaker = new SpeakerUser() ;
            var cache:Speaker   = new SpeakerCache( speaker ) ;
            
            cache.name = "John" ;
            cache.sayHello( "Jack" ) ;
            cache.sayGoodBye( "Jack" ) ;
            
            // flush the cache and initialize the speaker user
            
            if ( cache is Cache )
            {
                ( cache as Cache ).run() ;
            }
        }
    }
}
```

### The system.process.BindTask class ###

A **BindTask** instance wraps a function in another, locking its execution scope to a specific object.

**usage**

```
new BindTask( func:Function , scope:* = null , ...arguments:Array )
```

**basic example**

```
package examples
{
    import core.dump ;
    import system.process.Action;
    import system.process.BindTask;
    
    import flash.display.Sprite;
    
    public class BindTaskExample extends Sprite
    {
        public function BindTaskExample()
        {
            var scope:Object = {} ;
            scope.toString = function():String 
            {
                return "scope" ;
            };
            
            var execute:Function = function ( ...arguments:Array ):void 
            {
                trace( this + " execute " + dump(arguments) ) ;
            };
            
            var proxy:BindTask = new BindTask( execute , scope , "hello world" ) ;
            
            proxy.finishIt.connect( finish ) ;
            proxy.startIt.connect( start ) ;
            
            proxy.run() ;
        }
        
        public function finish( action:Action ):void 
        {
            trace( "finish" ) ;
        }
        
        public function start( action:Action ):void 
        {
            trace( "start" ) ;
        }
    }
}
```

### The system.process.Initializer class ###

The **Initializer** class is dynamic and provides a basic task with a custom initialize method. This method can be dynamic or defines in a class who extends the **Initializer** class.

**usage**

```
new Initializer()
```

**basic example**

```
import system.process.Action ;
import system.process.Initializer ;

var finish:Function = function( action:Action ):void
{
    trace( "finish" ) ;
}

var start:Function = function( action:Action ):void
{
    trace( "start" ) ;
}

var process:Initializer = new Initializer() ;

process.initialize = function():void
{
    trace( "initialize your application" ) ;
}

process.startIt.connect( start ) ;
process.finishIt.connect( finish ) ;

process.run() ;
```

_**Result in the output panel :**_

```
start
initialize your application
finish
```

**example with inheritance**

In the **system.process.Initializer** class the **initialize** method is defines in the **prototype** of the class. If you extends your class you can defines a public method without use the **override** keyword.

```
package examples.process
{
    import system.process.Initializer;
    
    public class Init extends Initializer
    {
        public function Init()
        {
            super();
        }
        
        public function initialize():void
        {
            trace( "initialize your application now" ) ;
        };
    }
}
```

Now we can use basically the custom initializer object :

```
import examples.process.Init;

import system.process.Action;
   
import flash.display.Sprite;

function finish( action:Action ):void 
{
    trace( "finish" ) ;
}

function start( action:Action ):void 
{
    trace( "start" ) ;
}
   
var process:Init = new Init() ;
            
process.startIt.connect( start ) ;
process.finishIt.connect( finish ) ;

process.run() ;
```

_**Result in the output panel :**_

```
start
initialize your application now
finish
```

### The system.process.EventDispatcherTask class ###

This task is a wrapper to encapsulate a specific **flash.events.EventDispatcher** object and dispatch an event with it when the process is executed.

**usage**

```
new EventDispatcherTask( dispatcher:EventDispatcher = null , event:* = null , verbose:Boolean = false )
```

**Note :** The verbose argument is optional and allow the logging messages when the task without a valid EventDispatcher reference or a valid Event reference.

**example**

```
package examples
{
    import system.process.Action;
    import system.process.EventDispatcherTask;
    
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    
    public class EventDispatcherTaskExample extends Sprite
    {
        public function EventDispatcherTaskExample()
        {
            var dispatcher:EventDispatcher = new EventDispatcher() ;
            var event:Event                = new Event("action") ;
            
            ///////
            
            dispatcher.addEventListener( "action" , debug ) ;
            
            ///////
            
            var process:EventDispatcherTask = new EventDispatcherTask(dispatcher,event);
                        
            process.finishIt.connect( finish ) ;
            process.startIt.connect( start ) ;
            
            process.run() ;
        }
        
        public function debug( e:Event ):void
        {
            trace( e.type ) ;
        }
        
        public function finish( action:Action ):void
        {
            trace( "finish" ) ;
        }
        
        public function start( action:Action ):void
        {
            trace( "start" ) ;
        }
    }
}
```

### The system.process.CoreAction class ###

This abstract class extends the **system.process.Task** class and defines new signals to enhance the basic functionality of the **system.process.Action** interface and create new custom class more flexible.

We can enumerate all the signals define in this class : _changeIt, clearIt, infoIt, loopIt, pauseIt, progressIt, resumeIt, stopIt, timeoutIt_.

To use it we can use the specific notification methods : _notifyChanged(), notifyCleared(), notifyInfo(info), notifyLooped(), notifyPaused(), notifyProgress(), notifyResumed(), notifyStopped(), notifyTimeOut()_.

This class is use to create complex task and process in your applications like the **CountDown**, **DelayedTask**, **Pause**, **TaskGroup** classes and many others throughout the packages and libraries of the framework.

### The system.process.CountDown class ###

A countdown is a sequence of counting backward to indicate the seconds, days, or other time units remaining before an event occurs or a deadline expires.

The **CountDown** instances defines a delay in millisecond and a maximal counter value for run the count down process.

The **CountDown** class extends the **CoreAction** class and implements the **Action** interface and the **Resetable**, **Resumable**, **Serializable**, **Startable** and **Stoppable** interfaces too.

**usage**

```
new CountDown( maxCount:uint = 0 , delay:Number = 1000 )
```

**example**

```
package examples
{
    import system.process.Action;
    import system.process.CountDown;

    import flash.display.Sprite;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;

    public class CountDownExample extends Sprite
    {
        public function CountDownExample()
        {
            stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
            
            counter = new CountDown( 5 ) ;
            
            counter.changeIt.connect( change ) ;
            counter.finishIt.connect( finish ) ;
            counter.pauseIt.connect( change ) ;
            counter.resumeIt.connect( resume ) ;
            counter.startIt.connect( start  ) ;
            counter.stopIt.connect( stop  ) ;
            
            counter.run() ;
        }
        
        public var counter:CountDown ;
        
        public function change( action:Action ):void
        {
            trace( "change count:" + counter.count ) ;
        }
        
        public function finish( action:Action ):void
        {
            trace( "finish count:" + counter.count ) ;
        }
        
        public function pause( action:Action ):void
        {
            trace( "pause count:" + counter.count ) ;
        }
        
        public function resume( action:Action ):void
        {
            trace( "resume count:" + counter.count ) ;
        }
        
        public function start( action:Action ):void
        {
            trace( "start count:" + counter.count ) ;
        }
        
        public function stop( action:Action ):void
        {
            trace( "stop count:" + counter.count ) ;
        }
        
        //////////
        
        private function keyDown( e:KeyboardEvent ):void 
        {
            var code:uint = e.keyCode ;
            switch( code )
            {
                case Keyboard.UP :
                {
                    counter.stop() ;
                    break ;
                }
                case Keyboard.DOWN :
                {
                    if( counter.stopped )
                    {
                        counter.resume() ;
                    }
                    else
                    {
                        counter.start() ;
                    }
                    break ;
                }
                case Keyboard.SPACE :
                {
                    counter.reset() ;
                    break ;
                }
            }
        }
    }
}
```

### The system.process.DelayedTask class ###

This class provides a delayed task who is executed after a specific delay in milliseconds.

The **DelayedTask** class extends the **systemp.process.CoreAction** abstract class and implements too the tree interfaces **Resumable**, **Startable** and **Stoppable**.

A **DelayedTask** use composition to encapsulate a specific task (Action) and run it with a specific time interval. You can passed-in the reference of the task in the constructor of the class or with the "task" property of the **DelayedTask** instance.

**example**

Use the **DelayedTask** with a **Message** instance to notify a message with a specific delay.

```
package examples
{
    import examples.process.Message;
    
    import system.process.Action;
    import system.process.DelayedTask;
    
    import flash.display.Sprite;
    
    public class DelayedTaskExample extends Sprite
    {
        public function DelayedTaskExample()
        {
            var delayed:DelayedTask = new DelayedTask() ;
            
            delayed.finishIt.connect( finish ) ;
            delayed.startIt.connect( start  ) ;
            
            delayed.task  = new Message("test") ;
            delayed.delay = 4000 ;
            
            delayed.run() ; // The task message start in 4 second
        }
        
        public function finish( action:Action ):void
        {
            trace( "finish" ) ;
        }
        
        public function start( action:Action ):void
        {
            trace( "start" ) ;
        }
    }
}
```

### The system.process.Pause class ###

This command is used to pause the currently running process until a specific delay is not finished or until the user stop it.

**usage**

```
new Pause( duration:Number = 0 , useSeconds:Boolean = true )
```

The **useSeconds** argument defines if the duration value is in seconds or in milliseconds. By this argument default is **true**. You can change this property when you want with the getter/setter property for this purpose.

**example**

```
package examples
{
    import system.process.Action;
    import system.process.Pause;
    
    import flash.display.Sprite;
    
    public class PauseExample extends Sprite
    {
        public function PauseExample()
        {
            var pause:Pause = new Pause( 5 ) ;
            
            trace ( "pause    : " + pause ) ;
            trace ( "duration : " + pause.duration ) ;
            
            pause.startIt.connect( start ) ;
            pause.finishIt.connect( finish ) ;
            
            pause.run() ;
        }
        
        public function finish( action:Action ):void 
        {
            trace( "finish" ) ;
        }
        
        public function start( action:Action ):void 
        {
            trace( "start" ) ;
        }
    }
}
```

## The groups of tasks ##

### The system.process.TaskGroup class ###

A task-group is a collection with a finite or infinite number of actions. This class is considered abstract and will not allow these to be instantiated.

You can extend this class with your custom classes but the main objective of this class is to defines the core of the **system.process.BatchTask** and the **system.process.Chain** classes.
This class provides important properties to register Action objects and defines a complex process in your application.

#### Properties ####

**length**

Indicates the numbers of actions register in the group. This property is writable and can change the size of the group.

To clear and remove all Action registered in the task-group you can change the value of the length property in 0.

**mode**

Determinates the mode of the group. The mode can be
  * **normal** : the task-group has a normal life cycle.
  * **everlasting** : the action register in the task-group can't be auto-remove.
  * **transient** : all actions are strictly auto-remove in the task-group when are invoked.

Use the **addAction** method to auto remove the specific registered Action in the task-group in the normal mode. See the **autoRemove** argument in this method.

**stopped (readonly)**

Indicates if the process of the task-group is stopped.

**verbose**

Activate the verbose mode in the toString() method of the object.

#### Methods ####

**addAction( action:Action , priority:int = 0 , autoRemove:Boolean = false ):Boolean**

Adds a new **Action** in the task group.

You can determinates with the priority argument the level of the action in the collection. The priority is designated by a signed 32-bit integer. The higher the number, the higher the priority. All actions with priority n are processed before actions of priority n-1. If two or more actions share the same priority, they are processed in the order in which they were added. The default priority is 0.

If the **Action** implements the system.process.Priority interface the priority argument in the addAction method is ignored and the priority attribute of the **Priority** action is used to sort the task in the group.

With the **autoRemove** argument the task group can invoke a removeAction after the first finish notification of the current **Action** object.

**dispose():void**

Dispose the group and disconnect all actions but don't remove them. This feature is optional.

**getActionAt( index:uint ):Action**

Returns the action register in the task group at the specified index value or null.

**hasAction( action:Action ):Boolean**

Indicates if the specified Action is register in the task group.

**removeAction( action:Action = null ):Boolean**

Remove a specific action register in the collection and if the passed-in argument is null all actions register in the chain are removed (you can use too the length property with the 0 value).


### The system.process.BatchTask class ###

Execute a batch of tasks and notify a finish message only when all tasks are finished.

**usage**

```
new BatchTask( length:uint = 0 , fixed:Boolean = false , looping:Boolean = false , numLoop:uint = 0 , mode:String = "normal" , actions:* = null )
```

**example**

```
package examples
{
    import system.process.Action;
    import system.process.BatchTask;
    import system.process.Pause;
    
    import flash.display.Sprite;
    
    public class BatchTaskExample extends Sprite
    {
        public function BatchTaskExample()
        {
            batch = new BatchTask() ;
            
            // batch.mode = BatchTask.TRANSIENT ;
            
            batch.changeIt.connect( change ) ;
            batch.finishIt.connect( finish ) ;
            batch.progressIt.connect( progress ) ;
            batch.startIt.connect( start ) ;
            
            batch.addAction( new Pause(  2 , true ) , 0 , true ) ;
            batch.addAction( new Pause( 10 , true ) ) ;
            batch.addAction( new Pause(  1 , true ) , 0 , true ) ;
            batch.addAction( new Pause(  5 , true ) ) ;
            batch.addAction( new Pause(  7 , true ) , 0 , true ) ;
            batch.addAction( new Pause(  2 , true ) ) ;
            
            batch.run() ;
        }
        
        public var batch:BatchTask ;
        
        public function change( action:Action ):void
        {
            trace( "change current:" + batch.current ) ;
        }
        
        public function finish( action:Action ):void
        {
            trace( "finish length:" + batch.length ) ;
        }
        
        public function progress( action:Action ):void
        {
            trace( "progress current:" + batch.current ) ;
        }
        
        public function start( action:Action ):void
        {
            trace( "start" ) ;
        }
    }
}
```

_**Result in the output panel :**_

```
start
progress : [Pause duration:1s]
progress : [Pause duration:2s]
progress : [Pause duration:2s]
progress : [Pause duration:5s]
progress : [Pause duration:7s]
progress : [Pause duration:10s]
finish
```

### The system.process.Chain class ###

A chain extends the **TaskGroup** class and defines a sequence with a finite or infinite number of actions. All actions registered in the chain can be executed one by one with different strategies (loop, priority, auto remove, etc).

**usage**

```
new Chain( length:uint = 0 , fixed:Boolean = false , looping:Boolean = false , numLoop:uint = 0 , mode:String = "normal" , actions:* = null )
```

**basic example**

Use a **Chain** to run one by one a set of tasks (Pause object) and use **Signals** to dispatch the phases of the running sequence (start, progress, finish).

```
package examples
{
    import system.process.Action;
    import system.process.Chain;
    import system.process.Pause;
    
    import flash.display.Sprite;
    
    public class ChainBasicExample extends Sprite
    {
        public function ChainBasicExample()
        {
            var chain:Chain = new Chain() ;
            
            chain.finishIt.connect( finish ) ;
            chain.progressIt.connect( progress ) ;
            chain.startIt.connect( start  ) ;
            
            chain.addAction( new Pause(1) ) ;
            chain.addAction( new Pause(2) ) ;
            chain.addAction( new Pause(3) ) ;
            
            chain.run() ;
        }
        
        public function finish( action:Action ):void
        {
            trace( "finish" ) ;
        }
        
        public function progress( action:Action ):void
        {
            trace( "progress : " + (action as Chain).current ) ;
        }
        
        public function start( action:Action ):void
        {
            trace( "start" ) ;
        }
    }
}
```

#### priority example ####

All **Action** registered in a **Chain** with the **addAction** method can support a priority to sort it in the group.

```
addAction( action:Action , priority:int = 0 , autoRemove:Boolean = false ):Boolean
```

You can determinate with the priority argument the level of the action in the collection. The priority is designated by a signed 32-bit integer. The higher the number, the higher the priority. All actions with priority n are processed before actions of priority n-1. If two or more actions share the same priority, they are processed in the order in which they were added. The default priority is 0.

If the **Action** implements the **system.process.Priority** interface the priority argument in the **addAction** method is ignored and the priority attribute of the Priority action is used to sort the task in the group.

```
package examples
{
    import examples.process.PriorityTask;

    import system.process.Action;
    import system.process.Chain;
    import system.process.Pause;
    
    import flash.display.Sprite;
    
    public class ChainPriorityExample extends Sprite
    {
        public function ChainPriorityExample()
        {
            chain = new Chain() ;
            
            chain.finishIt.connect( finish ) ;
            chain.progressIt.connect( progress ) ;
            chain.startIt.connect( start ) ;
            
            // use the priority argument
            
            chain.addAction( new Pause(1) , 100 ) ;
            chain.addAction( new Pause(2) , 1   ) ;
            chain.addAction( new Pause(3) , 200 ) ;
            chain.addAction( new Pause(4) , 50  ) ;
            
            // use Priority task objects (see Note)
            
            chain.addAction( new PriorityTask( "task1" , 25  ) ) ;
            chain.addAction( new PriorityTask( "task2" , 75  ) ) ;
            chain.addAction( new PriorityTask( "task3" , 150 ) ) ;
            
            chain.run() ;
        }
        
        public var chain:Chain ;
        
        public function finish( action:Action ):void
        {
            trace( "#finish" ) ;
        }
        
        public function progress( action:Action ):void
        {
            trace( "#progress current:" + chain.current ) ;
        }
        
        public function start( action:Action ):void
        {
            trace( "#start" ) ;
        }
    }
}
```

_**Result in the output panel :**_

```
#start
#progress current:[Pause duration:3s]
#progress current:[PriorityTask name:task3 priority:150]
#progress current:[Pause duration:1s]
#progress current:[PriorityTask name:task2 priority:75]
#progress current:[Pause duration:4s]
#progress current:[PriorityTask name:task1 priority:25]
#progress current:[Pause duration:2s]
#finish
```

**Note :** The basic **PriorityTask** class in the previous example implements the system.process.Priority interface and is used only to illustrate the priority behaviour of the addAction method with a passed-in Priority action object.

```
package examples.process
{
    import system.process.Task;
    import system.process.Priority;
    
    public class PriorityTask extends Task implements Priority
    {
        public function PriorityTask( name:String , priority:int )
        {
            this.name = name ;
            _priority = priority ;
        }
        
        public var name:String ;
        
        public function get priority():int
        {
            return _priority;
        }
        
        public function set priority(value:int):void
        {
            _priority = value ;
        }
        
        public override function run( ...arguments:Array ):void 
        {
            notifyStarted() ;
            // do something here
            notifyFinished() ;
        }
        
        public override function toString():String
        {
            return "[PriorityTask name:" + name + " priority:" + priority + "]" ;
        }
        
        private var _priority:int ;
    }
}
```

#### looping example ####

```
package examples
{
    import system.process.Action;
    import system.process.Chain;
    import system.process.Pause;
    
    import flash.display.Sprite;
    
    public class ChainLoopExample extends Sprite
    {
        public function ChainLoopExample()
        {
            chain = new Chain() ;
            
            chain.looping = true ;
            chain.numLoop = 3 ;
            
            chain.finishIt.connect( finishg ) ;
            chain.loopIt.connect( loop ) ; 
            chain.progressIt.connect( progress ) ;
            chain.startIt.connect( start ) ;
            
            chain.addAction( new Pause(1) ) ;
            chain.addAction( new Pause(1) ) ;
            chain.addAction( new Pause(1) ) ;
            
            trace( "current:" + chain.currentLoop + " num:" + chain.numLoop ) ;
            
            chain.run() ;
        }
        
        public var chain:Chain ;
        
        public function finish( action:Action ):void
        {
            trace( "#finish" ) ;
        }
        
        public function loop( action:Action ):void
        {
            trace("#loop current:"+chain.currentLoop+" num:"+chain.numLoop) ;
        }
        
        public function progress( action:Action ):void
        {
            trace( "#progress" ) ;
        }
        
        public function start( action:Action ):void
        {
            trace( "#start" ) ;
        }
    }
}
```

#### auto-remove example ####

Use the **autoRemove** argument in the **addAction** method to remove the current task in the internal collection of the chain when it'is running the first time in the chain process.

```
package examples
{
    import examples.process.Message;
    
    import system.events.ActionEvent;
    import system.process.Chain;
    
    import flash.display.Sprite;
    
    public class ChainAutoRemoveExample extends Sprite
    {
        public function ChainAutoRemoveExample()
        {
            chain = new Chain() ;
            
            chain.addEventListener( ActionEvent.FINISH   , debug    ) ;
            chain.addEventListener( ActionEvent.PROGRESS , progress ) ;
            chain.addEventListener( ActionEvent.START    , debug    ) ;
            
            chain.addAction( new Message("1") , 0 , false ) ;
            chain.addAction( new Message("2") , 0 , true  ) ;
            chain.addAction( new Message("3") , 0 , false ) ;
            chain.addAction( new Message("4") , 0 , true  ) ;
            
            chain.looping = true ;
            chain.numLoop = 2 ;
            
            chain.run() ;
        }
        
        public var chain:Chain ;
        
        public function debug( e:ActionEvent ):void
        {
            trace( "# " + e.type ) ;
        }
        
        public function progress( e:ActionEvent ):void
        {
            trace( "# " + e.type + " current:" + chain.current ) ;
        }
    }
}
```

#### mode example ####

Defines in the **TaskGroup** superclass of the **Chain** class, the mode attribute defines the "normal", "transient" or "everlasting" behavior of the chain.

The mode can be
  * **normal** : the task-group has a normal life cycle.
  * **everlasting** : the action register in the task-group can't be auto-remove.
  * **transient** : all actions are strictly auto-remove in the task-group when are invoked.

```
package examples
{
    import examples.process.Message;
    
    import system.process.Action;
    import system.process.Chain;
    
    import flash.display.Sprite;
    
    public class ChainModeExample extends Sprite
    {
        public function ChainModeExample()
        {
            chain = new Chain() ;
            
            chain.finishIt.connect( finish ) ;
            chain.loopIt.connect( loop ) ; 
            chain.progressIt.connect( progress ) ;
            chain.startIt.connect( start ) ;
            
            chain.addAction( new Message("1") , 0 , false ) ;
            chain.addAction( new Message("2") , 0 , true  ) ;
            chain.addAction( new Message("3") , 0 , false ) ;
            chain.addAction( new Message("4") , 0 , true  ) ;
            
            chain.looping = true ;
            chain.numLoop = 1 ;
            
            trace("------ everlasting") ;
            
            chain.mode = Chain.EVERLASTING ;
            
            chain.run() ;
            
            trace("------ normal") ;
            
            chain.mode = Chain.NORMAL ;
            
            chain.run() ;
            
            trace("------ transient") ;
            
            chain.mode = Chain.TRANSIENT ;
            
            chain.run() ;
        }
        
        public var chain:Chain ;
        
        protected function finish( action:Action ):void
        {
            trace( "#finish" ) ;
        }
        
        protected function loop( action:Action ):void
        {
            trace( "#loop" ) ;
        }
        
        protected function progress( action:Action ):void
        {
            trace( "#progress current:" + chain.current ) ;
        }
        
        protected function start( action:Action ):void
        {
            trace( "#start" ) ;
        }
    }
}
```

## The loader tasks ##

### The CoreActionLoader abstract class ###

The main abstract class to create process who load external resources.

This core class not must be instantiated but help to create super-classes who encapsulate the **AS3** loader classes : **flash.display.Loader**, **flash.net.URLLoader** and **flash.net.URLStream**.

### The ActionLoader class ###

This wrapper encapsulate a **flash.display.Loader** instance.

```
package examples
{
    import system.process.Action;
    import system.process.ActionLoader;
    
    import flash.display.Loader;
    import flash.display.Sprite;
    import flash.net.URLRequest;
    
    public class ActionLoaderExample extends Sprite
    {
        public function ActionLoaderExample()
        {
            var url:String    = "library/picture.png" ;
            var loader:Loader = new Loader() ;
            
            loader.x = 50 ;
            loader.y = 50 ;
            
            addChild(loader) ;
            
            var process:ActionLoader = new ActionLoader( loader ) ;
            
            process.finishIt.connect( finish ) ;
            process.startIt.connect( start ) ; 
            
            process.init.connect( init ) ; 
            
            process.request = new URLRequest( url ) ;
            
            process.run() ;
        }
        
        public function finish( action:Action ):void 
        {
            trace( "finish" ) ;
        }
        
        public function init( action:Action ):void 
        {
            trace( "init" ) ;
        }
        
        public function start( action:Action ):void 
        {
            trace( "start" ) ;
        }
    }
}
```

### The ActionURLLoader class ###

This wrapper encapsulate a **flash.net.URLLoader** instance.

```
package examples
{
    import core.dump ;
    
    import system.process.Action;
    import system.process.ActionURLLoader;
    
    import flash.display.Sprite;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    
    public class ActionURLLoaderExample extends Sprite
    {
        public function ActionURLLoaderExample()
        {
            var url:String = "datas/config.eden" ;
            
            var loader:URLLoader = new URLLoader() ;
            
            process = new ActionURLLoader( loader ) ;
            
            process.finishIt.connect( finish ) ;
            process.startIt.connect( start ) ; 
            
            process.request = new URLRequest( url ) ;
            process.run() ;
        }
        
        public var process:ActionURLLoader ;
        
        public function finish( action:Action ):void 
        {
            trace( "finish : " + dump( process.data ) ) ;
        }
        
        public function start( action:Action ):void 
        {
            trace( "start" ) ;
        }
    }
}
```

### The ActionURLStream class ###

This wrapper encapsulate a **flash.net.URLStream** instance.

```
package examples
{
    import system.process.Action;
    import system.process.ActionURLStream;

    import flash.display.Sprite;
    import flash.net.URLRequest;
    import flash.net.URLStream;
    
    public class ActionURLStreamExample extends Sprite
    {
        public function ActionURLStreamExample()
        {
            var url:String = "datas/config.eden" ;
            
            var loader:URLStream = new URLStream() ;
            
            var process:ActionURLStream = new ActionURLStream(loader) ;
            
            process.finishIt.connect( finish ) ;
            process.startIt.connect( start ) ; 
            
            process.request = new URLRequest( url ) ;
            process.run() ;
        }
        
        public function finish( action:Action ):void 
        {
            trace( "finish" ) ;
        }
        
        public function start( action:Action ):void 
        {
            trace( "start" ) ;
        }
    }
}
```