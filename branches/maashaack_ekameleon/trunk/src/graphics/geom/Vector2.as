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

package graphics.geom 
{
    import core.maths.acosD;
    import core.maths.atan2D;
    import core.maths.cosD;
    import core.maths.sinD;
    
    import system.Serializable;
    
    import flash.geom.Point;
    
    /**
     * Represents a vector in a 2D world with the coordinates x and y.
     */
    public class Vector2 extends Point implements Serializable
    {
        /**
         * Creates a new <code class="prettyprint">Vector2</code> instance.
         * @param x the x coordinate.
         * @param y the y coordinate.
         * @param degrees Optional flag who indicates if all methods use angles in degrees or radians.
         */
        public function Vector2( x:Number = 0 , y:Number = 0 , degrees:Boolean = false )
        {
            super(x , y) ;
            this.degrees = degrees ;
        }
        
        /**
         * Indicates the relative "down" direction.
         */
        public static const DOWN:Vector2 = new Vector2( 0 , -1 ) ;
        
        /**
         * Indicates the relative "left" direction.
         */
        public static const LEFT:Vector2 = new Vector2( -1 , 0 ) ;
        
        /**
         * Indicates the relative "right" direction.
         */
        public static const RIGHT:Vector2 = new Vector2( 1 , 0 ) ;
        
        /**
         * Indicates the relative "up" direction.
         */
        public static const UP:Vector2 = new Vector2( 0 , 1 );
        
        /**
         * Defines the Vector2 object with the x and y properties set to zero.
         */
        public static var ZERO:Vector2 = new Vector2( 0 , 0 ) ;
        
        /**
         * Indicates the angle value of the specified Vector2 object.
         * @return the angle value of this Point object.
         * @see degrees boolean property to set if the value is in degrees or radians.
         */
        public function get angle():Number 
        {
            return degrees ? atan2D( y , x) : Math.atan2( y , x ) ;
        }
        
        /**
         * @private
         */
        public function set angle( value:Number ):void 
        {
            var r:Number = length ;
            x = r * ( degrees ? cosD( value ) : Math.cos( value ) ) ;
            y = r * ( degrees ? sinD( value ) : Math.sin( value ) ) ;
        }
        
        /**
         * Indicates if all calcul in this methods use angles in degrees or radians.
         */
        public var degrees:Boolean ;
        
        /**
         * @private
         */
        public function set length( value:Number ):void 
        {
            if ( isNaN(value) || value == 0 )
            {
                x = 0 ;
                y = 0 ;
            }
            else 
            {
                var d:Number = value / length ;
                x *= d ;
                y *= d ;
            }
        }
        
        /**
         * Transforms the coordinates of the vector to used absolute value for the x and y properties.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.geom.Vector2 ;
         * 
         * var v:Vector2 = new Vector2(-10, -20) ;
         * 
         * v.abs() ;
         * 
         * trace( v ) ; // [Vector2 x:10 y:20]
         * </pre>
         * @return a new Vector2 reference with the absolute value of the coordinates of the passed-in Vector2 object.
         */
        public function abs():void 
        {
            x = Math.abs( x ) ;
            y = Math.abs( y ) ;
        }
        
        /**
         * Returns a new Vector2 reference with the absolute value of the coordinates of the specified Vector2 object.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.geom.Vector2 ;
         * 
         * var v1:Vector2 = new Vector2(-10, -20) ;
         * var v2:Vector2 = Vector2.abs( v1 ) ;
         * 
         * trace( v1 + " / " + v2 ) ; // [Vector2 x:-10 y:-20] / [Vector2 x:10 y:20]
         * </pre>
         * @param vector The vector reference to create the new absolute Vector2 object.
         * @return a new Vector2 reference with the absolute value of the coordinates of the passed-in Vector2 object.
         */
        public static function abs( vector:Vector2 ):Vector2 
        {
            return new Vector2( Math.abs( vector.x ) , Math.abs( vector.y ) ) ;
        }
        
        /**
         * Computes the addition of two Vector2.
         * @param v1 a Vector2 to concat.
         * @param v2 a Vector2 to concat.
         * @return the addition result of two Vector2.
         */
        public static function add( v1:Point , v2:Point ):Vector2
        {
            return new Vector2( v1.x + v2.x , v1.y + v2.y ) ;
        }
        
        /**
         * Returns the angle value between this Vector2 object and the specified Vector2 passed in arguments.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.geom.Vector2 ;
         * 
         * var angle:Number ;
         * 
         * var v1:Vector2 = new Vector2(10, 20) ;
         * var v2:Vector2 = new Vector2(50, 200) ;
         * 
         * v1.degrees = false ;
         * angle      = v1.angleBetween(v2) ;
         * 
         * trace( angle ) ;
         * 
         * v1.degrees = true ;
         * angle      = v1.angleBetween(v2) ;
         * 
         * trace( angle ) ;
         * </pre>
         * @return the angle value between this Point object and the specified Point passed in arguments.
         */
        public function angleBetween( vector:Vector2 ):Number 
        {
            var d:Number = dot( vector ) ;
            var a:Number = d / ( length * vector.length ) ;
            return degrees ? acosD( a ) : Math.acos( a ) ;
        }
        
        /**
         * Returns a shallow copy of this instance.
         * @return a shallow copy of this instance.
         */
        public override function clone():Point
        {
            return new Vector2(x, y, degrees) ;
        }
        
        /**
         * Returns the cross value of the two Vector2.
         * <pre class="prettyprint">
         * import graphics.geom.Vector2 ;
         * 
         * var v1:Vector2 = new Vector2( 10 , 20 ) ;
         * var v2:Vector2 = new Vector2( 40 , 60 ) ;
         * 
         * trace( v1.cross( v2 ) ) ; // -200
         * </pre>
         * @param vector The Vector2 object use to calculate the cross value. 
         * @return The cross value of the current Vector2 object with the Vector2 passed in argument.
         */
        public function cross( vector:Vector2 ):Number 
        {
            return ( x * vector.y ) - ( y * vector.x ) ;
        }
        
        /**
         * Returns the direction of this Vector2 object.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.geom.Vector2 ;
         * var v1 : Vector2 = new Point(10,2);
         * var v2 : Vector2 = p1.direction();
         * trace( v2 ) ; 
         * </pre>
         * @return the direction of this Point.
         * @see Vector2.normalize
         */
        public function direction():Vector2 
        {
            var v:Vector2 = clone() as Vector2 ;
            v.normalize(1);
            return v ;
        }
        
        /**
         * Returns the distance between the 2 vectors.
         * @param v1 the first vector.
         * @param v2 the second vector.
         * @return the distance between the 2 vectors.
         */
        public static function distance( v1:Vector2 , v2:Vector2 ):Number
        {
            return Math.sqrt( squaredDistance( v1 , v2 ) ) ;
        }
        
        /**
         * Returns the dot value of the passed-in Vector2 with the current Vector2 object.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.geom.Vector2 ;
         * 
         * var v1:Vector2 = new Vector2(10,20) ;
         * var v2:Vector2 = new Vector2(40,60) ;
         * 
         * trace( v1.dot( v2 ) ) ; // 1600
         * </pre>
         * @param vector the Vector2 object to calculate the dot value.
         * @return the dot value.
         */
        public function dot( vector:Vector2 ):Number 
        {
            return ( x * vector.x ) + ( y * vector.y ) ;
        }
        
        /**
         * Compares the specified object with this object for equality.
         * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
         */
        public override function equals( toCompare:Point ):Boolean 
        {
            if ( toCompare is Point )
            {
                return ( toCompare.x == x) && ( toCompare.y == y ) ;
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Determines a point between two specified points.
         * The parameter 'level' determines where the new interpolated point is located relative to the two end points. 
         * The closer the value of the parameter level is to 1.0, the closer the interpolated point is to the first vector (current Vector2). 
         * The closer the value of the parameter level is to 0, the closer the interpolated point is to the second vector (parameter vector).
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.geom.Vector2 ;
         * 
         * var v1:Vector2 = new Vector2(10,10) ;
         * var v2:Vector2 = new Vector2(40,40) ;
         * 
         * var v3:Vector2 ;
         * 
         * v3 = v1.interpolate( v2 , 0 ) ;
         * trace(v3) ; // [Vector2 x:40 y:40]
         * 
         * v3 = v1.interpolate( v2 , 1 ) ;
         * trace(v3) ; // [Vector2 x:10 y:10]
         * 
         * v3 = v1.interpolate( v2 , 0.5 ) ;
         * trace(v3) ; // [Vector2 x:25 y:25]
         * </pre>
         * @param p1 The first point.
         * @param p2 The second Point.
         * @param level the The level of interpolation between the two points. Indicates where the new point will be, along the line between <code>p1</code> and <code>p2</code>. If f=1, pt1 is returned; if f=0, pt2 is returned.
         * @return The new interpolated Vector2 object.
         */
        public function interpolate( vector:Point , level:Number ):Vector2 
        {
            return new Vector2( vector.x + level * ( x - vector.x ) , vector.y + level * ( y - vector.y ) ) ;
        }
        
        /**
         * Invert the current Vector2 object.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.geom.Vector2 ;
         * 
         * var vector:Vector2 = new Vector2(10,20) ;
         * 
         * vector.invert() ;
         * 
         * trace( vector ) ;
         * </pre>
         */
        public function invert():void
        {
            x *= -1 ;
            y *= -1 ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the Vector2 is perpendicular with the passed-in Vector2.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.geom.Vector2 ;
         * 
         * var v1:Point = new Vector2(  0 , 10 ) ;
         * var v2:Point = new Vector2( 10 , 10 ) ;
         * var v3:Point = new Vector2( 10 ,  0 ) ;
         * 
         * trace( v1.isPerpendicularTo( v2 ) ) ; // false
         * trace( v1.isPerpendicularTo( v3 ) ) ; // true
         * </pre>
         * @param p the Point use to determinate if this Point object is perpendicular.
         * @return <code class="prettyprint">true</code> if the Point is perpendicular with the passed-in Point.
         */
        public function isPerpendicularTo( vector:Vector2 ):Boolean 
        {    
            return dot( vector ) == 0 ;
        }
        
        /**
         * Returns the new Vector2 with the maximum horizontal coordinate and the maximum vertical coordinate.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.geom.Vector2 ;
         * 
         * var v1:Vector2 = new Vector2(10,100) ;
         * var v2:Vector2 = new Vector2(100,10) ;
         * 
         * var v3:Vector2 = v1.max( v2 ) ;
         * trace( v3 ) ; // [Vector2 x:100 y:100]
         * </pre>
         * @param p The Vector2 passed in this method
         * @return The new Vector2 with the maximum horizontal coordinate and the maximum vertical coordinate.
         */
        public function max( vector:Vector2 ):Vector2 
        {
            return new Vector2( Math.max( x , vector.x ), Math.max( y , vector.y ) ) ;
        }
        
        /**
         * Returns the middle Vector2 object between 2 Points.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.geom.Vector2 ;
         * 
         * var v1:Vector2 = new Vector2(10,10) ;
         * var v2:Vector2 = new Vector2(20,20) ;
         * 
         * var middle:Vector2 = v1.middle( v2 ) ;
         * 
         * trace(middle) ;
         * </pre>
         * @return the middle Point between 2 Points.
         */
        public function middle( vector:Vector2 ):Vector2 
        {
            return new Vector2( ( x + vector.x ) / 2 , ( y + vector.y ) / 2) ;
        }
        
        /**
         * Returns a new Vector2 with the minimum horizontal coordinate and the minimize vertical coordinate.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * var v1:Vector2 = new Vector2(  10 , 100 ) ;
         * var v2:Vector2 = new Vector2( 100 ,  10 ) ;
         * 
         * var v3:Vector2 = v1.min( v2 ) ;
         * 
         * trace( v3 ) ; // [Vector2 x:10 y:10]
         * </pre>
         * @param vector The Vector2 passed in this method
         * @return The new Vector2 with the min horizontal coordinate and the minimize vertical coordinate.
         */
        public function min( vector:Vector2 ):Vector2 
        {
            return new Vector2( Math.min( x , vector.x ) , Math.min( y , vector.y ) ) ;
        }
        
        /**
         * Sets this Vector2 with negate coordinates.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.geom.Vector2 ;
         * 
         * var v:Vector2 = new Vector2(10,20) ;
         * 
         * trace(v) ; // [Vector2 x:10 y:20]
         * 
         * v.negate() ;
         * 
         * trace(v) ; // [Vector2 x:-10 y:-20]
         * 
         * v.negate() ;
         * 
         * trace(v) ; // [Vector2 x:10 y:20]
         * </pre>
         */
        public function negate():void 
        {
            x = -x ;
            y = -y ;
        }
        
        /**
         * Returns the new negate Vector2 of the specified Vector2 objet.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.geom.Vector2 ;
         * 
         * var v:Vector2 = new Point(10,20) ;
         * var n:Vector2 = Vector2.negate( v ) ;
         * 
         * trace(n) ; // [Vector2 x:-10 y:-20]
         * </pre>
         * @return The new negate Vector2 of the specified Vector2 objet.
         */
        public static function negate( vector:Vector2 ):Vector2 
        {
            return new Vector2( -vector.x , -vector.y ) ;
        }
        
        /**
         * Returns the normal value of this Vector2.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.geom.Vector2 ;
         * 
         * var v:Vector2 = new Vector2( 10 , 10 ) ;
         * var n:Vector2 = p.normal() ;
         *  
         * trace(n) ; // [Vector2 x:-10 y:10]
         * </pre>
         * @return the normal value of this vector.
         */
        public function normal():Vector2 
        {
            return new Vector2( -y , x ) ;
        }
        
        /**
         * Converts a pair of polar coordinates to a Cartesian point coordinate.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * var polar:Vector2 = Vector2.polar( 5, Math.atan(3/4) ) ;
         * trace(polar) ; // [Vector2 x:4 y:3]
         * </pre>
         * @param length The length coordinate of the polar pair.
         * @param angle The angle, in radians, of the polar pair.
         * @return The new Cartesian vector.
          */
        public static function polar( length:Number , angle:Number ):Vector2 
        {
            return new Vector2( length * Math.cos(angle), length * Math.sin(angle) ) ;
        }
        
        /**
         * Computes the power of the vector.
         * @param value the value of the pow..
         */
        public function pow( value:Number ):void
        {
            x = Math.pow( x , value ) ;
            y = Math.pow( y , value ) ;
        }
        
        /**
         * Computes the power of the specified Vector2.
         * @param vector the Vector2 reference.
         * @param value the value of the pow..
         * @return A new Vector2 powered by the method.
         */
        public static function pow( vector:Vector2, value:Number ):Vector2
        {
            return new Vector2( Math.pow( vector.x, value ) , Math.pow( vector.y, value ) ) ;
        }
        
        /**
         * Returns the projection of a Vector2 with the specified Vector2 passed in argument.
         * @param vector the Vector2 to project with this current Vector2.
         * @return the new project Vector2 object.
         */
        public function project( vector:Vector2 ):Vector2 
        {
            var l:Number = vector.dot(vector) ;
            if( l == 0 ) 
            {
                return clone() as Vector2 ;
            }
            else 
            {
                return Vector2.scale( this , dot( vector ) / l ) ;
            }
        }
        
        /**
         * Returns the size of the projection of this Point with an other Point.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
          * var p1:Point = new Point(10,10) ;
         * var p2:Point = new Point(100,200) ;
         * var size:Number = p1.getProjectionLength(p2) ;
         * trace(size) ; // 0.06
         * </pre>
         * @param p the Point use to calculate the length of the projection.
         * @return the size of the projection of this Point with an other Point.
          */
        public function projectionLength( v:Vector2 ):Number 
        {
            var l:Number = v.dot(v) ;
            return (l==0) ? 0 : Math.abs(dot(v)/l) ;
        }
        
        /**
         * Reflects the current Vector2 object with the passed-in normal Vector2 argument.
         */
        public function reflect( normal:Vector2 ):void
        {
            var d:Number = 2 * dot( normal ) ;
            x -= normal.x * d ;
            y -= normal.y * d ;
        }
        
        /**
         * Creates a new Vector2 object, the reflect of the specific vector.
         * @return A new reflect Vector2.
         */
        public static function reflect( vector:Vector2 , normal:Vector2 ):Vector2
        {
            var dot:Number = 2 * vector.dot( normal ) ;
            return new Vector2( vector.x - ( normal.x * dot ) , vector.y - ( normal.y * dot ) ) ;
        }
        
        /**
         * Rotates the Vector2 object with the specified angle passed-in argument.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.geom.Vector2 ;
         * import graphics.geom.Vectors2 ;
         * 
         * var v:Vector2 = new Vector2(100,100) ;
         * 
         * Vectors2.rotate(v, Math.PI) ;
         * 
         * trace(v) ;
         * </pre> 
         * @param angle the Angle to rotate the specified Vector2 object (in degrees if the "degrees" property is true else in radians).
         * @see degrees
         */
        public function rotate( angle:Number ):void 
        {
            var ca:Number = degrees ? cosD (angle) : Math.sin( angle ) ;
            var sa:Number = degrees ? sinD (angle) : Math.sin( angle ) ;
            x = x * ca - y * sa ;
            y = x * ca + y * sa ;
        }
        
        /**
         * Rotates the Vector2 with the specified <code class="prettyprint">angle</code> in argument and creates a new Vector2.
         * @param angle the Angle to rotate this Vector2.
         * @return The rotate new Vector2.
         */
        public static function rotate( vector:Vector2 , angle:Number ):Vector2 
        {
            var v:Vector2 = vector.clone() as Vector2;
            v.rotate (angle) ;
            return v ;
        }
        
        /**
         * Scales the vector object with the input value.
         * @param value a real number to scale the current vector object.
         */
        public function scale( value:Number ):void
        {
            x *= value ;
            y *= value ;
        }
        
        /**
         * Scales a new Vector2 object with the specified Vector2.
         * @param vector the Vector2 reference to transform.
         * @param value a real number to scale the current Vector2.
         * @return A new Vector2 scaled by the value passed in in this method.
         */
        public static function scale( v:Vector2, value:Number ):Vector2
        {
            return new Vector2 ( v.x * value , v.y * value ) ;
        }
        
        /**
         * Sets the current Vector2 with the passed-in Vector2 argument.
         * <pre class="prettyprint">
         * import graphics.geom.Vector2 ;
         * 
         * var v1:Vector2 = new Vector2( 10 , 20 ) ;
         * var v2:Vector2 = new Vector2( 40 , 60 ) ;
         * 
         * v1.set( v2 ) ;
         * 
         * trace( v1 ) ; 
         * </pre>
         * @param vector The Vector2 object use to calculate the cross value. 
         * @return The cross value of the current Vector2 object with the Vector2 passed in argument.
         */
        public function set( vector:Vector2 ):void 
        {
            x = vector.x ;
            y = vector.y ;
        }
        
        /**
         * Sets the current Vector2 object with the passed-in Object argument.
         * @param o The Object to set the vector with this x and y properties.
         */
        public function setByObject( o:Object ):void
        {
            x = o.x ;
            y = o.y ;
        }
        
        /**
         * Sets the current Vector2 object with the passed-in flash.geom.Point argument.
         * @param p The Point to set the vector.
         */
        public function setByPoint( p:Point ):void
        {
            x = p.x ;
            y = p.y ;
        }
        
        /**
         * Returns the squared distance between 2 vectors.
         * @param v1 the first vector.
         * @param v2 the second vector.
         * @return the squared distance between 2 vectors.
         */
        public static function squaredDistance( v1:Vector2 , v2:Vector2 ):Number
        {
            var dx:Number = v2.x - v1.x ;
            var dy:Number = v2.y - v1.y ; 
            return (dx * dx) + (dy * dy) ;
        }
        
        /**
         * Computes the substraction of the current vector object with an other.
         * @param v the vector to substract.
         */
        public function substract( v:Vector2 ):void
        {
            x -= v.x ;
            y -= v.y ;
        }
        
        /**
         * Computes the substraction of two Vector2.
         * @param v1 a Vector2 to substract.
         * @param v2 a Vector2.
         * @return the substraction result of two Vector2.
         */
        public static function substract( v1:Vector2 , v2:Vector2 ):Vector2
        {
            return new Vector2( v1.x - v2.x , v1.y - v2.y ) ;
        }
        
        /**
         * Swap the horizontal and vertical coordinates of two Vector2 objects.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.geom.Vector2 ;
         * 
         * var v1:Vector2 = new Vector2( 10 , 20 ) ;
         * var v2:Vector2 = new Vector2( 30 , 40 ) ;
         * 
         * trace( v1 + " / " + v2 ) ; // [Vector2 x:10 y:20] / [Vector2 x:30 y:40]
         * 
         * v1.swap( v2 ) ;
         * 
         * trace( v1 + " / " + v2 ) ; // [Vector2 x:30 y:40] / [Vector2 x:10 y:20]
         * </pre>
         */
        public function swap( vector:Vector2 ):void 
        {
            var tx:Number = x ;
            var ty:Number = y ;
            x = vector.x ;
            y = vector.y ;
            vector.x = tx ;
            vector.y = ty ;
        }
        
        /**
         * Returns the Object representation of this object.
         * @return the Object representation of this object.
         */
        public function toObject():Object 
        {
            return { x:x , y:y } ;
        }
        
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public function toSource( indent:int = 0 ):String 
        {
            return "new graphics.geom.Vector2(" +  x.toString()  + "," + y.toString() + "," + ( degrees ? "true" : "false" ) +")" ;
        }
        
        /**
         * Returns the string representation of the object.
         * @return the string representation of the object.
         */
        public override function toString():String
        {
            return "[Vector2 x:" + x + " y:" + y + "]" ;
        }
    }
}
