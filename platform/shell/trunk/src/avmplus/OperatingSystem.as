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
     * 
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
                var lines:Array          = file.split( "\n" );
                _linuxDistribID          = lines[0].split( "=" )[1];
                _linuxDistribRelease     = lines[1].split( "=" )[1];
                _linuxDistribCodename    = lines[2].split( "=" )[1];
                _linuxDistribDescription = lines[3].split( "=" )[1];
            }
            else
            {
                //set defaults if filename not found
                _linuxDistribID          = name;
                _linuxDistribRelease     = release;
                _linuxDistribCodename    = UNKNOWN;
                _linuxDistribDescription = "";
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
            /* TODO:
               return "Windows 98", "Windows 2000", "Windows 7", etc.
            */
            return "Windows";
        }

        private static function getVendorVersionAll():String
        {
            switch( vendor )
            {
                case "Apple": /* will get 10.1, 10.5.2, 10.6.1, etc. */
                case "Microsoft": /* will get 3.1, 4, 5.0, 5.1, 6.0 etc. */
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
                if( _linuxDistribDescription ) { return _linuxDistribDescription; }
                _parseLinuxReleaseFile();
                return _linuxDistribDescription;

                default:
                return EMPTY;
            }
        }

        private static function getVendorDescriptionApple():String
        {
            /* TODO:
               return something like "Mac OS X Leopard" or "Mac OS X Leopard (10.5.1)"
               and also check with the Darwin version
               for ex:
               Darwin 8.8.2 is "Mac OS X for Apple TV"

               see:
               http://en.wikipedia.org/wiki/Darwin_(operating_system)#Releases
               http://www.theapplemuseum.com/index.php?id=33
            */
            return EMPTY;
        }

        private static function getVendorDescriptionMicrosoft():String
        {
            /* TODO:
               return something like "Windows 7 Home Premium" or "Windows 7 Home Premium (NT 6.1)"

               see:
               http://en.wikipedia.org/wiki/Windows_NT
               http://msdn.microsoft.com/en-us/library/ms724429(v=VS.85).aspx
            */
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
                    case 0:
                    return "Cheetah";
                    
                    case 1:
                    return "Puma";
                    
                    case 2:
                    return "Jaguar";

                    case 3:
                    return "Panther";

                    case 4:
                    return "Tiger";

                    case 5:
                    return "Leopard";

                    case 6:
                    return "Snow Leopard";

                    default:
                    return UNKNOWN;
                }
            }

            return UNKNOWN;
        }

        private static function getCodeNameMicrosoft():String
        {
            return UNKNOWN;
        }


        
        /**
         * 
         */
        public static function get name():String
        {
            if( _name ) { return _name; }

            _name = getName();
            return _name;
        }
        
        /**
         * 
         */
        public static function get nodename():String
        {
            if( _nodename ) { return _nodename; }

            _nodename = getNodeName();
            return _nodename;
        }
        
        /**
         * 
         */
        public static function get hostname():String
        {
            if( _hostname ) { return _hostname; }

            _hostname = gethostname();
            return _hostname;
        }
        
        /**
         * 
         */
        public static function get release():String
        {
            if( _release ) { return _release; }

            _release = getRelease();
            return _release;
        }
        
        /**
         * 
         */
        public static function get version():String
        {
            if( _version ) { return _version; }

            _version = getVersion();
            return _version;
        }
        
        /**
         * 
         */
        public static function get machine():String
        {
            if( _machine ) { return _machine; }

            _machine = getMachine();
            return _machine;
        }
        
        /**
         * 
         */
        public static function get vendor():String
        {
            if( _vendor ) { return _vendor; }

            _vendor = getVendorAll();
            return _vendor;
        }
        
        /**
         * 
         */
        public static function get vendorName():String
        {
            if( _vendorname ) { return _vendorname; }

            _vendorname = getVendorNameAll();
            return _vendorname;
        }
        
        /**
         * 
         */
        public static function get vendorVersion():String
        {
            if( _vendorversion ) { return _vendorversion; }

            _vendorversion = getVendorVersionAll();
            return _vendorversion;
        }

        /**
         * 
         */
        public static function get vendorDescription():String
        {
            if( _vendordescription ) { return _vendordescription; }

            _vendordescription = getVendorDescriptionAll();
            return _vendordescription;
        }
        
        /**
         * 
         */
        public static function get codeName():String
        {
            if( _codename ) { return _codename; }

            _codename = getCodeNameAll();
            return _codename;
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
