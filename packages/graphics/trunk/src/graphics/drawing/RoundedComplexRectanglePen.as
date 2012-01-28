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
    
    /**
     * Draws a complex rounded rectangle. You can set the corner radius of the rectangle with the top left, top right, bottom left and bottom right corner.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * package examples 
     * {
     *     import graphics.Align;
     *     import graphics.FillStyle;
     *     import graphics.LineStyle;
     *     import graphics.Corner;
     *     
     *     import graphics.drawing.RoundedComplexRectanglePen;
     *     
     *     import flash.display.CapsStyle;
     *     import flash.display.JointStyle;
     *     import flash.display.LineScaleMode;
     *     import flash.display.Shape;
     *     import flash.display.Sprite;
     *     import flash.display.StageScaleMode;
     *     import flash.events.KeyboardEvent;
     *     import flash.ui.Keyboard;
     *     
     *     public class ExampleRoundedComplexRectanglePen extends Sprite
     *     {
     *         public function ExampleRoundedComplexRectanglePen()
     *         {
     *             stage.scaleMode = StageScaleMode.NO_SCALE ;
     *             stage.align     = "" ;
     *             
     *             var shape:Shape = new Shape() ;
     *             
     *             shape.x = stage.stageWidth  / 2 ;
     *             shape.y = stage.stageHeight / 2 ;
     *             
     *             addChild( shape ) ;
     *             
     *             pen      = new RoundedComplexRectanglePen( shape , 0, 0, 200, 180, 12, 0, 0, 24, Align.CENTER ) ;
     *             pen.fill = new FillStyle( 0xFF0000 , 0.5 ) ;
     *             pen.line = new LineStyle( 2, 0xFFFFFF , 1 , true, LineScaleMode.NORMAL , CapsStyle.SQUARE, JointStyle.MITER ) ;
     *             
     *             pen.draw() ;
     *             
     *             stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
     *         }
     *         
     *         public var pen:RoundedComplexRectanglePen ;
     *         
     *         public function keyDown( e:KeyboardEvent ):void
     *         {
     *             var code:uint = e.keyCode ;
     *             switch( code )
     *             {
     *                 case Keyboard.LEFT :
     *                 {
     *                     pen.draw( 0, 0, 200, 180, 12, 12, 32, 32, Align.LEFT ) ;
     *                     break ;
     *                 }
     *                 case Keyboard.RIGHT :
     *                 {
     *                     pen.draw( 0, 0, 200, 180, 32, 12, 32, 32, Align.RIGHT ) ;
     *                     break ;
     *                 }
     *                 case Keyboard.UP :
     *                 {
     *                     pen.draw( 0, 0, 200, 180, 32, 12, 0, 0, Align.TOP ) ;
     *                     break ;
     *                 }
     *                 case Keyboard.DOWN :
     *                 {
     *                     pen.draw( 0, 0, 200, 180, 0, 0, 24, 24, Align.BOTTOM ) ;
     *                     break ;
     *                 }
     *                 case Keyboard.SPACE :
     *                 {
     *                     pen.x = -10 ;
     *                     pen.y = 10 ;
     *                     pen.bottomLeftRadius  = 0 ;
     *                     pen.bottomRightRadius = 0 ;
     *                     pen.topLeftRadius     = 0 ;
     *                     pen.topRightRadius    = 0 ;
     *                     pen.align  = Align.TOP_RIGHT ;
     *                     pen.draw() ;
     *                     break ;
     *                 }
     *                 case Keyboard.NUMPAD_7 :
     *                 {
     *                     pen.cornerRadius = 10 ;
     *                     pen.draw( 0, 0, 200, 180 ) ;
     *                     break ;
     *                 }
     *                 case Keyboard.NUMPAD_8 :
     *                 {
     *                     pen.cornerRadius = NaN ;
     *                     pen.draw( 0, 0, 200, 180 ) ;
     *                     break ;
     *                 }
     *                 case Keyboard.NUMPAD_9 :
     *                 {
     *                     pen.corner = new Corner(false, false, false, false) ;
     *                     pen.draw( 0, 0, 200, 180 ) ;
     *                     break ;
     *                 }
     *                 case Keyboard.NUMPAD_6 :
     *                 {
     *                     pen.corner = new Corner() ;
     *                     pen.draw( 0, 0, 200, 180 ) ;
     *                     break ;
     *                 }
     *             }
     *         }
     *     }
     * }
     * </pre>
     */
    public dynamic class RoundedComplexRectanglePen extends CornerRectanglePen 
    {
        use namespace hack ;
        
        /**
         * Creates a new RoundedComplexRectanglePen instance.
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
        public function RoundedComplexRectanglePen( graphic:* = null , x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0, topLeftRadius:Number=0 , topRightRadius:Number=0 , bottomLeftRadius:Number=0 , bottomRightRadius:Number=0, align:uint = 10)
        {
            super( graphic );
            setPen(  x , y , width , height , topLeftRadius , topRightRadius, bottomLeftRadius, bottomRightRadius, align ) ;
        }
        
        /**
         * The radius of the bottom-left corner, in pixels.
         */
        public function get bottomLeftRadius():Number
        {
            return _bottomLeftRadius ;
        }
        
        /**
         * @private
         */
        public function set bottomLeftRadius( value:Number ):void
        {
            _bottomLeftRadius = isNaN(value) ? 0 : value ;
        }
        
        /**
         * The radius of the bottom-left corner, in pixels.
         */
        public function get bottomRightRadius():Number
        {
            return _bottomRightRadius ;
        }
        
        /**
         * @private
         */
        public function set bottomRightRadius( value:Number ):void
        {
            _bottomRightRadius = isNaN(value) ? 0 : value ;
        }
        
        /**
         * The global corner radius corner, in pixels. 
         * <p>The cornerRadius property no change the other corner properties.</p>
         * <p>If this property is NaN the bottomLeftRadius, bottomRightRadius, topLeftRadius and topRightRadius properties are used.</p>
         */
        public function get cornerRadius():Number
        {
            return _cornerRadius ;
        }
        
        /**
         * @private
         */
        public function set cornerRadius( value:Number ):void
        {
            _cornerRadius = value ;
        } 
        
        /**
         * The radius of the upper-left corner, in pixels.
         */
        public function get topLeftRadius():Number
        {
            return _topLeftRadius ;
        }
        
        /**
         * @private
         */
        public function set topLeftRadius( value:Number ):void
        {
            _topLeftRadius = isNaN(value) ? 0 : value ;
        }
        
        /**
         * The radius of the upper-right corner, in pixels. 
         */
        public function get topRightRadius():Number
        {
            return _topRightRadius ;
        }

        /**
         * @private
         */
        public function set topRightRadius( value:Number ):void
        {
            _topRightRadius = isNaN(value) ? 0 : value ;
        }
        
        /**
         * This method contains the basic drawing shape algorithm.
         */
        public override function drawShape():void
        {
            _refreshAlign() ;
            _graphics.drawRoundRectComplex
            ( 
                _x     , 
                _y     , 
                width  , 
                height , 
                corner.tl ? ( isNaN(_cornerRadius) ? _topLeftRadius     : _cornerRadius ) : 0 , 
                corner.tr ? ( isNaN(_cornerRadius) ? _topRightRadius    : _cornerRadius ) : 0 , 
                corner.bl ? ( isNaN(_cornerRadius) ? _bottomLeftRadius  : _cornerRadius ) : 0 , 
                corner.br ? ( isNaN(_cornerRadius) ? _bottomRightRadius : _cornerRadius ) : 0
            ) ;
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
         */
        public override function setPen( ...args:Array  ):void 
        {
            super.setPen( args[0], args[1], args[2], args[3], args[8] ) ;
            if ( args[4] != null && args[4] is Number )
            {
                this.topLeftRadius = isNaN( args[4] ) ? 0 : args[4] ;
            }
            if ( args[5] != null && args[5] is Number )
            {
                this.topRightRadius = isNaN( args[5] ) ? 0 : args[5] ;
            }
            if ( args[6] != null && args[6] is Number )
            {
                this.bottomLeftRadius = isNaN( args[6] ) ? 0 : args[6] ;
            }
            if ( args[7] != null && args[7] is Number )
            {
                this.bottomRightRadius = isNaN( args[7] ) ? 0 : args[7] ;
            }
        }
        
        /**
         * @private
         */
        hack var _bottomLeftRadius:Number = 0 ;
        
        /**
         * @private
         */
        hack var _bottomRightRadius:Number = 0 ;
        
        /**
         * @private
         */
        hack var _cornerRadius:Number ;
        
        /**
         * @private
         */
        hack var _topLeftRadius:Number = 0 ;
        
        /**
         * @private
         */
        hack var _topRightRadius:Number = 0 ;
    }
}
