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
    import C.stdlib.*;
    import C.unistd.*;
    import flash.utils.ByteArray;
    import avmplus.profiles.Profile;

    internal namespace hack_sys = "http://code.google.com/p/redtamarin/2011/hack/system" ;

    /**
     * The System class
     * Represents the currently running application and the avmshell runtime.
     * 
     * @langversion 3.0
     * @playerversion Flash 9
     * @productversion redtamarin 0.3
     * @since 0.3.0
     * 
     * @see http://code.google.com/p/redtamarin/wiki/System
     */
    [native(cls="::avmshell::SystemClass", classgc="exact", methods="auto")]
    public class System
    {
        
        private static var _API:Array = [];
                           _API[660] = "FP_9_0";
                           _API[661] = "AIR_1_0";
                           _API[662] = "FP_10_0";
                           _API[663] = "AIR_1_5";
                           _API[664] = "AIR_1_5_1";
                           _API[665] = "FP_10_0_32";
                           _API[666] = "AIR_1_5_2";
                           _API[667] = "FP_10_1";
                           _API[668] = "AIR_2_0";
                           _API[669] = "AIR_2_5";
                           _API[670] = "FP_10_2";
                           _API[671] = "AIR_2_6";
                           _API[672] = "SWF_12";
                           _API[673] = "AIR_2_7";
                           _API[674] = "FP_SYS";
                           _API[675] = "AIR_SYS";

        private static var _profile:Profile;
        
        private native static function getArgv():Array;
        private native static function getStartupDirectory():String;
        
        /**
         * Contains the arguments passed to the program.
         *
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static const argv:Array = getArgv();
        
        /**
         * The original directory when the application started.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static const startupDirectory:String = getStartupDirectory();



        /**
         * Return the value passed to -api at launch
         * (or the default value, if -api was not specified).
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public native static function get apiVersion():int;

        /**
         * Returns the alias name of the api version.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function get apiAlias():String
        {
            return _API[ apiVersion ];
        }

        /**
         * Returns the current process id.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function get pid():int
        {
            return getpid();
        }

        /**
         * Returns the current profile.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.1
         */
        public static function get profile():Profile
        {
            if( _profile ) { return _profile; }

            //lazy init
            var defaultProfile:Class = getClassByName( "avmplus.profiles.RedTamarinProfile" );

            if( defaultProfile )
            {
                _profile = new defaultProfile();
                return _profile;
            }

            return null;
        }

        /**
         * Defines the current profile.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.1
         */
        public static function set profile( value:Profile ):void
        {
            _profile = value;
        }

        /**
         * Standard Output.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.2
         */
        public static var stdout:StandardStream = new StandardStreamOut();

        /**
         * Standard Error.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.2
         */
        public static var stderr:StandardStream = new StandardStreamErr();

        /**
         * Standard Input.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.2
         */
        public static var stdin:StandardStream = new StandardStreamIn();

        
        /**
         * Returns the program filename.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public native static function get programFilename():String;

        private static var _shell:String;

        private static function _findShell():String
        {
            var sh:String = "";

            switch( OperatingSystem.vendor )
            {
                case "Microsoft":
                sh = getenv( "COMSPEC" );
                break;

                case "Apple":
                case "Linux":
                default:
                sh = getenv( "SHELL" );
            }

            return sh;
        }

        /**
         * Returns system default shell.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function get shell():String
        {
            if( _shell ) { return _shell; }

            _shell = _findShell();
            return _shell;
        }

        /**
         * Returns the value passed to -swfversion at launch
         * (or the default value, if -swfversion was not specified).
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public native static function get swfVersion():int;

        /**
         * Amount of real memory we've aqcuired from the OS.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public native static function get totalMemory():Number;
        
        /**
         * Part of totalMemory we aren't using.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public native static function get freeMemory():Number;
        
        /**
         * Process wide size of resident private memory.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public native static function get privateMemory():Number;
        
        /**
         * Allows to get or set the current working directory of the application.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function get workingDirectory():String { return getcwd(); }

        /**
         * @private
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function set workingDirectory( value:String ):void
        {
            //TODO: deal with errors etc.
            chdir( value );
        }




        /**
         * Evaluates AS3 source code at runtime.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.1
         */
        public native static function eval( source:String ):void;

        /**
         * Executes the specified command line and returns the status code.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function exec( command:String ):int
        {
            return C.stdlib.system( command );
        }

        /**
         * Terminates the program execution.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function exit( status:int = -1 ):void
        {
            C.stdlib.exit( status );
        }

        private native static function popenRead( command:String ):String;

        /**
         * Executes the specified command line and returns the output.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function popen( command:String ):String
        {
            return popenRead( command );
        }

        /**
         * Returns the current version of AVM+ in the form "1.0 d100".
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public native static function getAvmplusVersion():String;

        /**
         * Returns the current version of the RedTamarin API.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function getRedtamarinVersion():String
        {
            return "0.3.2";
        }

        /**
         * Returns the compiled in features of AVM+.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public native static function getFeatures():String;

        /**
         * Returns the current runmode.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public native static function getRunmode():String;

        /**
         * Returns the number of milliseconds that have elapsed
         * since the AMV+ started.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public native static function getTimer():uint;

        /**
         * Waits and returns all the characters entered by the user.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public native static function readLine():String;

        /**
         * Writes arguments to the command line and returns to the line.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public native static function trace( a:Array ):void;

        /**
         * Writes a string to the command line.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public native static function write( s:String ):void;

        /**
         * Writes a string to the command line and returns to the line.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function writeLine( s:String ):void
        {
            System.write( s + "\n" );
        }

        /**
         * Returns the length of the stdin buffer.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        hack_sys native static function getStdinLength():Number;
        
        /**
         * Reads the length of <code>bytes</code> from stdin.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        hack_sys native static function stdinRead( length:uint ):ByteArray;

        /**
         * Reads the stdin till EOF is reached.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        hack_sys native static function stdinReadAll():ByteArray;

        /**
         * Writes bytes to the stdout.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        hack_sys native static function stdoutWrite( bytes:ByteArray ):void;

        /**
         * Writes bytes to the stderr.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.2
         */
        hack_sys native static function stderrWrite( bytes:ByteArray ):void;

        /**
         * Enters debugger.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public native static function debugger():void;

        /**
         * Tests if the current program is compiled with debugger flags.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public native static function isDebugger():Boolean;
        
        /**
         * Initiate a garbage collection
         * (future versions will not return before completed).
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public native static function forceFullCollection():void;
        
        /**
         * Queue a garbage collection request.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public native static function queueCollection():void;

        /**
         * Makes the specified XML object immediately available for garbage collection.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public native static function disposeXML( xml:XML ):void;

    }
    
}

