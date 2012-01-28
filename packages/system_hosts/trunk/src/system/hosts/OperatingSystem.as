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

package system.hosts
{
    import system.Version;
    
    /**
     * Represents information about an operating system, such as the version and platform identifier. 
     * This class cannot be inherited.
     */
    public class OperatingSystem
    {
        
        /**
         * @private
         */
        private var _platform:PlatformID;
        
        /**
         * @private
         */
        private var _version:Version;
        
        /**
         * @private
         */
        private var _signature:String;
        
        /**
         * Creates a new OperatingSystem instance.
         * @param platform The PlatformID of the application operating system.
         * @param version The Version of the application operating system.
         */
        public function OperatingSystem( platform:PlatformID, version:Version, signature:String = "" )
        {
            _platform  = platform;
            _version   = version;
            _signature = signature;
        }
        
        /**
         * Returns the platform id of this operating system.
         * @return the platform id of this operating system.
         */
        public function get platform():PlatformID
        {
            return _platform;
        }
        
        /**
         * Returns the version of this operating system.
         * @return the version of this operating system.
         */
        public function get version():Version
        {
            return _version;
        }
        
        /**
         * Returns the signature of this operating system.
         * @return the signature of this operating system.
         */
        public function get signature():String
        {
            return _signature;
        }
        
        /**
         * Returns the String representation of the object.
         * @return the String representation of the object.
         */
        public function toString():String
        {
            //return platform.toString() + " " + version.toString();
            return platform.toString( );
        }
    }
}

