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
         * @param receivers The Array collection of listeners to register in the Signal object.
         */
        public function InternalSignal( listeners:Array = null )
        {
            this.receivers = new ArraySet() ;
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
         * Indicates the number of objects connected with the Signal.
         */
        public function get numReceivers():uint
        {
            return receivers.size() ;
        }
        
        /**
         * Connects a Function or a Receiver object with the signal.
         * @param receiver The receiver to connect : a Function reference or a Receiver object.
         * @param useWeakReference Determines whether the reference to the receiver is strong or weak.
         * @return <code>true</code> If the receiver is connected with the signal emitter.
         */
        public function connect( receiver:* , useWeakReference:Boolean = false ):Boolean
        {
            if ( receiver is Function || receiver is Receiver )
            {
                if (receiver is Receiver)
                {
                    receiver = ( receiver as Receiver ).receive ;
                }
                if ( hasReceiver( receiver ) )
                {
                    return false ;
                }
                if ( useWeakReference )
                {
                    receiver = new WeakReference( receiver ) ;
                }
                return receivers.add( receiver ) ;
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Disconnect the specified object.
         * @return <code>true</code> if the specified receiver exist and can be unregister.
         */
        public function disconnect( receiver:* ):Boolean
        {
            if ( receiver is Function || receiver is Receiver )
            {
                if ( receiver is Receiver )
                {
                    receiver = ( receiver as Receiver ).receive ;
                }
                var b:Boolean ;
                if ( receivers.size() > 0 )
                {
                    var l:int   = receivers.size() ;
                    var a:Array = receivers.toArray() ;
                    var o:* ;
                    while( --l > -1 )
                    {
                        o = a[l] ;
                        if ( o == receiver || ( o is WeakReference && ( (o as WeakReference).value == receiver ) ) )
                        {
                            receivers.remove(o) ;
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
         * Removes all receivers in the set of the signal.
         */
        public function disconnectAll():void
        {
            receivers.clear() ;
        }
        
        /**
         * Emit the specified values to the receivers.
         */
        public function emit( ...values:Array ):void
        {
            // overrides this method in concrete implementation
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if this signal contains the specified receiver.
         * @return <code class="prettyprint">true</code> if this signal contains the specified receiver.
         */
        public function hasReceiver( receiver:* ):Boolean
        {
            if ( receiver is Function || receiver is Receiver )
            {
                if (receiver is Receiver)
                {
                    receiver = ( receiver as Receiver ).receive ;
                }
                if ( receivers.size() > 0 )
                {
                    var a:Array = receivers.toArray() ;
                    var l:int   = a.length ;
                    var o:* ;
                    while( --l > -1 )
                    {
                        o = a[l] ;
                        if ( o is WeakReference && (o as WeakReference).value == receiver )
                        {
                            return true ;
                        }
                        else if ( o == receiver )
                        {
                            return true ;
                        }
                    }
                }
            }
            return false ;
        }
        
        /**
         * Returns <code>true</code> if the set of receivers is empty.
         * @return <code>true</code> if the set of receivers is empty.
         */
        public function isEmpty():Boolean
        {
            return receivers.isEmpty() ;
        }
        
        /**
         * Returns the iterator reference of all receivers.
         * @return the iterator reference of all receivers.
         */
        public function iterator():Iterator
        {
            return new ArrayIterator( toArray() ) ;
        }
        
        /**
         * Returns the Array representation of all receivers connected with the signal.
         * @return the Array representation of all receivers connected with the signal.
         */
        public function toArray():Array
        {
            if ( receivers.size() > 0 )
            {
                var l:int   = receivers.size() ;
                var r:Array = [] ;
                var a:Array = receivers.toArray() ;
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
         * The Array representation of all receivers.
         */
        protected var receivers:Set ;
    }
}
