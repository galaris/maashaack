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
    import graphics.Align;
    import graphics.geom.AspectRatio;

    import flash.display.BitmapData;
    import flash.geom.Matrix;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    /**
     * This pen scale a bitmap and divided it into a grid with nine regions, based on the scale9Grid rectangle, which defines the center region of the grid.
     * <p>Note : In this pen the fill and line styles properties are not used.</p>
     */
    public class ScalePen extends Pen 
    {
        /**
         * Creates a new ScalePen instance.
         * @param graphics The Graphics reference to control with this helper. You can passed-in a Shape or Sprite/MovieClip reference in argument.
         */
        public function ScalePen( graphics:* = null , bitmapData:BitmapData = null , width:Number = NaN , height:Number = NaN , inner:Rectangle = null , outer:Rectangle = null )
        {
            super(graphics) ;
            setup( bitmapData , width , height , inner , outer ) ;
        }
        
        /**
         * Determinates the BitmapData reference of the pen.
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
         * Indicates the height value of the pen.
         */
        public function get height():Number 
        {
            return _ratio.height ;
        }
        
        /**
         * @private
         */
        public function set height( value:Number ):void 
        {
            _ratio.height = value > 0 ? value : 0 ;
        }
        
        /**
         * Indicates the inner scale nine area of the pen.
         */
        public function get inner():Rectangle 
        {
            return _inner ;
        }
        
        /**
         * @private
         */
        public function set inner( area:Rectangle ):void 
        {
            _inner = area ;
        }
        
        /**
         * Indicates if the pen keep the aspect ratio.
         */
        public function get keepAspectRatio():Boolean
        {
            return _ratio.isLocked() ;
        }
        
        /**
         * @private
         */
        public function set keepAspectRatio( b:Boolean ):void
        {
            if ( b )
            {
                _ratio.lock() ;
            }
            else
            {
                _ratio.unlock() ;
            }
        }
        
        /**
         * Indicates the outer scale nine area of the pen.
         */
        public function get outer():Rectangle 
        {
            return _outer ;
        }
        
        /**
         * @private
         */
        public function set outer( area:Rectangle ):void 
        {
            _outer = area ;
        }
        
        /**
         * Indicates whether or not use pixel smoothing render.
         */
        public var smoothing:Boolean = true ;
        
        
        /**
         * Determinates the width of the pen.
         */
        public function get width():Number 
        {
            return _ratio.width ;
        }
        
        /**
         * @private
         */
        public function set width( value:Number ):void 
        {
            _ratio.width = value > 0 ? value : 0 ;
        }
        
        
        /**
         * Draws the shape and scale it.
         */
        public override function draw( ...args:Array):void 
        {
            if ( args.length > 0 ) 
            {
                setup.apply( this , args ) ;
            }
            if ( useClear ) 
            {
                _graphics.clear() ;
            }
            drawShape() ;
            if ( useEndFill )
            {
                _graphics.endFill() ; 
            }
        }
        
        /**
         * This method contains the basic drawing shape algorithm.
         */
        public override function drawShape():void
        {
            if ( _bitmapData )
            {
                var sw:int = _bitmapData.width  ;
                var sh:int = _bitmapData.height ;
                
                var i:int ;
                var j:int;
                
                var ox:Number = 0 ;
                var oy:Number ;
                
                var ax:Number = 0 ;
                var ay:Number = 0 ;
                
                switch( align )
                {
                    case Align.CENTER :
                    {
                        ax = _ratio.width / 2 ;                        ay = _ratio.height / 2 ;
                        break ;
                    }
                }
                
                var dx:Number = 0 ;
                var dy:Number;
                
                var dh:Number ;
                var dw:Number ;
                
                var h:Number ;
                var w:Number ;
                
                if ( _outer == null)
                {
                    _outer = new Rectangle( 0 , 0 , sw , sh ) ;
                }
                
                if ( _inner == null)
                {
                    _inner = new Rectangle( 0 , 0 , sw , sh ) ;
                }
                
                _matrix.identity() ;
                
                var widths:Array  = [ _inner.left , _inner.width , sw - _inner.right ] ;
                var heights:Array = [ _inner.top , _inner.height , sh - _inner.bottom ]  ;
                
                _size.x = _ratio.width  - widths[0]  - widths[2]  ;
                _size.y = _ratio.height - heights[0] - heights[2] ;
                
                for (i = 0 ; i < 3 ; i++ )
                {
                    w  = widths[i] ;
                    dw = ( i == 1 ) ? _size.x : widths[i] ;
                    dy = oy = 0  ;
                    for ( j = 0; j < 3 ; j++ )
                    {
                        h  = heights[j];
                        dh = ( j == 1 ) ? _size.y : heights[j];
                        if (dw > 0 && dh > 0)
                        {
                            _matrix.a  = dw / w ;
                            _matrix.d  = dh / h ;
                            _matrix.tx = -ox * _matrix.a + dx  ;
                            _matrix.ty = -oy * _matrix.d + dy  ;
                            _matrix.translate( -_outer.left , -_outer.top ) ;
                            _graphics.beginBitmapFill( _bitmapData, _matrix, false, smoothing ) ;
                            _graphics.drawRect( dx - _outer.left , dy - _outer.top , dw , dh ) ;
                        }
                        oy += h ;
                        dy += dh ;
                    }
                    ox += w ;
                    dx += dw ;
                }
            }
            else
            {
                //
            }
        }
        
        /**
         * Sets the pen options to defined all values to draw the shape.
         */
        public function setup( bitmap:BitmapData = null , width:Number = NaN , height:Number = NaN , inner:Rectangle = null , outer:Rectangle = null ):void 
        {
            _bitmapData = bitmap ;
            this.width  = ( isNaN(width) )  ? _bitmapData.width  : width  ;
            this.height = ( isNaN(height) ) ? _bitmapData.height : height ;
            _inner      = inner ;
            _outer      = outer ;
        }
        
        /**
         * Sets the width and height properties of the pen.
         */
        public function setSize( width:Number = 0 , height:Number = 0 ):void 
        {
            this.width  = width ;
            this.height = height ;
        }
        
        /**
         * @private
         */
        protected var _ratio:AspectRatio = new AspectRatio() ;
        
        /**
         * @private
         */
        protected var _bitmapData:BitmapData ;
        
        /**
         * @private
         */
        public var _inner:Rectangle ;
        
        /**
         * @private
         */
        public var _outer:Rectangle ;
        
        /**
         * @private
         */
        private var _size:Point = new Point() ;
        
        /**
         * @private
         */
        private var _matrix:Matrix = new Matrix() ;
    }
}