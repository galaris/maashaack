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
    import flash.filters.*;
    import flash.utils.*;
    import __AS3__.vec.*;

    /**
     * The BitmapData class lets you work with the data (pixels) of a Bitmap object.
     * 
     * @langversion ActionScript 3.0
     * @playerversion Flash Player 9
     * @playerversion AIR 1.0
     */
    public class BitmapData implements IBitmapDrawable
    {

        private var _width;
        private var _height;
        private var _transparent:Boolean;
        private var _fillColor:uint;
        
        public function BitmapData( width:int, height:int, transparent:Boolean = true, fillColor:uint = 0xFFFFFFFF )
        {
            CFG::dbg{ trace( "new BitmapData( " + [width,height,transparent,fillColor].join(", ") + " )" ); }
            super();

            ctor( width, height, transparent, fillColor );
        }

        private native function ctor( width:int, height:int, transparent:Boolean, fillColor:uint ):void;
        {
            _width       = width;
            _height      = height;
            _transparent = transparent;
            _fillColor   = fillColor;
        }

        //public native function clone():BitmapData;
        public function clone():BitmapData
        {
            CFG::dbg{ trace( "BitmapData.clone()" ); }
            return this;
        }

        //public native function get width():int;
        public function get width():int
        {
            CFG::dbg{ trace( "BitmapData.get width()" ); }
            return _width;
        }

        //public native function get height():int;
        public function get height():int
        {
            CFG::dbg{ trace( "BitmapData.get height()" ); }
            return _height;
        }

        //public native function get transparent():Boolean;
        public function get transparent():Boolean
        {
            CFG::dbg{ trace( "BitmapData.get transparent()" ); }
            return _transparent;
        }

        public function get rect():Rectangle
        {
            CFG::dbg{ trace( "BitmapData.get rect()" ); }
            return new Rectangle( 0, 0, width, height );
        }
        
        //public native function getPixel( x:int, y:int ):uint;
        public function getPixel( x:int, y:int ):uint
        {
            CFG::dbg{ trace( "BitmapData.getPixel( " + [x,y].join(", ") +" )" ); }
            return 0;
        }

        //public native function getPixel32( x:int, y:int ):uint;
        public function getPixel32( x:int, y:int ):uint
        {
            CFG::dbg{ trace( "BitmapData.getPixel32( " + [x,y].join(", ") +" )" ); }
            return 0;
        }

        //public native function setPixel( x:int, y:int, color:uint ):void;
        public function setPixel( x:int, y:int, color:uint ):void
        {
            CFG::dbg{ trace( "BitmapData.setPixel( " + [x,y,color].join(", ") + " )" ); }
        }

        //public native function setPixel32( x:int, y:int, color:uint ):void;
        public function setPixel32( x:int, y:int, color:uint ):void
        {
            CFG::dbg{ trace( "BitmapData.setPixel32( " + [x,y,color].join(", ") + " )" ); }
        }

        //public native function applyFilter( sourceBitmapData:BitmapData, sourceRect:Rectangle, destPoint:Point, filter:BitmapFilter ):void;
        public function applyFilter( sourceBitmapData:BitmapData, sourceRect:Rectangle, destPoint:Point, filter:BitmapFilter ):void
        {
            CFG::dbg{ trace( "BitmapData.applyFilter( " + [sourceBitmapData,sourceRect,destPoint,filter].join(", ") + " )" ); }
        }

        //public native function colorTransform( rect:Rectangle, colorTransform:ColorTransform ):void;
        public function colorTransform( rect:Rectangle, colorTransform:ColorTransform ):void
        {
            CFG::dbg{ trace( "BitmapData.colorTransform( " + [rect,colorTransform].join(", ") + " )" ); }
        }

        //public native function compare( otherBitmapData:BitmapData ):Object;
        public function compare( otherBitmapData:BitmapData ):Object
        {
            CFG::dbg{ trace( "BitmapData.compare( " + otherBitmapData + " )" ); }
            return null;
        }

        //public native function copyChannel( sourceBitmapData:BitmapData, sourceRect:Rectangle, destPoint:Point, sourceChannel:uint, destChannel:uint ):void;
        public function copyChannel( sourceBitmapData:BitmapData, sourceRect:Rectangle, destPoint:Point, sourceChannel:uint, destChannel:uint ):void
        {
            CFG::dbg{ trace( "BitmapData.copyChannel( " + [sourceBitmapData,sourceRect,destPoint,sourceChannel,destChannel].join(", ") + " )" ); }
        }

        //public native function copyPixels( sourceBitmapData:BitmapData, sourceRect:Rectangle, destPoint:Point, alphaBitmapData:BitmapData = null, alphaPoint:Point = null, mergeAlpha:Boolean = false ):void;
        public function copyPixels( sourceBitmapData:BitmapData, sourceRect:Rectangle, destPoint:Point, alphaBitmapData:BitmapData = null, alphaPoint:Point = null, mergeAlpha:Boolean = false ):void
        {
            CFG::dbg{ trace( "BitmapData.copyPixels( " + [sourceBitmapData,sourceRect,destPoint,alphaBitmapData,alphaPoint,mergeAlpha].join(", ") + " )" ); }
        }

        //public native function dispose():void;
        public function dispose():void
        {
            CFG::dbg{ trace( "BitmapData.dispose()" ); }
        }

        //public native function draw( source:IBitmapDrawable, matrix:Matrix = null, colorTransform:ColorTransform = null, blendMode:String = null, clipRect:Rectangle = null, smoothing:Boolean = false ):void;
        public function draw( source:IBitmapDrawable, matrix:Matrix = null, colorTransform:ColorTransform = null, blendMode:String = null, clipRect:Rectangle = null, smoothing:Boolean = false ):void
        {
            CFG::dbg{ trace( "BitmapData.draw( " + [source,matrix,colorTransform,blendMode,clipRect,smoothing].join(", ") + " )" ); }
        }

        //public native function fillRect( rect:Rectangle, color:uint ):void;
        public function fillRect( rect:Rectangle, color:uint ):void
        {
            CFG::dbg{ trace( "BitmapData.fillRect( " + [rect,color].join(", ") + " )" ); }
        }

        //public native function floodFill( x:int, y:int, color:uint ):void;
        public function floodFill( x:int, y:int, color:uint ):void
        {
            CFG::dbg{ trace( "BitmapData.floodFill( " + [x,y,color].join(", ") + " )" ); }
        }

        //public native function generateFilterRect( sourceRect:Rectangle, filter:BitmapFilter ):Rectangle;
        public function generateFilterRect( sourceRect:Rectangle, filter:BitmapFilter ):Rectangle
        {
            CFG::dbg{ trace( "BitmapData.generateFilterRect( " + [sourceRect,filter].join(", ") + " )" ); }
            return new Rectangle();
        }

        //public native function getColorBoundsRect( mask:uint, color:uint, findColor:Boolean = true ):Rectangle;
        public function getColorBoundsRect( mask:uint, color:uint, findColor:Boolean = true ):Rectangle
        {
            CFG::dbg{ trace( "BitmapData.getColorBoundsRect( " + [mask,color,findColor].join(", ") + " )" ); }
            return new Rectangle();
        }

        //public native function getPixels( rect:Rectangle ):ByteArray;
        public function getPixels( rect:Rectangle ):ByteArray
        {
            CFG::dbg{ trace( "BitmapData.getPixels( " + rect + " )" ); }
            return new ByteArray();
        }

        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function getVector( rect:Rectangle ):Vector.<uint>
        {
            CFG::dbg{ trace( "BitmapData.getVector( " + rect + " )" ); }
            var imgR:Rectangle = rect;

            if( rect == null )
            {
                Error.throwError( TypeError, 2007, "rect" );
            }
            
            var r:Rectangle     = imgR.intersection( rect );
            var width:int       = r.width;
            var height:int      = r.height;
            var v:Vector.<uint> = new Vector.<uint>( (width * height) );
            
            _getVector( v, r.x, r.y, r.width, r.height );
            return v;
        }

        //private native function _getVector( v:Vector.<uint>, x:int, y:int, width:int, height:int ):void;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        private native function _getVector( v:Vector.<uint>, x:int, y:int, width:int, height:int ):void
        {
            
        }

        //public native function hitTest( firstPoint:Point, firstAlphaThreshold:uint, secondObject:Object, secondBitmapDataPoint:Point = null, secondAlphaThreshold:uint = 1 ):Boolean;
        public function hitTest( firstPoint:Point, firstAlphaThreshold:uint, secondObject:Object, secondBitmapDataPoint:Point = null, secondAlphaThreshold:uint = 1 ):Boolean
        {
            CFG::dbg{ trace( "BitmapData.hitTest( " + [firstPoint,firstAlphaThreshold,secondObject,secondBitmapDataPoint,secondAlphaThreshold].join(", ") + " )" ); }
            return false;
        }

        //public native function merge( sourceBitmapData:BitmapData, sourceRect:Rectangle, destPoint:Point, redMultiplier:uint, greenMultiplier:uint, blueMultiplier:uint, alphaMultiplier:uint ):void;
        public function merge( sourceBitmapData:BitmapData, sourceRect:Rectangle, destPoint:Point, redMultiplier:uint, greenMultiplier:uint, blueMultiplier:uint, alphaMultiplier:uint ):void
        {
            CFG::dbg{ trace( "BitmapData.merge( " + [sourceBitmapData,sourceRect,destPoint,redMultiplier,greenMultiplier,blueMultiplier,alphaMultiplier].join(", ") + " )" ); }
        }

        //public native function noise( randomSeed:int, low:uint = 0, high:uint = 0xFF, channelOptions:uint = 7, grayScale:Boolean = false ):void;
        public function noise( randomSeed:int, low:uint = 0, high:uint = 0xFF, channelOptions:uint = 7, grayScale:Boolean = false ):void
        {
            CFG::dbg{ trace( "BitmapData.noise( " + [randomSeed,low,high,channelOptions,grayScale].join(", ") + " )" ); }
        }

        //public native function paletteMap( sourceBitmapData:BitmapData, sourceRect:Rectangle, destPoint:Point, redArray:Array = null, greenArray:Array = null, blueArray:Array = null, alphaArray:Array = null ):void;
        public function paletteMap( sourceBitmapData:BitmapData, sourceRect:Rectangle, destPoint:Point, redArray:Array = null, greenArray:Array = null, blueArray:Array = null, alphaArray:Array = null ):void
        {
            CFG::dbg{ trace( "BitmapData.paletteMap( " + [sourceBitmapData,sourceRect,destPoint,redArray,greenArray,blueArray,alphaArray].join(", ") + " )" ); }
        }

        //public native function perlinNoise( baseX:Number, baseY:Number, numOctaves:uint, randomSeed:int, stitch:Boolean, fractalNoise:Boolean, channelOptions:uint = 7, grayScale:Boolean = false, offsets:Array = null ):void;
        public function perlinNoise( baseX:Number, baseY:Number, numOctaves:uint, randomSeed:int, stitch:Boolean, fractalNoise:Boolean, channelOptions:uint = 7, grayScale:Boolean = false, offsets:Array = null ):void
        {
            CFG::dbg{ trace( "BitmapData.perlinNoise( " + [baseX,baseY,numOctaves,randomSeed,stitch,fractalNoise,channelOptions,grayScale,offsets].join(", ") + " )" ); }
        }

        //public native function pixelDissolve( sourceBitmapData:BitmapData, sourceRect:Rectangle, destPoint:Point, randomSeed:int = 0, numPixels:int = 0, fillColor:uint = 0 ):int;
        public function pixelDissolve( sourceBitmapData:BitmapData, sourceRect:Rectangle, destPoint:Point, randomSeed:int = 0, numPixels:int = 0, fillColor:uint = 0 ):int
        {
            CFG::dbg{ trace( "BitmapData.pixelDissolve( " + [sourceBitmapData,sourceRect,destPoint,randomSeed,numPixels,fillColor].join(", ") + " )" ); }
            return 0;
        }

        //public native function scroll( x:int, y:int ):void;
        public function scroll( x:int, y:int ):void
        {
            CFG::dbg{ trace( "BitmapData.scroll( " + [x,y].join(", ") + " )" ); }
        }

        //public native function setPixels( rect:Rectangle, inputByteArray:ByteArray ):void;
        public function setPixels( rect:Rectangle, inputByteArray:ByteArray ):void
        {
            CFG::dbg{ trace( "BitmapData.setPixels( " + [rect,inputByteArray].join(", ") + " )" ); }
        }

        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function setVector( rect:Rectangle, inputVector:Vector.<uint> ):void
        {
            CFG::dbg{ trace( "BitmapData.setVector( " + [rect,inputVector].join(", ") + " )" ); }
            var imgR:Rectangle = rect;
            if( rect == null )
            {
                Error.throwError( TypeError, 2007, "rect" );
            }
            
            if( inputVector == null )
            {
                Error.throwError( TypeError, 2007, "inputVector" );
            }
            
            var r:Rectangle = imgR.intersection( rect );
            var width:int   = r.width;
            var height:int  = r.height;

            if( (width * height) > inputVector.length )
            {
                Error.throwError( RangeError, 1125, ((width * height) - 1), inputVector.length );
            }
            
            _setVector( inputVector, r.x, r.y, r.width, r.height );
        }

        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        //private native function _setVector( inputVector:Vector.<uint>, x:int, y:int, width:int, height:int ):void;
        private native function _setVector( inputVector:Vector.<uint>, x:int, y:int, width:int, height:int ):void
        {
        
        }

        //public native function threshold( sourceBitmapData:BitmapData, sourceRect:Rectangle, destPoint:Point, operation:String, threshold:uint, color:uint = 0, mask:uint = 0xFFFFFFFF, copySource:Boolean = false ):uint;
        public function threshold( sourceBitmapData:BitmapData, sourceRect:Rectangle, destPoint:Point, operation:String, threshold:uint, color:uint = 0, mask:uint = 0xFFFFFFFF, copySource:Boolean = false ):uint
        {
            CFG::dbg{ trace( "BitmapData.threshold( " + [sourceBitmapData,sourceRect,destPoint,operation,threshold,color,mask,copySource].join(", ") + " )" ); }
            return 0;
        }

        //public native function lock():void;
        public function lock():void
        {
            CFG::dbg{ trace( "BitmapData.lock()" ); }
        }

        //public native function unlock( changeRect:Rectangle = null ):void;
        public native function unlock( changeRect:Rectangle = null ):void
        {
            CFG::dbg{ trace( "BitmapData.unlock( " + changeRect + " )" ); }
        }

        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        //public native function histogram( hRect:Rectangle = null ):Vector.<Vector.<Number>>;
        public native function histogram( hRect:Rectangle = null ):Vector.<Vector.<Number>>
        {
            CFG::dbg{ trace( "BitmapData.histogram( " + hRect + " )" ); }
            return null;
        }
    }
}
