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

package system.broadcasters 
{
    /**
     * This class provides a basic implementation of the Broadcaster interface.
     */
    public class InternalBroadcaster implements Broadcaster
    {
        /**
         * Creates a new InternalBroadcaster instance.
         * @param listeners The Array collection of listeners to initialize in the broadcaster.
         */
        public function InternalBroadcaster( listeners:Array = null ) 
        {
            this.listeners = new Vector.<BroadcasterEntry>() ;
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
         * Indicates the number of listeners registered in the Broadcaster.
         */
        public function get length():uint
        {
            return listeners.length ;
        }
        
        /**
         * Registers an object to receive messages.
         * @param listener The listener to register.
         * @param priority Determinates the priority level of the listener.
         * @param autoRemove Apply a removeListener after the first trigger
         * @return <code>true</code> If the listener is register in the broadcaster.
         */
        public function addListener( listener:* , priority:uint = 0 , autoRemove:Boolean = false ):Boolean
        {
            if ( listener == null || hasListener( listener ) )
            {
                return false ;
            }
            else
            {
                listeners.push( new BroadcasterEntry( listener , priority , autoRemove ) ) ;
                shellSort(listeners) ; 
                return true ;
            }
        }
        
        /**
         * Broadcast the specified message.
         * @param message The message to broadcast.
         * @param ...rest Optional parameters passed in with the broadcast message.
         */
        public function broadcastMessage( message:String , ...rest:Array ):*
        {
            return null ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if this dispatcher contains the specified listener.
         * @return <code class="prettyprint">true</code> if this dispatcher contains the specified listener.
         */
        public function hasListener( listener:* ):Boolean
        {
            if ( listener )
            {
                if ( listeners.length > 0 )
                {
                    var l:int = listeners.length ;
                    while( --l > -1 )
                    {
                        if ( ( listeners[l] as BroadcasterEntry ).listener == listener )
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
            return listeners.length == 0 ;
        }
        
        /**
         * Removes the specified listener or all listeners if the parameter is null.
         * @return <code>true</code> if the specified listener exist and can be removed.
         */
        public function removeListener( listener:* = null ):Boolean
        {
            if ( listener == null )
            {
                if ( listeners.length > 0 )
                {
                    listeners = new Vector.<BroadcasterEntry>() ;
                    return true ; 
                }
            }
            var b:Boolean ;
            if ( listener && listeners.length > 0 )
            {
                var o:* ;
                var l:int = listeners.length ;
                while( --l > -1 )
                {
                    o = (listeners[l] as BroadcasterEntry).listener ;
                    if ( o == listener )
                    {
                        listeners.splice( l , 1 ) ;
                        b = true ;
                    }
                }
            }
            return b ;
        }
        
        /**
         * Returns the Array representation of all listeners.
         * @return the Array representation of all listeners.
         */
        public function toArray():Array
        {
            var r:Array = [] ;
            if ( listeners.length > 0 )
            {
                var l:int = listeners.length ;
                for( var i:int ; i<l ; i++ )
                {
                    r[i] = ( listeners[i] as BroadcasterEntry ).listener ;
                }
            }
            return r ;
        }
        
        /**
         * The Vector representation of all listeners.
         */
        protected var listeners:Vector.<BroadcasterEntry> ;
        
        /**
         * Use a shell sort algorithm to sort the Vector of ActionEntry (http://en.wikipedia.org/wiki/Shell_sort). The sort method with a basic PriorityComparator.compare method failed ?
         * @private
         */
        protected function shellSort( data:Vector.<BroadcasterEntry> ):void 
        {
            var temp:BroadcasterEntry ;
            var i:int ;
            var j:int ;
            var n:int = data.length ;
            var inc:int = int( n / 2 + 0.5 ) ;
            while( inc ) 
            {
                for( i = inc ; i<n ; i++) 
                {
                    temp = data[i] ;
                    j    = i ;
                    while( j >= inc && data[int(j - inc)].priority < temp.priority ) 
                    {
                        data[j] = data[int(j - inc)] ;
                        j = int(j - inc);
                    }
                    data[j] = temp ;
                }
                inc = int(inc / 2.2 + 0.5);
            }
        }
    }
}