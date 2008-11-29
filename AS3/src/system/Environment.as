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
  Portions created by the Initial Developers are Copyright (C) 2006-2009
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

    import system.hosts.Host;
    import system.hosts.HostID;
    import system.hosts.OperatingSystem;
    import system.hosts.PlatformID;    

    /**
     * This class defines the environment of the client application.
     */
    public class Environment
    {

        ///**
        // * @private
        // */
        //private static var _hostid:HostID      = _getHostID();
        
        /**
         * @private
         */
        private static var _host:Host = null;

        /**
         * @private
         */
        private static var _os:OperatingSystem = null;

        /**
         * @private
         */
        private static function _getHostID():HostID
        {
            var runtime:String = Capabilities.playerType;
            
            switch( runtime )
            {
                case "ActiveX"    :
                case "External"   :
                case "PlugIn"     :
                case "StandAlone" :
                {
                    return HostID.Flash ;
                }
                case "Desktop":
                {
                    return HostID.Air ;
                }
                default:
                {
                    return HostID.Unknown ;
                }
            }
        }

        /**
         * @private
         */
        private static function _getPlatformID():PlatformID
        {
            var platform:String = Capabilities.os;
            
            switch( platform )
            {
                case "Windows Vista" :
                case "Windows 95"    :
                case "Windows 98/ME" :
                case "Windows NT"    :
                case "Windows 2000"  :
                case "Windows XP"    :
                case "Windows CE"    :
                case "win32"         :
                {
                    return PlatformID.Windows ;
                }
                
                case "Mac OS 10.5.2" :
                case "MacOS"         :
                case "mac"           :
                {
                    return PlatformID.Macintosh ;
                }
                
                case "Linux" :
                case "unix"  :
                {
                    return PlatformID.Unix;
                }
                
                case "arm":
                {
                    return PlatformID.Arm ;
                }

                case "web" :
                {
                    return PlatformID.Web ;
                }
                
                case "unknown" :
                default        :
                {
                    return PlatformID.Unknown;
                }
            }
        }

        /**
         * @private
         */
        private static function _getHostVersion():Version
        {
            /* note:
            WIN 9,0,0,0    // Flash Player 9 for Windows
            MAC 7,0,25,0   // Flash Player 7 for Macintosh
            UNIX 5,0,55,0  // Flash Player 5 for UNIX
             */
            var str:String = Strings.trimStart( Capabilities.version, "WINMACUNIX ".split( "" ) );
            str = str.split( "," ).join( "." );
            
            return Version.fromString( str );
        }

        /**
         * Returns the Host reference of the client application.
         * @return the Host reference of the client application.
         */
        public static function get host():Host
        {
            if( _host != null )
            {
                return _host;
            }
            
            var _id:HostID = _getHostID( );
            var _ver:Version = _getHostVersion( );
            
            _host = new Host( _id, _ver );
            
            return _host;
        }

        /**
         * Returns the os OperatingSystem value of the current client application.
         * @return the os OperatingSystem value of the current client application.
         */        
        public static function get os():OperatingSystem
        {
            if( _os != null )
            {
                return _os;
            }
            
            var p:PlatformID = _getPlatformID( );
            var v:Version = new Version( ); 
            // 0.0.0.0 till we can get more detailled system infos
            if( p == PlatformID.Web )
            {
                v = new Version( 2, 0 ); //ok it's silly I know hehe
            }
            
            _os = new OperatingSystem( p, v );
            
            return _os;
        }

        /**
         * Returns the new line string value in the current environment.
         * @return the new line string value in the current environment.
         */
        public static function get newLine():String
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

