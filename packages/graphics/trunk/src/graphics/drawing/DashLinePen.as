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
    /**
     * This pen is the basic tool to draw a dash line.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import flash.display.StageScaleMode ;
     * 
     * import graphics.LineStyle ;
     * 
     * import graphics.drawing.DashLinePen ;
     * 
     * import graphics.geom.Vector2 ;
     * 
     * stage.scaleMode = StageScaleMode.NO_SCALE ;
     * stage.align     = "" ;
     * 
     * var shape:Shape = new Shape() ;
     * 
     * shape.x = 10 ;
     * shape.y = 10 ;
     * 
     * var start:Vector2 = new Vector2(0,0) ;
     * var end:Vector2   = new Vector2(100, 100) ;
     * 
     * var pen:DashLinePen = new DashLinePen( shape , start , end , 4, 6) ;
     * pen.line            = new LineStyle( 2, 0xFFFFFF , 1 , true ) ;
     * pen.draw() ;
     * 
     * addChild( shape ) ;
     * </pre>
     */
    public class DashLinePen extends LinePen
    {
        /**
         * Creates a new DashLinePen instance.
         * @param graphic The Graphics reference to control with this helper. You can passed-in a Shape or Sprite/MovieClip reference in argument.
         * @param start The vector object to defines the start position of the drawing.
         * @param end The vector object to defines the end position of the drawing.
         * @param length The length of the dashs.
         * @param spacing The spacing between two dashs.
         */
        public function DashLinePen(graphic:* = null, start:* = null, end:* = null, length:Number = 2, spacing:Number = 2)
        {
            super(graphic);
            setPen(start, end, length, spacing) ;
        }
        
        /**
         * The default length value of the dashs in the line.
         */
        public static var DEFAULT_LENGTH:Number = 2 ;
        
        /**
         * The default spacing value of the dashs in the line.
         */
        public static var DEFAULT_SPACING:Number = 2 ;
        
        /**
         * A value representing the accuracy used in determining the length of curveTo curves.
         */
        public var curveAccuracy:Number = 6;
        
        /**
         * Determinates the length of a dash in the line.
         */
        public function get length():Number
        {
            return _length ;
        }
        
        /**
         * @private
         */
        public function set length(n:Number):void
        {
            _length = isNaN(n) ? DEFAULT_LENGTH : n ;
            _dashLength = _spacing + _length ;
        }
        
        /**
         * Determinates the spacing value between two dashs in this line.
         */
        public function get spacing():Number
        {
            return _spacing ;
        }
        
        /**
         * @private
         */
        public function set spacing(n:Number):void
        {
            _spacing = isNaN(n) ? DEFAULT_SPACING : n ;
            _dashLength = _spacing + _length ;
        }
        
        /**
         * Draws a dashed curve in a specific Graphics object using the current line style from the current drawing position to (x, y) using the control point specified by (cx, cy). 
         * The current  drawing position is then set to (x, y). 
         * @param cx An integer that specifies the horizontal position of the control point relative to the registration point of the parent movie clip.
         * @param cy An integer that specifies the vertical position of the control point relative to the registration point of the parent movie clip.
         * @param x An integer that specifies the horizontal position of the next anchor point relative to the registration. point of the parent movie clip.
         * @param y An integer that specifies the vertical position of the next anchor point relative to the registration point of the parent movie clip.
         */
        public function curveTo( cx:Number , cy:Number , x:Number , y:Number ):void 
        {
            var sx:Number = __x;
            var sy:Number = __y;
            
            var segLength:Number = _curveLength(sx, sy, cx, cy, x, y);
            
            var t:Number  = 0;
            var t2:Number = 0;
            
            var c:Array;
            
            if ( _overflow )
            {
                if ( _overflow > segLength )
                {
                    if ( _isLine ) 
                    {
                        _targetCurveTo( cx , cy , x , y );
                    }
                    else 
                    {
                        _targetMoveTo( x , y );
                    }
                    _overflow -= segLength ;
                    return;
                }
                t = _overflow / segLength ;
                c = _curveSliceUpTo(sx, sy, cx, cy, x, y, t) ;
                if ( _isLine )
                {
                    _targetCurveTo( c[2] , c[3] , c[4] , c[5] ) ;
                }
                else
                {
                    _targetMoveTo( c[4] , c[5] ) ;
                }
                _overflow = 0;
                _isLine   = !_isLine ;
                if (!segLength) 
                {
                    return;
                }
            }
            var remainLength:Number = segLength - segLength * t ;
            var count:int           = Math.floor( remainLength / _dashLength ) ;
            var ont:Number          = _length/segLength;
            var offt:Number         = _spacing/segLength;
            
            if ( count )
            {
                for ( var i:int = 0 ; i < count ; i++ )
                {
                    if (_isLine)
                    {
                        t2 = t + ont;
                        c = _curveSlice(sx, sy, cx, cy, x, y, t, t2);
                        _targetCurveTo(c[2], c[3], c[4], c[5]);
                        t = t2;
                        t2 = t + offt;
                        c = _curveSlice(sx, sy, cx, cy, x, y, t, t2);
                        _targetMoveTo(c[4], c[5]);
                    }
                    else
                    {
                        t2 = t + offt;
                        c = _curveSlice(sx, sy, cx, cy, x, y, t, t2);
                        _targetMoveTo(c[4], c[5]);
                        t = t2;
                        t2 = t + ont;
                        c = _curveSlice(sx, sy, cx, cy, x, y, t, t2);
                        _targetCurveTo(c[2], c[3], c[4], c[5]);
                    }
                    t = t2;
                }
            }
            remainLength = segLength - segLength * t ;
            if ( _isLine )
            {
                if ( remainLength > _length )
                {
                    t2 = t + ont;
                    c = _curveSlice(sx, sy, cx, cy, x, y, t, t2);
                    _targetCurveTo(c[2], c[3], c[4], c[5]);
                    _targetMoveTo(x, y);
                    _overflow = _spacing -( remainLength - _length ) ;
                    _isLine = false;
                }else{
                    c = _curveSliceFrom(sx, sy, cx, cy, x, y, t);
                    _targetCurveTo(c[2], c[3], c[4], c[5]);
                    if ( segLength == _length )
                    {
                        _overflow = 0;
                        _isLine   = !_isLine ;
                    }
                    else
                    {
                        _overflow = _length - remainLength ;
                        _targetMoveTo(x, y);
                    }
                }
            }
            else
            {
                if ( remainLength > _spacing )
                {
                    t2 = t + offt;
                    c = _curveSlice(sx, sy, cx, cy, x, y, t, t2) ;
                    _targetMoveTo(c[4], c[5]);
                    c = _curveSliceFrom(sx, sy, cx, cy, x, y, t2);
                    _targetCurveTo(c[2], c[3], c[4], c[5]);
                    _overflow = _length - ( remainLength - _spacing ) ;
                    _isLine = true ;
                }
                else
                {
                    _targetMoveTo( x, y ) ;
                    if ( remainLength == _spacing )
                    {
                        _overflow = 0;
                        _isLine   = !_isLine ;
                    }
                    else
                    {
                        _overflow = _spacing - remainLength ;
                    }
                }
            }
        }
        
        /**
         * This method contains the basic drawing shape algorithm.
         */
        public override function drawShape():void
        {
            if ( start.equals(end) )
            {
                return ;
            }
            moveTo( start.x , start.y ) ;
            lineTo( end.x   , end.y ) ;
        }
        
        /**
         * Draws a dashed line in target using the current line style from the current drawing position
         * to (x, y); the current drawing position is then set to (x, y).
         * @param x An integer indicating the horizontal position relative to the registration point of
         * the parent movie clip.
         * @param An integer indicating the vertical position relative to the registration point of the
         * parent movie clip.
         * @return nothing
         */
        public function lineTo( x:Number , y:Number ):void 
        {
            var dx:Number = x - __x ;
            var dy:Number = y - __y ;
            
            var a:Number  = Math.atan2(dy, dx) ;
            
            var ca:Number = Math.cos(a) ;
            var sa:Number = Math.sin(a) ;
            
            var segLength:Number = _lineLength( dx , dy ) ;
            
            if ( _overflow )
            {
                if ( _overflow > segLength )
                {
                    if ( _isLine ) 
                    {
                        _targetLineTo(x, y);
                    }
                    else 
                    {
                        _targetMoveTo(x, y) ;
                    }
                    _overflow -= segLength ;
                    return ;
                }
                
                if ( _isLine ) 
                {
                    _targetLineTo( __x + ca * _overflow , __y + sa * _overflow ) ;
                }
                else 
                {
                    _targetMoveTo( __x + ca * _overflow , __y + sa * _overflow );
                }
                
                segLength -= _overflow ;
                
                _isLine   = !_isLine;
                _overflow = 0;
                
                if (!segLength) 
                {
                    return;
                }
            }
            
            var count:Number = Math.floor( segLength / _dashLength );
            
            if ( count )
            {
                var onx:Number  = ca * _length ;
                var ony:Number  = sa * _length ;
                
                var offx:Number = ca * _spacing ;
                var offy:Number = sa * _spacing ;
                
                for ( var i:int ; i < count ; i++ )
                {
                    if (_isLine)
                    {
                        _targetLineTo( __x + onx  , __y + ony  ) ;
                        _targetMoveTo( __x + offx , __y + offy ) ;
                    }
                    else
                    {
                        _targetMoveTo( __x + offx , __y + offy ) ;
                        _targetLineTo( __x + onx  , __y + ony  ) ;
                    }
                }
                
                segLength -= _dashLength * count ;
            }
            
            if ( _isLine )
            {
                if (segLength > _length )
                {
                    _targetLineTo( __x +ca * _length , __y + sa * _length );
                    _targetMoveTo(x, y);
                    _overflow = _spacing - ( segLength - _length );
                    _isLine   = false;
                }
                else
                {
                    _targetLineTo(x, y);
                    if (segLength == _length)
                    {
                        _overflow = 0;
                        _isLine = !_isLine;
                    }
                    else
                    {
                        _overflow = _length - segLength ;
                        _targetMoveTo(x, y);
                    }
                }
            }
            else
            {
                if ( segLength > _spacing )
                {
                    _targetMoveTo( __x + ca * _spacing , __y + sa * _spacing ) ;
                    _targetLineTo( x , y ) ;
                    _overflow = _length - ( segLength - _spacing ) ;
                    _isLine   = true;
                } 
                else
                {
                    _targetMoveTo( x , y ) ;
                    if ( segLength == _spacing )
                    {
                        _overflow = 0 ;
                        _isLine   = !_isLine ;
                    }
                    else 
                    {
                        _overflow = _spacing - segLength ;
                    }
                }
            }
        }
        
        /**
         * Moves the current drawing position in target to (x, y).
         * @param x An integer indicating the horizontal position relative to the registration point of the parent display container.
         * @param An integer indicating the vertical position relative to the registration point of the parent display container.
         */
        public function moveTo(x:Number, y:Number):void 
        {
            _targetMoveTo( x , y ) ;
        }
        
        /**
         * Sets the arc options to defined all values to draw the arc shape in the movieclip reference of this pen.
         * @param end (optional) The end vector value (flash.geom.Point or graphics.geom.Vector2)
         * @param start (optional) The start vector value (flash.geom.Point or graphics.geom.Vector2)
         */
        public override function setPen(...args:Array):void
        {
            super.setPen.call(this, args[0], args[1]) ;
            if ( args[2] != null && args[2] is Number )
            {
                length = args[2] ;
            }
            if ( args[3] != null && args[3] is Number )
            {
                spacing = args[3] ;
            }
        }
        
        /**
         * @private
         */
        private var _dashLength:Number = 0 ;
        
        /**
         * @private
         */
        private var _isLine:Boolean = true;
        
        /**
         * @private
         */
        private var _length:Number = 2 ;
        
        /**
         * @private
         */
        private var _overflow:Number = 0;
        
        /**
         * @private
         */
        private var _spacing:Number = 2 ;
        
        /**
         * @private
         */
        private var __x:Number ;
        
        /**
         * @private
         */
        private var __y:Number ;
        
        /**
         * @private
         */
        private function _curveSlice(sx:Number, sy:Number, cx:Number, cy:Number, ex:Number, ey:Number, t1:Number, t2:Number):Array
        {
            if (t1 == 0) 
            {
                return _curveSliceUpTo(sx, sy, cx, cy, ex, ey, t2);
            }
            else if ( t2 == 1 ) 
            {
                return _curveSliceFrom(sx, sy, cx, cy, ex, ey, t1);
            }
            
            var c:Array = _curveSliceUpTo(sx, sy, cx, cy, ex, ey, t2);
            
            c.push(t1 / t2);
            
            return _curveSliceFrom.apply( this , c ) ;
        }
        
        /**
         * @private
         */
        private function _curveSliceFrom( sx:Number, sy:Number, cx:Number, cy:Number, ex:Number, ey:Number, t:Number = 0 ):Array
        {
            if (t == 0) 
            {
                t = 1 ;
            }
            if (t != 1)
            {
                var midx:Number = sx + (cx - sx) * t;
                var midy:Number = sy + (cy - sy) * t;
                
                cx = cx + (ex - cx) * t;
                cy = cy + (ey - cy) * t;
                
                sx = midx + (cx - midx) * t;
                sy = midy + (cy - midy) * t;
            }
            return [sx, sy, cx, cy, ex, ey];
        }
        
        /**
         * @private
         */
        private function _curveSliceUpTo(sx:Number, sy:Number, cx:Number, cy:Number, ex:Number, ey:Number, t:Number = 0):Array
        {
            if (t == 0) t = 1;
            if (t != 1)
            {
                var midx:Number = cx + (ex - cx) * t;
                var midy:Number = cy + (ey - cy) * t;
                
                cx = sx + (cx - sx) * t;
                cy = sy + (cy - sy) * t;
                
                ex = cx + (midx - cx) * t;
                ey = cy + (midy - cy) * t;
            }
            return [sx, sy, cx, cy, ex, ey];
        }
        
        /**
         * @private
         */
        private function _curveLength( sx:Number , sy:Number , cx:Number, cy:Number, ex:Number, ey:Number, ...args:Array ):Number
        {
            var r:Number = 0;
            
            var tx:Number = sx;
            var ty:Number = sy;
            
            var px:Number ;
            var py:Number ;
            
            var t:Number, it:Number ;
            var a:Number, b:Number, c:Number;
            
            var n:Number = (args[0] != null) ? args[0] : curveAccuracy ;
            
            for (var i:int = 1; i <= n; i++)
            {
                t  = i / n;
                it = 1 - t;
                
                a  = it * it;
                b  = 2 * t * it;
                c  = t * t;
                
                px = a * sx + b * cx + c * ex;
                py = a * sy + b * cy + c * ey;
                
                r += _lineLength( tx , ty , px , py ) ;
                
                tx = px;
                ty = py;
            }
            
            return r;
        }
        
        /**
         * @private
         */
        private function _lineLength( sx:Number , sy:Number , ...args:Array ):Number
        {
            if ( args.length == 0 )
            {
                return Math.sqrt( sx * sx + sy * sy ) ;
            }
            
            var dx:Number = Number(args[0]) - sx;
            var dy:Number = Number(args[1]) - sy;
            
            return Math.sqrt( dx * dx + dy * dy ) ;
        }
        
        /**
         * @private
         */
        private function _targetMoveTo(x:Number, y:Number):void
        {
            __x = x ;
            __y = y ;
            _graphics.moveTo( x , y ) ;
        }
        
        /**
         * @private
         */
        private function _targetLineTo(x:Number, y:Number):void
        {
            if (x == __x && y == __y ) 
            {
                return;
            }
            __x = x ;
            __y = y ;
            _graphics.lineTo( x , y ) ;
        }
        
        /**
         * @private
         */
        private function _targetCurveTo(cx:Number, cy:Number, x:Number, y:Number):void
        {
            if ( cx == x && cy == y && x == __x && y == __y ) 
            {
                return ;
            }
            __x = x ;
            __y = y ;
            _graphics.curveTo( cx , cy , x , y ) ;
        }
    }
}
