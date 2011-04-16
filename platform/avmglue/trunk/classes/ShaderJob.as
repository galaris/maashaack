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
    import avmplus.flash_api;
    import flash.events.EventDispatcher;

    /**
     * A ShaderJob instance is used to execute a shader operation in stand-alone mode.
     * 
     * @langversion ActionScript 3.0
     * @playerversion Flash Player 10
     * @playerversion AIR 1.5
     */
    [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
    public class ShaderJob extends EventDispatcher
    {
        private var _shader:Shader;
        private var _target:Object;
        private var _width:int;
        private var _height:int;
        
        private var _progress:Number;
        
        public function ShaderJob( shader:Shader = null, target:Object = null, width:int = 0, height:int = 0)
        {
            CFG::dbg{ trace( "new ShaderJob( " + [shader,target,width,height].join(", ") + " )" ); }
            super();

            _shader = shader;
            _target = target;
            _width  = width;
            _height = height;
        }

        //public native function start( waitForCompletion:Boolean = false ):void;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function start( waitForCompletion:Boolean = false ):void
        {
            CFG::dbg{ trace( "ShaderJob.start( " + waitForCompletion + " )" ); }
        }

        //public native function cancel():void;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function cancel():void
        {
            CFG::dbg{ trace( "ShaderJob.cancel()" ); }
        }

        //public native function get shader():Shader;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function get shader():Shader
        {
            CFG::dbg{ trace( "ShaderJob.get shader()" ); }
            return _shader;
        }

        //public native function set shader( value:Shader ):void;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function set shader( value:Shader ):void
        {
            CFG::dbg{ trace( "ShaderJob.set shader( " + value + " )" ); }
            _shader = value;
        }

        //public native function get target():Object;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function get target():Object
        {
            CFG::dbg{ trace( "ShaderJob.get target()" ); }
            return _target;
        }

        //public native function set target( value:Object ):void;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function set target( value:Object ):void
        {
            CFG::dbg{ trace( "ShaderJob.set target( " + value + " )" ); }
            _target = value;
        }

        //public native function get width():int;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function get width():int
        {
            CFG::dbg{ trace( "ShaderJob.get width()" ); }
            return _width;
        }

        //public native function set width( value:int ):void;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function set width( value:int ):void
        {
            CFG::dbg{ trace( "ShaderJob.set width( " + value + " )" ); }
            _width = value;
        }

        //public native function get height():int;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function get height():int
        {
            CFG::dbg{ trace( "ShaderJob.get height()" ); }
            return _height;
        }

        //public native function set height( value:int ):void;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function set height( value:int ):void
        {
            CFG::dbg{ trace( "ShaderJob.set height( " + value + " )" ); }
            _height = value;
        }

        //public native function get progress():Number;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function get progress():Number
        {
            CFG::dbg{ trace( "ShaderJob.get progress()" ); }
            return _progress;
        }

        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        flash_api function set progress( value:Number ):void
        {
            CFG::dbg{ trace( "[flash_api] ShaderJob.set progress( " + value + " )" ); }
            _progress = value;
        }
    }
}
