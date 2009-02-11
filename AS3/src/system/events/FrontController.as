/*
Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
The contents of this file are subject to the Mozilla Public License Version
1.1 (the "License"); you may not use this file except in compliance with
the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/
  
Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
for the specific language governing rights and limitations under the
License.
  
The Original Code is [maashaack framework].
  
The Initial Developers of the Original Code are
Zwetan Kjukov <zwetan@gmail.com> and Marc Alcaraz <ekameleon@gmail.com>.
Portions created by the Initial Developers are Copyright (C) 2006-2009
the Initial Developers. All Rights Reserved.
  
Contributor(s):
  
Alternatively, the contents of this file may be used under the terms of
either the GNU General Public License Version 2 or later (the "GPL"), or
the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
in which case the provisions of the GPL or the LGPL are applicable instead
of those above. If you wish to allow use of your version of this file only
under the terms of either the GPL or the LGPL, and not to allow others to
use your version of this file under the terms of the MPL, indicate your
decision by deleting the provisions above and replace them with the notice
and other provisions required by the LGPL or the GPL. If you do not delete
the provisions above, a recipient may use your version of this file under
the terms of any one of the MPL, the GPL or the LGPL.

*/

package system.events
{
    import system.data.Iterator;
    import system.data.maps.ArrayMap;
    import system.data.maps.HashMap;
    
    import flash.events.Event;    

    /**
     * The front controller pattern defines a single EventDispatcher that is responsible for processing application requests.
     * <p>A front controller centralizes functions such as view selection, security, 
     * and templating, and applies them consistently across all pages or views. 
     * Consequently, when the behavior of these functions need to change, only a small part of the application 
     * needs to be changed: the controller and its helper classes.</p>
     */
    public class FrontController
    {
        
        /**
         * Creates a new FrontController instance.
         * @param channel the channel of this FrontController.
         * @param target the EventDispatcher reference to switch with the default EventDispatcher singleton in the controller.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * var controller:FrontController = new FrontController() ;
         * </pre>
         */
        public function FrontController( channel:String = null, target:EventDispatcher = null )
        {
            _map         = new ArrayMap() ;
            _dispatcher  = target || EventDispatcher.getInstance( channel ) ; 
        }
                
        /**
         * Add a new entry into the FrontController.
         * @param eventName:String
         * @param listener A listener Function or an EventListener object.
         * @throws ArgumentError If the 'eventName' value in argument is <code class="prettyprint">null</code> or <code class="prettyprint">undefined</code>.
         * @throws ArgumentError If the 'listener' object in argument is <code class="prettyprint">null</code> or <code class="prettyprint">undefined</code>.
         */
        public function add( type:String , listener:* ):void 
        {
            if ( type == null )
            {
                throw new ArgumentError( this + " add() method failed, the 'eventName' value in argument not must be 'null' or 'undefined'.") ;    
            }
            if ( listener == null )
            {
                throw new ArgumentError( this + " add() method failed with the event type '" + type + "' failed, the 'listener' object in argument not must be 'null' or 'undefined'.") ;    
            }
            if ( contains( type ) )
            {
            	remove( type ) ;
            }
            _map.put.apply( this, arguments ) ;
            _dispatcher.registerEventListener( type, listener ) ;
        }
        
        /**
         * Adds a new EventListener into an EventListenerBatch in the FrontController.
         * If this <code class="prettyprint">listener</code> argument is 'null' or 'undefined' and if the <code class="prettyprint">eventName</code> argument isn't register with an EventListenerBatch in the FrontController, 
         * an empty EventListenerBatch is created and register in the FrontController with the specified 'eventName'.
         * @param eventName The name of the event type.
         * @param listener (optional) The <code class="prettyprint">EventListener</code> mapped in the FrontController with the specified event type (This listener is added in an EventListenerBatch). 
         * @throws ArgumentError If the 'eventName' value in argument not must be 'null' or 'undefined'.
         */
        public function addBatch( eventName:String , listener:EventListener ):void
        {
            if ( eventName == null )
            {
                throw new ArgumentError( this + " addBatch method failed, the 'eventName' value in argument not must be 'null' or 'undefined'.") ;    
            }
            if ( _map.containsKey(eventName) )
            {
                if ( _map.get( eventName ) is EventListenerBatch && listener != null )
                {
                    ( _map.get( eventName ) as EventListenerBatch ).add( listener ) ;
                    return ;                
                }
            }
            var batch:EventListenerBatch = new EventListenerBatch() ;
            if ( listener != null )
            {
                batch.add( listener ) ;
            }
            add( eventName , batch ) ;
        }
        
        /**
         * Removes all entries in the FrontController. 
         */
        public function clear():void
        {
            if ( size() > 0 )
            {
                var it:Iterator = _map.keyIterator() ;
                while(it.hasNext())
                {
                    remove(it.next()) ;    
                }
                _map.clear() ;
            }    
        }

        /**
         * Returns 'true' if the eventName is registered in the FrontController.
         * @param eventName:String
         */
        public function contains( eventName:String ):Boolean 
        {
            return _map.containsKey(eventName) ;    
        }
        
        /**
         * Dispatch an event into the FrontController
         * @param event A type value who corresponding a event type or an event object.
         * @throws ArgumentError If the passed-in 'event' argument is not a String or an Event object. 
         */
        public function fireEvent( event:* ):void 
        {
        	if ( event is Event )
            {
                _dispatcher.dispatchEvent( event ) ;        
            }
            else if ( event is String )
            {
                _dispatcher.dispatchEvent( new BasicEvent( event ) ) ;    
            }
            else
            {
            	throw ArgumentError( "FrontController.fireEvent method failed with the argument " + event + ", the type of this argument is invalid." ) ;
            }
        }

        /**
         * Flush all global FrontController singletons.
         */
        public static function flush():void 
        {
            _instances.clear() ;
        }
        
        /**
         * Returns the Array representation of all channels register in the FrontController factory or <code class="prettyprint">null</code> if no singletons are registered.
         * @return the Array representation of all channels register in the FrontController factory or <code class="prettyprint">null</code> if no singletons are registered.
         */
        public static function getChannels():Array
        {
            return ( _instances.size() > 0 ) ? _instances.getKeys() : null ; 
        }        

        /**
         * Returns the internal EventDispatcher singleton reference of this FrontController.
         * @return the internal EventDispatcher singleton reference of this FrontController.
         */
        public function getEventDispatcher():EventDispatcher
        {
            return _dispatcher ;        
        }

        /**
         * Returns a global <code class="prettyprint">FrontController</code> singleton.
         * @param channel The channel of the FrontController (default the EventDispatcher.DEFAULT_SINGLETON_NAME value).
         * @return a global <code class="prettyprint">FrontController</code> singleton.
         */
        public static function getInstance( channel:String = null ):FrontController 
        {
            if ( channel == null ) 
            {
                channel = EventDispatcher.DEFAULT_SINGLETON_CHANNEL ;
            }
            if ( !FrontController._instances.containsKey( channel ) ) 
            {
                FrontController._instances.put( channel , new FrontController( channel ) ) ;
            }
            return FrontController._instances.get(channel) as FrontController ;
        }

        /**
         * Returns the listener register in the frontcontroller with the specified event name.
         * @param  eventName:String
         * @return an EventListener or a event callback Function.
         */
        public function getListener(eventName:String):* 
        {
            return _map.get(eventName) ;
        }
                
        /**
         * Indicates if the specified EventListener or listener registered with the 'eventName' value in argument is an EventListenerBatch instance.
         * @return <code class="prettyprint">true</code> if the specified EventListener or listener function registered with the 'eventName' value in argument is an EventListenerBatch instance.
         */
        public function isEventListenerBatch( eventName:String ):Boolean
        {
            if ( contains( eventName ) )
            {
            	return getListener( eventName ) is EventListenerBatch ;
            }
            else
            {
            	return false ;
            }
        }
        
        /**
         * Remove an entry into the FrontController.
         * @param eventName The name of the event type.
         */
        public function remove( eventName:String ):void
        {
        	var listener:* = _map.remove( eventName ) ;
            if ( listener != null ) 
            {
                _dispatcher.unregisterEventListener( eventName , listener ) ;
            }
        }
        
        /**
         * Removes a global FrontController singleton.
         * @param channel The channel of the FrontController to remove.
         */
        public static function removeInstance( channel:String ):Boolean 
        {
            if ( _instances.containsKey(channel) ) 
            {
                return _instances.remove(channel) != null ;
            }
            else 
            {
                return false ;
            }
        }
   
        /**
         * Sets the EventDispatcher reference of this FrontController.
         * @param target The EventDispatcher reference of this FrontController.
         */
        public function setEventDispatcher( target:EventDispatcher ):void
        {
            _dispatcher = target ;
        }      
   
        /**
         * Returns the number of elements in the controller.
         * @return the number of elements in the controller.
         */
        public function size():int
        {
            return _map.size() ;
        }
 
        /**
         * @private
         */
        private var _dispatcher:EventDispatcher ;
         
        /**
         * @private
         */    
        private static var _instances:HashMap = new HashMap() ;
        
        /**
         * @private
         */
        private var _map:ArrayMap ;
        
    }
    
}