# AMF and remoting services #

<a href='http://creativecommons.org/licenses/by-sa/3.0/'><img src='http://i.creativecommons.org/l/by-sa/2.0/uk/88x31.png' alt='Licence Creative Commons' /></a> author : Marc ALCARAZ ([ekameleon](https://code.google.com/u/109962507657971592081/))



Defines in the [system.remoting package](http://code.google.com/p/maashaack/source/browse/#svn%2Fpackages%2Fsystem_remoting%2Ftrunk) you can find all tools to exchange data with the **AMF** protocol between your **ActionScript** clients and multi-platform servers.

[![](http://maashaack.googlecode.com/svn/gfx/framework/packages/system.remoting.png)](http://code.google.com/p/maashaack/source/browse/#svn%2Fpackages%2Fsystem_remoting%2Ftrunk)

## Generality ##

Action Message Format (**AMF**) is a compact binary format that is used to serialize **ActionScript** objects. It is used primarily to exchange data between an **Adobe Flash** application and a remote service, usually over the Internet.

The **AMF** protocol is used for example to exchange datas with **Flash Remoting** or **Flash Media Interactive Server**.

Once serialized an **AMF** encoded object graph may be used to persist and retrieve the public state of an application across sessions or allow two endpoints to communicate through the exchange of strongly typed data.

**AMF** was introduced in Flash Player 6 in 2001 and this version is referred to as AMF 0.

It was unchanged until the release of **Flash Player 9** and **ActionScript 3.0**, when new data types and language features prompted an update, called **AMF 3**.

Adobe published the **AMF** binary data protocol specification on December 13, 2007 and announced that it will support the developer community to make this protocol available for every major server platform.

You can find all specifications of the **AMF** protocol and other open specifications in the publications page of the **openscreen project** with the SWF, FLV/F4V, etc. :

  * http://www.openscreenproject.org/about/publications.html


In this article i use the AMF protocol to exchange binary datas between a Flash application and PHP web services write with the opensource library [AMFPHP](http://amfphp.sourceforge.net/) 1.9.

We can use [JAVA](http://sourceforge.net/projects/openamf/), [.NET](http://www.fluorinefx.com/), [Python](http://www.pyamf.org/index.html) or other server side technologies with an **AMF** serializer/deserializer.

In **AMFPHP** we can exchange strongly typed custom datas with class mapping process.

## Basic exchange between AS3 application and AMFPHP ##

To illustrate the basic data exchange with the **AMF** protocol between an **AS3** client and **AMFPHP** it's easy to create a little example.

I deploy this example in a local **PHP** server with [MAMP](http://www.mamp.info/en/index.html) on **Mac OSX** but you can use [WAMP](http://www.wampserver.com/) Server or other **apache/php/mysql** server solutions.

First i install in a local folder in the htdocs (or www) directory your php project with all sources of the **AMFPHP** library.

In this example i create a new **remoting/** directory in the root of the local server and i deploy the [amfphp library](http://sourceforge.net/projects/amfphp/files/#files) sources in the **remoting/amfphp/** folder.

Now we can write our first service in the **remoting/amfphp/services** directory with the PHP file **HelloWorld.php** :

```
<?php

class HelloWorld 
{
    public function __construct() 
    {
        //
    }
    
    public function hello( $who = "" ) 
    {
        if ( $who == "" )
        {
            trigger_error("The argument not must be empty.") ;
        }
        return "hello " . $who . " !" ;
    }
}

?>
```

The **HelloWorld** class defines the basic **amfphp** service class, we can use it to return a custom **"hello world"** message in a Flash application.

The [trigger\_error](http://php.net/manual/en/function.trigger-error.php) command is a **PHP** function who handling in the service the errors and can kill the current method before notify the flash client application with a specific message.

In the example the **$who** argument can't be an empty string.

We can test this service without a Flash application with the internal browser of **AMFPHP** in the navigator :

  * http://localhost:8888/remoting/amfphp/browser/

**Note :** In **MAMP** on **Mac OSX** the default localhost use the port **8888**, customize this **uri** with your main **localhost** url.

In **AS3** to connect an **AMF** service with the client application we must use the two classes : [flash.net.NetConnection](http://help.adobe.com/fr_FR/FlashPlatform/reference/actionscript/3/flash/net/NetConnection.html) and [flash.net.Responder](http://help.adobe.com/fr_FR/AS3LCR/Flash_10.0/flash/net/Responder.html).

We can create a little **AS3 main class** to test this service :

```
package remoting
{
    import core.dump;
    
    import flash.display.Sprite;
    
    import flash.events.Event;

    import flash.events.NetStatusEvent;

    import flash.net.NetConnection;
    import flash.net.Responder;
   
    public class RemotingExample extends Sprite
    {
        public function RemotingExample()
        {
            var connection:NetConnection = new NetConnection() ;
            
            connection.addEventListener(NetStatusEvent.NET_STATUS, status) ;
            
            connection.connect( gatewayUrl ) ;
            
            var responder:Responder = new Responder( result , fault ) ;
            
            connection.call( "HelloWorld.hello", responder, "John" ) ;
        }

        protected var gatewayUrl:String =
        "http://localhost:8888/remoting/amfphp/gateway.php" ;
        
        protected function result( result:Object ):void
        {
            trace("> result : " + result) ;
        }
        
        protected function fault( fault:Object ):void
        {
            trace("> fault : " + dump( fault ) ) ;
        }
        
        protected function status( e:NetStatusEvent ):void
        {
            trace("> status : " + dump( e.info ) ) ;
        }
    }
}
```

This example connect the Flash application with the **gateway** of the **amfphp** services with the **NetConnection.connect()** method.

```
import flash.net.NetConnection ;

var connection:NetConnection = new NetConnection() ;

connection.connect( gatewayUrl ) ;
```

The gatewayUrl variable target the gateway.php file in the local server :

```
"http://localhost:8888/remoting/amfphp/gateway.php"
```

We can handling the net status events of the **flash.net.NetConnection** class to notify a server side connection problem. We add the status method to handle all net status messages.

```
connection.addEventListener(NetStatusEvent.NET_STATUS, status) ;
```

We use a responder (**flash.net.Responder**) object to create a proxy and target a result or fault method when a method is calling server side :

```
var responder:Responder = new Responder( result , fault ) ;

connection.call( "HelloWorld.hello" , responder, "John" ) ;
```

The first argument in the call method indicates the name of the service and the name of this method to invoke.

The second argument is the responder object and all the last arguments are the passed-in arguments in the service method.

**Note :** The **core.dump** function use in the status and fault is a basic singleton method to dump an object.

You can test this application with the default "**John**" argument value in the **call** method to test the **result** method, or an **empty** or **null** String to test the **fault** method.

You can test in the error method the errors of connection with a bad gateway url for example to test the **status** method.

## Class mapping with AMF data exchange ##

In **ActionScript 3** the **flash.net.registerClassAlias** function preserves the class (type) of an object when the object is encoded in Action Message Format (**AMF**).

When you encode an object into **AMF**, this function saves the alias for its class, so that you can recover the class when decoding the object.

If the encoding context did not register an alias for an object's class, the object is encoded as an anonymous object.

Similarly, if the decoding context does not have the same alias registered, an anonymous object is created for the decoded data.

**LocalConnection**, **ByteArray**, **SharedObject**, **NetConnection** and **NetStream** are all examples of classes that encode objects in **AMF**.

The encoding and decoding contexts do not need to use the same class for an alias; they can intentionally change classes, provided that the destination class contains all of the members that the source class serializes.

With **AMFPHP** it's possible to use class mapping and keep strongly typed objects.

A **Value Object** (previously known as **Transfer Object**) is a serializable class that groups related attributes, forming a composite value.

This class is used as the return type of a remote business method. Clients receive instances of this class by calling coarse-grained business methods, and then locally access the fine-grained values within the transfer object. Fetching multiple values in one server roundtrip decreases network traffic and minimizes latency and server resource usage.

We can create a little example of **AMF** exchange with **class-mapping** and **Value Object**.

First we write a little **Value Object** class in **AS3** :

```
package remoting.vo
{
    public class User
    {
        public function User( name:String="" , age:uint=0 , url:String="" )
        {
            this.name = name ;
            this.age  = age ;
            this.url  = url ;
        }
        
        public var age:uint ;
        
        public var name:String ;
        
        public var url:String ;
        
        public function toString():String
        {
            return "[User name:" + name + 
                   " age:" + this.age + 
                   " url:" + this.url + "]"  ;    
        }
    }
}
```

We can create the same **Value Object** server side with the class **remoting/amfphp/services/vo/User.php** :

```
<?php
class User
{
    function __construct( $name="", $age=0 , $url="" )
    {
        $this->name = $name ;
        $this->age  = $age  ;
        $this->url  = $url  ;
    }
    
    public $age ;
    public $name ;
    public $url ;
    
    /**
     * The AMFPHP private property to register the object.
     */
    public $_explicitType = "User" ;
}
?>
```

**Important :** In **AMFPHP** to enable the **class-mapping** encoding we must defines in the **Value Object** class the property _$**explicitType**._

The **String** value of the _$**explicitType** property must be the same in the **AS3** source code to register the **ActionScript** **User** class with the alias **"User"**._

```
import flash.net.registerClassAlias ;
import remoting.vo.User ;

registerClassAlias( "User" , User ) ;
```

You can change this alias and choose your custom alias name.

Now we can create a little **AMFPHP** service **remoting/amfphp/services/ClassMapping.php** to test the **class-mapping** of the User value object class.

```
<?php
require("./vo/User.php") ;

class ClassMapping 
{
    public function __construct() 
    {
        //
    }
    
    public function getUser( $name="" , $age=0 , $url="" )
    {
        return new User( $name , $age , $url ) ;
    }
}
?>
```

**Note :** The **require()** method use relative path of the **ClassMapping** class to target the dependencies.

To finalize this little example we write an AS3 main class :

```
package remoting
{
    import remoting.vo.User;
    
    import flash.display.Sprite;
    import flash.net.NetConnection;
    import flash.net.Responder;
    import flash.net.registerClassAlias;
    
    public class RemotingExample extends Sprite
    {
        public function RemotingExample()
        {
            registerClassAlias( "User" , User ) ;
            
            var connection:NetConnection = new NetConnection() ;
            
            connection.connect( gatewayUrl ) ;
            
            var responder:Responder = new Responder( result , fault ) ;
            
            connection.call
            ( 
                "ClassMapping.getUser" , responder, 
                "eka" , 33 , "http://www.ekameleon.net"
            );
        }
        
        protected var gatewayUrl:String = 
        "http://localhost:8888/remoting/amfphp/gateway.php" ;
        
        protected function fault( fault:Object ):void
        {
            trace( "fault : " + fault.description ) ;
        }
        
        protected function result( result:Object ):void
        {
            trace( "result : " + result ) ;
        }
    }
}
```

The output panel of the flashplayer debugger return :

```
result : [User name:eka age:33 url:http://www.ekameleon.net]
```

**Note** : Don't forget to register the **remoting.vo.User** class with the registerClassAlias method to receive a User instance and not a generic object.
AMF service class with the **system.remoting** package

## The RemotingService class ##

The **system.remoting.RemotingService** class is a helper to connect your application with a specific **AMF** service.

This class use composition and a little internal factory to locate singleton reference of the **NetConnection** class defines for all single **gateway uri**.

You can create a single service to connect it with a single AMF gateway with a simple instance of the **RemotingService** class.

```
import system.remoting.RemotingService ;

var gatewayUrl:String = "http://localhost:8888/remoting/amfphp/gateway.php" ;

var service:RemotingService = new RemotingService( gatewayUrl ) ;
```

You can defines the name of the service and the name of the method to invoke server side :

```
service.serviceName = "HelloWorld"  ;
service.methodName  = "hello" ;
```

To trigger the server side data exchange you can use the **run()** method (**system.process.Runnable**) :

```
service.run() ;
```

You can sending arguments to the server side method in the run method :

```
service.run( "arg1", "arg2" ) ;
```

Or you can use the params (**Array**) attribute to register all the arguments but not execute the trigger command immediatly :

```
service.params = [ "arg1", "arg2" ] ;
service.run() ;
```

## Signals notification ##

The **RemotingService** class use **[signals](Signals.md)** to notify the asynchronous client/server datas exchange :

  * **result** : receive the result object if the trigger is success.
  * **fault** : receive a fault message from the server.
  * **error** : receive an error message from the server (bad version, bad connection, etc).

The **[signals](Signals.md)** are more flexible. Replace the two basic callback methods registered in the **flash.net.Responder** reference to receive the asynchronous server side response.

```
package examples 
{
    import core.dump;
    
    import system.remoting.RemotingService;
    
    import flash.display.Sprite;
    
    public class RemotingExample extends Sprite 
    {
        public function RemotingExample()
        {
            var service:RemotingService = new RemotingService() ;
            
            service.error.connect( error  ) ;
            service.fault.connect( fault  ) ;
            service.result.connect( result ) ;
            
            service.gatewayUrl  = gatewayUrl ;
            service.serviceName = "HelloWorld"  ;
            service.methodName  = "hello" ;
            
            service.run( "world" ) ;
        }
        
        public var gatewayUrl:String = 
        "http://localhost:8888/remoting/amfphp/gateway.php" ;
        
        //////////////// slots
        
        protected function error( error:* , service:RemotingService ):void
        {
            trace( "error:" + dump(error) ) ;
        }
        
        protected function fault( fault:* , service:RemotingService ):void
        {
            trace( "fault:" + dump(fault) ) ;
        }
        
        protected function result( result:* , service:RemotingService ):void
        {
             trace( "result : " + result ) ;
        }
       
        ////////////////
    }
}
```

## Service like a command and task ##

The **RemotingService** class extends the **system.process.Task** class and implements the **system.process.Runnable** and **system.process.Action** interfaces.

All remoting service can be added in a chain or batch process (See more informations about the [command and task engine](CommandAndTask.md) in this wiki)

```
package examples 
{
    import system.remoting.RemotingService;
    
    import flash.display.Sprite;
    
    public class RemotingExample extends Sprite 
    {
        public function RemotingExample()
        {
            var service:RemotingService = new RemotingService() ;
            
            service.finishIt.connect( finish ) ;
            service.progressIt.connect( progress ) ;
            service.startIt.connect( start ) ;
            service.timeoutIt.connect( timeout ) ;
            
            service.gatewayUrl  = gatewayUrl ;
            service.serviceName = "HelloWorld"  ;
            service.methodName  = "hello" ;
            
            service.run( "world" ) ;
        }
        
        public var gatewayUrl:String = 
        "http://localhost:8888/remoting/amfphp/gateway.php" ;
        
        //////////////// slots
        
        protected function finish( service:RemotingService ):void
        {
            trace( "#finish" ) ;
        }
        
        protected function progress( service:RemotingService ):void
        {
            trace( "#progress" ) ;
        }
        
        protected function start( service:RemotingService ):void
        {
            trace( "#start : " + service ) ;
        }
        
        protected function timeout( service:RemotingService ):void
        {
            trace( "#timeout" ) ;
        }
        
        ////////////////
    }
}
```

The **progress** slot is invoked if the **multipleSimultaneousAllowed** property of the remoting service is false and if the service is already running.

```
import system.remoting.RemotingService ;

var service:RemotingService = new RemotingService() ;

service.multipleSimultaneousAllowed = true ;

service.run( "john" ) ;
service.run( "jack" ) ; // it's possible to run multiple requests

service.multipleSimultaneousAllowed = false ;

service.run( "alfred" ) ; // the progress signal emit a message
```

The **timeout** slot is invoked if the process is out of time, the delay is set with the method **setDelay( time:uint , useSeconds:Boolean=false)**. By default the delay property is setting with **25 seconds**.

You can disable this timeout phase with the property **timeoutPolicy** with the infinity mode define in the **system.process.TimeoutPolicy** enumeration class :

```
import system.process.TimeoutPolicy ;
import system.remoting.RemotingService ;

var service:RemotingService = new RemotingService() ;

trace( service.delay ) ; // 25000

service.setDelay( 15 , true ) ;

trace( service.delay ) ; // 15000

service.timeoutPolicy = TimeoutPolicy.INFINITY ; // disable timeout

service.timeoutPolicy = TimeoutPolicy.LIMIT ; // enable timeout
```

## Service listener ##

The **system.remoting.RemotingServiceListener** class provides an optional custom multi-slots tool to connect all the main **signals** of the **RemotingService** class and debug/manage **AMF asynchronous response**.

The **RemotingServiceListener** class implement the **IRemotingServiceListener** interface :

```
package system.remoting 
{
    public interface IRemotingServiceListener 
    {
        /**
         * Invoked when the service notify an error.
         */
        function error( error:* , service:RemotingService ):void
        
        /**
         * Invoked when the service notify a fault.
         */
        function fault( fault:* , service:RemotingService ):void
        
        /**
         * Invoked when the service process is finished.
         */
        function finish( service:RemotingService ):void
        
        /**
         * Registers the specific remoting service.
         * @return true if the service is registered.
         */
        function registerService( service:RemotingService ):Boolean
        
        /**
         * Invoked when the service notify a success.
         */
        function result( result:* , service:RemotingService ):void
        
        /**
         * Invoked when the service process is started.
         */
        function start( service:RemotingService ):void
        
        /**
         * Invoked when the service notify a timeout.
         */
        function timeout( service:RemotingService ):void
        
        /**
         * Unregister the passed-in service.
         * @return true if the service is unregister with success.
         */
        function unregisterService( service:RemotingService ):Boolean
    }
}
```

By default the **RemotingServiceListener** class is used to log all debug and warning messages with the **system.logging** engine.

```
package examples 
{
    import system.logging.LoggerLevel;
    import system.logging.targets.TraceTarget;
    
    import system.remoting.RemotingService;
    import system.remoting.RemotingServiceListener;
    
    import flash.display.Sprite;
    
    public class RemotingExample extends Sprite 
    {
        public function RemotingExample()
        {
            //////////////
            
            var target:TraceTarget = new TraceTarget() ;
            
            target.includeLines = true ;
            target.filters      = [ "*" ] ;
            target.level        = LoggerLevel.ALL ;
            
            //////////////
            
            var service:RemotingService = new RemotingService() ;

            service.gatewayUrl  = gatewayUrl ;
            service.serviceName = "HelloWorld" ;
            service.methodName  = "hello" ;
            
            service.listener = new RemotingServiceListener() ;
            
            service.run( "world" ) ;
        }
        
        public var gatewayUrl:String  = 
        "http://localhost:8888/remoting/amfphp/gateway.php" ;
    }
}
```

We run this little example and the output panel notify the **TraceTarget** message :

```
[1] [object RemotingServiceListener] start:[RemotingService serviceName:Test methodName:hello]
[2] [object RemotingServiceListener] result:hello world !
[3] [object RemotingServiceListener] finish:[RemotingService serviceName:Test methodName:hello]
```

The singleton **system.remoting.logger** is a **Logger** and dispatch log messages with the channel "**system.remoting**" in the **RemotingServiceListener** methods if the verbose of the instance property is true (by default this attribute is true).

You can create your custom listener with your custom class who extend the **RemotingServiceListener** class and override the slot methods **result**, **fault**, **error**, etc. methods, example :

```
package examples.remoting
{
    import system.remoting.RemotingService;
    import system.remoting.RemotingServiceListener;
    import system.remoting.logger;
    
    /**
     * The custom HelloWorld.hello AMF listener.
     */
    public class Hello extends RemotingServiceListener
    {
        public function Hello( service:*=null , verbose:Boolean = true)
        {
            super( service , verbose );
        }
        
        public override function result( result:* , service:RemotingService ):void
        {
            if ( verbose )
            {
                logger.debug( this + " result:" + result ) ;
                // check and use the result object here
            }
        }
    }
}
```

And you can register this service in your application with the source code :

```
import system.remoting.RemotingService;

import examples.remoting.Hello;

var service:RemotingService = new RemotingService() ;

service.listener = new Hello() ;
```

With this sort of modular objects you can create in your custom applications single listeners for all methods of the **AMF** services. Can use [injection of dependencies](InversionOfControl.md) principles and use programming with layers to create single result process for all services.

## Service proxy ##

You can use an optional feature in the **RemotingService** class with the proxy property.

The proxy property is defines with an instance of the **system.remoting.RemotingProxy** class.

This property is a dynamic object who create a proxy between the service instance and the **AMF** service server side.

**Example to use this dynamic attribute :**

```
package examples 
{
    import system.remoting.RemotingService;
    
    import flash.display.Sprite;
    
    public class RemotingExample extends Sprite 
    {
        public function RemotingExample()
        {
            var service:RemotingService = new RemotingService() ;
            
            service.fault.connect( fault  ) ;
            service.result.connect( result ) ;
            
            service.gatewayUrl  = gatewayUrl ;
            service.serviceName = "Test"  ;
            
            service.multipleSimultaneousAllowed = true ;
            
            service.proxy.hello( "world" ) ;

            service.proxy.bonjour( "monde" ) ; // unknow method
        }
        
        public var gatewayUrl:String = 
        "http://localhost:8888/remoting/amfphp/gateway.php" ;
        
        //////////////// slots
        
        protected function fault( fault:* , service:RemotingService ):void
        {
            trace("fault : " + dump(fault) ) ;
        }
        
        protected function result( result:* , service:RemotingService ):void
        {
            trace("result : " + result ) ;
        }
        
        ////////////////
    }
}
```

The output panel returns the log message of this example :

```
result : hello world !
fault : {code:"AMFPHP_INEXISTANT_METHOD",description:"The method  {bonjour} does not exist in class {Test}.",details:"/htdocs/remoting/amfphp/core/shared/app/BasicActions.php",level:"User Error",line:86}
```

## ObjectEncoding property ##

In the **RemotingService** class you can find the **objectEncoding** attribute, is used to set the internal **NetConnection.objectEncoding** property during the trigger process.

Use valid **flash.net.ObjectEncoding** enumeration values (0 or 3) to set this property. By default the **RemotingService** class use the **ObjectEncoding.AMF3** value.

```
import flash.net.ObjectEncoding ;
import system.remoting.RemotingService ;

var service:RemotingService = new RemotingService() ;

trace( service.objectEncoding ) ; // 3

service.objectEncoding = ObjectEncoding.AMF0 ;
trace( service.objectEncoding ) ; // 0

service.objectEncoding = ObjectEncoding.AMF3 ;
trace( service.objectEncoding ) ; // 3
```

**Note :** You can't change the objectEncoding value when the process is in progress.