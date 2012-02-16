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
    import system.hack;
    
    use namespace hack ;
    
    /**
     * Draws a dash rounded rectangle. You can set the corner radius of the rectangle with the top left, top right, bottom left and bottom right corner.
     * <p><b>Example :</b>></p>
     * <pre class="prettyprint">
     * import graphics.Align ;
     * import graphics.Corner ;
     * import graphics.FillStyle ;
     * import graphics.LineStyle ;
     * 
     * import graphics.drawing.DashRoundedRectanglePen ;
     * 
     * import flash.display.Shape ;
     * 
     * var shape:Shape = new Shape() ;
     * 
     * shape.x = 740 / 2 ;
     * shape.y = 420 / 2 ;
     * 
     * addChild( shape ) ;
     * 
     * var pen:DashRoundedRectanglePen = new DashRoundedRectanglePen( shape , 0 , 0 , 200 , 200 ) ;
     * 
     * pen.align = Align.CENTER ;
     * pen.fill  = new FillStyle( 0xEDC798 , 0.8 ) ;
     * pen.line  = new LineStyle( 2, 0xFFFFFF , 1 ) ;
     * 
     * pen.bottomLeftRadius  = 12 ;
     * pen.bottomRightRadius = 0 ;
     * pen.topLeftRadius     = 12 ;
     * pen.topRightRadius    = 12 ;
     * 
     * pen.length  = 8 ;
     * pen.spacing = 6 ;
     * 
     * pen.draw() ;
     * 
     * stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
     * 
     * function keyDown( e:KeyboardEvent ):void
     * {
     *     var code:uint = e.keyCode ;
     *     switch( code )
     *     {
     *         case Keyboard.LEFT :
     *         {
     *             pen.cornerRadius = 22 ;
     *             pen.align = Align.LEFT ;
     *             break ;
     *         }
     *         case Keyboard.RIGHT :
     *         {
     *             pen.cornerRadius = NaN ;
     *             pen.align = Align.RIGHT ;
     *             break ;
     *         }
     *         case Keyboard.UP :
     *         {
     *             pen.corner = new Corner(false, false, false, false) ;
     *             break ;
     *         }
     *         case Keyboard.DOWN :
     *         {
     *             pen.corner = new Corner() ;
     *             break ;
     *         }
     *     }
     *     pen.draw() ;
     * }
     * </pre>
     */
    public class DashRoundedRectanglePen extends RoundedComplexRectanglePen
    {
        /**
         * Creates a new DashRoundedRectangle instance.
         * @param graphic The Graphics reference to control with this helper. You can passed-in a Shape or Sprite/MovieClip reference in argument.
         * @param x (optional) The x position of the pen. (default 0)
         * @param y (optional) The y position of the pen. (default 0)
         * @param width (optional) The width of the pen. (default 0)
         * @param height (optional) The height of the pen. (default 0)
         * @param topLeftRadius (optional) The radius of the upper-left corner, in pixels. (default 0)
         * @param topRightRadius (optional) The radius of the upper-right corner, in pixels. (default 0)
         * @param bottomLeftRadius (optional) The radius of the bottom-left corner, in pixels. (default 0)
         * @param bottomRightRadius (optional) The radius of the bottom-right corner, in pixels. (default 0)
         * @param align (optional) The align value of the pen. (default Align.TOP_LEFT)
         */
        public function DashRoundedRectanglePen(graphic:* = null, x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0, length:Number = 4 , spacing:Number = 4 , topLeftRadius:Number = 0, topRightRadius:Number = 0, bottomLeftRadius:Number = 0, bottomRightRadius:Number = 0, align:uint = 10)
        {
            super( graphic, x, y, width, height, topLeftRadius, topRightRadius, bottomLeftRadius, bottomRightRadius, align );
            this.length  = length ;
            this.spacing = spacing ;
        }
        
        /**
         * @private
         */
        public override function set graphics( value:* ):void
        {
            super.graphics = value ;
            _dashline.graphics = _graphics ;
        }
        
        /**
         * Determinates the length of a dash in the line.
         */
        public function get length():Number 
        {
            return _dashline.length ;
        }
        
        /**
         * @private
         */
        public function set length( value:Number):void 
        {
            _dashline.length = value ;
        }
        
        /**
         * Determinates the spacing value between two dashs in this line.
         */
        public function get spacing():Number 
        {
            return _dashline.spacing ;
        }
        
        /**
         * @private
         */
        public function set spacing( value:Number ):void 
        {
            _dashline.spacing = value ;
        }
        
        /**
         * This method contains the basic drawing shape algorithm.
         */
        public override function drawShape():void
        {
            _refreshAlign() ;
            
            var off:Number  = 0.6 ;
            var circ:Number = 0.707107 ;
            
            var inv1:Number = 1 - off ;
            var inv2:Number = 1 - circ ;
            
            var tl:Number = corner.tl ? ( isNaN(_cornerRadius) ? _topLeftRadius     : _cornerRadius ) : 0 ; 
            var tr:Number = corner.tr ? ( isNaN(_cornerRadius) ? _topRightRadius    : _cornerRadius ) : 0 ; 
            var bl:Number = corner.bl ? ( isNaN(_cornerRadius) ? _bottomLeftRadius  : _cornerRadius ) : 0 ; 
            var br:Number = corner.br ? ( isNaN(_cornerRadius) ? _bottomRightRadius : _cornerRadius ) : 0 ;
            
            _dashline.moveTo( _x , _y + tl ) ; 
            
            if( bl == 0 )
            {
                _dashline.lineTo( _x , _y + height ) ;
            }
            else
            {
                _dashline.lineTo( _x , _y + height - bl ) ;
                _dashline.curveTo( _x , _y + ( height - bl ) + bl * inv1 , _x + inv2 * bl , _y + height - inv2 *bl ) ;
                _dashline.curveTo( _x + bl - bl * inv1 , _y + height , _x + bl , _y + height ) ;
            }
            
            if( br == 0 )
            {
                _dashline.lineTo( _x + width , _y + height ) ;
            }
            else
            {
                _dashline.lineTo( _x + width - br , _y + height ) ;
                _dashline.curveTo( _x + ( width - br ) + br * inv1 , _y + height , _x + width - inv2 * br , _y + height - inv2 * br ) ;
                _dashline.curveTo( _x + width , _y + ( height - br ) + br * inv1 , _x + width , _y + height -br ) ;
            }
            
            if( tr == 0 )
            {
                _dashline.lineTo( _x + width , _y ) ;
            }
            else
            {
                _dashline.lineTo( _x + width , _y + tr ) ;
                _dashline.curveTo( _x + width , _y + tr - tr * inv1 , _x + width - inv2 * tr , _y + inv2 *tr ) ;
                _dashline.curveTo( _x + ( width - tr ) + tr * inv1 , _y , _x + width - tr , _y ) ;
            }
            
            if( tl == 0 )
            {
                _dashline.lineTo( _x , _y ) ;
            }
            else
            {
                _dashline.lineTo( _x + tl , _y ) ;
                _dashline.curveTo( _x + tl - tl * inv1 , _y , _x + inv2 * tl , _y + inv2 * tl ) ;
                _dashline.curveTo( _x , _y + tl - tl * inv1 , _x , _y + tl );
            }
        }
        
        /**
         * Sets the shape options to defined all values to draw the shape.
         * @param x (optional) The x position of the pen.
         * @param y (optional) The y position of the pen.
         * @param width (optional) The width of the pen.
         * @param height (optional) The height of the pen.
         * @param topLeftRadius (optional) The radius of the upper-left corner, in pixels.
         * @param topRightRadius (optional) The radius of the upper-right corner, in pixels.
         * @param bottomLeftRadius (optional) The radius of the bottom-left corner, in pixels.
         * @param bottomRightRadius (optional) The radius of the bottom-right corner, in pixels.
         * @param align (optional) The align value of the pen.
         * @param length (optional) The length of the dash line.
         * @param spacing (optional) The spacing between the dashs.
         */
        public override function setPen( ...args:Array  ):void 
        {
            if( args[9] != null && args[9] is Number )
            {
                this.length = isNaN( args[9] ) ? 0 : args[9] ;
            }
            if( args[10] != null && args[10] is Number )
            {
                this.spacing = isNaN( args[10] ) ? 0 : args[10] ;
            }
            args.length = Math.min( args.length , 8 ) ;
            super.setPen.apply( this , args ) ;
        }
        
        /**
         * @private
         */
        protected const _dashline:DashLinePen = new DashLinePen() ;
    }
}
