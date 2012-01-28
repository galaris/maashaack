/*
  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at
  http://www.mozilla.org/MPL/
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the
  License.
  
  The Original Code is [maashaack framework].
  
  The Initial Developers of the Original Code are
  Zwetan Kjukov <zwetan@gmail.com> and Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developers are Copyright (C) 2006-2012
  the Initial Developers. All Rights Reserved.
  
  Contributor(s):
  
  Alternatively, the contents of this file may be used under the terms of
  either the GNU General Public License Version 2 or later (the "GPL"), or
  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
  in which case the provisions of the GPL or the LGPL are applicable instead
  of those above. If you wish to allow use of your version of this file only
  under the terms of either the GPL or the LGPL, and not to allow others to
  use your version of this file under the terms of the MPL, indicate your
  decision by deleting the provisions above and replace them with the notice
  and other provisions required by the LGPL or the GPL. If you do not delete
  the provisions above, a recipient may use your version of this file under
  the terms of any one of the MPL, the GPL or the LGPL.
*/

package graphics.drawing 
{
    import flash.display.BitmapData;
    import flash.geom.Matrix;
    
    /**
     * This pen tesselates an area into severals triangles to allow free transform distortion on BitmapData Objects.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import graphics.drawing.DistortPen ;
     * 
     * stage.align     = "tl" ;
     * stage.scaleMode = "noScale" ;
     * 
     * var shape:Shape = new Shape() ;
     * 
     * shape.x = 0 ;
     * shape.y = 0 ;
     * 
     * addChildAt( shape , 0 ) ;
     * 
     * var bmp:BitmapData = new Girl(0,0) ; // Girl a BitmapData linked in the library of the SWF.
     * 
     * var pen:DistortPen = new DistortPen( shape, bmp.width, bmp.height, 4, 4 ) ;
     * 
     * pen.bitmapData = bmp
     * 
     * pen.draw( p1 , p2 , p3 , p4 ) ;
     * 
     * var enterFrame:Function = function (e:Event ):void
     * {
     *     pen.draw( p1, p2, p3, p4 ) ;
     * }
     * 
     * var onStartDrag:Function = function( e:Event ):void
     * {
     *     if ( e.target is MovieClip )
     *     {
     *         (e.target as MovieClip).startDrag() ;
     *         (e.target as MovieClip).addEventListener( Event.ENTER_FRAME , enterFrame ) ;
     *     }
     * }
     * 
     * var onStopDrag:Function = function( e:Event ):void
     * {
     *     if ( e.target is MovieClip )
     *     {
     *         (e.target as MovieClip).stopDrag() ;
     *         (e.target as MovieClip).removeEventListener( Event.ENTER_FRAME , enterFrame ) ;
     *     }
     * }
     * 
     * // p1, p2, p3 and p4 are 4 little anchor MovieClip in the stage of the application.
     * 
     * p1.buttonMode    = true ;
     * p1.useHandCursor = true ;
     * p1.addEventListener( MouseEvent.MOUSE_DOWN , onStartDrag ) ;
     * p1.addEventListener( MouseEvent.MOUSE_UP   , onStopDrag  ) ;
     * 
     * p2.buttonMode    = true ;
     * p2.useHandCursor = true ;
     * p2.addEventListener( MouseEvent.MOUSE_DOWN , onStartDrag ) ;
     * p2.addEventListener( MouseEvent.MOUSE_UP   , onStopDrag  ) ;
     * 
     * p3.buttonMode    = true ;
     * p3.useHandCursor = true ;
     * p3.addEventListener( MouseEvent.MOUSE_DOWN , onStartDrag ) ;
     * p3.addEventListener( MouseEvent.MOUSE_UP   , onStopDrag  ) ;
     * 
     * p4.buttonMode    = true ;
     * p4.useHandCursor = true ;
     * p4.addEventListener( MouseEvent.MOUSE_DOWN , onStartDrag ) ;
     * p4.addEventListener( MouseEvent.MOUSE_UP   , onStopDrag  ) ;
     * </pre>
     */
    public class DistortPen extends Pen
    {
        /**
         * Creates a new DistorPen instance.
         * @param graphic The Graphics reference to control with this helper. You can passed-in a Shape or Sprite/MovieClip reference in argument.
         * @param width  The width of the picture to be processed (default 0).
         * @param height The height of the picture to be processed (default 0).
         * @param hPrecision The horizontal precision value (default 2).
         * @param vPrecision The vertical precision value (default 2).
         */
        public function DistortPen( graphic:* = null , width:Number = 0, height:Number = 0, hPrecision:uint = 2, vPrecision:uint = 2 , bitmapData:BitmapData = null ):void 
        {
            super( graphic ) ;
            _bitmapData = bitmapData ;
            _w          = width  ;
            _h          = height ;
            _hseg       = hPrecision ;
            _vseg       = vPrecision ;
            init() ;
        }
        
        /**
         * Determinates the BitmapData reference of the distort pen.
         */
        public function get bitmapData():BitmapData
        {
            return _bitmapData ;
        }
        
        /**
         * @private
         */
        public function set bitmapData( bmp:BitmapData ):void
        {
            _bitmapData = bmp ;
        }
        
        /**
         * The bottom left point of the distortion.
         * <p><b>Note :</b> This point must be an object with the x and y attributes (Point, Vector2, generic object, DisplayObject, etc.</p>
         */
        public var bl:* ;
        
        /**
         * The bottom right point of the distortion.
         * <p><b>Note :</b> This point must be an object with the x and y attributes (Point, Vector2, generic object, DisplayObject, etc.</p>
         */
        public var br:* ;
        
        /**
         * Indicates the height value of the pen.
         */
        public function get height():Number 
        {
            return _h ;
        }
        
        /**
         * @private
         */
        public function set height( value:Number ):void 
        {
            _h = value ;
            init() ;
        }
        
        /**
         * Indicates the horizontal precision of the pen.
         */
        public function get hPrecision():uint 
        {
            return _hseg ;
        }
        
        /**
         * @private
         */
        public function set hPrecision( value:uint ):void 
        {
            _hseg = value ;
            init() ;
        }
        
        /**
         * Indicates whether or not use pixel smoothing render.
         */
        public var smoothing:Boolean = true ;
        
        /**
         * The top left point of the distortion.
         * <p><b>Note :</b> This point must be an object with the x and y attributes (Point, Vector2, generic object, DisplayObject, etc.</p>
         */
        public var tl:* ;
        
        /**
         * The top right point of the distortion.
         * <p><b>Note :</b> This point must be an object with the x and y attributes (Point, Vector2, generic object, DisplayObject, etc.</p>
         */
        public var tr:* ;
        
        /**
         * Indicates the vertical precision precision of the pen.
         */
        public function get vPrecision():uint 
        {
            return _vseg;
        }
        
        /**
         * @private
         */
        public function set vPrecision( value:uint ):void 
        {
            _vseg = value ;
            init() ;
        }
        
        /**
         * Determinates the width of this distort pen.
         */
        public function get width():Number 
        {
            return _w;
        }
        
        /**
         * @private
         */
        public function set width( value:Number ):void 
        {
            _w = value ;
            init() ;
        }
        
        /**
         * Draws the shape and distorts the BitmapData according to the provided Point instances and draws it into the provided Graphics.
         * @param tl The position object specifying the coordinates of the top-left corner of the distortion.
         * @param tr The position object specifying the coordinates of the top-right corner of the distortion.
         * @param br The position object specifying the coordinates of the bottom-right corner of the distortion.
         * @param bl The position object specifying the coordinates of the bottom-left corner of the distortion.
         * @param bitmapData The BitmapData object to render the shape.
         */
        public override function draw( ...args:Array):void 
        {
            if ( args.length > 0 ) 
            {
                setPen.apply( this , args ) ;
            }
            super.draw() ;
        }
        
        /**
         * This method contains the basic drawing shape algorithm.
         */
        public override function drawShape():void
        {
            if ( bl != null && br != null && tl != null && tr != null )
            {
                var dx30:Number = bl.x - tl.x ;
                var dy30:Number = bl.y - tl.y ;
                var dx21:Number = br.x - tr.x ;
                var dy21:Number = br.y - tr.y ;
                var l:int = _p.length;
                while( -- l > - 1 )
                {
                    var point:Object = _p[ l ];
                    var gx:Number = ( point.x - _xMin ) / _w ;
                    var gy:Number = ( point.y - _yMin ) / _h ;
                    var bx:Number = tl.x + gy * ( dx30 );
                    var by:Number = tl.y + gy * ( dy30 );
                    point.sx = bx + gx * ( ( tr.x + gy * ( dx21 ) ) - bx );
                    point.sy = by + gx * ( ( tr.y + gy * ( dy21 ) ) - by );
                }
                _render();
            }
        }
        
        /**
         * Sets the shape options to defined all values to draw the shape.
         * @param tl Point specifying the coordinates of the top-left corner of the distortion.
         * @param tr Point specifying the coordinates of the top-right corner of the distortion.
         * @param br Point specifying the coordinates of the bottom-right corner of the distortion.
         * @param bl Point specifying the coordinates of the bottom-left corner of the distortion.
         * @param bitmapData The BitmapData object to render the shape.
         */
        public function setPen( ...args:Array  ):void 
        {
            if ( args[0] != null )
            {
                tl = args[0];
            }
            if ( args[1] != null )
            {
                tr = args[1] ;
            }
            if ( args[2] != null )
            {
                br = args[2] ;
            }
            if ( args[3] != null )
            {
                bl = args[3] ;
            }
            if ( args[4] != null )
            {
                bitmapData = args[4] as BitmapData ;
            }
        }
        
        /**
         * Sets the precision of this distort pen instance and re-initializes the triangular grid.
         * @param hPrecision The horizontal precision.
         * @param hPrecision The vertical precision.
         */
        public function setPrecision( hPrecision:Number , vPrecision:Number ):void 
        {
            _hseg = hPrecision ;
            _vseg = vPrecision ;
            init() ;
        }
        
        /**
         * Sets the size of this pen and re-initializes the triangular grid.
         * @param width New width value.
         * @param height New height value.
         */
        public function setSize( width:Number , height:Number ):void 
        {
            _w = width ;
            _h = height ;
            init() ;
        }
        
        /**
         * @private
         */
        protected var _h:Number ;
        
        /**
         * @private
         */
        protected var _hseg:uint ;
        
        /**
         * @private
         */
        protected var _hsLen:Number ;
        
        /**
         * @private
         */
        protected var _p:Array;
        
        /**
         * @private
         */
        protected var _sMat:Matrix ;
        
        /**
         * @private
         */
        protected var _tMat:Matrix ;
        
        /**
         * @private
         */
        protected var _tri:Array;
        
        /**
         * @private
         */
        protected var _vseg:uint;
        
        /**
         * @private
         */
        protected var _vsLen:Number;
        
        /**
         * @private
         */
        protected var _w:Number;
        
        /**
         * @private
         */
        protected var _xMin:Number ;
        
        /**
         * @private
         */
        protected var _xMax:Number ;
        
        /**
         * @private
         */
        protected var _yMin:Number ;
        
        /**
         * @private
         */
        protected var _yMax:Number ;
        
        /**
         * Tesselates the area into triangles.
         */
        protected function init():void 
        {
            var ix:Number;
            var iy:Number;
            var x:Number, y:Number;
            
            _p   = [] ;
            _tri = [] ;
            
            _xMin = _yMin = 0;
            _xMax = _w; 
            _yMax = _h;
            _hsLen = _w / ( _hseg + 1 );
            _vsLen = _h / ( _vseg + 1 );
            
            for ( ix = 0 ; ix < _vseg + 2 ; ix++ )
            {
                for ( iy = 0 ; iy < _hseg + 2 ; iy++ )
                {
                    x = ix * _hsLen;
                    y = iy * _vsLen;
                    _p.push( { x: x , y: y , sx: x , sy: y } );
                }
            }
            
            for ( ix = 0 ; ix < _vseg + 1 ; ix++ )
            {
                for ( iy = 0 ; iy < _hseg + 1 ; iy++ )
                {
                    _tri.push( [ _p[ iy + ix * ( _hseg + 2 ) ] , _p[ iy + ix * ( _hseg + 2 ) + 1 ] , _p[ iy + ( ix + 1 ) * ( _hseg + 2 ) ] ] );
                    _tri.push( [ _p[ iy + ( ix + 1 ) * ( _hseg + 2 ) + 1 ] , _p[ iy + ( ix + 1 ) * ( _hseg + 2 ) ] , _p[ iy + ix * ( _hseg + 2 ) + 1 ] ] );
                }
            }
        }
        
        /**
         * Distorts the provided BitmapData and draws it onto the provided Graphics.
         * @private
         */
        protected function _render():void 
        {
            var p0:Object, p1:Object, p2:Object ;
            var a:Array;
            _sMat = new Matrix();
            _tMat = new Matrix();
            var l:int = _tri.length;
            while( -- l > - 1 )
            {
                a = _tri[ l ];
                p0 = a[0];
                p1 = a[1];
                p2 = a[2];
                
                var x0:Number = p0.sx;
                var y0:Number = p0.sy;
                var x1:Number = p1.sx;
                var y1:Number = p1.sy;
                var x2:Number = p2.sx;
                var y2:Number = p2.sy;
                var u0:Number = p0.x;
                var v0:Number = p0.y;
                var u1:Number = p1.x;
                var v1:Number = p1.y;
                var u2:Number = p2.x;
                var v2:Number = p2.y;
                
                _tMat.tx = u0;
                _tMat.ty = v0;
                _tMat.a = ( u1 - u0 ) / _w ;
                _tMat.b = ( v1 - v0 ) / _w ;
                _tMat.c = ( u2 - u0 ) / _h ;
                _tMat.d = ( v2 - v0 ) / _h ;
                _sMat.a = ( x1 - x0 ) / _w ;
                _sMat.b = ( y1 - y0 ) / _w ;
                _sMat.c = ( x2 - x0 ) / _h ;
                _sMat.d = ( y2 - y0 ) / _h ;
                _sMat.tx = x0;
                _sMat.ty = y0;
                _tMat.invert();
                _tMat.concat( _sMat );
                
                _graphics.beginBitmapFill( _bitmapData, _tMat , false , smoothing );
                _graphics.moveTo( x0, y0 );
                _graphics.lineTo( x1, y1 );
                _graphics.lineTo( x2, y2 );
                _graphics.endFill( );
            }
        }
        
        /**
         * @private
         */
        private var _bitmapData:BitmapData ;
    }
}