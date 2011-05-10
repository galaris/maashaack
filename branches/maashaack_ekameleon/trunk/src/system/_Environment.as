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
    import core.strings.indexOfAny;
    import core.strings.trimStart;

    import system.hosts.Host;
    import system.hosts.HostID;
    import system.hosts.OperatingSystem;
    import system.hosts.PlatformID;

    import flash.system.Capabilities;
    
    /**
     * The internal Environment class.
     */
    public class _Environment
    {
        private var _host:Host = null;
        private var _os:OperatingSystem = null;
        
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
         * @private
         */
        private function _getHostID():HostID
        {
            var runtime:String = Capabilities.playerType;
            
            switch( runtime )
            {
                case "ActiveX"    :
                case "External"   :
                case "PlugIn"     :
                case "StandAlone" :
                {
                    return HostID.Flash;
                }
                
                case "Desktop":
                {
                    return HostID.Air;
                }
                
                case "RedTamarin":
                {
                    return HostID.RedTamarin;
                }
                
                case "AVMPlus":
                {
                    return HostID.Tamarin;
                }
            }
            
            return HostID.Unknown;
        }
        
        /**
         * @private
         */
        private function _getHostVersion():Version
        {
            /* note:
            WIN 9,0,0,0    // Flash Player 9 for Windows
            MAC 7,0,25,0   // Flash Player 7 for Macintosh
            UNIX 5,0,55,0  // Flash Player 5 for UNIX
            */
            var str:String = trimStart( Capabilities.version, "WINMACUNIX ".split( "" ) );
                str = str.split( "," ).join( "." );
            
            return Version.fromString( str );
        }
        
        /**
         * @private
         */
        private function _getPlatformID():PlatformID
        {
            var platform:String = Capabilities.os;
            if( indexOfAny( platform, ["Windows","WIN","win32"] ) > -1 )
            {
                return PlatformID.Windows;
            }
            else if( indexOfAny( platform, ["Macintosh","MAC","Mac OS","MacOS"] ) > -1 )
            {
                return PlatformID.Macintosh;
            }
            else if( indexOfAny( platform, ["Linux","UNIX","unix"] ) > -1 )
            {
                return PlatformID.Unix;
            }
            else if( indexOfAny( platform, ["arm"] ) > -1 )
            {
                return PlatformID.Arm;
            }
            else if( indexOfAny( platform, ["web"] ) > -1 )
            {
                return PlatformID.Web;
            }
            return PlatformID.Unknown;
        }
        
        /**
         * Returns the Host reference of the client application.
         * @return the Host reference of the client application.
         */
        public function get host():Host
        {
            if( _host )
            {
                return _host;
            }
            
            var _id:HostID   = _getHostID();
            var _ver:Version = _getHostVersion();
            
            _host = new Host( _id, _ver );
            
            return _host;
        }
        
        /**
         * Returns the os OperatingSystem value of the current client application.
         * @return the os OperatingSystem value of the current client application.
         */
        public function get os():OperatingSystem
        {
            if( _os )
            {
                return _os;
            }
            
            var p:PlatformID = _getPlatformID();
            var v:Version    = new Version(); // 0.0.0.0 till we can get more detailled system infos
            var s:String     = Capabilities.os;
            
            if( p == PlatformID.Web )
            {
                v = new Version( 2, 0 ); //still silly =)
            }
            
            _os = new OperatingSystem( p, v, s );
            
            return _os;
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
