# Some basic definitions #

<a href='http://creativecommons.org/licenses/by-sa/3.0/'><img src='http://i.creativecommons.org/l/by-sa/2.0/uk/88x31.png' alt='Licence Creative Commons' /></a> author : Marc ALCARAZ ([ekameleon](https://code.google.com/u/109962507657971592081/))



## Event ##

The **Event** interface is used to provide contextual information about an event to the handler processing the event. An object which implements the Event interface is generally passed as the first parameter to an event handler. More specific context information is passed to event handlers by deriving additional interfaces from Event which contain information directly relating to the type of event they accompany. These derived interfaces are also implemented by the object passed to the event listener.

## EventListener ##

The **EventListener** interface is the primary method for handling events. Users implement the **EventListener** interface and register their listener on an **EventTarget** using the **addEventListener** method. The users should also remove their **EventListener** from its **EventTarget** after they have completed using the listener.

## EventDispatcher ##

The **EventDispatcher** class itself is the center of the event-driven application. You may register listeners for certain events and it also provides methods to dispatch an event.

## EventTarget ##

The **EventTarget** interface is implemented by all Nodes in an implementation which supports the DOM Event Model. The interface allows registration and removal of eventListeners on an **EventTarget** and dispatch of events to that **EventTarget**.

## FrontController ##

The **Front Controller** pattern defines a single **EventDispatcher** that is responsible for processing application requests.

A **front controller** centralizes functions such as view selection, security, and templating, and applies them consistently across all pages or views. Consequently, when the behavior of these functions need to change, only a small part of the application needs to be changed : the controller and its helper classes.

## IEventDispatcher ##

This interface contains all methods of the **EventDispatcher** class.