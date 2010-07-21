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
     * The SimpleButton class lets you control all instances of button symbols in a SWF file.
     * 
     * @langversion ActionScript 3.0
     * @playerversion Flash Player 9
     * @playerversion AIR 1.0
     */
    public class SimpleButton extends InteractiveObject
    {
        private var _useHandCursor:Boolean;
        private var _enabled:Boolean;
        private var _trackAsMenu:Boolean;
        private var _soundTransform:SoundTransform;
    
        private var _upState:DisplayObject;
        private var _overState:DisplayObject;
        private var _downState:DisplayObject;
        private var _hitTestState:DisplayObject;

        public function SimpleButton( upState:DisplayObject = null, overState:DisplayObject = null,
                                      downState:DisplayObject = null, hitTestState:DisplayObject = null )
        {
            CFG::dbg{ trace( "new SimpleButton( " + [upState,overState,downState,hitTestState].join(", ") + " )" ); }
            super();

            if( upState )      { this.upState      = upState; }
            if( overState )    { this.overState    = overState; }
            if( downState )    { this.downState    = downState; }
            if( hitTestState ) { this.hitTestState = hitTestState; }

            _ctor();
            _updateButton();
        }

        //private native function _updateButton():void;
        private function _updateButton():void
        {
        
        }

        private function _ctor():void
        {
            _useHandCursor = true;
            _enabled       = true;
            _trackAsMenu   = false;
        }

        //public native function get useHandCursor():Boolean;
        public function get useHandCursor():Boolean
        {
            CFG::dbg{ trace( "SimpleButton.get useHandCursor()" ); }
            return _useHandCursor;
        }

        //public native function set useHandCursor( value:Boolean ):void;
        public function set useHandCursor( value:Boolean ):void
        {
            CFG::dbg{ trace( "SimpleButton.set useHandCursor( " + value + " )" ); }
            _useHandCursor = value;
        }

        //public native function get enabled():Boolean;
        public function get enabled():Boolean
        {
            CFG::dbg{ trace( "SimpleButton.get enabled()" ); }
            return _enabled;
        }

        //public native function set enabled( value:Boolean ):void;
        public function set enabled( value:Boolean ):void
        {
            CFG::dbg{ trace( "SimpleButton.set enabled( " + value + " )" ); }
            _enabled = true;
        }

        //public native function get trackAsMenu():Boolean;
        public function get trackAsMenu():Boolean
        {
            CFG::dbg{ trace( "SimpleButton.get trackAsMenu()" ); }
            return _trackAsMenu;
        }

        //public native function set trackAsMenu( value:Boolean ):void;
        public function set trackAsMenu( value:Boolean ):void
        {
            CFG::dbg{ trace( "SimpleButton.set trackAsMenu( " + value + " )" ); }
            _trackAsMenu = value;
        }

        //public native function get soundTransform():SoundTransform;
        public function get soundTransform():SoundTransform
        {
            CFG::dbg{ trace( "SimpleButton.get soundTransform()" ); }
            return _soundTransform;
        }

        //public native function set soundTransform( value:SoundTransform ):void;
        public function set soundTransform( value:SoundTransform ):void
        {
            CFG::dbg{ trace( "SimpleButton.set soundTransform( " + value + " )" ); }
            _soundTransform = value;
        }


        //public native function get upState():DisplayObject;
        public function get upState():DisplayObject
        {
            CFG::dbg{ trace( "SimpleButton.get upState()" ); }
            return _upState;
        }

        //public native function set upState( value:DisplayObject ):void;
        public function set upState( value:DisplayObject ):void
        {
            CFG::dbg{ trace( "SimpleButton.set upState( " + value + " )" ); }
            _upState = value;
            _updateButton();
        }

        //public native function get overState():DisplayObject;
        public function get overState():DisplayObject
        {
            CFG::dbg{ trace( "SimpleButton.get overState()" ); }
            return _overState;
        }

        //public native function set overState( value:DisplayObject ):void;
        public function set overState( value:DisplayObject ):void
        {
            CFG::dbg{ trace( "SimpleButton.set overState( " + value + " )" ); }
            _overState = value;
            _updateButton();
        }

        //public native function get downState():DisplayObject;
        public function get downState():DisplayObject
        {
            CFG::dbg{ trace( "SimpleButton.get downState()" ); }
            return _downState;
        }

        //public native function set downState( value:DisplayObject ):void;
        public function set downState( value:DisplayObject ):void
        {
            CFG::dbg{ trace( "SimpleButton.set downState( " + value + " )" ); }
            _downState = value;
            _updateButton();
        }

        //public native function get hitTestState():DisplayObject;
        public function get hitTestState():DisplayObject
        {
            CFG::dbg{ trace( "SimpleButton.get hitTestState()" ); }
            return _hitTestState;
        }

        //public native function set hitTestState( value:DisplayObject ):void;
        public function set hitTestState( value:DisplayObject ):void
        {
            CFG::dbg{ trace( "SimpleButton.set hitTestState( " + value + " )" ); }
            _hitTestState = value;
            _updateButton();
        }
        
    }
}
