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
    import flash.geom.*;
    import flash.media.*;
    
    /**
     * The Sprite class is a basic display list building block:
     * a display list node that can display graphics and can also contain children.
     * 
     * @langversion ActionScript 3.0
     * @playerversion Flash Player 9
     * @playerversion AIR 1.0
     */
    public class Sprite extends DisplayObjectContainer
    {
        private var _graphics:Graphics;
        private var _buttonMode:Boolean;
        private var _dropTarget:DisplayObject;
        private var _hitArea:Sprite;
        private var _useHandCursor:Boolean;
        private var _soundTransform:SoundTransform;
        
        public function Sprite()
        {
            CFG::dbg{ trace( "new Sprite()" ); }
            super();

            _ctor();
        }

        //private native function constructChildren():void;
        private function constructChildren():void
        {
        
        }

        private function _ctor():void
        {
            _buttonMode    = false;
            _hitArea       = null;
            _useHandCursor = true;
            
            constructChildren();
        }

        //public native function get graphics():Graphics;
        public function get graphics():Graphics
        {
            CFG::dbg{ trace( "Sprite.get graphics()" ); }
            return _graphics;
        }

        //public native function get buttonMode():Boolean;
        public function get buttonMode():Boolean
        {
            CFG::dbg{ trace( "Sprite.get buttonMode()" ); }
            return _buttonMode;
        }

        //public native function set buttonMode( value:Boolean ):void;
        public function set buttonMode( value:Boolean ):void
        {
            CFG::dbg{ trace( "Sprite.set buttonMode( " + value + " )" ); }
            _buttonMode = value;
        }

        //public native function get dropTarget():DisplayObject;
        public function get dropTarget():DisplayObject
        {
            CFG::dbg{ trace( "Sprite.get dropTarget()" ); }
            return _dropTarget;
        }
        
        flash_api function set dropTarget( value:DisplayObject ):void
        {
            CFG::dbg{ trace( "[flash_api] Sprite.set dropTarget( " + value + " )" ); }
            _dropTarget = value;
        }

        //public native function get hitArea():Sprite;
        public function get hitArea():Sprite
        {
            CFG::dbg{ trace( "Sprite.get hitArea()" ); }
            if( _hitArea == null )
            {
                return this;
            }
            
            return _hitArea;
        }

        //public native function set hitArea( value:Sprite ):void;
        public function set hitArea( value:Sprite ):void
        {
            CFG::dbg{ trace( "Sprite.set hitArea( " + value + " )" ); }
            _hitArea = value;
        }

        //public native function get useHandCursor():Boolean;
        public function get useHandCursor():Boolean
        {
            CFG::dbg{ trace( "Sprite.get useHandCursor()" ); }
            return _useHandCursor;
        }

        //public native function set useHandCursor( value:Boolean ):void;
        public function set useHandCursor( value:Boolean ):void
        {
            CFG::dbg{ trace( "Sprite.set useHandCursor( " + value + " )" ); }
            _useHandCursor = value;
        }

        //public native function get soundTransform():SoundTransform;
        public function get soundTransform():SoundTransform
        {
            CFG::dbg{ trace( "Sprite.get soundTransform()" ); }
            return _soundTransform;
        }

        //public native function set soundTransform( value:SoundTransform ):void;
        public function set soundTransform( value:SoundTransform ):void
        {
            CFG::dbg{ trace( "Sprite.set soundTransform( " + value + " )" ); }
            _soundTransform = value;
        }

        //public native function startDrag( lockCenter:Boolean = false, bounds:Rectangle = null ):void;
        public function startDrag( lockCenter:Boolean = false, bounds:Rectangle = null ):void
        {
            CFG::dbg{ trace( "Sprite.startDrag( " + [lockCenter,bounds].join(", ") + " )" ); }
        }

        //public native function stopDrag():void;
        public function stopDrag():void
        {
            CFG::dbg{ trace( "Sprite.stopDrag()" ); }
        }

        //public native function startTouchDrag( touchPointID:int, lockCenter:Boolean = false, bounds:Rectangle = null ):void;
        [API(CONFIG::FP_10_1,CONFIG::AIR_2_0)]
        public function startTouchDrag( touchPointID:int, lockCenter:Boolean = false, bounds:Rectangle = null ):void
        {
            CFG::dbg{ trace( "Sprite.startTouchDrag( " + [touchPointID,lockCenter,bounds].join(", ") + " )" ); }
        }

        //public native function stopTouchDrag( touchPointID:int ):void;
        [API(CONFIG::FP_10_1,CONFIG::AIR_2_0)]
        public function stopTouchDrag( touchPointID:int ):void
        {
            CFG::dbg{ trace( "Sprite.stopTouchDrag( " + touchPointID + " )" ); }
        }
    }
}
