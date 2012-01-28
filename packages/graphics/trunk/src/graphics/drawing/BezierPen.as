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
    import graphics.geom.Beziers;
    import graphics.geom.Line;
    import graphics.geom.Lines;
    import graphics.geom.Vector2;
    
    import flash.geom.Point;
    
    /**
     * This pen draw a bezier line curve in a MovieClip reference.
     */
    public dynamic class BezierPen extends Pen
    {
        /**
         * Creates a new BezierPen instance.
         * @param graphic The Graphics reference to control with this helper. You can passed-in a Shape or Sprite/MovieClip reference in argument.
         */
        public function BezierPen( graphic:* = null )
        {
            super( graphic );
        }
        
        /**
         * The tolerance of the drawing shape process.
         */
        public var tolerance:uint = 5 ;
        
        /**
         * The first vector element who defines the bezier shape.
         */
        public var v1:Vector2 ;
        
        /**
         * The second vector element who defines the bezier shape.
         */
        public var v2:Vector2 ;
        
        /**
         * The third vector element who defines the bezier shape.
         */
        public var v3:Vector2 ;
        
        /**
         * The fourth vector element who defines the bezier shape.
         */
        public var v4:Vector2 ;
        
        /**
          * Draw the bezier shape.
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
         * Draw the bezier representation defines by the array of point passed in argument.
         */
        public function drawPoints( points:Array ):void 
        {
            if ( points == null )
            {
                throw new ArgumentError( this + " drawPoints failed with a 'null' or 'undefined' points argument.") ;
            }
            var size:int = points.length ;
            if ( size > 0 ) 
            {
                _graphics.moveTo( points[0].x, points[0].y );
                for ( var i:int ; i < size ; i++ )
                {
                    _graphics.lineTo( points[i].x, points[i].y );
                }
            } 
        }
        
        /**
         * This method contains the basic drawing shape algorithm.
         */
        public override function drawShape():void
        {
            graphics.moveTo( v1.x, v1.y );
            _create( v1, v2, v3, v4, Math.pow( tolerance, 2 ) ) ;
        }
        
        /**
         * Sets the pen properties.
         */
        public function setPen( ...arguments:Array ):void
        {
            if ( arguments[0] != null && ( arguments[0] is Vector2 || arguments[0] is Point ) )
            {
                v1 = arguments[0] ;
            }
            if ( arguments[1] != null && ( arguments[1] is Vector2 || arguments[1] is Point ) )
            {
                v2 = arguments[1] ;
            }
            if ( arguments[2] != null && ( arguments[2] is Vector2 || arguments[2] is Point ) )
            {
                v3 = arguments[2] ;
            }
            if ( arguments[3] != null && ( arguments[3] is Vector2 || arguments[3] is Point ) )
            {
                v4 = arguments[3] ;
            }
            if ( arguments[4] != null && arguments[4] is Number )
            {
                tolerance = isNaN(arguments[4]) ? 5 : arguments[4] ;
            }
        }
        
        /**
         * @private
         */
        private function _create( a:Vector2 , b:Vector2 , c:Vector2 , d:Vector2 , k:Number ):void 
        {
            var l1:Line   = Lines.getLine( a, b ) ;
            var l2:Line   = Lines.getLine( c, d ) ;
            var s:Vector2 = Lines.getLineCross( l1, l2 ) ;
            var dx:Number = (a.x + d.x + s.x * 4 - (b.x + c.x) * 3) * .125 ;
            var dy:Number = (a.y + d.y + s.y * 4 - (b.y + c.y) * 3) * .125 ;
            if ( dx * dx + dy * dy > k ) 
            {
                var halves:Object = Beziers.split( a, b, c, d ) ;
                var b0:Object = halves.b0 ;
                var b1:Object = halves.b1 ;
                _create( a, b0.b, b0.c, b0.d, k ) ;
                _create( b1.a, b1.b, b1.c, d, k ) ;
            } 
            else 
            {
                _graphics.curveTo( s.x, s.y, d.x, d.y ) ;
            }
        }
    }
}