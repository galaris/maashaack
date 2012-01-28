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

package core
{
    public class version
    {
        /**
         * Creates a new version instance.
         */
        public function version( major:uint = 0,
                                 minor:uint = 0,
                                 build:uint = 0,
                                 revision:uint = 0 )
        {
            _value = (major << 28) | (minor << 24) | (build << 16) | revision;
        }

        /**
         * Indicates the build value of this version.
         */
        public function get build():uint
        {
            return (_value & 0x00FF0000) >>> 16;
        }
        
        /**
         * @private
         */ 
        public function set build( value:uint ):void
        {
            _value = (_value & 0xFF00FFFF) | (value << 16);
        }

        /**
         * Indicates the major value of this version.
         */
        public function get major():uint
        {
            return _value >>> 28;
        }
        
        /**
         * @private
         */ 
        public function set major( value:uint ):void
        {
            _value = (_value & 0x0FFFFFFF) | (value << 28);
        }

        /**
         * Indicates the minor value of this version.
         */
        public function get minor():uint
        {
            return (_value & 0x0F000000) >>> 24;
        }

        /**
         * @private
         */ 
        public function set minor( value:uint ):void
        {
            _value = (_value & 0xF0FFFFFF) | (value << 24);
        }
        
        /**
         * Indicates the revision value of this version.
         */
        public function get revision():uint
        {
            return _value & 0x0000FFFF;
        }
        
        /**
         * @private
         */ 
        public function set revision( value:uint ):void
        {
            _value = (_value & 0xFFFF0000) | value;
        }
        
        /**
         * Returns a string representation of the object.
         * @return a string representation of the object.
         */
        public function toString( fields:int = 0, separator:String = "." ):String
        {
            var data:Array = [major,minor,build,revision];
            if( (fields > 0) && (fields < 5) )
            {
                data = data.slice( 0, fields );
            }
            else
            {
                var i:int;
                var l:int = data.length;
                for( i=l-1 ; i>0 ; i-- )
                {
                    if( data[i] == 0 )
                    {
                        data.pop();
                    }
                    else
                    {
                        break;
                    }
                }
            }
            
            return data.join( separator );
        }
        
        /**
         * Returns the primitive value of the object.
         * @return the primitive value of the object.
         */
        public function valueOf():Number
        {
            return _value;
        }
        
        /**
         * @private
         */
        private var _value:Number = 0;
    }
}
