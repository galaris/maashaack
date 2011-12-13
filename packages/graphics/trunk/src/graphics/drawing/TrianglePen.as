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
    import core.maths.fixAngle;
    
    import system.hack;
    
    import flash.geom.Point;
    
    /**
     * Draw a triangle with the A, B and C points in the 2D space. ab and ac are the lengths to defines the base of the shape.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * package examples 
     * {
     *     import graphics.Align;
     *     import graphics.FillStyle;
     *     import graphics.LineStyle;
     *     
     *     import graphics.drawing.RectanglePen;
     *     import graphics.drawing.TrianglePen;
     *     
     *     import flash.display.Shape;
     *     import flash.display.Sprite;
     *     import flash.events.KeyboardEvent;
     *     import flash.ui.Keyboard;
     *     
     *     public class ExampleTrianglePen extends Sprite 
     *     {
     *         public function ExampleTrianglePen()
     *         {
     *             var container:Sprite = new Sprite() ;
     *             
     *             container.x = 740/2 ;
     *             container.y = 200   ;
     *             
     *             addChild( container ) ;
     *             
     *             ///////////////////////////////
     *             
     *             a = new Shape() ;
     *             b = new Shape() ;
     *             c = new Shape() ;
     *             
     *             var rec:RectanglePen ;
     *             
     *             rec = new RectanglePen( a ) ;
     *             rec.fill  = new FillStyle( 0xFFFFFF ) ;
     *             rec.draw( 0 , 0 , 5 , 5 , Align.CENTER ) ;
     *             
     *             rec = new RectanglePen( b ) ;
     *             rec.fill  = new FillStyle( 0xFFFFFF ) ;
     *             rec.draw( 0 , 0 , 5 , 5 , Align.CENTER ) ;
     *             
     *             rec = new RectanglePen( c ) ;
     *             rec.fill  = new FillStyle( 0xFFFFFF ) ;
     *             rec.draw( 0 , 0 , 5 , 5 , Align.CENTER ) ;
     *             
     *             ///////////////////////////////
     *             
     *             var canvas:Shape = new Shape() ;
     *             
     *             container.addChild( canvas ) ;
     *             container.addChild( a ) ;
     *             container.addChild( b ) ;
     *             container.addChild( c ) ;
     *             
     *             pen       = new TrianglePen( canvas.graphics, 200, 200, 90, 90, 0, 0) ;
     *             pen.fill  = new FillStyle( 0x3F65FC , 0.6 ) ;
     *             pen.line  = new LineStyle( 2, 0xFFFFFF ) ;
     *             
     *             pen.draw() ;
     *             
     *             update() ;
     *             
     *             stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
     *         }
     *         
     *         public var a:Shape ;
     *         public var b:Shape ;
     *         public var c:Shape ;
     *         
     *         public var pen:TrianglePen ;
     *         
     *         public function keyDown( e:KeyboardEvent ):void
     *         {
     *             var code:uint = e.keyCode ;
     *             switch( code )
     *             {
     *                 case Keyboard.LEFT :
     *                 {
     *                     pen.rotation -= 10 ;
     *                     pen.draw() ;
     *                     break ;
     *                 }
     *                 case Keyboard.RIGHT :
     *                 {
     *                     pen.rotation += 10 ;
     *                     pen.draw() ;
     *                     break ;
     *                 }
     *                 case Keyboard.UP :
     *                 {
     *                     pen.angle -= 10 ;
     *                     pen.draw() ;
     *                     break ;
     *                 }
     *                 case Keyboard.DOWN :
     *                 {
     *                     pen.angle += 10 ;
     *                     pen.draw() ;
     *                     break ;
     *                 }
     *             }
     *             trace( "angle : " + pen.angle + " rotation:" + pen.rotation ) ;
     *             update() ;
     *         }
     *         
     *         public function update():void
     *         {
     *             a.x = pen.a.x ;
     *             a.y = pen.a.y ;
     *             
     *             b.x = pen.b.x ;
     *             b.y = pen.b.y ; 
     *             
     *             c.x = pen.c.x ;
     *             c.y = pen.c.y ; 
     *         }
     *     }
     * }
     * </pre>
     */
    public dynamic class TrianglePen extends Pen 
    {
        use namespace hack ;
        
        /**
         * Creates a new TrianglePen instance.
         * @param graphic The Graphics reference to control with this helper. You can passed-in a Shape or Sprite/MovieClip reference in argument.
         * @param ab The AB distance of the triangle.
         * @param ac The AC distance of the triangle.
         * @param angle The value of the angle used to draw the shape.
         * @param rotation The rotation value of the shape.
         * @param x The x barycentre position of the triangle shape.
         * @param y The y barycentre position of the triangle shape.
         */
        public function TrianglePen( graphic:* = null , ab:Number = 0 , ac:Number = 0, angle:Number = 360, rotation:Number = 0 , x:Number = 0 , y:Number = 0  )
        {
            super( graphic );
            setPen( ab, ac, angle, rotation, x, y ) ;
        }
        
        /**
         * Indicates the A corner position of the triangle.
         */
        public function get a():Point 
        {
            return _a.clone() ;
        }
        
        /**
         * Indicates the AB distance of the triangle.
         */
        public function get ab():Number 
        {
            return _ab ;
        }
        
        /**
         * @private
         */
        public function set ab( n:Number ):void 
        {
            _ab = isNaN(n) ? 0 : n ;
            _calculate() ;
        }
        
        /**
         * Indicates the AC distance of the triangle.
         */
        public function get ac():Number 
        {
            return _ac ;
        }
        
        /**
         * @private
         */
        public function set ac( n:Number ):void 
        {
            _ac = isNaN(n) ? 0 : n ;
            _calculate() ;
        }
        
        /**
         * Indicates the value of the angle used to draw the shape.
         */
        public function get angle():Number 
        {
            return _angle ;
        }
        
        /**
         * @private
         */
        public function set angle(n:Number):void 
        {
            _angle = fixAngle( n ) ;
            _angleR = _angle * DEG2RAD ;
            _calculate() ;
        }
        
        /**
         * Indicates the B corner position of the triangle.
         */
        public function get b():Point 
        {
            return _b.clone() ;
        }
        
        /**
         * Indicates a new barycenter Point object of the triangle.
         */
        public function get barycenter():Point
        {
            return new Point(x,y) ;
        }
        
        /**
         * Indicates the C corner position of the triangle.
         */
        public function get c():Point 
        {
            return _c.clone() ;
        }
        
        /**
         * Indicates the rotation value of the shape.
         */
        public function get rotation():Number 
        {
            return _rotation ;
        }
        
        /**
         * @private
         */
        public function set rotation( n:Number ):void 
        {
            _rotation  = fixAngle( n ) ;
            _rotationR = _rotation * DEG2RAD ;
            _calculate() ;
        }
        
        /**
         * Defines the x barycentre position of the triangle shape.
         */
        public function get x():Number
        {
            return _x ;
        }
        
        /**
         * @private
         */
        public function set x( n:Number ):void
        {
            _x = isNaN(n) ? 0 : n ;
            _calculate() ;
        }
        
        /**
         * Defines the y barycentre position of the triangle shape.
         */
        public function get y():Number
        {
            return _y ;
        }
        
        /**
         * @private
         */
        public function set y( n:Number ):void
        {
            _y = isNaN(n) ? 0 : n ;
            _calculate() ;
        }
        
        /**
         * Draws the shape.
         * @param ab (optional) The ab distance in pixels of the triangle pen.
         * @param ac (optional) The ac distance in pixels of the triangle pen.
         * @param angle (optional) The angle of the triangle pen (angle of the A corner).
         * @param rotation (optional) The rotation value of the triangle pen.
         * @param x (optional) The x position of the barycenter of the triangle.
         * @param y (optional) The y position of the barycenter of the triangle.
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
            
            _graphics.moveTo( _a.x , _a.y ) ;
            _graphics.lineTo( _b.x , _b.y ) ;
            _graphics.lineTo( _c.x , _c.y ) ;
            _graphics.lineTo( _a.x , _a.y ) ;
        }
        
        /**
         * Sets the shape options to defined all values to draw the shape.
         * @param ab (optional) The ab distance in pixels of the triangle pen.
         * @param ac (optional) The ac distance in pixels of the triangle pen.
         * @param angle (optional) The angle of the triangle pen (angle of the A corner).
         * @param rotation (optional) The rotation value of the triangle pen.
         * @param x (optional) The x position of the barycenter of the triangle.
         * @param y (optional) The y position of the barycenter of the triangle.
         */
        public function setPen( ...arguments:Array ):void
        {
            if ( arguments[0] != null && arguments[0] is Number )
            {
                _ab = isNaN(arguments[0]) ? 0 : arguments[0] ;
            }
            if ( arguments[1] != null && arguments[1] is Number )
            {
                _ac = isNaN(arguments[1]) ? 0 : arguments[1] ;
            }
            if ( arguments[2] != null && arguments[2] is Number )
            {
                _angle = fixAngle( arguments[2] ) ;
                _angleR = _angle * DEG2RAD ;
            }
            if ( arguments[3] != null && arguments[3] is Number )
            {
                _rotation  = fixAngle( arguments[3] ) ;
                _rotationR = _rotation * DEG2RAD ;
            }
            if ( arguments[4] != null && arguments[4] is Number )
            {
                _x = isNaN(arguments[4]) ? 0 : arguments[4] ;
            }
            if ( arguments[5] != null && arguments[3] is Number )
            {
                _y = isNaN(arguments[5]) ? 0 : arguments[5] ;
            }
            _calculate() ;
        }
        
        /**
         * @private
         */
        hack var _a:Point = new Point() ;
        
        /**
         * @private
         */
        hack var _ab:Number ;
        
        /**
         * @private
         */
        hack var _ac:Number ;
        
        /**
         * @private
         */
        hack var _angle:Number ;
        
        /**
         * @private
         */
        hack var _angleR:Number ;
        
        /**
         * @private
         */
        hack var _b:Point = new Point() ;
        
        /**
         * @private
         */
        hack var _c:Point = new Point() ;
        
        /**
         * @private
         */
        hack var _rotation:Number ;
        
        /**
         * @private
         */
        hack var _rotationR:Number ;
        
        /**
         * @private
         */
        hack var _x:Number ;
        /**
         * @private
         */
        hack var _y:Number ;
        
        /**
         * @private
         */
        private function _calculate():void
        {
            var bx:Number = Math.cos( _angleR - _rotationR ) * _ab ;
            var by:Number = Math.sin( _angleR - _rotationR ) * _ab ;
            
            var cx:Number = Math.cos( -_rotationR ) * _ac ;
            var cy:Number = Math.sin( -_rotationR ) * _ac ;
            
            var ax:Number = ( cx + bx ) / 3 - x ;
            var ay:Number = ( cy + by ) / 3 - y ;
            
            _a.x = -1 * ax ;
            _a.y = -1 * ay ;
            
            _b.x = cx - ax ;
            _b.y = cy - ay ;
            
            _c.x = bx - ax ;
            _c.y = by - ay ;
        }
    }
}
