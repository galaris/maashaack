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
    import system.Cloneable;
    import system.data.Iterable;
    import system.data.Iterator;
    import system.data.Set;
    import system.data.sets.ArraySet;
    
    import flash.events.Event;
    
    /**
     * This class provides a fast event dispatcher based "Observer" event model (like ASBroadcaster in AS1) but used <code>Event</code> object to dispatch the message to the listeners.
     */
    public class FastDispatcher implements Cloneable, Iterable
    {
        /**
         * Creates a new FastDispatcher instance.
         * @param listeners An optional Array of listeners to register when the dispatcher is initialized.
         */
        public function FastDispatcher( listeners:Array = null )
        {
            this.listeners = new ArraySet( listeners ) ;
        }
        
        /**
         * Registers an object to receive event notification messages.
         * This method is called on the broadcasting object and the listener object is sent as an argument.
         * @return <code>true</code> If the listener is register in the dispatcher and don't already exist.
         */
        public function addListener( listener:* ):Boolean
        {
            return listeners.add( listener ) ;
        }
        
        /**
         * Broadcast the specified message.
         * @return The reference of the BasicEvent dispatched by the dispatcher.
         */
        public function broadcastMessage( message:String , ...rest:Array ):Event
        {
            if ( message == null && listeners.size() == 0 )
            {
                return null ;
            }
            var e:BasicEvent = new BasicEvent( message , this , rest ) ;
            _propagate( e ) ;
            return e ;
        }
        
        /**
         * Creates and returns a shallow copy of the object.
         * @return A new object that is a shallow copy of this instance.
         */
        public function clone():*
        {
            return new FastDispatcher( listeners.toArray() ) ;
        }
        
        /**
         * Sends an Event Object to each object in the list of listeners.
         * When the Event is received by the listening object, Flash Player attempts to invoke a function of the same name on the Event.type property.
         */
        public function dispatch( e:Event ):void 
        {
            if ( e == null && listeners.size() == 0 )
            {
                return ;
            }
            _propagate( e ) ;
        }
        
        /**
         * Returns the Array representation of all listeners.
         * @return the Array representation of all listeners.
         */
        public function getListeners():Array
        {
            return listeners.toArray() ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if this dispatcher contains the specified listener.
         * @return <code class="prettyprint">true</code> if this dispatcher contains the specified listener.
         */
        public function hasListener( listener:* ):Boolean
        {
            return listeners.contains( listener ) ;
        }
        
        /**
         * Returns <code>true</code> if the set of listeners is empty.
         * @return <code>true</code> if the set of listeners is empty.
         */
        public function isEmpty():Boolean
        {
            return listeners.isEmpty() ;
        }
        
        /**
         * Returns the iterator reference of the object.
         * @return the iterator reference of the object.
         */
        public function iterator():Iterator
        {
            return listeners.iterator() ;
        }
        
        /**
         * Removes all listeners in the set of the dispatcher.
         */
        public function removeAllListeners():void
        {
            listeners.clear() ;
        }
        
        /**
         * Removes the specified listener.
         * @return <code>true</code> if the specified listener exist and can be unregister.
         */
        public function removeListener( listener:* ):Boolean
        {
            return listeners.remove( listener ) ;
        }
        
        /**
         * Indicates the number of listeners registered in the dispatcher.
         * @return The number of listeners registered in the dispatcher.
         */
        public function size():uint
        {
            return listeners.size() ;
        }
        
        /**
         * The Array representation of all listeners.
         */
        protected var listeners:Set ;
        
        /**
         * @private
         */
        private function _propagate( e:Event ):void
        {
            var o:* ;
            var a:Array  = listeners.toArray() ;
            var l:int    = a.length ;
            var t:String = e.type ;
            for ( var i:int ; i<l ; i++ ) 
            {
                o = a[i] ;
                if ( t in o && o[t] is Function )
                {
                    o[t].call( o , e ) ;
                }
            }
        }
    }
}
