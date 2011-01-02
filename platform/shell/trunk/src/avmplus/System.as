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
    import flash.utils.ByteArray;

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
         * Returns the program filename.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public native static function get programFilename():String;

        /**
         * The original directory when the application started.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static const startupDirectory:String = getStartupDirectory();

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
         * Returns the value passed to -swfversion at launch
         * (or the default value, if -swfversion was not specified).
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public native static function get swfVersion():int;
        
        /**
         * Return the value passed to -api at launch
         * (or the default value, if -api was not specified).
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public native static function get apiVersion():int;

        // Amount of real memory we've aqcuired from the OS
        public native static function get totalMemory():Number;

        // Part of totalMemory we aren't using
        public native static function get freeMemory():Number;

        // process wide size of resident private memory
        public native static function get privateMemory():Number;

        public native static function getAvmplusVersion():String;
        public native static function getFeatures():String;
        public native static function getRunmode():String;

        public native static function getTimer():uint;
        
        public native static function trace(a:Array):void;
        public native static function write(s:String):void;
        public native static function readLine():String;
        
        public native static function debugger():void;
        public native static function isDebugger():Boolean;


        // Initiate a garbage collection; future versions will not return before completed.
        public native static function forceFullCollection():void;

        // Queue a garbage collection request.
        public native static function queueCollection():void;

        public native static function disposeXML(xml:XML):void;

    }
    
}

