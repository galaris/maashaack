# Signalers & Receivers #

<a href='http://creativecommons.org/licenses/by-sa/3.0/'><img src='http://i.creativecommons.org/l/by-sa/2.0/uk/88x31.png' alt='Licence Creative Commons' /></a> author : Marc ALCARAZ ([ekameleon](https://code.google.com/u/109962507657971592081/))



## Generality ##

The "**signal engine**" implemented in the package [system.signals](system_signals.md) is a very easy **ActionScript 3** messaging tools.

With the **Signaler** interface we can define objects who communicates by signals and can be use to create a light-weight implementation of the Observer pattern. A signal emit simple values with its own array of receivers (slots). This values can be strongly-typed with an internal checking process.

Receivers can be defined with a simple function reference or a custom object which implements the interface `system.signals.Receiver`.

Receivers subscribe to real objects, not to string-based channels. Event string constants are no longer needed like **W3C DOM 2/3 event model**.

## Interfaces ##

The `system.signals` package contains two interfaces : **Signaler** and **Receiver**.

The `Signaler` interface is simple but contains all important methods to deploy your signals.

```
    package system.signals
    {
        public interface Signaler
        {
            /**
             * Indicates the number of objects connected.
             */
            function get numReceivers():uint ;
            
            /**
             * Connects a Function reference or a Receiver object.
             * @param receiver The receiver to connect : a Function reference or a Receiver object.
             * @param priority Determinates the priority level of the receiver.
             * @param autoDisconnect Apply a disconnect after the first trigger
             * @return true If the receiver is connected with the signal emitter.
             */
            function connect( receiver:* , priority:uint = 0 , autoDisconnect:Boolean = false ):Boolean ;
            
            /**
             * Returns true if one or more receivers are connected.
             * @return true if one or more receivers are connected.
             */
            function connected():Boolean ;
            
            /**
             * Disconnect the specified object or all objects if the parameter is null.
             * @return true if the specified receiver exist and can be unregister.
             */
            function disconnect( receiver:* = null ):Boolean ;
            
            /**
             * Emit the specified values to the receivers.
             * @param ...values All values to emit to the receivers.
             */
            function emit( ...values:Array ):void ;
            
            /**
             * Returns true if specified receiver is connected.
             * @return true if specified receiver is connected.
             */
            function hasReceiver( receiver:* ):Boolean ;
        }
    }
```

The **Receiver** interface is optional and can be used to defines a basic slot connected with Signaler objects using the connect() method<br />
(note: only the receive method is connected with the signal, not the Receiver reference).

```
    package system.signals
    {
        /**
         * The Receiver defines a simple method for receiving values from Signaler objects.
         */
        public interface Receiver
        {
            /**
             * This method is called when the receiver is connected with a Signal object.
             * @param ...values All the values emitting by the signals connected with this object.
             */
            function receive( ...values:Array ):void ;
        }
    }
```

### Hello World ###

We begin with a first basic example. In this example we use the system.signals.Signal, this class is a basic but full implementation of the Signaler interface. This script can be compiled as an application with mxmlc or as a document class in Flash Professional or all ActionScript IDE (FDT, etc.)

```
    package examples
    {
        import system.signals.Signal;

        import flash.display.Sprite;
        
        [SWF(width="740", height="480", frameRate="24", backgroundColor="#666666")]
       
        public class SignalExample extends Sprite
        {
            public function SignalExample ()
            {
                var signal:Signal = new Signal() ;
                
                signal.connect( write ) ;
                
                signal.emit( "hello world" ) ; // hello world
                signal.emit( "thank you" ) ; // thank you
            }
            
            public function write( message:String ):void
            {
                trace( message ) ;
            }
        }
    }
```

## Features ##

Signals have many features.

### Restrict the types and the number of arguments passed-in the emit method. ###

A signal can be initialized with specific value classes that will validate value objects on dispatch (optional).

The **'types'** property is an optional **read-write** **Array** attribute who can register **Class** references to defines a validation when the signal emit. If this property is **null** the signal not check the emit parameters.

```
var signal:Signal = new Signal([ String , Number , uint ] ) ;

trace( "restricted types : " + signal.types ) ;
```

If the **'types'** property is **null** the signal not check the types and the number of the passed-in arguments when the emit method is invoked.

Basic example to restrict the emit method with 3 arguments with the types **String** , **Number** and **uint**.

```
    import system.signals.Signal ;

    var slot:Function = function( ...values:Array ):void
    {
        trace("receive : " + values ) ;
    }

    var signal:Signal ;

    signal = new Signal() ;

    signal.types = [ String , Number , uint ] ;

    signal.connect( slot ) ;

    signal.emit( "hello" , 2.5, 4 ) ; // slot : hello,2.5,4

    try
    {
        signal.emit( "hello" , 2.5 , 4.5 ) ;
    }
    catch( e:Error )
    {
        trace( e.message ) ;
        // The parameter with the index 2 in the emit method isn't valid,
        // must be an instance of the [class uint] class but is an instance of the Number class.
    }

    try
    {
        signal.emit( "hello" ) ;
    }
    catch( e:Error )
    {
        trace( e.message ) ;
        // The number of arguments in the emit method is not valid,
        // must be invoked with 3 argument(s) and you call it with 1 argument(s).
    }

    try
    {
        signal.emit() ;
    }
    catch( e:Error )
    {
        trace( e.message ) ;
        // The number of arguments in the emit method is not valid,
        // must be invoked with 3 argument(s) and you call it with 0 argument(s).
    }
```

### Disconnect a specific receiver or all receivers ###

You can disconnect the receivers registered in a **Signaler** object with the method **disconnect()**. This method can target a specific receiver (**function** reference or **Receiver** instance) but you can disconnect all registered receivers if you don't passed-in value.

**Example :**

```
    import system.signals.Signal ;

    var signal:Signal = new Signal() ;

    signal.connect( slot1 ) ;
    signal.connect( slot2 ) ;
    signal.connect( slot3 ) ;

    trace( signal.numReceivers ) ; // 3

    signal.disconnect( slot2 ) ;

    trace( signal.numReceivers ) ; // 2

    signal.disconnect() ; // disconnect all

    trace( signal.numReceivers ) ; // 2
```

Note :

  * You can retrieve the number of receivers with the **read-only** attribute : **signal.numReceivers**
  * You can retrieve if the signal contains one or more receivers with the method : **signal.connected():Boolean**
  * You can retrieve if a specific receiver is connected with the method : **signal.hasReceiver( receiver:** ):Boolean

### Auto disconnect feature ###

**Receivers** can be added for a one-time call and removed automatically on dispatch

```
    import system.signals.Signal ;

    var receiver:Function = function( message:String ):void
    {
        trace( message ) ;
    }

    var signal:Signal = new Signal() ;

    signal.connect( receiver , 0 , true ) ;

    signal.emit( "hello world" ) ; // hello world
    signal.emit( "bonjour monde" ) ;
```

Only the first message is dispatched, the **reveiver** is automatically disconnected and can't receive the next messages.

### Receiver priority ###

When you connect a receiver with the connect method you can apply a priority over your reference.

The priority is designated by an **uint** value( an integer > 0 ). The higher the number, the higher the priority. All receivers with priority n are processed before receivers of priority n-1. If two or more receivers share the same priority, they are processed in the order in which they were added. The default priority is **0**.

```
    import system.signals.Signal ;

    var slot1:Function = function( message:String ):void
    {
        trace( "slot1: " + message ) ;
    }

    var slot2:Function = function( message:String ):void
    {
        trace( "slot2: " + message ) ;
    }

    var slot3:Function = function( message:String ):void
    {
        trace( "slot3: " + message ) ;
    }

    var signal:Signal = new Signal() ;

    signal.connect( slot1 ,  10 ) ;
    signal.connect( slot2 , 999 ) ;
    signal.connect( slot3 , 400 ) ;

    signal.emit( "hello world" ) ;

    // slot2: hello world
    // slot3: hello world
    // slot1: hello world
```

## Use composition with the system.signals.Signaler interface ##

```
    package examples.signals
    {
        import system.signals.Signal;
        import system.signals.Signaler;
        
        import flash.display.Sprite;
        import flash.events.MouseEvent;

        public class SignalButton extends Sprite implements Signaler
        {
            public function SignalButton( width:Number = 160 , height:Number = 20 , color:Number = 0xA2A2A2 ):void
            {
                _signal = new Signal( [ String , SignalButton ] ) ;
                addEventListener( MouseEvent.CLICK , _click ) ;
                graphics.beginFill( color ) ;
                graphics.drawRect( 0 , 0 , width , height ) ;
                buttonMode    = true ;
                mouseEnabled  = true ;
                useHandCursor = true ;
            }

            public function get numReceivers():uint ;
            {
                return _signal.numReceivers ;
            }

            public function connect( receiver:* , priority:uint = 0 , autoDisconnect:Boolean = false ):Boolean
            {
                return _signal.connect( receiver , priority , autoDisconnect ) ;
            }
            
            public function connected():Boolean
            {
                return _signal.connected() ;
            }
            
            public function disconnect( receiver:* = null ):Boolean
            {
                return _signal.disconnect( receiver ) ;
            }
            
            public function emit( ...values:Array ):void
            {
                _signal.emit.apply( values ) ;
            }
           
            public function hasReceiver( receiver:* ):Boolean
            {
                return _signal.hasReceiver( receiver )
            }
               
            private var _signal:Signal ;
               

            private function _click( e:MouseEvent ):void
            {
                _signal.emit( "click" , this ) ;
            }
        }
    }
```

Now we can write a little example to use the previous class :

```
    package examples
    {
        import examples.signals.SignalButton;
        
        import flash.display.Sprite;
        
        [SWF(width="760", height="480", frameRate="24", backgroundColor="#666666")]
        
        public class SignalButtonExample extends Sprite
        {
            public function SignalButtonExample()
            {
                var button:SignalButton = new SignalButton( 200 , 24 , 0xCCCCCC ) ;
                
                button.x = 25 ;
                button.y = 24 ;
                
                button.connect( notify ) ;
                
                addChild( button ) ;
            }
                 
            public function notify( type:String , target:SignalButton ):void
            {
                trace( "notify : " + type + " in " + target ) ;
            }
        }
    }
```

## Basic example to use the system.signals.Receiver interface ##

First we defines a little class **Messenger** who format a specific receiving message with a name and a string pattern.

```
    package examples.signals
    {
        import system.Strings;
        import system.console;
        import system.signals.Receiver;
        
        public class Messenger implements Receiver
        {
            public function Messenger( pattern:String = "{0}:{1}" ):void
            {
                this.pattern = pattern ;
            }
            
            public var pattern:String ;
            
            public function receive( ...values:Array ):void
            {
                var name:String    = values[0] as String ;
                var message:String = values[1] as String ;
                console.writeLine( Strings.format( pattern , name , message ) ) ;
            }
        }
    }
```

Now the document class to compile the basic example.

```
package examples
{
    import examples.signals.Messenger;
    
    import system.console;
    import system.diagnostics.TextFieldConsole;
    import system.signals.Signal;
    
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.text.TextField;
    import flash.text.TextFormat;
    
    [SWF(width="760", height="480", frameRate="24", backgroundColor="#666666")]
    
    public class MessengerExample extends Sprite
    {
        public function MessengerExample()
        {
            // stage
            
            stage.align     = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;
            
            stage.addEventListener( Event.RESIZE , resize ) ;
            
            // console
            
            textfield                   = new TextField() ;
            textfield.defaultTextFormat = new TextFormat( "Courier New" , 14 , 0xFFFFFF ) ;
            textfield.multiline         = true ;
            textfield.selectable        = true ;
            textfield.wordWrap          = true ;
            
            addChild( textfield ) ;
            
            resize() ;
            
            console = new TextFieldConsole( textfield ) ;
            
            // receiver
            
            var messenger:Messenger = new Messenger( "{0} say: {1}" )  ;
            
            // signaler
                 
            signal = new Signal([String,String]) ;
            
            signal.connect( messenger ) ;
            
            signal.emit( "john" , "hello world" ) ;
            signal.emit( "jack" , "Hi !" ) ;
            signal.emit( "jack" , "signals are fast" ) ;
        }
        
        public var signal:Signal ;
        
        public var textfield:TextField ;
            
        public function resize( e:Event = null ):void
        {
            if ( stage && textfield )
            {
                textfield.width  = stage.stageWidth ;
                textfield.height = stage.stageHeight ;
            }
        }
    }
}
```