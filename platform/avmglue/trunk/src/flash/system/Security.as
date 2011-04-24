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
    public class Security
    {
        
        public static const REMOTE:String             = "remote";
        public static const LOCAL_WITH_FILE:String    = "localWithFile";
        public static const LOCAL_WITH_NETWORK:String = "localWithNetwork";
        public static const LOCAL_TRUSTED:String      = "localTrusted";
        
        [API(CONFIG::AIR_1_0)]
        public static const APPLICATION:String        = "application";
        
        private static var _exactSettings:Boolean;
        private static var _disableAVM1Loading:Boolean;
        
        public function Security()
        {
            super();
            _ctor();
        }
        
        private function _ctor():void
        {
            //TODO add a throw SecurityError if the setting change more than once ?
            _exactSettings      = false;
            _disableAVM1Loading = false;
        }
        
        //NOT PART OF THE PUBLIC FPAPI
        /*
        private static function createSandboxBridgeProxyFunction( targetFunc:Function,
                                                                  targetObj:Object,
                                                                  srcToplevel:Object,
                                                                  destToplevel:Object ):Function
        {
            var targetFunc:* = targetFunc;
            var targetObj:* = targetObj;
            var srcToplevel:* = srcToplevel;
            var destToplevel:* = destToplevel;

            return (function (... _args)
            {
                var args:* = duplicateSandboxBridgeInputArguments(srcToplevel, _args);
                var res:* = targetFunc.apply(targetObj, args);
                return (duplicateSandboxBridgeOutputArgument(destToplevel, res));
            });
        }
        */
        
        //NOT PART OF THE PUBLIC FPAPI
        //static native function duplicateSandboxBridgeInputArguments(toplevel:Object, args:Array):Array;
        //static native function duplicateSandboxBridgeOutputArgument(toplevel:Object, arg);

        public static function get exactSettings():Boolean { return _exactSettings; }
        public static function set exactSettings( value:Boolean ):void { _exactSettings = value; }
        public static function get disableAVM1Loading():Boolean { return _disableAVM1Loading; }
        public static function set disableAVM1Loading( value:Boolean ):void { _disableAVM1Loading = value; }
        
        //public static native function get sandboxType():String;
        public static function get sandboxType():String
        {
            return avmplus.System.profile.sandbox;
        }
        
        //for AIR 2.7 and FP 10.3
        //public static function get pageDomain():String
        
        public static function allowDomain( ... domains ):void {};
        public static function allowInsecureDomain( ... domains ):void {};
        public static function loadPolicyFile( url:String ):void {};
        public static function showSettings( panel:String = "default" ):void {};


    }
}