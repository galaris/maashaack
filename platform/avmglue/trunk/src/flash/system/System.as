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
 *   Adobe AS3 Team
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

package flash.system
{
    import avmplus.System;
    
    API::MOCK
    public final class System
    {
        //NOT IMPLEMENTED
        //private static var _IME:IME = null;
        
        private static var _clipboard:String;
        private static var _useCodePage:Boolean;
        
        public function System()
        {
        }
        
        //NOT IMPLEMENTED
        //public static function get ime():IME
        
        public static function setClipboard( string:String ):void { _clipboard = string; }
        
        public static function get totalMemory():uint { return totalMemoryNumber as uint; }
        public static function get totalMemoryNumber():Number { return 0; }
        public static function get freeMemory():Number { return 0; }
        public static function get privateMemory():Number { return 0; }
        public static function get useCodePage():Boolean { return _useCodePage; }
        public static function set useCodePage( value:Boolean ):void { _useCodePage = value; }
        public static function get vmVersion():String { return ""; }
        
        public static function pause():void {}
        public static function resume():void {}
        public static function exit( code:uint ):void {}
        public static function gc():void {}
        public static function disposeXML(node:XML):void {}
    }
    
    
    API::REDTAMARIN
    public final class System
    {
        //NOT IMPLEMENTED
        //private static var _IME:IME = null;
        
        private var _useCodePage:Boolean;
        
        public function System()
        {
        }
        
        //NOT IMPLEMENTED
        //public static function get ime():IME
        
        //NOT IMPLEMENTED
        //public static native function setClipboard(string:String):void;
        public static function setClipboard( string:String ):void {}
        
        public static function get totalMemory():uint { return totalMemoryNumber as uint; }
        
        //public static native function get totalMemoryNumber():Number;
        public static function get totalMemoryNumber():Number { return avmplus.System.totalMemory; }
        
        //public static native function get freeMemory():Number;
        public static function get freeMemory():Number { return avmplus.System.freeMemory; }
        
        //public static native function get privateMemory():Number;
        public static function get privateMemory():Number { return avmplus.System.privateMemory; }
        
        //NOT PART OF THE PUBLIC FPAPI
        //public static native function get precise_startupTime():Number;
        
        //NOT PART OF THE PUBLIC FPAPI
        //public static native function get currentTime():Number;
        
        //NOT IMPLEMENTED
        //public static native function get useCodePage():Boolean;
        public static function get useCodePage():Boolean { return _useCodePage; }
        //public static native function set useCodePage(value:Boolean):void;
        public static function set useCodePage( value:Boolean ):void { _useCodePage = value; }
        
        //public static native function get vmVersion():String;
        public static function get vmVersion():String { return avmplus.System.getAvmplusVersion(); }
        
        //NOT IMPLEMENTED
        //public static native function pause():void;
        public static function pause():void {}
        
        //NOT IMPLEMENTED
        //public static native function resume():void;
        public static function resume():void {}
        
        //public static native function exit(code:uint):void;
        public static function exit( code:uint ):void { avmplus.System.exit( code ); }
        
        //public static native function gc():void;
        public static function gc():void { avmplus.System.forceFullCollection(); }
        
        //NOT PART OF THE PUBLIC FPAPI
        //public static native function nativeConstructionOnly(object:Object):void;
        
        //public static native function disposeXML(node:XML):void;
        public static function disposeXML(node:XML):void { avmplus.System.disposeXML( node ); }
    }
}