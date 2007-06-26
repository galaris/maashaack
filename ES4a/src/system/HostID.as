
/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [ES4a: ECMAScript 4 MaasHaack framework].
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
*/

package system
    {
    
    /* Class: HostID
       Host identifier.
     */
    public class HostID extends Enum
        {
        
        public function HostID( value:int, name:String )
            {
            super( value, name );
            }
        
        public static const Unknown:HostID    = new HostID( 0, "Unknown" );
        public static const Flash:HostID      = new HostID( 1, "Flash" );
        public static const Apollo:HostID     = new HostID( 2, "Apollo" );
        public static const Tamarin:HostID    = new HostID( 3, "Tamarin" );
        public static const RedTamarin:HostID = new HostID( 4, "RedTamarin" );
        
        }
    
    }

