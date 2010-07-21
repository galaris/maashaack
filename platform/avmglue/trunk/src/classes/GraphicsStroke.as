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
     * Use a GraphicsStroke object with the <code>Graphics.drawGraphicsData()</code> method.
     * Drawing a GraphicsStroke object is the equivalent of calling one of the methods of the Graphics class
     * that sets the line style, such as the <code>Graphics.lineStyle()</code> method,
     * the <code>Graphics.lineBitmapStyle()</code> method, or the <code>Graphics.lineGradientStyle()</code> method.
     * 
     * @langversion ActionScript 3.0
     * @playerversion Flash Player 10
     * @playerversion AIR 1.5
     */
    [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
    public final class GraphicsStroke implements IGraphicsStroke, IGraphicsData
    {
        private var _scaleMode:String;
        private var _caps:String;
        private var _joints:String;
        
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)] public var thickness:Number;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)] public var pixelHinting:Boolean;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)] public var miterLimit:Number;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)] public var fill:IGraphicsFill;

        public function GraphicsStroke( thickness:Number = NaN, pixelHinting:Boolean = false, scaleMode:String = "normal",
                                        caps:String = "none", joints:String = "round", miterLimit:Number = 3,
                                        fill:IGraphicsFill = null )
        {
            CFG::dbg{ trace( "new GraphicsStroke( " + [thickness,pixelHinting,scaleMode,caps,joints,miterLimit,fill].join(", ") + " )" ); }
            super();

            _scaleMode = scaleMode;
            _caps      = caps;
            _joints    = joints;
            
            this.thickness    = thickness;
            this.pixelHinting = pixelHinting;
            this.miterLimit   = miterLimit;
            this.fill         = fill;

            if( !(_scaleMode == LineScaleMode.NORMAL) &&
                !(_scaleMode == LineScaleMode.NONE) &&
                !(_scaleMode == LineScaleMode.VERTICAL) &&
                !(_scaleMode == LineScaleMode.HORIZONTAL) )
            {
                Error.throwError( ArgumentError, 2008, "scaleMode" );
            }
            
            if( !(_caps == CapsStyle.NONE) &&
                !(_caps == CapsStyle.ROUND) &&
                !(_caps == CapsStyle.SQUARE) )
            {
                Error.throwError( ArgumentError, 2008, "caps" );
            }
            
            if( !(_joints == JointStyle.BEVEL) &&
                !(_joints == JointStyle.MITER) &&
                !(_joints == JointStyle.ROUND) )
            {
                Error.throwError( ArgumentError, 2008, "joints" );
            }
        }

        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function get scaleMode():String
        {
            CFG::dbg{ trace( "GraphicsStroke.get scaleMode()" ); }
            return _scaleMode;
        }

        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function set scaleMode( value:String ):void
        {
            CFG::dbg{ trace( "GraphicsStroke.set scaleMode( " + value + " )" ); }
            if( !(value == LineScaleMode.NORMAL) &&
                !(value == LineScaleMode.NONE) &&
                !(value == LineScaleMode.VERTICAL) &&
                !(value == LineScaleMode.HORIZONTAL) )
            {
                Error.throwError( ArgumentError, 2008, "scaleMode" );
            }
            
            _scaleMode = value;
        }

        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function get caps():String
        {
            CFG::dbg{ trace( "GraphicsStroke.get caps()" ); }
            return _caps;
        }

        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function set caps( value:String ):void
        {
            CFG::dbg{ trace( "GraphicsStroke.set caps( " + value + " )" ); }
            if( !(value == CapsStyle.NONE) &&
                !(value == CapsStyle.ROUND) &&
                !(value == CapsStyle.SQUARE) )
            {
                Error.throwError( ArgumentError, 2008, "caps" );
            }
            
            _caps = value;
        }

        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function get joints():String
        {
            CFG::dbg{ trace( "GraphicsStroke.get joints()" ); }
            return _joints;
        }

        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function set joints( value:String ):void
        {
            CFG::dbg{ trace( "GraphicsStroke.set joints( " + value + " )" ); }
            if( !(value == JointStyle.BEVEL) &&
                !(value == JointStyle.MITER) &&
                !(value == JointStyle.ROUND) )
            {
                Error.throwError( ArgumentError, 2008, "joints" );
            }
            
            _joints = value;
        }
        
    }
}
