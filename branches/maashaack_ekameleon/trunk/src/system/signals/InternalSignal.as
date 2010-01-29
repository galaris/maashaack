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

package system.signals
{
    import system.comparators.PriorityComparator;
    import system.data.Iterable;
    import system.data.Iterator;
    import system.data.iterators.ArrayIterator;

    /**
     * This core basic class provides all basic methods of the system.events.Signal interface.
     * You must overrides this class and defines the content emit() method.
     */
    public class InternalSignal implements Signal, Iterable
    {
        /**
         * Creates a new InternalSignal instance.
         * @param receivers The Array collection of receiver objects to connect with this signal.
         */
        public function InternalSignal( receivers:Array = null )
        {
            this.receivers = [] ;
            if ( receivers != null )
            {
                var l:int = receivers.length ;
                for( var i:int ; i<l ; i++ )
                {
                    connect( receivers[i] );
                }
            }
        }
        
        /**
         * Indicates the number of objects connected with the Signal.
         */
        public function get numReceivers():uint
        {
            return receivers.length ;
        }
        
        /**
         * Connects a Function or a Receiver object with the signal.
         * @param receiver The receiver to connect : a Function reference or a Receiver object.
         * @param priority Determinates the priority level of the receiver.
         * @param autoDisconnect Apply a disconnect after the first trigger
         * @return <code>true</code> If the receiver is connected with the signal emitter.
         */
        public function connect( receiver:* , priority:uint = 0 , autoDisconnect:Boolean = false ):Boolean
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
                receivers.push( new SignalEntry( receiver , priority , autoDisconnect ) ) ;
                receivers.sort( _comparator.compare ) ; 
                return true ;
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Returns <code>true</code> if one or more receivers are connected.
         * @return <code>true</code> if one or more receivers are connected.
         */
        public function connected():Boolean
        {
            return receivers.length > 0 ;
        }
        
        /**
         * Disconnect the specified object or all objects if the parameter is null.
         * @return <code>true</code> if the disconnection is a success.
         */
        public function disconnect( receiver:* = null  ):Boolean
        {
            if ( receiver == null )
            {
                if ( receivers.length > 0 )
                { 
                    receivers = [] ;
                    return true ;
                }
                else
                {
                    return false ;
                }
            }
            if ( receiver is Receiver )
            {
                receiver = ( receiver as Receiver ).receive ;
            }
            var b:Boolean ;
            if ( receiver && receiver is Function && receivers.length > 0 )
            {
                var r:Function ;
                var l:int = receivers.length ;
                while( --l > -1 )
                {
                    r = (receivers[l] as SignalEntry).receiver ;
                    if ( r == receiver )
                    {
                        receivers.splice( l , 1 ) ;
                        b = true ;
                    }
                }
            }
            return b ;
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
            if ( receiver is Receiver )
            {
                receiver = ( receiver as Receiver ).receive ;
            }
            if ( receiver && receiver is Function )
            {
                if ( receivers.length > 0 )
                {
                    var l:int = receivers.length ;
                    while( --l > -1 )
                    {
                        if ( ( receivers[l] as SignalEntry ).receiver == receiver )
                        {
                            return true ;
                        }
                    }
                }
            }
            return false ;
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
            if ( receivers.length > 0 )
            {
                var r:Array = [] ;
                var l:int = receivers.length ;
                for( var i:int ; i<l ; i++ )
                {
                    r[i] = ( receivers[i] as SignalEntry ).receiver ;
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
        protected var receivers:Array ;
        
        /**
         * @private
         */
        private static const _comparator:PriorityComparator = new PriorityComparator() ; 
    }
}
