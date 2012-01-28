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

package system.ioc 
{
    /**
     * This object defines a receiver definition in an object definition.
     */
    public class ObjectReceiver
    {
        /**
         * Creates a new ObjectReceiver instance.
         * @param signal The id of the signal in the IoC factory.
         * @param slot The id of the receiver of function to connect in the IoC factory.
         * @param priority Determines the priority level of the receiver.
         * @param autoDisconnect Indicate if the receiver is auto disconnect in the signal when is used.
         * @param order Indicates the order to connect the receiver "after" or "before" (see the system.ioc.ObjectOrder enumeration class).
         */
        public function ObjectReceiver( signal:String , slot:String = null , priority:int = 0 , autoDisconnect:Boolean = false , order:String = "after" )
        {
            this.signal         = signal ;
            this.slot           = slot ;
            this.priority       = priority ;
            this.autoDisconnect = autoDisconnect ;
            this.order          = order ;
        }
        
        /**
         * Defines the "autoDisconnect" attribute in a receiver object definition.
         */
        public static const AUTO_DISCONNECT:String = "autoDisconnect" ;
        
        /**
         * Defines the "order" attribute in a receiver object definition.
         */
        public static const ORDER:String = "order" ;
        
        /**
         * Defines the "priority" attribute in a receiver object definition.
         */
        public static const PRIORITY:String = "priority" ;
        
        /**
         * Defines the "signal" attribute in a receiver object definition.
         */
        public static const SIGNAL:String = "signal" ;
        
        /**
         * Defines the "slot" attribute in a receiver object definition.
         */
        public static const SLOT:String = "slot" ;
        
        /**
         * Indicates if the receiver (slot) is auto disconnect by the signal.
         */
        public var autoDisconnect:Boolean ;
        
        /**
         * The order of the receiver registration ('after' or by default 'before').
         */
        public function get order():String
        {
            return _order ;
        }
        
        /**
         * @private
         */
        public function set order( value:String ):void
        {
            _order = ( value == ObjectOrder.BEFORE ) ? ObjectOrder.BEFORE : ObjectOrder.AFTER ;
        }
        
        /**
         * Determines the priority level of the event listener.
         */
        public var priority:int ;
        
        /**
         * The id of the signal to connect in the IoC factory.
         */
        public var signal:String ;
        
        /**
         * The id of the receiver of function to connect in the IoC factory.
         */
        public var slot:String ;
        
        /**
         * Returns the String representation of the object.
         * @return the String representation of the object.
         */
        public function toString():String
        {
            var s:String = "[ObjectReceiver" ;
            if ( signal )
            {
               s += " signal:\"" + signal + "\"" ;
            }
            if ( slot )
            {
               s += " slot:\"" + slot + "\"" ;
            }
            if ( _order )
            {
                s += " order:\"" + _order + "\"" ;
            }
            s += "]" ;
            return s ;
        }
        
        /**
         * @private
         */
        private var _order:String ;
    }
}
