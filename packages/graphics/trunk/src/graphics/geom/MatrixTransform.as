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

package graphics.geom
{
    import flash.geom.Matrix;
    import flash.geom.Point;
    
    /**
     * Helper to transform a flash.geomatrix.Matrix. 
     * This class can change horizontal and vertical scale, horizontal and vertical skew, and rotation. 
     * This class also has methods for rotating around a given transformation point rather than the typical (0, 0) point.
     */
    public class MatrixTransform
    {
        /**
         * Creates a new MatrixTransform instance.
         * @param matrix The Matrix reference to transform.
         * @param degrees Indicates if all calcul use angles in degrees or radians (default use radians angles).
         */
        public function MatrixTransform( matrix:Matrix = null , degrees:Boolean = false )
        {
             this.matrix  = matrix ;
             this.degrees = degrees ;
        }
        
        /**
         * Indicates if all calcul use angles in degrees or radians.
         */
        public var degrees:Boolean ;
        
        /**
         * The Matrix reference to transform.
         */
        public var matrix:Matrix;
        
        /**
         * Calculates the angle of rotation present in a matrix. 
         * If the horizontal and vertical skews are not equal, the vertical skew value is used.
         * @return The angle of rotation, in radians.
         * @see flash.geom.Matrix
         */
        public function get rotation():Number
        {
            var value:Number = Math.atan2( matrix.b , matrix.a ) ;
            if ( degrees )
            {
                 value *= RAD2DEG ;
            }
            return value ;
        }
        
        /**
         * Changes the angle of rotation in a matrix.
         * If the horizontal and vertical skews are not equal, the vertical skew is set to the rotation value
         * and the horizontal skew is increased by the difference between the old rotation and the new rotation.
         * This matches the rotation behavior in Flash Player.
         * @param value The angle of rotation.
         * @see flash.geom.Matrix
         */
        public function set rotation( value:Number ):void
        {
            if ( degrees )
            {
                 value *= DEG2RAD ;
            }
            
            var sX:Number = Math.atan2( -matrix.c , matrix.d ) ; // skewX
            var sY:Number = Math.atan2(  matrix.b , matrix.a ) ; // skewY
            
            var angle:Number ;
            var scale:Number ;
            
            // set skewX
            
            scale    = Math.sqrt( matrix.c * matrix.c + matrix.d * matrix.d ) ;
            angle    = sX + value - sY ;
            matrix.c = -scale * Math.sin( angle ) ;
            matrix.d =  scale * Math.cos( angle ) ;
            
            // set skewY
            
            scale    = Math.sqrt( matrix.a * matrix.a + matrix.b * matrix.b ) ;
            matrix.a = scale * Math.cos( value ) ;
            matrix.b = scale * Math.sin( value ) ;
        }
        
        /**
         * Calculates the horizontal scale present in a matrix.
         * @return The horizontal scale of the Matrix.
         * @see flash.geomatrix.Matrix
         */
        public function get scaleX():Number
        {
            return Math.sqrt( matrix.a * matrix.a + matrix.b * matrix.b ) ;
        }
        
        /**
         * Changes the horizontal scale in a matrix.
         * @param value The new horizontal scaleX value.
         * @see flash.geomatrix.Matrix
         */
        public function set scaleX( value:Number ):void
        {
            var oldValue:Number = Math.sqrt( matrix.a * matrix.a + matrix.b * matrix.b ) ;
            if ( oldValue )
            {
                var ratio:Number = value / oldValue ;
                matrix.a *= ratio ;
                matrix.b *= ratio ;
            }
            else
            {
                var angle:Number = Math.atan2( matrix.b , matrix.a ) ;
                matrix.a = Math.cos( angle ) * value ;
                matrix.b = Math.sin( angle ) * value ;
            }
        }
        /**
         * Calculates the vertical scale present in a matrix.
         * @return The vertical scale.
         * @see flash.geom.Matrix
         */
        public function get scaleY():Number
        {
            return Math.sqrt( matrix.c * matrix.c + matrix.d * matrix.d ) ;
        }
        
        /**
         * Changes the vertical scale in a matrix.
         * @param scaleY The new vertical scale.
         * @see flash.geom.Matrix
         */
        public function set scaleY( value:Number ):void
        {
            var oldValue:Number = Math.sqrt( matrix.c * matrix.c + matrix.d * matrix.d ) ;
            if (oldValue)
            {
                var ratio:Number = value / oldValue ;
                matrix.c *= ratio ;
                matrix.d *= ratio ;
            }
            else
            {
                var angle:Number = Math.atan2( -matrix.c , matrix.d ) ;
                matrix.c = -Math.sin( angle ) * value ;
                matrix.d =  Math.cos( angle ) * value ;
            }
        }
        /**
         * Calculates the angle of horizontal skew present in a matrix, in radians.
         * @return The angle of horizontal skew, in radians.
         * @see flash.geom.Matrix
         */
        public function get skewX():Number
        {
            var value:Number = Math.atan2( -matrix.c , matrix.d ) ;
            if ( degrees )
            {
                 value *= RAD2DEG ;
            }
            return value ;
        }
        
        /**
         * Changes the horizontal skew in a matrix.
         * @param skewX The new horizontal skew, in radians.
         * @see flash.geom.Matrix
         */
        public function set skewX( value:Number ):void
        {
            if( degrees )
            {
                value *= DEG2RAD ;
            }
            var scaleY:Number = Math.sqrt( matrix.c * matrix.c + matrix.d * matrix.d ) ;
            matrix.c = -scaleY * Math.sin( value ) ;
            matrix.d =  scaleY * Math.cos( value ) ;
        }
        
        /**
         * Calculates the angle of vertical skew present in a matrix, in radians.
         * @return The angle of vertical skew, in radians.
         * @see flash.geom.Matrix
         */
        public function get skewY():Number
        {
            var value:Number = Math.atan2( matrix.b , matrix.a ) ;
            if ( degrees )
            {
                 value *= RAD2DEG ;
            }
            return value ;
        }
        
        /**
         * Changes the vertical skew in a matrix.
         * @param skewY The new vertical skew, in radians.
         * @see flash.geom.Matrix
         */
        public function set skewY( value:Number ):void
        {
            if( degrees )
            {
                value *= DEG2RAD ;
            }
            var scaleX:Number = Math.sqrt( matrix.a * matrix.a + matrix.b * matrix.b ) ;
            matrix.a = scaleX * Math.cos( value ) ;
            matrix.b = scaleX * Math.sin( value ) ;
        }
        
        /**
         * Moves a matrix as necessary to align an internal point with an external point.
         * This can be used to match a point in a transformed DisplayObject with one in its parent.
         * @param internalPoint A Point instance defining a position within the matrix's transformation space.
         * @param externalPoint A Point instance defining a reference position outside the matrix's transformation space.
         */ 
        public function matchInternalPointWithExternal( internalPoint:Point , externalPoint:Point ):void
        {
            var transformed:Point = matrix.transformPoint( internalPoint ) ;
            matrix.tx += externalPoint.x - transformed.x ;
            matrix.ty += externalPoint.y - transformed.y ;
        }
        
        /**
         * Rotates a matrix about a point defined inside the matrix's transformation space.
         * This can be used to rotate a DisplayObject around a transformation point inside itself. 
         * @param point The anchor point reference.
         * @param angle The angle of rotation.
         */
        public function rotateAroundInternalPoint( point:Point , angle:Number ):void
        {
            if( degrees )
            {
                angle *= DEG2RAD ;
            }
            point = matrix.transformPoint( point ) ;
            matrix.tx -= point.x;
            matrix.ty -= point.y;
            matrix.rotate( angle ) ;
            matrix.tx += point.x;
            matrix.ty += point.y;
        }
        
        /**
         * Rotates a matrix about a point defined outside the matrix's transformation space. 
         * This can be used to rotate a DisplayObject around a transformation point in its parent. 
         * @param point The anchor point reference.
         * @param angle The angle of rotation.
         */
        public function rotateAroundExternalPoint( point:Point , angle:Number ):void
        {
            if( degrees )
            {
                angle *= DEG2RAD ;
            }
            matrix.tx -= point.x ;
            matrix.ty -= point.y ;
            matrix.rotate( angle ) ;
            matrix.tx += point.x ;
            matrix.ty += point.y ;
        }
        
        /**
         * This constant change degrees to radians : <b>Math.PI/180</b>.
         */
        protected const DEG2RAD:Number = Math.PI / 180 ;
        
        /**
         * This constant change radians to degrees : <b>180/Math.PI</b>.
         */
        protected const RAD2DEG:Number = 180 / Math.PI ;
    }
}
