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

package system.broadcasters 
{
    /**
     * This class provides a basic broadcaster interface based "Observer" event model (like ASBroadcaster in AS1).
     */
    public interface Broadcaster
    {
        /**
         * Indicates the number of listeners registered in the Broadcaster object.
         */
        function get length():uint ;
        
        /**
         * Registers an object to receive messages.
         * @param listener The listener to register.
         * @param priority Determinates the priority level of the listener.
         * @param autoRemove Apply a removeListener after the first trigger
         * @return <code>true</code> If the listener is register in the broadcaster.
         */
        function addListener( listener:* , priority:uint = 0 , autoRemove:Boolean = false ):Boolean ;
        
        /**
         * Broadcast the specified message.
         */
        function broadcastMessage( message:String , ...rest:Array ):* ;
        
        /**
         * Returns <code class="prettyprint">true</code> if this broadcaster contains the specified listener.
         * @return <code class="prettyprint">true</code> if this broadcaster contains the specified listener.
         */
        function hasListener( listener:* ):Boolean ;
        
        /**
         * Returns <code>true</code> if the set of listeners is empty.
         * @return <code>true</code> if the set of listeners is empty.
         */
        function isEmpty():Boolean ;
        
        /**
         * Removes the specified listener or all listeners if the parameter is null.
         * @return <code>true</code> if the specified listener exist and can be removed.
         */
        function removeListener( listener:* = null ):Boolean ;
    }
}
