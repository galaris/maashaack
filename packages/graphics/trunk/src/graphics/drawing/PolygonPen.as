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
  Portions created by the Initial Developers are Copyright (C) 2006-2011
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
    import core.maths.DEG2RAD;

    import graphics.Align;
    
    /**
     * This pen is the tool to draw a regular polygon vector shape.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * package examples 
     * {
     *     import graphics.Align;
     *     import graphics.FillStyle;
     *     import graphics.drawing.PolygonPen;
     *      
     *     import flash.display.Shape;
     *     import flash.display.Sprite;
     *     import flash.display.StageScaleMode;
     *     import flash.events.KeyboardEvent;
     *     import flash.ui.Keyboard;
     *     
     *     public class ExamplePolygonPen extends Sprite 
     *     {
     *         public function ExamplePolygonPen()
     *         {
     *             stage.scaleMode = StageScaleMode.NO_SCALE ;
     *             stage.align     = "" ;
     *             
     *             var shape:Shape = new Shape() ;
     *             shape.x = 740 / 2 ;
     *             shape.y = 420 / 2 ;
     *             
     *             pen      = new PolygonPen( shape , 0, 0, 10 , 100, 0 , Align.CENTER ) ;
     *             pen.fill = new FillStyle( 0xEBD936 ) ;
     *             
     *             pen.draw() ;
     *             
     *             addChild( shape ) ;
     *             
     *             stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
     *         }
     *         
     *         public var pen:PolygonPen ;
     *         
     *         public function keyDown( e:KeyboardEvent ):void
     *         {
     *             var code:uint = e.keyCode ;
     *             switch( code )
     *             {
     *                 case Keyboard.LEFT :
     *                 {
     *                     pen.draw( 0, 0, 10 , 100, 0 , Align.LEFT ) ;
     *                     break ;
     *                 }
     *                 case Keyboard.RIGHT :
     *                 {
     *                     pen.draw( 0, 0, 10 , 100, 20 , Align.RIGHT ) ;
     *                     break ;
     *                 }
     *                 case Keyboard.UP :
     *                 {
     *                     pen.draw( 0, 0, 3 , 100, 40 , Align.TOP ) ;
     *                     break ;
     *                 }
     *                 case Keyboard.DOWN :
     *                 {
     *                     pen.draw( 0, 0, 4 , 100, 60 , Align.BOTTOM ) ;
     *                     break ;
     *                 }
     *                 case Keyboard.SPACE :
     *                 {
     *                     pen.x      = 10 ;
     *                     pen.y      = 40 ;
     *                     pen.sides  = 8  ;
     *                     pen.radius = 50 ;
     *                     pen.angle  = 40 ;
     *                     pen.align  = Align.TOP_RIGHT ;
     *                     pen.draw() ;
     *                     break ;
     *                 }
     *             }
     *         }
     *     }
     * }
     * </pre>
     */
    public dynamic class PolygonPen extends Pen
    {
        /**
         * Creates a new PolygonPen. The Pen class use composition to control a Graphics reference and draw custom vector graphic shapes.
         * @param graphic The Graphics reference to control with this helper. You can passed-in a Shape or Sprite/MovieClip reference in argument.
         * @param x (optional)The x location of the center of the circle relative to the registration point of the parent display object (in pixels).
         * @param y (optional)The y location of the center of the circle relative to the registration point of the parent display object (in pixels).
         * @param sides (optional) The number of sides (Math.abs(sides) must be > 2)
         * @param radius (optional) The radius of the circle (in pixels). 
         * @param angle (optional) The starting angle in degrees. (defaults to 0) 
         * @param align (optional) The Align value to align the shape.
         */
        public function PolygonPen( graphic:* , x:Number = 0 , y:Number = 0 , sides:uint = 6 , radius:Number = 20 , angle:Number = 0 , align:uint = 1 )
        {
            super( graphic ) ;
            setPen(x,y,sides,radius,angle,align) ;
        }
        
        /**
         * Starting angle in degrees (default to 0).
         */
        public var angle:Number = 0 ;
        
        /**
         * The radius value of the pen.
         */
        public var radius:Number ;
        
        /**
         * The number of sides (Math.abs(sides) must be > 2)
         */
        public function get sides():uint
        {
            return _sides ;
        }
        
        /**
         * The number of sides (Math.abs(sides) must be > 2)
          */
        public function set sides( value:uint ):void
        {
            _sides = ( value > 2 ) ? value : 3 ;
        }
        
        /**
         * The offset x value of the center of the circle.
         */
        public var x:Number ;
        
        /**
         * The offset y value of the center of the circle.
         */
        public var y:Number ;
        
        /**
         * Draws the shape.
         * @param x (optional)The x location of the center of the circle relative to the registration point of the parent display object (in pixels).
         * @param y (optional)The y location of the center of the circle relative to the registration point of the parent display object (in pixels).
         * @param sides (optional) The number of sides (Math.abs(sides) must be > 2)
         * @param radius (optional) The radius of the circle (in pixels). 
         * @param angle (optional) The starting angle in degrees. (defaults to 0) 
         * @param align (optional) The Align value to align the shape.
         */
        public override function draw( ...arguments:Array ):void
        {
            if ( arguments.length > 0 ) 
            {
                setPen.apply( this, arguments ) ;
            }
            super.draw() ;
        }
        
        /**
         * This method contains the basic drawing shape algorithm.
         */
        public override function drawShape():void
        {
            if ( _sides > 2 ) 
            {
                var $x:Number = x ;
                var $y:Number = y ;
                if ( _align == Align.CENTER ) 
                {
                    // default
                }
                else if ( _align == Align.BOTTOM ) 
                {
                    $y -= radius ;
                }
                else if ( _align == Align.BOTTOM_LEFT ) 
                {
                    $x += radius ;
                    $y -= radius ;
                }
                else if ( _align == Align.BOTTOM_RIGHT) 
                {
                    $x -= radius ;
                    $y -= radius ;
                }
                else if ( _align == Align.LEFT) 
                {
                    $x += radius ;
                }
                else if ( _align ==  Align.RIGHT) 
                {
                    $x -= radius ;
                }
                else if ( _align == Align.TOP) 
                {
                    $y += radius ;
                }
                else if ( _align == Align.TOP_RIGHT) 
                {
                    $x -= radius ;
                    $y += radius ;
                }
                else // TOP_LEFT
                {
                    $x += radius ;
                    $y += radius ;
                }    
                    
                var step:Number  = _PI2 / sides ; // calculate span of sides
                var start:Number = angle * DEG2RAD ; // calculate starting angle in radians
                
                _graphics.moveTo( $x + ( Math.cos( start ) * radius ), $y - ( Math.sin( start ) * radius ) ) ;
                
                for ( var i:int = 1 ; i <= _sides ; i++ ) 
                {
                    _graphics.lineTo
                    (
                        $x + Math.cos( start + ( step*i ) ) * radius , 
                        $y - Math.sin( start + ( step*i ) ) * radius
                    );
                }
            }
        }
        
        /**
         * Sets the shape options to defined all values to draw the shape.
         * @param x (optional) The x location of the center of the circle relative to the registration point of the parent display object (in pixels).
         * @param y (optional) The y location of the center of the circle relative to the registration point of the parent display object (in pixels).
         * @param sides (optional) The number of sides (Math.abs(sides) must be > 2)
         * @param radius (optional) The radius of the circle (in pixels). 
         * @param angle (optional) The starting angle in degrees. (defaults to 0) 
         * @param align (optional) The Align value to align the shape.
         */
        public function setPen( ...arguments:Array ):void
        {
            if ( arguments[0] != null && arguments[0] is Number )
            {
                x = isNaN(arguments[0]) ? 0 : arguments[0] ; // x
            }
            if ( arguments[1] != null && arguments[1] is Number )
            {
                y = isNaN(arguments[1]) ? 0 : arguments[1] ; // y
            }
            if ( arguments[2] != null && arguments[2] is Number )
            {
                sides = arguments[2] > 2 ? arguments[2] : 3 ; // sides
            }
            if ( arguments[3] != null && arguments[3] is Number )
            {
                radius = isNaN(arguments[3]) ? 0 : arguments[3] ; // radius
            }
            if ( arguments[4] != null && arguments[4] is Number )
            {
                angle = arguments[4] > 0 ? arguments[4] : 0 ; // angle
            }
            if ( arguments.length == 6 && arguments[5] is uint )
            {
                align = arguments[5] as uint ; // align
            }
        }
        
        /**
         * @private
         */
        private const _PI2:Number = Math.PI * 2 ;
        
        /**
         * @private
         */
        private var _sides:uint = 3 ;
    }
}
