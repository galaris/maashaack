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
    import flash.geom.Matrix;

    /**
     * Use a GraphicsGradientFill object with the <code>Graphics.drawGraphicsData()</code> method.
     * Drawing a GraphicsGradientFill object is the equivalent of calling the <code>Graphics.beginGradientFill()</code> method.
     * 
     * @langversion ActionScript 3.0
     * @playerversion Flash Player 10
     * @playerversion AIR 1.5
     */
    [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
    public final class GraphicsGradientFill implements IGraphicsFill, IGraphicsData
    {

        private var _type:String;
        private var _spreadMethod:String;
        private var _interpolationMethod:String;
        
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)] public var colors:Array;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)] public var alphas:Array;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)] public var ratios:Array;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)] public var matrix:Matrix;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)] public var focalPointRatio:Number;

        public function GraphicsGradientFill( type:String = "linear", colors:Array = null, alphas:Array = null,
                                              ratios:Array = null, matrix = null, spreadMethod = "pad",
                                              interpolationMethod:String = "rgb", focalPointRatio:Number = 0 )
        {
            CFG::dbg{ trace( "new GraphicsGradientFill( " + [type,colors,alphas,ratios,matrix,spreadMethod,interpolationMethod,focalPointRatio].join(", ") + " )" ); }
            super();

            _type                = type;
            _spreadMethod        = spreadMethod;
            _interpolationMethod = interpolationMethod;
            this.colors          = colors;
            this.alphas          = alphas;
            this.ratios          = ratios;
            this.matrix          = matrix;
            this.focalPointRatio = focalPointRatio;

            if( !(_type == GradientType.LINEAR) &&
                !(_type == GradientType.RADIAL) )
            {
                Error.throwError( ArgumentError, 2008, "type" );
            }
            
            if( !(_spreadMethod == "none") &&
                !(_spreadMethod == SpreadMethod.PAD) &&
                !(_spreadMethod == SpreadMethod.REFLECT) &&
                !(_spreadMethod == SpreadMethod.REPEAT) )
            {
                Error.throwError( ArgumentError, 2008, "spreadMethod" );
            }
            
            if( !(_interpolationMethod == InterpolationMethod.LINEAR_RGB) &&
                !(_interpolationMethod == InterpolationMethod.RGB) )
            {
                Error.throwError( ArgumentError, 2008, "interpolationMethod" );
            }
        }

        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function get type():String
        {
            CFG::dbg{ trace( "GraphicsGradientFill.get type()" ); }
            return _type;
        }

        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function set type( value:String ):void
        {
            CFG::dbg{ trace( "GraphicsGradientFill.set type( " + value + " )" ); }
            if( !(value == GradientType.LINEAR) &&
                !(value == GradientType.RADIAL) )
            {
                Error.throwError( ArgumentError, 2008, "type" );
            }
            
            _type = value;
        }

        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function get spreadMethod():String
        {
            CFG::dbg{ trace( "GraphicsGradientFill.get spreadMethod()" ); }
            return _spreadMethod;
        }

        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function set spreadMethod( value:String ):void
        {
            CFG::dbg{ trace( "GraphicsGradientFill.set spreadMethod( " + value + " )" ); }
            if( !(value == "none") &&
                !(value == SpreadMethod.PAD) &&
                !(value == SpreadMethod.REFLECT) &&
                !(value == SpreadMethod.REPEAT) )
            {
                Error.throwError( ArgumentError, 2008, "spreadMethod" );
            }
            
            _spreadMethod = value;
        }

        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function get interpolationMethod():String
        {
            CFG::dbg{ trace( "GraphicsGradientFill.get interpolationMethod()" ); }
            return _interpolationMethod;
        }

        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function set interpolationMethod( value:String ):void
        {
            CFG::dbg{ trace( "GraphicsGradientFill.set interpolationMethod( " + value + " )" ); }
            if( !(value == InterpolationMethod.LINEAR_RGB) &&
                !(value == InterpolationMethod.RGB) )
            {
                Error.throwError( ArgumentError, 2008, "interpolationMethod" );
            }
            
            _interpolationMethod = value;
        }
    }
}
