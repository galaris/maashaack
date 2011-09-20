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

package system
{
    import flash.system.Capabilities;
    
    /**
     * The internal Environment class.
     */
    public class _Environment
    {
        private var _host:String = "";
        private var _os:String   = "";
        
        /**
         * Creates a new _Environment instance.
         */
        public function _Environment()
        {
            /* note:
               we want our singleton to be lazy
               so most properties will be initialized
               when getter are accessed
               and nothing get initialized in the ctor
            */
        }
        
        
        /**
         * Returns the Host reference of the current client application.
         * @return the Host reference of the current client application.
         */
        public function get host():String
        {
            if( _host )
            {
                return _host;
            }
            
            _host = Capabilities.playerType + " " + Capabilities.version.split( "," ).join( "." );
            
            return _host;
        }
        
        /**
         * Returns the Operating System of the current client application.
         * @return the Operating System of the current client application.
         */
        public function get os():String
        {
            if( _os )
            {
                return _os;
            }
            
            _os = Capabilities.os;
            
            return _os;
        }
        
        public function isDebug():Boolean
        {
            return Capabilities.isDebugger;
        }
        
        /**
         * Returns the new line string value in the current environment.
         * @return the new line string value in the current environment.
         */
        public function get newLine():String
        {
            /* FIXME:
            a console should always get \n
            but what about cases where you want to get the newline
            for the file system
            win32 should be \r\n
            mac should be   \r
            unix should be  \n
             */
            return "\n";
        }
    }
}
