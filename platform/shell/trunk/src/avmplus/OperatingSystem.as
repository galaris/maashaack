/* -*- c-basic-offset: 4; indent-tabs-mode: nil; tab-width: 4 -*- */
/* vi: set ts=4 sw=4 expandtab: (add to ~/.vimrc: set modeline modelines=5) */
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is [Open Source Virtual Machine.].
 *
 * The Initial Developer of the Original Code is
 * Adobe System Incorporated.
 * Portions created by the Initial Developer are Copyright (C) 2004-2006
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *   Zwetan Kjukov <zwetan@gmail.com>.
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

package avmplus
{
    import C.unistd.*;
    
    /**
     * The OperatingSystem class
     * Provides informations about the Operating System.
     * 
     * @langversion 3.0
     * @playerversion Flash 9
     * @productversion redtamarin 0.3
     * @since 0.3.0
     * 
     * @see http://code.google.com/p/redtamarin/wiki/System
     */
    [native(cls="::avmshell::OperatingSystemClass", methods="auto")]
    public class OperatingSystem
    {

        private static const UNKNOWN:String = "Unknown";
        private static const EMPTY:String   = "";
    
        //uname
        private static var _name:String;
        private static var _nodename:String;
        private static var _hostname:String;
        private static var _release:String;
        private static var _version:String;
        private static var _machine:String;

        private native static function getName():String;
        private native static function getNodeName():String;
        private native static function getRelease():String;
        private native static function getVersion():String;
        private native static function getMachine():String;


        //vendor
        private static var _vendor:String;
        private static var _vendorname:String;
        private static var _vendorversion:String;
        private static var _vendordescription:String;
        private static var _codename:String;
        
        private native static function getVendorVersion():String;
        
        //other
        private static var _username:String;
        
        
        private static function getVendorAll():String
        {
            switch( name )
            {
                case "Darwin":
                return "Apple";
                
                case "Win32":
                return "Microsoft";

                default:
                return name;
            }
        }

        /*
        see:
          Detecting Underlying Linux Distro
          http://www.novell.com/coolsolutions/feature/11251.html

          /etc/release equivalents for sundry Linux (and other Unix) distributions
          http://linuxmafia.com/faq/Admin/release-files.html

        for example on my Ubuntu
        /etc/lsb-release
        ----
        DISTRIB_ID=Ubuntu
        DISTRIB_RELEASE=8.04
        DISTRIB_CODENAME=hardy
        DISTRIB_DESCRIPTION="Ubuntu 8.04.4 LTS"
        ----

        more Ubuntu codenames
        http://en.wikipedia.org/wiki/Ubuntu_(operating_system)#Releases

        here we get "hardy", maybe we could add some code to change that to "Hardy Heron", etc.
        */
        private static var _linuxDistribID:String;
        private static var _linuxDistribRelease:String;
        private static var _linuxDistribCodename:String;
        private static var _linuxDistribDescription:String;

        /* note:
           good enougth for now
           add more distrib files later
        */
        private static var _linuxReleaseFiles:Array = [
        /*Ubuntu Linux*/ "/etc/lsb-release",
        /*Red Hat*/      "/etc/redhat-release",
        /*SUSE Linux*/   "/etc/SuSE-release", "/etc/novell-release",
        /*Mandrake*/     "/etc/mandrake-release",
        /*Debian*/       "/etc/debian_version"
        ]

        private function _setDefaultLinuxRelease():void
        {
            _linuxDistribID          = name;
            _linuxDistribRelease     = release;
            _linuxDistribCodename    = UNKNOWN;
            _linuxDistribDescription = "";
        }

        /* note:
           maybe add a little more parsing to get a _linuxDistribVersion
           that contains major.minor.bugfix

           right now, for example with Ubuntu, we will have
           OperatingSystem.vendorVersion = "8.04"

           but if we check the _linuxDistribDescription
           we could find "8.04.4" and so include the bugfix number
        */
        private static function _parseLinuxReleaseFile():void
        {
            var filename:String;
            var file:String;
            var i:uint;
            
            for( i=0; i<_linuxReleaseFiles.length; i++ )
            {
                filename = _linuxReleaseFiles[i];
                if( FileSystem.exists( filename ) )
                {
                    file = FileSystem.read( filename );
                    break;
                }
            }

            if( file )
            {
                /* note:
                   OK, here we assume a little too much
                   - line separator always "\n"
                   - lines always in the same order

                   tested and working on Ubuntu
                   but come back here later and improve the parsing
                */
                try
                {
                    var lines:Array          = file.split( "\n" );
                    _linuxDistribID          = lines[0].split( "=" )[1];
                    _linuxDistribRelease     = lines[1].split( "=" )[1];
                    _linuxDistribCodename    = lines[2].split( "=" )[1];
                    _linuxDistribDescription = lines[3].split( "=" )[1];

                    if( _linuxDistribDescription.indexOf( "\"" ) > -1 )
                    {
                        _linuxDistribDescription = _linuxDistribDescription.split( "\"" ).join( "" );
                    }
                }
                catch( e:Error )
                {
                    _setDefaultLinuxRelease();
                }

            }
            else
            {
                //set defaults if filename not found
                _setDefaultLinuxRelease();
            }
            
        }

        private static var _macProductBuildVersion:String;
        private static var _macSystemVersionFile:String = "/System/Library/CoreServices/SystemVersion.plist";

        /* note:
           we do that to only get the build number

           see
           http://osxdaily.com/2007/04/23/get-system-information-from-the-command-line/
           ----
           $ sw_vers
           ProductName: Mac OS X
           ProductVersion: 10.4.9
           BuildVersion: 8P2137
           ----

           http://blog.loudhush.ro/2007/07/swvers-does-not-use-gestalt.html
           ----
            $ nm /usr/bin/sw_vers
            [..]
                     U __CFCopyServerVersionDictionary
                     U __CFCopySystemVersionDictionary
            [..]

            $ DYLD_IMAGE_SUFFIX=_debug gdb /usr/bin/sw_vers
            [..]

            Breakpoint 10, CFURLCreateWithFileSystemPath (allocator=0x0, 
            filePath=0x2ee828, 
            fsType=kCFURLPOSIXPathStyle, 
            isDirectory=0 '\000') 
            at URL.subproj/CFURL.c:3480

            (gdb) bt
            #0  CFURLCreateWithFileSystemPath (allocator=0x0, 
                  filePath=0x2ee828, 
                  fsType=kCFURLPOSIXPathStyle, 
                  isDirectory=0 '\000') 
                  at URL.subproj/CFURL.c:3480
            #1  0x00262866 in _CFCopyVersionDictionary (path=0x2ee828) 
                  at Base.subproj/CFUtilities.c:253
            #2  0x0026282a in _CFCopySystemVersionDictionary () 
                  at Base.subproj/CFUtilities.c:309
            #3  0x000019ae in ?? ()
            #4  0x00001896 in ?? ()
            #5  0x000017bd in ?? ()

            (gdb) call CFShow(0x2ee828)
            /System/Library/CoreServices/SystemVersion.plist
           ----
        */
        private static function _parseMacVersionFile():void
        {
            var filename:String = _macSystemVersionFile;
            var file:String;

            if( FileSystem.exists( filename ) )
            {
                file = FileSystem.read( filename );
            }

            if( file )
            {
                /* note:
                   yeah that's some ugly parsing but good enought for the time being
                */
                var tmp:String = file.split( "<key>ProductBuildVersion</key>" )[1];
                var pos1:int = tmp.indexOf( "<string>" );
                var pos2:int = tmp.indexOf( "</string>" );
                _macProductBuildVersion = tmp.substring( pos1+("<string>".length), pos2 );
            }
            else
            {
                //set defaults if filename not found
                _macProductBuildVersion = EMPTY;
            }
            
        }

        private static function getVendorNameAll():String
        {
            switch( vendor )
            {
                /* note:
                   return "Mac OS" when vendorVersion.major <= 9 ?
                */
                case "Apple":
                return "Mac OS X";

                case "Microsoft":
                return getVendorNameMicrosoft();

                case "Linux":
                if( _linuxDistribID ) { return _linuxDistribID; }
                _parseLinuxReleaseFile();
                return _linuxDistribID;

                default:
                return name;
            }
        }
        
        private static function getVendorNameMicrosoft():String
        {
            if( version.indexOf( "Windows 95" ) > -1 ) { return "Windows 95"; }
            if( version.indexOf( "Windows 98" ) > -1 ) { return "Windows 98"; }
            if( version.indexOf( "Windows ME" ) > -1 ) { return "Windows ME"; }
            if( version.indexOf( "Windows NT" ) > -1 ) { return "Windows NT"; }
            if( version.indexOf( "Windows XP" ) > -1 ) { return "Windows XP"; }
            if( version.indexOf( "Windows 2000" ) > -1 ) { return "Windows 2000"; }
            if( version.indexOf( "Windows Server 2003 R2" ) > -1 ) { return "Windows Server 2003 R2"; }
            if( version.indexOf( "Windows Server 2003" ) > -1 ) { return "Windows Server 2003"; }
            if( version.indexOf( "Windows Vista" ) > -1 ) { return "Windows Vista"; }
            if( version.indexOf( "Windows Server 2008 R2" ) > -1 ) { return "Windows Server 2008 R2"; }
            if( version.indexOf( "Windows Server 2008" ) > -1 ) { return "Windows Server 2008"; }
            if( version.indexOf( "Windows 7" ) > -1 ) { return "Windows 7"; }
            
            return "Windows";
        }
        
        private static function getVendorVersionAll():String
        {
            switch( vendor )
            {
                case "Apple": /* will get 10.1, 10.5.2, 10.6.1, etc. */
                case "Microsoft": /* will get 3.1, 4, 5.0, 5.1, 6.0 etc. */
                /* note:
                   for Windows, the bugfix number is the major service pack number
                   0 if no service pack,
                   for ex:
                   Windows XP Professional Service Pack 3
                   would return "5.1.3"
                */
                return getVendorVersion();

                case "Linux":
                if( _linuxDistribRelease ) { return _linuxDistribRelease; }
                _parseLinuxReleaseFile();
                return _linuxDistribRelease;

                default:
                return version;
            }
        }

        private static function getVendorDescriptionAll():String
        {
            switch( vendor )
            {
                case "Apple":
                return getVendorDescriptionApple();

                case "Microsoft":
                return getVendorDescriptionMicrosoft();

                case "Linux":
                return getVendorDescriptionLinux();

                default:
                return EMPTY;
            }
        }

        private static function getVendorDescriptionApple():String
        {
            /* TODO:
               return something like "Apple Mac OS X 10.5.1 (Leopard build 9B18)"
               
               see:
               http://en.wikipedia.org/wiki/Darwin_(operating_system)#Releases
               http://www.theapplemuseum.com/index.php?id=33
            */
            
            if( (vendor != "") && (vendorName != "") )
            {
                var desc:String = vendor + " " + vendorName + " " + vendorVersion;
                    desc += " ("
                if( codename != UNKNOWN )
                {
                    desc += codename + " ";
                }

                if( !_macProductBuildVersion )
                {
                    _parseMacVersionFile();
                }

                if(_macProductBuildVersion != EMPTY)
                {
                    desc += "build " + _macProductBuildVersion + ")";
                }
                else
                {
                    desc += ")";
                }
                
                return desc;
            }
            
            return EMPTY;
        }

        private static function getVendorDescriptionMicrosoft():String
        {
            /* TODO:
               return something like "Microsoft Windows 7 Home Premium (Vienna 6.1 build 2600)"

               see:
               http://en.wikipedia.org/wiki/Windows_NT
               http://msdn.microsoft.com/en-us/library/ms724429(v=VS.85).aspx
            */
            if( (vendor != "") && (version != "") )
            {
                var desc:String = vendor + " " + version;
                    desc += " ("
                if( codename != UNKNOWN )
                {
                    desc += codename + " ";
                }
                    desc += release+")";
                return desc;
            }
            
            return EMPTY;
        }

        private static function getVendorDescriptionLinux():String
        {
            if( !_linuxDistribDescription )
            {
                _parseLinuxReleaseFile();
            }
            
            /* note:
               return something like "Linux Ubuntu 8.04.4 LTS (hardy)"
            */
            if( _linuxDistribDescription && (_linuxDistribDescription != EMPTY) )
            {
                var desc:String = vendor + " " + _linuxDistribDescription;
                if( codename != UNKNOWN )
                {
                    desc += " (" + codename + ")";
                }
                return desc;
            }

            return EMPTY;
        }
        
        private static function getCodeNameAll():String
        {
            switch( vendor )
            {
                case "Apple":
                return getCodeNameApple();

                case "Microsoft":
                return getCodeNameMicrosoft();

                case "Linux":
                if( _linuxDistribCodename ) { return _linuxDistribCodename; }
                _parseLinuxReleaseFile();
                return _linuxDistribCodename;

                default:
                return UNKNOWN;
            }
        }
        
        private static function getCodeNameApple():String
        {
            var version:Array = vendorVersion.split( "." );
            var major:uint = parseInt( version[0] );
            var minor:uint = parseInt( version[1] );

            /* note:
               we don't really plan to support anything before Leopard (10.5)
               but well, as you can compile a PPC version of Tamarin
               technically redtamarin should be able to run on those old OSX
            */
            if( major == 10 )
            {
                switch( minor )
                {
                    case 0: return "Cheetah";
                    case 1: return "Puma";
                    case 2: return "Jaguar";
                    case 3: return "Panther";
                    case 4: return "Tiger";
                    case 5: return "Leopard";
                    case 6: return "Snow Leopard";
                    default: return UNKNOWN;
                }
            }
            
            return UNKNOWN;
        }
        
        /* note:
           http://en.wikipedia.org/wiki/List_of_Microsoft_codenames
        */
        private static function getCodeNameMicrosoft():String
        {
            if( version.indexOf( "Windows 95 OEM Service Release 2" ) > -1 ) { return "Detroit"; }
            if( version.indexOf( "Windows 95" ) > -1 ) { return "Chicago"; }
            if( version.indexOf( "Windows 98" ) > -1 ) { return "Memphis"; }
            if( version.indexOf( "Windows XP" ) > -1 ) { return "Whistler"; }
            if( version.indexOf( "Windows 2000" ) > -1 ) { return "Memphis NT"; }
            if( version.indexOf( "Windows 2003" ) > -1 ) { return "Whistler Server"; }
            if( version.indexOf( "Windows Vista" ) > -1 ) { return "Longhorn"; }
            if( version.indexOf( "Windows 2008" ) > -1 ) { return "Longhorn Server"; }
            if( version.indexOf( "Windows 7" ) > -1 ) { return "Vienna"; }
            
            return UNKNOWN;
        }

        private native static function getSystemLocale():String;

        private static function _parseSystemLocale( raw:String ):Object
        {
            /* note:
               here the format
               locale :: "lang[_country_region[.code_page]]"

               we ignore region for now
            */

            var localeinfo:Object = {};
                localeinfo.language = "";
                localeinfo.country  = "";
                localeinfo.codepage = "";

            if( raw.indexOf( "." ) > -1 )
            {
                var tmp:Array = raw.split( "." );

                if( tmp[1] && (tmp[1] != "") )
                {
                    localeinfo.codepage = tmp[1];
                }
                
                raw = tmp[0];
            }

            if( raw.indexOf( "_" ) > -1 )
            {
                var tmp2:Array = raw.split( "_" );

                if( tmp2[0] && (tmp2[0] != "") )
                {
                    localeinfo.language = tmp2[0];
                }

                if( tmp2[1] && (tmp2[1] != "") )
                {
                    localeinfo.country = tmp2[1];
                }
            }
            
            return localeinfo;
        }



        
        /**
         * The OS kernel name.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function get name():String
        {
            if( _name ) { return _name; }

            _name = getName();
            return _name;
        }
        
        /**
         * The current user name logged in the OS.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function get username():String
        {
            if( _username ) { return _username; }

            _username = getlogin(); //C.unistd.getlogin()
            return _username;
        }
        
        /**
         * Name of this node on the network.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function get nodename():String
        {
            if( _nodename ) { return _nodename; }

            _nodename = getNodeName();
            return _nodename;
        }
        
        /**
         * The host name of the local computer.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function get hostname():String
        {
            if( _hostname ) { return _hostname; }

            _hostname = gethostname(); //C.unistd.gethostname()
            return _hostname;
        }
        
        /**
         * Current release level of the OS.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function get release():String
        {
            if( _release ) { return _release; }

            _release = getRelease();
            return _release;
        }
        
        /**
         * Current version level of this release of the OS.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function get version():String
        {
            if( _version ) { return _version; }

            _version = getVersion();
            return _version;
        }
        
        /**
         * Name of the hardware type the system is running on.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function get machine():String
        {
            if( _machine ) { return _machine; }

            _machine = getMachine();
            return _machine;
        }
        
        /**
         * Name of the vendor (commercial) or distributor (non-commercial) of this OS.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function get vendor():String
        {
            if( _vendor ) { return _vendor; }

            _vendor = getVendorAll();
            return _vendor;
        }
        
        /**
         * Name of the OS provided by the vendor/distributor.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function get vendorName():String
        {
            if( _vendorname ) { return _vendorname; }

            _vendorname = getVendorNameAll();
            return _vendorname;
        }
        
        /**
         * Version of the OS provided by the vendor/distributor.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function get vendorVersion():String
        {
            if( _vendorversion ) { return _vendorversion; }

            _vendorversion = getVendorVersionAll();
            return _vendorversion;
        }

        /**
         * Description of the OS provided by the vendor/distributor,
         * or the empty string if not defined.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function get vendorDescription():String
        {
            if( _vendordescription ) { return _vendordescription; }

            _vendordescription = getVendorDescriptionAll();
            return _vendordescription;
        }
        
        /**
         * Codename of this OS, or "Unknown" if not defined.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function get codename():String
        {
            if( _codename ) { return _codename; }

            _codename = getCodeNameAll();
            return _codename;
        }

        /**
         * The OS language.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function get language():String
        {
            var info:Object = _parseSystemLocale( getSystemLocale() );
            return info.language;
        }

        /**
         * The OS country.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function get country():String
        {
            var info:Object = _parseSystemLocale( getSystemLocale() );
            return info.country;
        }

        /**
         * The OS locale as <code>language[_country]</code>.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function get locale():String
        {   
            var str:String = "";

            if( language != "" )
            {
                str += language;
            }

            if( country != "" )
            {
                if( str != "" ) { str += "_"; }
                str += country;
            }

            return str;
        }

        /**
         * The OS code page.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function get codepage():String
        {
            var info:Object = _parseSystemLocale( getSystemLocale() );
            return info.codepage;
        }




/* notes:
   Capabilities.os
   The os property can return the following strings: "Windows XP", "Windows 2000", "Windows NT", "Windows 98/ME",
   "Windows 95", "Windows CE", "Linux", and "Mac OS X.Y.Z" (where X.Y.Z is the version number, for example: Mac OS 10.5.2).

   Capabilities.cpuArchitecture
   can return the following strings: "PowerPC", "x86", "SPARC", and "ARM".
*/

    }
}
