
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
    import flash.system.Capabilities;
    
    /* Class: Environment
    */
    public class Environment extends Ghosts
        {
        private static var __:Namespace        = null;
        private static var _hostid:HostID      = _getHostID();
        private static var _host:Host          = null;
        private static var _os:OperatingSystem = null;
        
        private static function init():void
            {
            /* note:
               We don't want to use the Ghost class here.
            */
            switch( _hostid )
                {
                case HostID.Flash:
                __ = flash;
                break;
                
                case HostID.Apollo:
                __ = apollo;
                break;
                
                case HostID.RedTamarin:
                __ = redtamarin;
                break;
                
                case HostID.Tamarin:
                __ = tamarin;
                break;
                
                case HostID.Unknown:
                default:
                __ = unknown;
                }
            }
        
        private static function _getHostID():HostID
            {
            var runtime:String = Capabilities.playerType;
            
            switch( runtime )
                {
                case "ActiveX":
                case "External":
                case "PlugIn":
                case "StandAlone":
                return HostID.Flash;
                
                case "Desktop":
                return HostID.Apollo;
                
                case "AVMPlus":
                return HostID.Tamarin;
                
                case "RedTamarin":
                return HostID.RedTamarin;
                
                default:
                return HostID.Unknown;
                }
            }
        
        private static function _getPlatformID():PlatformID
            {
            var platform:String = getPlatformStringInternal();
            
            switch( platform )
                {
                case "Windows 95":
                case "Windows 98/ME":
                case "Windows NT":
                case "Windows 2000":
                case "Windows XP":
                case "Windows CE":
                case "win32":
                return PlatformID.Windows;
                
                case "MacOS":
                case "mac":
                return PlatformID.Macintosh;
                
                case "Linux":
                case "unix":
                return PlatformID.Unix;
                
                case "arm":
                return PlatformID.Arm;

                case "web":
                return PlatformID.Web;
                
                case "unknown":
                default:
                return PlatformID.Unknown;
                }
            }
        
        
        /* Method: getPlatformStringInternal
        */
        unknown static function getPlatformStringInternal():String
            {
            return "unknown";
            }
        
        flash static function getPlatformStringInternal():String
            {
            import flash.system.Capabilities;
            
            return Capabilities.os;
            }
        
        apollo static function getPlatformStringInternal():String
            {
            return flash::getPlatformStringInternal();
            }
        
        redtamarin static function getPlatformStringInternal():String
            {
            import avmplus.System;
            return System.getPlatformString();
            }
        
        internal static function getPlatformStringInternal():String
            {
            return __::getPlatformStringInternal();
            }
        
        /* Method: getHostVersion
        */
        unknown static function getHostVersion():Version
            {
            return new Version(); //0.0.0.0
            }
        
        flash static function getHostVersion():Version
            {
            import flash.system.Capabilities;
            /* note:
               WIN 9,0,0,0    // Flash Player 9 for Windows
               MAC 7,0,25,0   // Flash Player 7 for Macintosh
               UNIX 5,0,55,0  // Flash Player 5 for UNIX
            */
            var str:Strings = new Strings( Capabilities.version );
            var str2:String = str.trimStart( "WINMACUNIX ".split("") );
                str2        = str2.split( "," ).join( "." );
            
            return Version.fromString( str2 );
            }

        apollo static function getHostVersion():Version
            {
            return flash::getHostVersion();
            }
        
        tamarin static function getHostVersion():Version
            {
            import avmplus.System;
            var str:String = System.getAvmplusVersion();
                str        = str.split( " " )[0];
            
            return Version.fromString( str );
            }
        
        redtamarin static function getHostVersion():Version
            {
            import avmplus.System;
            /* note:
               0.1 red_dzwetan_2007-05-30_01-06
            */
            var str:String = System.getRedTamarinVersion();
                str        = str.split( " " )[0];
            
            return Version.fromString( str );
            }
        
        internal static function getHostVersion():Version
            {
            return __::getHostVersion();
            }
        
        
        public static function get host():Host
            {
            if( _host != null )
                {
                return _host;
                }
            
            var _id:HostID   = _getHostID();
            var _ver:Version = getHostVersion();
            
            _host = new Host( _id, _ver );
            
            return _host;
            }
        
        public static function get os():OperatingSystem
            {
            if( _os != null )
                {
                return _os;
                }
            
            var p:PlatformID = _getPlatformID();
            var v:Version    = new Version(); // 0.0.0.0 till we can get more detailled system infos
            
            if( p == PlatformID.Web )
                {
                v = new Version( 2, 0 ); //ok it's silly I know hehe
                }
            
            _os = new OperatingSystem( p, v );
            
            return _os;
            }
        
        
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
        
        init(); //dynamically select our current environment
        }
    
    }

