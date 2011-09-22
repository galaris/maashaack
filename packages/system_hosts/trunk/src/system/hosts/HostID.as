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

package system.hosts
{
    /**
     * This static enumeration class defines all host identifiers.
     */
    public final class HostID
    {
        /**
         * @private
         */
        protected var _name:String ;
        
        /**
         * @private
         */
        protected var _value:int ;
        
        /**
         * Creates a new HostID instance.
         * @param value The value of the enumeration.
         * @param name The name key of the enumeration.
         */
        public function HostID( value:int, name:String )
        {
            _value = value ;
            _name  = name  ;
        }
        
        /**
         * Returns the source code String representation of the object.
         * @return the source code String representation of the object.
         */
        public function toSource( indent:int = 0 ):String
        {
            return "system.hosts.HostID." + _name ;
        }
        
        /**
         * Returns the String representation of the object.
         * @return the String representation of the object.
         */
        public function toString():String
        {
            return _name;
        }
        
        /**
         * Returns the primitive value of the object.
         * @return the primitive value of the object.
         */
        public function valueOf():int
        {
            return _value;
        }
        
        /**
         * The 'Unknow' host id constant.
         */
        public static const Unknown:HostID = new HostID( 0, "Unknown" );
        
        /**
         * The 'Flash' host id constant.
         */
        public static const Flash:HostID = new HostID( 1, "Flash" );
        
        /**
         * The 'Air' host id constant.
         */
        public static const Air:HostID = new HostID( 2, "Air" );
        
        /* note:
           We will take into account only hosts upon which you can build
           "real" application, no moving target.
        */
        
        public static const Tamarin:HostID    = new HostID( 3, "Tamarin" );
        public static const RedTamarin:HostID = new HostID( 4, "RedTamarin" );
    }
}
