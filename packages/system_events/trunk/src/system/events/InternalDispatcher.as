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
  Portions created by the Initial Developers are Copyright (C) 2006-2012
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
    import flash.events.Event;
    import flash.events.EventDispatcher;
    
    /**
     * This abstract class provides all basic methods of the system.events.EventDispatcher.
     */
    public class InternalDispatcher extends flash.events.EventDispatcher implements IEventDispatcher
    {
        /**
         * Creates a new InternalDispatcher instance.
         * @param target The target object for events dispatched to the EventDispatcher object. This parameter is used when the EventDispatcher instance is aggregated by a class that implements IEventDispatcher; it is necessary so that the containing object can be the target for events. Do not use this parameter in simple cases in which a class extends EventDispatcher.
         */
        public function InternalDispatcher( target:IEventDispatcher = null )
        {
            super( target );
            _target = (target == null) ? this : target ;
        }
        
        /**
         * Indicates the optional target reference of the instance.
         */
        public function get target():IEventDispatcher 
        {
            return _target ;
        }
         
        /**
         * Dispatches an event into the event flow.
         * @param event The Event object that is dispatched into the event flow (a String or an Event object).
         * @param target the target of the event.
         * @param context the context of the event.
         */
        public function fireEvent( event:* , target:*=null, context:*=null , bubbles:Boolean=false ):Boolean
        {
            if ( event is String )
            {
                return super.dispatchEvent( new BasicEvent( event as String, target, context ) );
            }
            else if ( event is Event )
            {
                if ( event is BasicEvent )
                {
                    if ( target != null )
                    {
                        event.target = target ;
                    }
                    if ( context != null )
                    {
                        event.context = context ;
                    }
               }
               return super.dispatchEvent( event ) ;
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Registers an <code class="prettyprint">system.events.EventListener</code> object with an <code class="prettyprint">system.events.EventDispatcher</code> object so that the listener receives notification of an event.
         */
        public function registerEventListener( type:String, listener:*, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false ):void
        {    
            var func:Function ;
            if ( listener is Function )
            {
                func = listener ;
            }
            else if ( listener is EventListener ) 
            {
                func = EventListener(listener).handleEvent ;
            }
            super.addEventListener(type, func, useCapture, priority, useWeakReference) ;
        }
        
        /**
         * Removes an <code class="prettyprint">system.events.EventListener</code> from the <code class="prettyprint">system.events.EventDispatcher</code> object.
         */
        public function unregisterEventListener( type:String , listener:* , useCapture:Boolean = false ):void 
        {
            var func:Function ;
            if ( listener is Function )
            {
                func = listener ;
            }
            else if ( listener is EventListener ) 
            {
                func = (listener as EventListener).handleEvent ;
            }
            super.removeEventListener(type, func, useCapture) ;
        }
        
        /**
         * @private
         */
        private var _target:IEventDispatcher ;
    }
}
