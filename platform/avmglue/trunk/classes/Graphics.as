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
    import __AS3__.vec.*;
    
    /**
     * The Graphics class contains a set of methods that you can use to create a vector shape.
     * 
     * @langversion ActionScript 3.0
     * @playerversion Flash Player 9
     * @playerversion AIR 1.0
     */
    public final class Graphics
    {

        private function drawPathObject( path:IGraphicsPath ):void
        {
            var graphicsPath:GraphicsPath;
            var graphicsTrianglePath:GraphicsTrianglePath;
            
            if( path is GraphicsPath )
            {
                graphicsPath = GraphicsPath( path );
                drawPath( graphicsPath.commands, graphicsPath.data, graphicsPath.winding );
            }
            else if( path is GraphicsTrianglePath )
            {
                graphicsTrianglePath = GraphicsTrianglePath( path );
                drawTriangles( graphicsTrianglePath.vertices, graphicsTrianglePath.indices, graphicsTrianglePath.uvtData, graphicsTrianglePath.culling );
            }
        }
        
        private function beginFillObject( fill:IGraphicsFill ):void
        {
            var solidFill:GraphicsSolidFill;
            var gradientFill:GraphicsGradientFill;
            var bitmapFill:GraphicsBitmapFill;
            var shaderFill:GraphicsShaderFill;
            
            if( fill == null )
            {
                endFill();
            }
            else if( fill is GraphicsEndFill )
            {
                endFill();
            }
            else if( fill is GraphicsSolidFill )
            {
                solidFill = GraphicsSolidFill( fill );
                beginFill( solidFill.color, solidFill.alpha );
            }
            else if( fill is GraphicsGradientFill )
            {
                gradientFill = GraphicsGradientFill( fill );
                beginGradientFill( gradientFill.type, gradientFill.colors, gradientFill.alphas, gradientFill.ratios, gradientFill.matrix,
                                   gradientFill.spreadMethod, gradientFill.interpolationMethod, gradientFill.focalPointRatio );
            }
            else if( fill is GraphicsBitmapFill )
            {
                bitmapFill = GraphicsBitmapFill( fill );
                beginBitmapFill( bitmapFill.bitmapData, bitmapFill.matrix, bitmapFill.repeat, bitmapFill.smooth );
            }
            else if( fill is GraphicsShaderFill )
            {
                shaderFill = GraphicsShaderFill( fill );
                beginShaderFill( shaderFill.shader, shaderFill.matrix );
            }
            
        }
        
        private function beginStrokeObject( istroke:IGraphicsStroke ):void
        {
            var solidFill:GraphicsSolidFill;
            var gradientFill:GraphicsGradientFill;
            var bitmapFill:GraphicsBitmapFill;
            var shaderFill:GraphicsShaderFill;
            var stroke:GraphicsStroke;
            var fill:IGraphicsFill;
            
            if( ((!((istroke == null))) && ((istroke is GraphicsStroke))) )
            {
                stroke = istroke as GraphicsStroke;
            }
            
            if( stroke && stroke.fill && (stroke.fill is IGraphicsFill) )
            {
                fill = stroke.fill;
            }
            
            if( (stroke == null) || (fill == null) )
            {
                lineStyle();
            }
            else if( fill is GraphicsSolidFill )
            {
                solidFill = GraphicsSolidFill( fill );
                lineStyle( stroke.thickness, solidFill.color, solidFill.alpha, stroke.pixelHinting, stroke.scaleMode, stroke.caps, stroke.joints, stroke.miterLimit );
            }
            else if( fill is GraphicsGradientFill )
            {
                gradientFill = GraphicsGradientFill( fill );
                lineStyle( stroke.thickness, 0, 1, stroke.pixelHinting, stroke.scaleMode, stroke.caps, stroke.joints, stroke.miterLimit );
                lineGradientStyle( gradientFill.type, gradientFill.colors, gradientFill.alphas, gradientFill.ratios, gradientFill.matrix,
                                   gradientFill.spreadMethod, gradientFill.interpolationMethod, gradientFill.focalPointRatio );
            }
            else if( fill is GraphicsBitmapFill )
            {
                bitmapFill = GraphicsBitmapFill( fill );
                lineStyle( stroke.thickness, 0, 1, stroke.pixelHinting, stroke.scaleMode, stroke.caps, stroke.joints, stroke.miterLimit );
                lineBitmapStyle( bitmapFill.bitmapData, bitmapFill.matrix, bitmapFill.repeat, bitmapFill.smooth );
            }
            else if( fill is GraphicsShaderFill )
            {
                shaderFill = GraphicsShaderFill( fill );
                lineStyle( stroke.thickness, 0, 1, stroke.pixelHinting, stroke.scaleMode, stroke.caps, stroke.joints, stroke.miterLimit );
                lineShaderStyle( shaderFill.shader, shaderFill.matrix );
            }
            
        }

        //public native function clear():void;
        public function clear():void
        {
            CFG::dbg{ trace( "Grahpics.clear()" ); }
        }

        //public native function beginFill( color:uint, alpha:Number = 1 ):void;
        public function beginFill( color:uint, alpha:Number = 1 ):void
        {
            CFG::dbg{ trace( "Grahpics.beginFill( " + [color,alpha].join(", ") + " )" ); }
        }

        //public native function beginGradientFill( type:String, colors:Array, alphas:Array, ratios:Array, matrix:Matrix = null, spreadMethod:String = "pad", interpolationMethod:String = "rgb", focalPointRatio:Number = 0 ):void;
        public function beginGradientFill( type:String, colors:Array, alphas:Array, ratios:Array, matrix:Matrix = null, spreadMethod:String = "pad", interpolationMethod:String = "rgb", focalPointRatio:Number = 0 ):void
        {
            CFG::dbg{ trace( "Grahpics.beginGradientFill( " + [type,colors,alphas,ratios,matrix,spreadMethod,interpolationMethod,focalPointRatio].join(", ") + " )" ); }
        }

        //public native function beginBitmapFill( bitmap:BitmapData, matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = false ):void;
        public function beginBitmapFill( bitmap:BitmapData, matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = false ):void
        {
            CFG::dbg{ trace( "Grahpics.beginBitmapFill( " + [bitmap,matrix,repeat,smooth].join(", ") + " )" ); }
        }

        //public native function beginShaderFill( shader:Shader, matrix:Matrix = null ):void;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function beginShaderFill( shader:Shader, matrix:Matrix = null ):void
        {
            CFG::dbg{ trace( "Grahpics.beginShaderFill( " + [shader,matrix].join(", ") + " )" ); }
        }

        //public native function lineGradientStyle( type:String, colors:Array, alphas:Array, ratios:Array, matrix:Matrix = null, spreadMethod:String = "pad", interpolationMethod:String = "rgb", focalPointRatio:Number = 0 ):void;
        public function lineGradientStyle( type:String, colors:Array, alphas:Array, ratios:Array, matrix:Matrix = null, spreadMethod:String = "pad", interpolationMethod:String = "rgb", focalPointRatio:Number = 0 ):void
        {
            CFG::dbg{ trace( "Grahpics.lineGradientStyle( " + [type,colors,alphas,ratios,matrix,spreadMethod,interpolationMethod,focalPointRatio].join(", ") + " )" ); }
        }

        //public native function lineStyle( thickness:Number=undefined, color:uint = 0, alpha:Number = 1, pixelHinting:Boolean = false, scaleMode:String = "normal", caps:String = null, joints:String = null, miterLimit:Number = 3 ):void;
        public function lineStyle( thickness:Number=undefined, color:uint = 0, alpha:Number = 1, pixelHinting:Boolean = false, scaleMode:String = "normal", caps:String = null, joints:String = null, miterLimit:Number = 3 ):void
        {
            CFG::dbg{ trace( "Grahpics.lineStyle( " + [thickness,color,alpha,pixelHinting,scaleMode,caps,joints,miterLimit].join(", ") + " )" ); }
        }

        //public native function drawRect( x:Number, y:Number, width:Number, height:Number ):void;
        public function drawRect( x:Number, y:Number, width:Number, height:Number ):void
        {
            CFG::dbg{ trace( "Grahpics.drawRect( " + [x,y,width,height].join(", ") + " )" ); }
        }

        //public native function drawRoundRect( x:Number, y:Number, width:Number, height:Number, ellipseWidth:Number, ellipseHeight:Number = undefined ):void;
        public function drawRoundRect( x:Number, y:Number, width:Number, height:Number, ellipseWidth:Number, ellipseHeight:Number = undefined ):void
        {
            CFG::dbg{ trace( "Grahpics.drawRoundRect( " + [x,y,width,height,ellipseWidth,ellipseHeight].join(", ") + " )" ); }
        }

        //public native function drawRoundRectComplex( x:Number, y:Number, width:Number, height:Number, topLeftRadius:Number, topRightRadius:Number, bottomLeftRadius:Number, bottomRightRadius:Number ):void;
        public function drawRoundRectComplex( x:Number, y:Number, width:Number, height:Number, topLeftRadius:Number, topRightRadius:Number, bottomLeftRadius:Number, bottomRightRadius:Number ):void
        {
            CFG::dbg{ trace( "Grahpics.drawRoundRectComplex( " + [x,y,width,height,topLeftRadius,topRightRadius,bottomLeftRadius,bottomRightRadius].join(", ") + " )" ); }
        }

        public function drawCircle( x:Number, y:Number, radius:Number ):void
        {
            CFG::dbg{ trace( "Grahpics.drawCircle( " + [x,y,radius].join(", ") + " )" ); }
            drawRoundRect( (x - radius), (y - radius), (radius * 2), (radius * 2), (radius * 2), (radius * 2) );
        }
        
        public function drawEllipse( x:Number, y:Number, width:Number, height:Number ):void
        {
            CFG::dbg{ trace( "Grahpics.drawEllipse( " + [x,y,width,height].join(", ") + " )" ); }
            drawRoundRect( x, y, width, height, width, height );
        }
        
        //public native function moveTo( x:Number, y:Number ):void;
        public function moveTo( x:Number, y:Number ):void
        {
            CFG::dbg{ trace( "Grahpics.moveTo( " + [x,y].join(", ") + " )" ); }
        }

        //public native function lineTo( x:Number, y:Number ):void;
        public function lineTo( x:Number, y:Number ):void
        {
            CFG::dbg{ trace( "Grahpics.lineTo( " + [x,y].join(", ") + " )" ); }
        }

        //public native function curveTo( controlX:Number, controlY:Number, anchorX:Number, anchorY:Number ):void;
        public function curveTo( controlX:Number, controlY:Number, anchorX:Number, anchorY:Number ):void
        {
            CFG::dbg{ trace( "Grahpics.curveTo( " + [controlX,controlY,anchorX,anchorY].join(", ") + " )" ); }
        }

        //public native function endFill():void;
        public function endFill():void
        {
            CFG::dbg{ trace( "Grahpics.endFill()" ); }
        }

        //public native function copyFrom( sourceGraphics:Graphics ):void;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function copyFrom( sourceGraphics:Graphics ):void
        {
            CFG::dbg{ trace( "Grahpics.copyFrom( " + sourceGraphics + " )" ); }
        }

        //public native function lineBitmapStyle( bitmap:BitmapData, matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = false ):void;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function lineBitmapStyle( bitmap:BitmapData, matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = false ):void
        {
            CFG::dbg{ trace( "Grahpics.lineBitmapStyle( " + [bitmap,matrix,repeat,smooth].join(", ") + " )" ); }
        }

        //public native function lineShaderStyle( shader:Shader, matrix:Matrix = null ):void;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function lineShaderStyle( shader:Shader, matrix:Matrix = null ):void
        {
            CFG::dbg{ trace( "Grahpics.lineShaderStyle( " + [shader,matrix].join(", ") + " )" ); }
        }

        //public native function drawPath( commands:Vector.<int>, data:Vector.<Number>, winding:String = "evenOdd" ):void;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function drawPath( commands:Vector.<int>, data:Vector.<Number>, winding:String = "evenOdd" ):void
        {
            CFG::dbg{ trace( "Grahpics.drawPath( " + [].join(", ") + " )" ); }
        }

        //public native function drawTriangles( vertices:Vector.<Number>, indices:Vector.<int> = null, uvtData:Vector.<Number> = null, culling:String = "none" ):void;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function drawTriangles( vertices:Vector.<Number>, indices:Vector.<int> = null, uvtData:Vector.<Number> = null, culling:String = "none" ):void
        {
            CFG::dbg{ trace( "Grahpics.drawTriangles( " + [vertices,indices,uvtData,culling].join(", ") + " )" ); }
        }

        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function drawGraphicsData( graphicsData:Vector.<IGraphicsData> ):void
        {
            CFG::dbg{ trace( "Grahpics.drawGraphicsData( " + graphicsData + " )" ); }
            var item:IGraphicsData;
            var path:IGraphicsPath;
            var fill:IGraphicsFill;
            var stroke:IGraphicsStroke;
            
            if( graphicsData == null ) { return; }
            
            var i:int;
            while( i < graphicsData.length )
            {
                item = graphicsData[i];
                
                if( item is IGraphicsPath )
                {
                    path = IGraphicsPath( item );
                    drawPathObject( path );
                }
                else if( item is IGraphicsFill )
                {
                    fill = IGraphicsFill( item );
                    beginFillObject( fill );
                }
                else if( item is IGraphicsStroke )
                {
                    stroke = IGraphicsStroke( item );
                    beginStrokeObject( stroke );
                }
                
                i++;
            }
        }
    
    }

}
