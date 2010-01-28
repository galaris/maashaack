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
Portions created by the Initial Developers are Copyright (C) 2006-2010
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
     * This core basic class provides all basic methods of the system.events.Signal interface.
     * You must overrides this class and defines the content emit() method.
     */
    public class InternalSignal implements Signal, Iterable
    {
        /**
         * Creates a new InternalSignal instance.
         * @param listeners The Array collection of listeners to register in the Signal object.
         */
        public function InternalSignal( listeners:Array = null )
        {
            this.listeners = new ArraySet() ;
            if ( listeners != null )
            {
                var l:int = listeners.length ;
                for( var i:int ; i<l ; i++ )
                {
                    connect( listeners[i] );
                }
            }
        }
        
        /**
         * Indicates the number of listeners connected with the Signal object.
         */
        public function get length():uint
        {
            return listeners.size() ;
        }
        
        /**
         * Connectes a listener to receive messages.
         * @param listener The listener to register (a Function reference or a Receiver object).
         * @param useWeakReference Determines whether the reference to the listener is strong or weak.
         * @return <code>true</code> If the listener is connected with the signal emitter.
         */
        public function connect( listener:* , useWeakReference:Boolean = false ):Boolean
        {
            if ( listener is Function || listener is Receiver )
            {
                if (listener is Receiver)
                {
                    listener = ( listener as Receiver ).receive ;
                }
                if ( has( listener ) )
                {
                    return false ;
                }
                if ( useWeakReference )
                {
                    listener = new WeakReference( listener ) ;
                }
                return listeners.add( listener ) ;
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Removes the specified listener.
         * @return <code>true</code> if the specified listener exist and can be unregister.
         */
        public function disconnect( listener:* ):Boolean
        {
            if ( listener is Function || listener is Receiver )
            {
                if ( listener is Receiver )
                {
                    listener = ( listener as Receiver ).receive ;
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
            else
            {
                return false ;
            }
        }
        
        /**
         * Removes all listeners in the set of the dispatcher.
         */
        public function disconnectAll():void
        {
            listeners.clear() ;
        }
        
        /**
         * Emit the specified values to the listeners.
         */
        public function emit( ...values:Array ):void
        {
            // overrides this method in concrete implementation
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if this dispatcher contains the specified listener.
         * @return <code class="prettyprint">true</code> if this dispatcher contains the specified listener.
         */
        public function has( listener:* ):Boolean
        {
            if ( listener is Function || listener is Receiver )
            {
                if (listener is Receiver)
                {
                    listener = ( listener as Receiver ).receive ;
                }
                if ( listeners.size() > 0 )
                {
                    var a:Array = listeners.toArray() ;
                    var l:int   = a.length ;
                    var o:* ;
                    while( --l > -1 )
                    {
                        o = a[l] ;
                        if ( o is WeakReference && (o as WeakReference).value == listener )
                        {
                            return true ;
                        }
                        else if ( o == listener )
                        {
                            return true ;
                        }
                    }
                }
            }
            return false ;
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
            return new ArrayIterator( toArray() ) ;
        }
        
        /**
         * Returns the Array representation of all listeners.
         * @return the Array representation of all listeners.
         */
        public function toArray():Array
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
         * The Array representation of all listeners.
         */
        protected var listeners:Set ;
    }
}
