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

package flash.display
{
    /**
     * The NativeWindowInitOptions class defines the initialization options used
     * to construct a new NativeWindow instance.
     * 
     * @langversion ActionScript 3.0
     * @playerversion AIR 1.0
     */
    [API(CONFIG::AIR_1_0)]
    public class NativeWindowInitOptions
    {
        private var _systemChrome:String;
        private var _transparent:Boolean;
        private var _type:String;
        private var _minimizable:Boolean;
        private var _maximizable:Boolean;
        private var _resizable:Boolean;

        
        public function NativeWindowInitOptions()
        {
            CFG::dbg{ trace( "new NativeWindowInitOptions()" ); }
            super();
            
            systemChrome = NativeWindowSystemChrome.STANDARD;
            transparent  = false;
            resizable    = true;
            maximizable  = true;
            minimizable  = true;
        }

        //public native function get systemChrome():String;
        [API(CONFIG::AIR_1_0)]
        public function get systemChrome():String
        {
            CFG::dbg{ trace( "NativeWindowInitOptions.get systemChrome()" ); }
            return _systemChrome;
        }

        //public native function set systemChrome( value:String ):void;
        [API(CONFIG::AIR_1_0)]
        public function set systemChrome( value:String ):void
        {
            CFG::dbg{ trace( "NativeWindowInitOptions.set systemChrome( " + value + " )" ); }
            _systemChrome = value;
        }

        //public native function get transparent():Boolean;
        [API(CONFIG::AIR_1_0)]
        public function get transparent():Boolean
        {
            CFG::dbg{ trace( "NativeWindowInitOptions.get transparent()" ); }
            return _transparent;
        }

        //public native function set transparent( value:Boolean ):void;
        [API(CONFIG::AIR_1_0)]
        public function set transparent( value:Boolean ):void
        {
            CFG::dbg{ trace( "NativeWindowInitOptions.set transparent( " + value + " )" ); }
            _transparent = value;
        }

        //public native function get type():String;
        [API(CONFIG::AIR_1_0)]
        public function get type():String
        {
            CFG::dbg{ trace( "NativeWindowInitOptions.get type()" ); }
            return _type;
        }

        //public native function set type( value:String ):void;
        [API(CONFIG::AIR_1_0)]
        public function set type( value:String ):void
        {
            CFG::dbg{ trace( "NativeWindowInitOptions.set type( " + value + " )" ); }
            _type = value;
        }

        //public native function get minimizable():Boolean;
        [API(CONFIG::AIR_1_0)]
        public function get minimizable():Boolean
        {
            CFG::dbg{ trace( "NativeWindowInitOptions.get minimizable()" ); }
            return _minimizable;
        }

        //public native function set minimizable( value:Boolean ):void;
        [API(CONFIG::AIR_1_0)]
        public function set minimizable( value:Boolean ):void
        {
            CFG::dbg{ trace( "NativeWindowInitOptions.set minimizable( " + value + " )" ); }
            _minimizable = value;
        }

        //public native function get maximizable():Boolean;
        [API(CONFIG::AIR_1_0)]
        public function get maximizable():Boolean
        {
            CFG::dbg{ trace( "NativeWindowInitOptions.get maximizable()" ); }
            return _maximizable;
        }

        //public native function set maximizable( value:Boolean ):void;
        [API(CONFIG::AIR_1_0)]
        public function set maximizable( value:Boolean ):void
        {
            CFG::dbg{ trace( "NativeWindowInitOptions.set maximizable( " + value + " )" ); }
            _maximizable = value;
        }

        //public native function get resizable():Boolean;
        [API(CONFIG::AIR_1_0)]
        public function get resizable():Boolean
        {
            CFG::dbg{ trace( "NativeWindowInitOptions.get resizable()" ); }
            return _resizable;
        }

        //public native function set resizable( value:Boolean ):void;
        [API(CONFIG::AIR_1_0)]
        public function set resizable( value:Boolean ):void
        {
            CFG::dbg{ trace( "NativeWindowInitOptions.set resizable( " + value + " )" ); }
            _resizable = value;
        }
    }
}
