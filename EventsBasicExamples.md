# Basic Example (real-life example) #

<a href='http://creativecommons.org/licenses/by-sa/3.0/'><img src='http://i.creativecommons.org/l/by-sa/2.0/uk/88x31.png' alt='Licence Creative Commons' /></a> author : Marc ALCARAZ ([ekameleon](https://code.google.com/u/109962507657971592081/))



I need to use a typical use case.

Imagine, you have an authentication mechanism in your application, which could be implemented like this :
```
package examples.events.Author
{

    /**
     * The Author class.
     */
    public class Author 
    {
        /**
         * Creates a new Author instance.
         */ 
        public function Author() {}
        
        private static var USER:String = "John" ;
        
        private static var PASS:String = "Doe" ;
        
        /**
         * Authentificate the specified user.
         */ 
        public function authenticate( user:String , pass:String ):Boolean 
        {
            if (user == Author.USER && pass == Author.PASS ) 
            {
                _username = user ;
                return true ;
            }
           return false ;
        }

        /**
         * Clear the authentification of the current author.
         */
        public function clearAuthentification():void 
        {
            _username = null;
        }

        /**
         * Returns the name of the user.
         */
        public function getUsername():String 
        {
            return _username ;
        }
        
        /**
         * Returns the String representation of the object.
         */
        public function toString():String 
        {
            var txt:String = "[Author" ;
            if (_username) 
            {
                txt += ", name:" + _username ;
            }
            txt += "]" ;
            return txt ;
        }
        
        private var _username:String ;
    }
}
```

This example is an extremely easy example of authentification application to illustrate a real-life application with the model events of **Maashaack**.

Now you want to display the user a login page in the ActionScript application and write a logfile if somebody successfully logged in and another logfile, if the authentication failed :

```
import examples.events.Author ;

var user:Author = new Author() ;
var result:Boolean = user.authenticate( username, password ) ;
if ( result ) 
{
    trace("log success....") ;
}
else 
{
    trace("log failed...") ;
}
```

Although this code will work, it can be greatly improved using a more flexible approach and the **EventDispatcher** package :

```
import system.events.EventDispatcher ;
import examples.events.Author ;

var dispatcher:EventDispatcher = new EventDispatcher() ;

var user:Author    = new Author() ;
var result:Boolean = user.authenticate( username, password ) ;
if ( result ) 
{
    dispatcher.dispatchEvent("onLogin", user) ;
}
else 
{
    dispatcher.dispatchEvent("onFail", user) ;
}
```

Instead of writing any logfiles you are just triggering new events. To actually write the logfiles, you need to register event listeners prior to launching your application.

```
package examples.events
{
    import flash.events.Event ;
    import system.events.EventListener ;
    
    public class AuthorLogger implements EventListener 
    {  
        /**
         * Creates a new AuthorLogger instance.
         */
        public function AuthorLogger() 
        {
            //
        }
        
        /**
         * Handles the event.
         */
        public function handleEvent( e:Event ):void 
        {      
            var type:String   = e.type ;
            var author:Author = e.target as Author ;
            var name:String   = author.getUsername() ;
            
            trace("AuthorLogger : Event has been triggered");
            
            trace( "event-type   : " + type ) ;
            trace( "event-target : " + author ) ;
            trace( "author-name  : " + name ) ;
        
            trace("---") ;
        }
    }
}
```
To finish this example, a little script in the main script of your application :
```
import system.events.BasicEvent ;
import system.events.EventDispatcher ;
import system.events.EventListener ;

import examples.events.Author ;
import examples.events.AuthorLogger ;

var logger:EventListener       = new AuthorLogger() ;
var dispatcher:EventDispatcher = new EventDispatcher() ;

dispatcher.registerEventListener( "onLogin" , logger ) ;
dispatcher.registerEventListener( "onFail"  , logger ) ;

/////////////

var user1:Author = new Author() ;
var result:Boolean = user1.authenticate("John", "Doe") ;

if ( result ) 
{
    dispatcher.dispatchEvent( new BasicEvent("onLogin", user1) ) ;
}
else 
{
    dispatcher.dispatchEvent( new BasicEvent("onFail", user1) ) ;
}

/////////////

var user2:Author = new Author() ;
var result:Boolean = user2.authenticate("John", "otherPass") ;

if ( result ) 
{
    dispatcher.dispatchEvent( new BasicEvent("onLogin", user2) ) ;
}
else 
{
    dispatcher.dispatchEvent( new BasicEvent("onFail", user2) ) ;
}
```

This way, you've achieved a clean separation of the logging code from the business logic. At a first glance, it seems a lot more complicated, than just checking the return value of authenticate() and then writing a logfile, but this approach has several benefits :

  * remove all logging functionality, by just removing the **addEventListener()** calls, or with the **removeEventListener()** method.
  * add logging to any other event (e.g. onLogout) by just adding the event listener to this event.
  * change the logging code to anything else (e.g. sending mails) without touching the business logic.