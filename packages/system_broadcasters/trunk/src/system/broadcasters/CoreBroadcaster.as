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
    import system.process.Lockable;
    
    /**
     * This basic class is used to create concrete <code class="prettyprint">Broadcaster</code> implementations. 
     * This class used composition with an internal <code class="prettyprint">Broadcaster</code> object, by default a MessageBroadcaster reference.
     */
    public class CoreBroadcaster implements Broadcaster, Lockable
    {
        /**
         * Creates a new CoreBroadcaster instance.
         * @param broadcaster The optional Broadcaster reference to use by composition in this Broadcaster.
         */
        public function CoreBroadcaster( broadcaster:Broadcaster = null )
        {
            setBroadcaster( broadcaster ) ;
        }
        
        /**
         * Indicates the Broadcaster reference used inside this composite Broadcaster.
         */
        public function get broadcaster():Broadcaster
        {
            return _broadcaster ;
        }
        
        /**
         * Indicates the number of listeners registered in the broadcaster.
         */
        public function get length():uint
        {
            return _broadcaster.length ;
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
            return _broadcaster.addListener( listener , priority , autoRemove ) ;
        }
        
        /**
         * Broadcast the specified message.
         */
        public function broadcastMessage(message:String, ...rest:Array):*
        {
            return _broadcaster.broadcastMessage.apply( _broadcaster , [message].concat(rest) ) ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if this dispatcher contains the specified listener.
         * @return <code class="prettyprint">true</code> if this dispatcher contains the specified listener.
         */
        public function hasListener(listener:*):Boolean
        {
            return _broadcaster.hasListener( listener ) ;
        }
        
        /**
         * Returns <code>true</code> if the set of listeners is empty.
         * @return <code>true</code> if the set of listeners is empty.
         */
        public function isEmpty():Boolean
        {
            return _broadcaster.isEmpty() ;
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
         * Removes the specified listener or all listeners if the parameter is null.
         * @return <code>true</code> if the specified listener exist and can be removed.
         */
        public function removeListener( listener:* = null ):Boolean
        {
            return _broadcaster.removeListener( listener ) ;
        }
        
        /**
         * Sets the internal <code class="prettyprint">Broadcaster</code> reference (default use MessageBroadcaster).
         * @param broadcaster The Broadcaster reference used in this instance.
         */
        public function setBroadcaster( broadcaster:Broadcaster = null ):void 
        {
            _broadcaster = broadcaster || initBroadcaster() ;
        }
        
        /**
         * Unlocks the display.
         */
        public function unlock():void 
        {
            ___isLock___ = false ;
        }
        
        /**
         * The internal Broadcaster reference.
         * @private
         */
        protected var _broadcaster:Broadcaster ;
        
        /**
         * The internal flag to indicates if the display is locked or not.
         * @private
         */ 
        protected var ___isLock___:Boolean ;
        
        /**
         * Creates and returns the internal <code class="prettyprint">Broadcaster</code> reference (this method is invoked in the constructor).
         */
        protected function initBroadcaster():Broadcaster 
        {
            return new MessageBroadcaster() ;
        }
    }
}
