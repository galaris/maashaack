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
    import core.maths.cosD;
    import core.maths.sinD;

    /**
     * Represents a vector in a 3D world with the coordinates x, y and z.
     */
    public class Vector3 implements Geometry 
    {
        /**
         * Creates a new <code class="prettyprint">Vector3</code> instance.
         * @param x the x coordinate.
         * @param y the y coordinate.
         * @param z the z coordinate.
         */ 
        public function Vector3( x:Number = 0, y:Number = 0 ,  z:Number = 0 )
        {
            this.x = isNaN(x) ? 0 : x ;
            this.y = isNaN(y) ? 0 : y ;
            this.z = isNaN(z) ? 0 : z ;
        }
        
        /**
         * Indicates the relative "backward" direction.
         */
        public static const BACKWARD:Vector3 = new Vector3( 0 ,  0 , -1 ) ;
        
        /**
         * Indicates the relative "down" direction.
         */
        public static const DOWN:Vector3 = new Vector3( 0 , -1 ,  0 );
        
        /**
         * Indicates the relative "forward" direction.
         */
        public static const FORWARD :Vector3 = new Vector3( 0 , 0 , 1 ) ;
        
        /**
         * Indicates the relative "left" direction.
         */
        public static const LEFT:Vector3 = new Vector3( -1 , 0 , 0 );
        
        /**
         * Indicates the relative "right" direction.
         */
        public static const RIGHT:Vector3 = new Vector3( 1 , 0 , 0 ) ;
        
        /**
         * Indicates the relative "up" direction.
         */
        public static const UP:Vector3 = new Vector3( 0 , 1 , 0 );
        
        /**
         * Defines the Vector3 object with the x, y and z properties set to zero.
         */
        public static var ZERO:Vector3 = new Vector3(0,0,0) ;
        
        /**
         * Indicates the length of the vector.
         */
        public function get length():Number
        {
            return Math.sqrt( x*x + y*y + z*z ) ;
        }
        
        /**
         * Defines the x coordinate.
         */
        public var x:Number ;
        
        /**
         * Defines the y coordinate.
         */
        public var y:Number ;
        
        /**
         * Defined the z coordinate.
         */
        public var z:Number;
        
        /**
         * Computes the addition of two vectors.
         * @param v the vector object to add.
         */
        public function add( v:Vector3 ):void
        {
             x += v.x ;
             y += v.y ;
             z += v.z ;
        }
        
        /**
         * Computes the addition of two Vector3.
         * @param v1 a Vector3 to concat.
         * @param v2 a Vector3 to concat.
         * @return the addition result of two Vector3.
         */
        public static function add( v1:Vector3 , v2:Vector3 ):Vector3
        {
            return new Vector3( v1.x + v2.x , v1.y + v2.y , v1.z + v2.z ) ;
        }
        
        /**
         * Returns the angle in radian between the two 3D vectors. The formula used here is very simple.
         * It comes from the definition of the dot product between two vectors.
         * @param v1 Vector3 The first Vector3.
         * @param v2 Vector3 The second Vector3.
         * @return the angle in radian between the two vectors.
         */
        public static function angle( v1:Vector3, v2:Vector3 ):Number
        {
            var ncos:Number = ( v1.dot( v2 ) ) / ( v1.length * v2.length );
            var sin2:Number = 1 - (ncos * ncos) ;
            if ( sin2 < 0 )
            {
                sin2 = 0 ;
            }
            return Math.atan2( Math.sqrt(sin2), ncos ) ; // TODO test it
        }
        
        /**
         * Returns a shallow copy of this instance.
         * @return a shallow copy of this instance.
         */
        public function clone():*
        {
            return new Vector3( x , y , z ) ;
        }
        
        /**
         * Computes the cross product of two Vector3s.
         * @param vector The <code class="prettyprint">Vector3</code> reference.
         * @return the <code class="prettyprint">Vector3</code> resulting of the cross product.
         */
        public function cross( vector:Vector3 ):Vector3
        {
            return new Vector3
            (     
                (vector.y * z) - (vector.z * y) ,
                (vector.z * x) - (vector.x * z) ,
                (vector.x * y) - (vector.y * x)
            );
        }
        
        /**
         * Returns the dot value of the passed-in Vector3 with the current Vector3 object.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.geom.Vector3 ;
         * 
         * var v1:Vector3 = new Vector3(10,20,30) ;
         * var v2:Vector3 = new Vector3(40,60,70) ;
         * 
         * trace( v1.dot( v2 ) ) ; 
         * </pre>
         * @param vector the Vector2 object to calculate the dot value.
         * @return the dot value.
         */
        public function dot( vector:Vector3 ):Number 
        {
            return ( x * vector.x ) + ( y * vector.y ) + ( z * vector.z ) ;
        }
        
        /**
          * Compares the specified object with this object for equality.
          * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
          */
        public function equals( o:* ):Boolean 
        {
            if ( o != null && o is Vector3 )
            {
                return (o.x == x) && (o.y == y) && (o.z == z) ;
            }
            return false ;
        }
        
        /**
         * Sets this Vector2 with negate coordinates.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.geom.Vector3 ;
         * 
         * var v:Vector3 = new Vector3(10,20,30) ;
         * 
         * trace(v) ; // [Vector3 x:10 y:20 z:30]
         * 
         * v.negate() ;
         * 
         * trace(v) ; // [Vector3 x:-10 y:-20 z:-30]
         * 
         * v.negate() ;
         * 
         * trace(v) ; // [Vector3 x:10 y:20 z:30]
         * </pre>
         */
        public function negate():void 
        {
            x = -x ;
            y = -y ;
            z = -z ;
        }
        
        /**
         * Returns the new negate Vector2 of the specified Vector2 objet.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.geom.Vector3 ;
         * 
         * var v:Vector3 = new Point(10,20,30) ;
         * var n:Vector3 = Vector3.negate( v ) ;
         * 
         * trace(n) ; // [Vector3 x:-10 y:-20 z:-30]
         * </pre>
         * @return The new negate Vector3 of the specified Vector2 objet.
         */
        public static function negate( vector:Vector3 ):Vector3 
        {
            return new Vector3( -vector.x , -vector.y , -vector.z ) ;
        }
        
        /**
         * Normalize the vector.
         * @return <code class="prettyprint">true</code> of the normalize method is success else false for mistake.
         */
        public function normalize():Boolean
        {
            var norm:Number = length;
            if( norm == 0 || norm == 1) 
            {
                return false ;
            }    
            x /= norm ;
            y /= norm ;
            z /= norm ;
            return true ;
        }
        
        /**
         * Calculates and returns the perspective ratio needed to scale an object correctly.
         * <p><b>Example :</b></p>
         * <code class="prettyprint">
         * import graphics.geom.Vector3 ;
         * 
         * var v:Vector3 = new Vector3(50,20,40);
         * var p:Number  = v.perspective();
         * 
         * trace(p) ;
         * </code>
         * @param distance The viewing distance of the projection (default value 300).
         * @return the perspective ratio needed to scale an object correctly.
         */
        public function perspective( distance:Number = 300 ):Number 
        {
            distance = isNaN(distance) ? 300 : distance ;
            return distance / (z + distance) ;
        }
        
        /**
         * Computes the power of the vector.
         * @param value the value of the pow..
         */
        public function pow( value:Number ):void
        {
            x = Math.pow( x , value ) ;
            y = Math.pow( y , value ) ;
            z = Math.pow( z , value ) ;
        }
        
        /**
         * Computes the power of the specified Vector3.
         * @param vector the Vector3 reference.
         * @param value the value of the pow..
         * @return A new Vector3 powered by the method.
         */
        public static function pow( vector:Vector3, value:Number ):Vector3
        {
            return new Vector3( Math.pow( vector.x, value ) , Math.pow( vector.y, value ) , Math.pow( vector.z, value ) ) ;
        }
        
        /**
         * Performs a perspective projection on a 3d point. It converts (x, y, z) coordinates to a 2d location (x, y) on the screen.
         * <p><b>Example :</b></p>
         * <code class="prettyprint">
         * import graphics.geom.Vector3 ;
         * 
         * var v:Vector3 = new Vector3(50,20,40) ;
         * v.project();
         * 
         * trace(v) ;
         * </code>
         * @param v the Vector3 reference.
         * @param perspective The perspective ratio. If no value is specified, it is calculated automatically by calling the getPerspective() method.
         */
        public function project( perspective:Number ):void 
        {
            perspective = isNaN(perspective) ? this.perspective() : perspective ;
            x *= perspective ;
            y *= perspective ;
            z  = 0 ;
        }
        
        /**
         * Performs a perspective projection on a 3d point. It converts (x, y, z) coordinates to a 2d location (x, y) on the screen.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.geom.Vector3 ;
         * 
         * var v:Vector3 = new Vector3(50,20,40) ;
         * var p:Vector3 = Vector3.project(v);
         * 
         * trace(v + " / " + p) ;
         * </pre>
         * @param perspective The perspective ratio. If no value is specified, it is calculated automatically by calling the getPerspective() method.
         */
        public static function project( v:Vector3, perspective:Number ):Vector3
        {
            var c:Vector3 = v.clone() ;
            c.project( perspective ) ;
            return c ;
        }
        
        /**
         * Rotates the current vector object around the x-axis by a certain amount of degrees.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.geom.Vector3 ;
         * 
         * var v:Vector3 = new Vector3(1,4,7) ;
         * 
         * v.rotateX( 180 );
         * trace( v ) ;
         * </pre>
         * @param angle    The amount of degrees that the current vector object will be rotated by.
         */
        public function rotateX( angle:Number ):void 
        {
            rotateXTrig( cosD( angle ), sinD( angle ));
        }
        
        /**
         * Rotates the current vector object around the x-axis by the cosine and sine of an angle.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.geom.Vector3 ;
         * import graphics.numeric.Degrees ;
         * 
         * var v:Vector3 = new Vector3(1,4,7);
         * 
         * var cosAngle:Number = cosD(180);
         * var sinAngle:Number = sinD(180);
         * 
         * v.rotateXTrig( cosAngle , sinAngle ) ;
         * 
         * trace (v);
         * </pre>
         * @param ca The cosine of the angle to rotate the current vector object by.
         * @param sa The sine of the angle to rotate the current vector object by.
         */
        public function rotateXTrig ( ca:Number, sa:Number ):void 
        {
            y = y * ca - z * sa ;
            z = y * sa + z * ca ;
        }
            
        /**
         * Rotates the current vector object around the y-axis by a certain amount of degrees.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.geom.Vector3 ;
         * 
         * var v:Vector3 = new Vector3(1,4,7);
         * 
         * v.rotateY( 180 );
         * trace(v);
         * </pre>
         * @param angle The amount of degrees that the current vector object will be rotated by.
         */
        public function rotateY( angle:Number ):void 
        {
            rotateYTrig( cosD(angle), sinD(angle) ) ;
        }
        
        /**
         * Rotates the current vector object around the y-axis by the cosine and sine of an angle.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.geom.Vector3 ;
         * import graphics.numeric.Degrees ;
         * 
         * var v:Vector3       = new Vector3(3,-8,5);
         * 
         * var cosAngle:Number = Trigo.cosD(90);
         * var sinAngle:Number = Trigo.sinD(90);
         * 
         * v.rotateYTrig( cosAngle, sinAngle ) ;
         * 
         * trace(v) ;
         * </pre>
         * @param ca The cosine of the angle to rotate the current vector object by.
         * @param sa The sine of the angle to rotate the current vector object by.
         */
        public function rotateYTrig( ca:Number, sa:Number ):void 
        {
            x = x *  ca + z * sa ;
            z = x * -sa + z * ca ;
        }
            
        /**
         * Rotates the current vector object around the z-axis by a certain amount of degrees.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.geom.Vector3 ;
         * 
         * var v:Vector3 = new Vector3(1,4,7) ;
         * 
         * v.rotateZ( 180 ) ;
         * trace(v);
         * </pre>
         * @param angle    The amount of degrees that the current vector object will be rotated by.
         */
        public function rotateZ( angle:Number ):void 
        {
            rotateZTrig( cosD(angle), sinD(angle) );
        }
        
        /**
         * Rotates the current vector object around the z-axis by the cosine and sine of an angle.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.geom.Vector3 ;
         * import graphics.numeric.Degrees ;
         * 
         * var v:Vector3 = new Vector3(6,1,4) ;
         * 
         * var cosAngle:Number = cosD(45) ;
         * var sinAngle:Number = sinD(45) ;
         * 
         * v.rotateZTrig( cosAngle , sinAngle ) ;
         * trace(v);
         * </pre>
         * @param ca The cosine of the angle to rotate the current vector object by.
         * @param sa The sine of the angle to rotate the current vector object by.
         */
        public function rotateZTrig ( ca:Number, sa:Number):void 
        {
            x = x * ca - y * sa ;
            y = x * sa + y * ca ;
        }
        
        /**
         * Rotates the current vector object around the x and y axes by a certain amount of degrees.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.geom.Vector3 ;
         * 
         * var v:Vector3 = new Vector3(8,0,0) ;
         * 
         * v.rotateXY( 45 , 45 ) ;
         * 
         * trace(v) ;
         * </pre>
         * @param a The amount of degrees that the current vector object will be rotated around the x-axis by.
         * @param b The amount of degrees that the current vector object will be rotated around the y-axis by.
         */
        public function rotateXY( a:Number, b:Number):void 
        {
            rotateXYTrig( cosD(a), sinD(a), cosD(b), sinD(b) ) ;
        }
        
        /**
         * Rotates the current vector object around the x and y axes by the cosine and sine of an angle.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.geom.Vector3 ;
         * import graphics.numeric.Degrees ;
         * 
         * var v:Vector3 = new Vector3(6,1,4) ;
         * 
         * var cosAngleA:Number = cosD(45) ;
         * var sinAngleA:Number = sinD(45) ;
         * 
         * var cosAngleB:Number = cosD(90) ;
         * var sinAngleB:Number = sinD(90) ;
         * 
         * v.rotateXYTrig( cosAngleA, sinAngleA, cosAngleB, sinAngleB ) ;
         * 
         * trace(v) ;
         * </pre>
         * @param ca The cosine of the angle to rotate the current vector object around the x-axis by.
         * @param sa The sine of the angle to rotate the current vector object around the x-axis by.
         * @param cb The cosine of the angle to rotate the current vector object around the y-axis by.
         * @param sb The sine of the angle to rotate the current vector object around the y-axis by.
         */
        public function rotateXYTrig( ca:Number, sa:Number, cb:Number, sb:Number ):void 
        {
            // x-axis rotation
            var rz:Number = y * sa + z * ca;
            y = y * ca - z * sa ;
            // y-axis rotation
            z = x * -sb + rz * cb ;
            x = x * cb + rz * sb  ;
        }
        
        /**
         * Rotates the current vector object around the x, y and z axes by a certain amount of degrees.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.geom.Vector3
         * 
         * var v:Vector3 = new Vector3(8,0,0);
         * 
         * v.rotateXYZ(45,45,45);
         * 
         * trace (v);
         * </pre>
         * @param a The amount of degrees that the current vector object will be rotated around the x-axis by.
         * @param b The amount of degrees that the current vector object will be rotated around the y-axis by.
         * @param c The amount of degrees that the current vector object will be rotated around the z-axis by.
         */
        public function rotateXYZ ( v:Vector3, a:Number, b:Number, c:Number):void 
        {
            rotateXYZTrig( cosD(a), sinD(a), cosD(b), sinD(b), cosD(c), sinD(c));
        }
            
        /**
         * Rotates the current vector object around the x, y and z axes by the cosine and sine of an angle.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.geom.Vector3 ;
         * import graphics.numeric.Degrees ;
         * 
         * var v:Vector3 = new Vector3(6,1,4) ;
         * 
         * var cosAngleA:Number = cosD(45) ;
         * var sinAngleA:Number = sinD(45) ;
         * 
         * var cosAngleB:Number = cosD(90) ;
         * var sinAngleB:Number = sinD(90) ;
         * 
         * var cosAngleC:Number = cosD(135) ;
         * var sinAngleC:Number = sinD(135) ;
         * 
         * v.rotateXYZTrig( cosAngleA, sinAngleA, cosAngleB, sinAngleB, cosAngleC, sinAngleC ) ;
         * 
         * trace(v) ;
         * </pre>
         * @param ca The cosine of the angle to rotate the current vector object around the x-axis by.
         * @param sa The sine of the angle to rotate the current vector object around the x-axis by.
         * @param cb The cosine of the angle to rotate the current vector object around the y-axis by.
         * @param sb The sine of the angle to rotate the current vector object around the y-axis by.
         * @param cc The cosine of the angle to rotate the current vector object around the z-axis by.
         * @param sc The sine of the angle to rotate the current vector object around the z-axis by.
         */
        public function rotateXYZTrig ( ca:Number, sa:Number, cb:Number, sb:Number, cc:Number, sc:Number):void 
        {
            // x-axis rotation
            var ry:Number = y * ca - z * sa ;
            var rz:Number = y * sa + z * ca ;
            // y-axis rotation
            var rx:Number = x * cb + rz * sb ;
            z = x * -sb + rz * cb ;
            // z-axis rotation
            x = rx * cc - ry * sc ;
            y = rx * sc + ry * cc ;
        }
        
        /**
         * Scales the vector object with the input value.
         * @param value a real number to scale the current vector object.
         */
        public function scale( value:Number ):void
        {
            x *= value ;
            y *= value ;
            z *= value ;
        }
        
        /**
         * Scales a new Vector3 object with the input value.
         * @param vector the Vector3 reference to transform.
         * @param value a real number to scale the current Vector3.
         * @return A new Vector3 scaled by the value passed in in this method.
         */
        public static function scale( v:Vector3, value:Number ):Vector3
        {
            return new Vector3 ( v.x * value , v.y * value , v.z * value ) ;
        }
        
        /**
         * Sets the specified <code class="prettyprint">Vector3</code> object with the second <code class="prettyprint">Vector3</code> object passed in argument.
         * @param vector the <code class="prettyprint">Vector3</code> to set the current Vector3.
         */
        public function set( vector:Vector3 ):void
        {
            x = vector.x ;
            y = vector.y ;
            z = vector.z ;
        }
        
        /**
         * Returns the squared length of this vector.
         * @return the squared length of this vector.
         */
        public function squaredLength():Number
        {
            return x*x + y*y + z*z ;
        }
        
        /**
         * Computes the substraction of the current vector object with an other.
         * @param v the vector to substract.
         */
        public function substract( v:Vector3 ):void
        {
            x -= v.x ;
            y -= v.y ;
            z -= v.z ;
        }
        
        /**
         * Computes the substraction of two Vector3 and creates a new Vector3.
         * @param v1 a Vector3 to substract.
         * @param v2 a Vector3.
         * @return the substraction result of two Vector3.
         */
        public static function substract( v1:Vector3 , v2:Vector3 ):Vector3
        {
            return new Vector3( v1.x - v2.x , v1.y - v2.y , v1.z - v2.z ) ;
        }
        
        /**
         * Swap the horizontal and vertical coordinates of two Vector2 objects.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.geom.Vector3 ;
         * 
         * var v1:Vector3 = new Vector3( 10 , 20 , 30) ;
         * var v2:Vector3 = new Vector3( 40 , 50 , 60) ;
         * 
         * trace( v1 + " / " + v2 ) ; // [Vector3 x:10 y:20 z:30] / [Vector3 x:40 y:50 z:60]
         * 
         * v1.swap( v2 ) ;
         * 
         * trace( v1 + " / " + v2 ) ; // [Vector3 x:40 y:50 z:60] / [Vector3 x:10 y:20 z:30]
         * </pre>
         */
        public function swap( vector:Vector3 ):void 
        {
            var tx:Number = x ;
            var ty:Number = y ;
            var tz:Number = z ;
            x = vector.x ;
            y = vector.y ;
            z = vector.z ;
            vector.x = tx ;
            vector.y = ty ;
            vector.z = tz ;
        }
        
        /**
         * Returns the Object representation of this object.
         * @return the Object representation of this object.
         */
        public function toObject():Object 
        {
            return { x:x , y:y , z:z } ;
        }
        
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public function toSource( indent:int = 0 ):String 
        {
            return "new graphics.geom.Vector3(" +  x.toString()  + "," + y.toString()  + "," + z.toString() + ")" ;
        }
        
        /**
         * Returns the string representation of the object.
         * @return the string representation of the object.
         */
        public function toString():String
        {
            return "[Vector3 x:" + x + " y:" + y + " z:" + z + "]" ;
        }
    }
}