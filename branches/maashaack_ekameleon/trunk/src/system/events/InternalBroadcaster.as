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
    import system.data.Iterable;
    import system.data.Iterator;
    import system.data.Set;
    import system.data.WeakReference;
    import system.data.iterators.ArrayIterator;
    import system.data.sets.ArraySet;
    
    /**
     * This class provides a basic implementation of the Broadcaster interface.
     */
    public class InternalBroadcaster implements Broadcaster, Iterable
    {
        /**
         * Creates a new InternalBroadcaster instance.
         * @param listeners The Array collection of listeners to register in the dispatcher.
         */
        public function InternalBroadcaster( listeners:Array = null ) 
        {
            this.listeners = new ArraySet() ;
            if ( listeners != null )
            {
                var l:int = listeners.length ;
                for( var i:int ; i<l ; i++ )
                {
                    addListener( listeners[i] );
                }
            }
        }
        
        /**
         * Registers an object to receive messages.
         * @param listener The listener to register.
         * @param useWeakReference Determines whether the reference to the listener is strong or weak.
         * @return <code>true</code> If the listener is register in the broadcaster.
         */
        public function addListener( listener:* , useWeakReference:Boolean = false ):Boolean
        {
            if ( listener == null )
            {
                return false ;
            }
            if ( useWeakReference )
            {
                if ( listeners.size() > 0 )
                {
                    var l:int   = listeners.size() ;
                    var a:Array = listeners.toArray() ;
                    var o:WeakReference ;
                    while( --l > -1 )
                    {
                        o = a[l] as WeakReference;
                        if ( o != null && o.value == listener )
                        {
                            return false ;
                        }
                    }
                }
                listener = new WeakReference( listener ) ;
            }
            return listeners.add( listener ) ;
        }
        
        /**
         * Broadcast the specified message.
         */
        public function broadcastMessage( message:String , ...rest:Array ):*
        {
            return null ;
        }
        
        /**
         * Returns the Array representation of all listeners.
         * @return the Array representation of all listeners.
         */
        public function getListeners():Array
        {
            if ( listeners.size() > 0 )
            {
                var l:int   = listeners.size() ;
                var r:Array = [] ;
                var a:Array = listeners.toArray() ;
                var o:* ;
                for( var i:int ; i<l ; i++ )
                {
                    o = a[i] ;
                    if ( o is WeakReference )
                    {
                        r.push( (o as WeakReference).value ) ;
                    }
                    else
                    {
                        r.push( o ) ;
                    }
                }
                return r ;
            }
            else
            {
                return [] ;
            }
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if this dispatcher contains the specified listener.
         * @return <code class="prettyprint">true</code> if this dispatcher contains the specified listener.
         */
        public function hasListener( listener:* ):Boolean
        {
            return getListeners().indexOf( listener ) > -1 ;
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
         * Returns the iterator reference of all listeners.
         * @return the iterator reference of all listeners.
         */
        public function iterator():Iterator
        {
            return new ArrayIterator(getListeners()) ;
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
            if ( listener == null )
            {
                return false ;
            }
            var b:Boolean ;
            if ( listeners.size() > 0 )
            {
                var l:int   = listeners.size() ;
                var a:Array = listeners.toArray() ;
                var o:* ;
                while( --l > -1 )
                {
                    o = a[l] ;
                    if ( o == listener || ( o is WeakReference && ( (o as WeakReference).value == listener ) ) )
                    {
                        listeners.remove(o) ;
                        b = true ;
                    }
                }
            }
            return b ;
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
    }
}