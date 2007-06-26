
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
    
    /* Class: PlatformID
       Platform identifier.
     */
    public class PlatformID extends Enum
        {
        
        public function PlatformID( value:int, name:String )
            {
            super( value, name );
            }
        
        public static const Unknown:PlatformID   = new PlatformID( 0, "Unknown" );
        public static const Web:PlatformID       = new PlatformID( 1, "Web" );
        public static const Windows:PlatformID   = new PlatformID( 2, "Windows" );
        public static const Macintosh:PlatformID = new PlatformID( 3, "Macintosh" );
        public static const Unix:PlatformID      = new PlatformID( 4, "Unix" );
        public static const Arm:PlatformID       = new PlatformID( 5, "Arm" );
        
        }
    
    }

