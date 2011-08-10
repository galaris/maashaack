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
  Portions created by the Initial Developers are Copyright (C) 2006-2011
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
    import system.process.Lockable;
    
    import flash.events.Event;
    
    /**
     * This basic class is used to create concrete <code class="prettyprint">IEventDispatcher</code> implementations. This class used composition with an internal <code class="prettyprint">EventDispatcher</code> object.
     * <p>You can overrides the internal <code class="prettyprint">EventDispatcher</code> instance with the <code class="prettyprint">initEventDispatcher</code> or the <code class="prettyprint">setEventDispatcher</code> methods. Used a global singleton reference in this method to register all events in a <code class="prettyprint">FrontController</code> for example.</p>
     */
    public class CoreEventDispatcher implements IEventDispatcher, Lockable
    {
        /**
         * Creates a new CoreEventDispatcher instance.
         * @param global the flag to use a global event flow or a local event flow.
         * @param channel the name of the global event flow if the <code class="prettyprint">global</code> argument is <code class="prettyprint">true</code>.
         */
        public function CoreEventDispatcher( global:Boolean = false , channel:String = null ) 
        {
            setGlobal( global , channel ) ;
        }
        
        /**
         * Indicates the channel of this dispatcher if this instance is global.
         */
        public function get channel():String
        {
            return _isGlobal ? _dispatcher.channel : null ;
        }
        
        /**
         * Allows the registration of event listeners on the event target.
         * @param type A string representing the event type to listen for. If eventName value is "ALL" addEventListener use addGlobalListener
         * @param listener The object that receives a notification when an event of the specified type occurs. This must be an object implementing the <code class="prettyprint">EventListener</code> interface.
          * @param useCapture Determinates if the event flow use capture or not.
         * @param priority Determines the priority level of the event listener.
         * @param useWeakReference Indicates if the listener is a weak reference.
         */
        public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0.0, useWeakReference:Boolean=false):void
        {
            _dispatcher.registerEventListener( type, listener, useCapture, priority, useWeakReference ) ;
        }
        
        /**
         * Dispatches an event into the event flow.
         * @param event The Event object that is dispatched into the event flow.
         * @return <code class="prettyprint">true</code> if the Event is dispatched.
         */
        public function dispatchEvent( event:Event ):Boolean
        {
            return _dispatcher.dispatchEvent( event ) ;
        }
        
         /**
         * Returns the internal <code class="prettyprint">system.events.EventDispatcher</code> reference.
         * @return the internal <code class="prettyprint">system.events.EventDispatcher</code> reference.
         */
         public function getEventDispatcher():EventDispatcher 
         {
            return _dispatcher ;
        }
         
         /**
         * Checks whether the EventDispatcher object has any listeners registered for a specific type of event.
         * This allows you to determine where altered handling of an event type has been introduced in the event flow heirarchy by an EventDispatcher object.
         */ 
        public function hasEventListener(type:String):Boolean
        {
            return _dispatcher.hasEventListener(type) ;
        }
        
        /**
         * Indicates if the dispatcher use a global event flow.
         * @return true if the dispatcher use a global event flow.
         */
        public function isGlobal():Boolean 
        {
            return _isGlobal ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the object is locked.
         * @return <code class="prettyprint">true</code> if the object is locked.
         */
        public function isLocked():Boolean 
        {
            return ___isLock___ ;
        }
        
        /**
         * Locks the object.
         */
        public function lock():void 
        {
            ___isLock___ = true ;
        }
        
        /**
         * Allows the registration of event listeners on the event target (Function or EventListener).
         * @param type A string representing the event type to listen for. If eventName value is "ALL" addEventListener use addGlobalListener
         * @param listener The object that receives a notification when an event of the specified type occurs. This must be an object implementing the <code class="prettyprint">EventListener</code> interface.
          * @param useCapture Determinates if the event flow use capture or not.
         * @param priority Determines the priority level of the event listener.
         * @param useWeakReference Indicates if the listener is a weak reference.
         */
        public function registerEventListener(type:String, listener:*, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
        {
            _dispatcher.registerEventListener(type, listener, useCapture, priority, useWeakReference) ;
        }
        
        /** 
         * Removes a listener from the EventDispatcher object.
         * If there is no matching listener registered with the <code class="prettyprint">EventDispatcher</code> object, then calling this method has no effect.
         * @param type The type of event.
         * @param listener The listener object to remove.
         * @param useCapture Specifies whether the listener was registered for the capture phase or the target and bubbling phases. If the listener was registered for both the capture phase and the target and bubbling phases, two calls to removeEventListener() are required to remove both, one call with useCapture() set to true , and another call with useCapture() set to false .
         */
        public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
        {
            _dispatcher.unregisterEventListener(type, listener, useCapture) ;
        } 
        
        /**
         * Sets the internal <code class="prettyprint">EventDispatcher</code> reference.
         * @param dispatcher The EventDispatcher reference used in this instance.
         */
        public function setEventDispatcher( dispatcher:EventDispatcher ):void 
        {
            _dispatcher = dispatcher || initEventDispatcher() ;
        }
        
        /**
         * Sets if the instance use a global <code class="prettyprint">system.events.EventDispatcher</code> to dispatch this events, if the <code class="prettyprint">flag</code> value is <code class="prettyprint">false</code> the instance use a local EventDispatcher.
         * @param flag the flag to use a global event flow or a local event flow.
         * @param channel the name of the global event flow if the <code class="prettyprint">flag</code> argument is <code class="prettyprint">true</code>.  
         */
        public function setGlobal( flag:Boolean = false , channel:String=null ):void 
        {
            _isGlobal = (flag == true) ;
            setEventDispatcher( _isGlobal ? EventDispatcher.getInstance( channel ) : null ) ;
        }
        
        /**
         * Unlocks the display.
         */
        public function unlock():void 
        {
            ___isLock___ = false ;
        }
        
        /** 
         * Removes a listener (Function or EventListener object) from the EventDispatcher object.
         * If there is no matching listener registered with the <code class="prettyprint">EventDispatcher</code> object, then calling this method has no effect.
         * @param type The type of event.
         * @param listener The listener object to remove.
         * @param useCapture Specifies whether the listener was registered for the capture phase or the target and bubbling phases. If the listener was registered for both the capture phase and the target and bubbling phases, two calls to removeEventListener() are required to remove both, one call with useCapture() set to true , and another call with useCapture() set to false .
         */
        public function unregisterEventListener( type:String , listener:* , useCapture:Boolean=false ):void
        {
            _dispatcher.unregisterEventListener(type, listener, useCapture) ;
        }
        
        /**
         * Checks whether an event listener is registered with this EventDispatcher object or any of its ancestors for the specified event type.
         * This method returns <code class="prettyprint">true</code> if an event listener is triggered during any phase of the event flow when an event of the specified type is dispatched to this EventDispatcher object or any of its descendants.
         * @return A value of <code class="prettyprint">true</code> if a listener of the specified type will be triggered; <code class="prettyprint">false</code> otherwise.
         */
        public function willTrigger(type:String):Boolean
        {
            return _dispatcher.willTrigger(type) ;
        }
        
        /**
         * The internal EventDispatcher reference.
         * @private
         */
        protected var _dispatcher:EventDispatcher ;
        
        /**
         * The internal flag to indicate if the event flow is global.
         * @private
         */
        protected var _isGlobal:Boolean ;
        
        /**
         * The internal flag to indicates if the display is locked or not.
         * @private
         */ 
        protected var ___isLock___:Boolean ;
        
        /**
         * Creates and returns the internal <code class="prettyprint">EventDispatcher</code> reference (this method is invoked in the constructor).
         * <p>You can overrides this method if you wan use a global <code class="prettyprint">EventDispatcher</code> singleton.</p>
         * @return the internal <code class="prettyprint">EventDispatcher</code> reference.
         */
        protected function initEventDispatcher():EventDispatcher 
        {
            return new EventDispatcher( this ) ;
        }
    }
}