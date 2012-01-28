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
    import core.maths.DEG2RAD;
    import core.maths.EPSILON;
    import core.maths.RAD2DEG;
    import graphics.Geometry;
    
    /**
     * Quaternions are hypercomplex numbers used to represent spatial rotations in three dimensions. 
     * This class encapsulates an Hamiltonian quaternion having the form <code class="prettyprint">xi + yj + zk + w</code>.
     */
    public class Quaternion implements Geometry 
    {
        /**
         * Creates a new <code class="prettyprint">Quaternion</code> instance.
         * @param x the x coordinate.
         * @param y the y coordinate.
         * @param z the z coordinate.
         * @param w the transform component of the quaternion.
          */ 
        public function Quaternion(x:Number = 0, y:Number = 0, z:Number = 0 , w:Number=0 )
        {
            this.x = isNaN(x) ? 0 : x ;
            this.y = isNaN(y) ? 0 : y ;
            this.z = isNaN(z) ? 0 : z ;
            this.w = isNaN(w) ? 0 : w ;
        }
        
        /**
         * Defined the x component of the quaternion.
         */
        public var x:Number ;
        
        /**
         * Defined the y component of the quaternion.
         */
        public var y:Number ;
        
        /**
         * Defined the z component of the quaternion.
         */
        public var z:Number ;
        
        /**
         * Represents the scalar value of the quaternion.
         */
        public var w:Number ;
        
        /**
         * Adds the values of the specified Quaternion.
         */
        public function add( q:Quaternion ):void 
        {
            x += q.x ;
            y += q.y ;
            z += q.z ;
            w += q.w ;
        }
        
        /**
         * Sets the quaternion with values representing the given rotation around a vector.
         * @param x The x value of the rotation vector.
         * @param y The y value of the rotation vector.
         * @param z The z value of the rotation vector.
         * @param angle The angle in radians of the rotation.
         */
        public function axis( x:Number, y:Number, z:Number, angle:Number ):void
        {
            var s:Number = Math.sin( angle / 2 ) ;
            var c:Number = Math.cos( angle / 2 ) ;
            this.x = x * s ;
            this.y = y * s ;
            this.z = z * s ;
            this.w = c ;
            normalize();
        }
        
        /**
         * Returns a shallow copy of this instance.
         * @return a shallow copy of this instance.
         */
        public function clone():*
        {
            return new Quaternion(x, y, z, w) ;
        }
        
        /**
         * Conjugates the Quaternion.
         */
        public function conjugate():void
        {
            x = -x ;
            y = -y ;
            z = -z ;
        }
        
        /**
         * Returns the dot product of two quaternions.
         * @param q The quaternion to calculate the dot product.
         * @return The dot product of the two quaternions.
         */
        public function dot( q:Quaternion ):Number
        {
            return ( x * q.x ) + ( y * q.y ) + ( z * q.z ) + ( w * q.w ) ;
        }
        
        /**
         * Compares the specified object with this object for equality.
         * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
         */
        public function equals( o:* ):Boolean
        {
            if ( o is Quaternion )
            {
                return (o.x == x) && (o.y == y) && (o.z == z) && (o.w == w) ;
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Calculates the exponential of a quaternion.
         * @return The new Quaternion reference.
         */
        public function exp():Quaternion
        {
            var a:Number = Math.sqrt( x*x + y*y + z*z ) ;
            var s:Number = Math.sin( a ) ;
            var c:Number = Math.cos( a ) ;
            var q:Quaternion = new Quaternion() ;
            q.w = c ;
            if ( a > 0 )
            {
                q.x = s * x / a ;
                q.y = s * y / a ;
                q.z = s * z / a ;
            }
            else
            {
                q.x = q.y = q.z = 0 ;
            }
            return q ;
        }
        
        /**
         * Sets the quaternion with values representing the given euler rotation. 
         * <p><b>Note :</b> that we are applying in order: pitch, yaw, roll but we've ordered them in x, y, and z for convenience.</p>
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.geom.Quaternion ;
         * import graphics.numeric.Trigo ;
         * 
         * var q:Quaternion = new Quaternion();
         * 
         * q.euler( 360 &#42; DEG2RAD , 180 &#42; DEG2RAD , 90 &#42; DEG2RAD ) ;
         * trace(q) ;
         * trace(q.getEulerAngles(true) ) ;
         * 
         * q.euler( 360, 180 , 90 , true ) ;
         * trace(q) ;
         * trace(q.getEulerAngles(true) ) ;
         * 
         * q.euler(40,80,180,true) ;
         * trace(q) ;
         * trace(q.getEulerAngles(true) ) ;
         * 
         * q.euler( 2 * Math.PI , Math.PI , Math.PI / 2 ) ;
         * trace(q.getEulerAngles(true) ) ;
         * </pre>
         * @param roll The angle of the rotation around the y axis (heading/azimuth/θ).
         * @param pitch The angle of the rotation around the z axis (attitude/elevation/φ).
         * @param yaw The angle of the rotation around the x axis (bank/tilt/ψ).
         * @param degrees Indicates if the angle are in degrees or in radians (default).
         */
        public function euler( roll:Number , pitch:Number, yaw:Number , degrees:Boolean = false ):void
        {
            if( degrees )
            {
               roll  *= DEG2RAD ;
               pitch *= DEG2RAD ;
               yaw   *= DEG2RAD ;
            }
            
            var c1:Number ; var s1:Number ;
            var c2:Number ; var s2:Number ;
            var c3:Number ; var s3:Number ;
            
            var a:Number ;
            
            ///////// roll (y)
            
            a  = roll * 0.5 ;
            
            c1 = Math.cos(a) ;
            s1 = Math.sin(a) ;
            
            ///////// pitch (z)
            
            a  = pitch * 0.5 ;
            
            c2 = Math.cos(a) ;
            s2 = Math.sin(a) ;
            
            ///////// yaw (x)
            
            a  = yaw * 0.5 ;
            
            c3 = Math.cos(a) ;
            s3 = Math.sin(a) ;
            
            // calculates
            
            var c1c2:Number = c1 * c2 ;
            var c1s2:Number = c1 * s2 ;
            var s1c2:Number = s1 * c2 ;
            var s1s2:Number = s1 * s2 ;
            
            w = ( c1c2*c3 ) - ( s1s2*s3 ) ;
            x = ( c1c2*s3 ) + ( s1s2*c3 ) ;
            y = ( s1c2*c3 ) + ( c1s2*s3 ) ;
            z = ( c1s2*c3 ) - ( s1c2*s3 ) ;
        
        }
        
        /**
         * Returns the Vector3 representation of the roll/pitch/yaw euler angles of the current quaternion.
         * <p><b>Note :</b></p>
         * <pre>
         * roll  = Heading  = rotation about y axis
         * pitch = Attitude = rotation about z axis
         * yaw   = Bank     = rotation about x axis
         * </pre>
         * <p><b> used in this class :</b> <a href="http://www.euclideanspace.com/maths/standards/index.htm">Standards</a></p>
         * @return the Vector3 representation of the roll/pitch/yaw euler angles of the current quaternion.
         */
        public function getEulerAngles( degrees:Boolean = false ):Vector3 
        {
            var roll:Number  ; // heading
            var pitch:Number ; // attitude
            var yaw:Number   ; // bank
            
            var t:Number = x * y + z * w ;
            if (t > 0.499) // Singularity at north pole. 
            {
                roll  = 2 * Math.atan2( x , w ) ;
                pitch = Math.PI / 2;
                yaw   = 0;
            }
            else if (t < -0.499) // Singularity at south pole. 
            {
                roll  = -2 * Math.atan2( x , w ) ;
                pitch = - Math.PI / 2;
                yaw   = 0 ;
            }
            else // General case. 
            {
                var sx:Number = x * x;
                var sy:Number = y * y;
                var sz:Number = z * z;
                roll  = Math.atan2( (2*y*w) - (2*x*z) , 1 - (2*sy) - (2*sz) ) ;
                pitch = Math.asin( 2*t ) ;
                yaw   = Math.atan2( (2*x* w) - (2*y* z) , 1 - (2*sx) - (2*sz) );
            }
            if ( degrees )
            {
                roll  *= RAD2DEG ;
                pitch *= RAD2DEG ;
                yaw   *= RAD2DEG ;
            }
            return new Vector3( roll , pitch , yaw ) ;
        }
        
        /**
         * Sets the Quaternion to be identity {0,0,0,1}.
         */
        public function identity():void 
        {
            x = 0 ;
            y = 0 ;
            z = 0 ;
            w = 1 ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the Quaternion is {0,0,0,1}.  
         * @return true if this Quaternion is {0,0,0,1}.
         */
        public function isIdentity():Boolean 
        {
            return x == 0 && y == 0 && z == 0 && w == 1 ; 
        }
        
        /**
         * Conjugates and renormalizes a quaternion.
         */
        public function invert():void 
        {
            conjugate() ;
            var l:Number = sizeSquared() ;
            x /= l ;
            y /= l ;
            z /= l ;
            w /= l ; 
        }
        
        /**
         * Calculates the natural logarithm of a quaternion.
         * @return The new Quaternion reference.
         */
        public function log():Quaternion
        {
            var a:Number = Math.acos( w ) ;
            var s:Number = Math.sin( a ) ;
            var r:Quaternion = new Quaternion() ;
            r.w = 0 ;
            if ( s > 0 )
            {
                r.x = a * x / s ;
                r.y = a * y / s ;
                r.z = a * z / s ;
            }
            else
            {
                r.x = r.y = r.z = 0 ;
            }
            return r ;
        }
        
        /**
         * Multiply the Quaternion with an other Quaternion.
         * @param q The Quaternion to multiply with the current Quaternion object.
         */
        public function multiply( q:Quaternion ):void
        {
            x = ( w * q.x ) + ( x * q.w ) + ( y * q.z ) - ( z * q.y ) ;
            y = ( w * q.y ) + ( y * q.w ) + ( z * q.x ) - ( x * q.z ) ;
            z = ( w * q.z ) + ( z * q.w ) + ( x * q.y ) - ( y * q.x ) ;
            w = ( w * q.w ) - ( x * q.x ) - ( y * q.y ) - ( z * q.z ) ;
        }
        
        /**
         * Normalizes the Quaternion instance.
         */
        public function normalize():void
        {
            var len:Number = size() ;
            if ( Math.abs(len) < EPSILON )
            {
                identity() ;
            }
            else
            {
                x /= len ;
                y /= len ;
                z /= len ;
                w /= len ;
            }
        }
        
        /**
         * Scales the quaternion object with the input value.
         * @param value a real number to scale the current quaternion object.
         */
        public function scale( value:Number ):void
        {
            x *= value ;
            y *= value ;
            z *= value ;
        }
        
        /**
         * Returns the magnitude (length) of a Quaternion, measured in the Euclidean norm.
         * @return The length of the quaternion.
         */
        public function size():Number
        {
            return Math.sqrt( w*w + x*x + y*y + z*z ) ;
        }
        
        /**
         * Returns the square of the length of a quaternion.
         * @return the square of the length of a quaternion.
         */
        public function sizeSquared():Number
        {
            return w*w + x*x + y*y + z*z ;
        }
        
        /**
         * Substracts the values of the s2ecified Quaternion. 
         */
        public function substract( q:Quaternion ):void 
        {
            x -= q.x ;
            y -= q.y ;
            z -= q.z ;
            w -= q.w ;
        }
        
        /**
         * Returns the Object representation of this object.
         * @return the Object representation of this object.
         */
        public function toObject():Object 
        {
            return { x:x , y:y , z:z , w:w } ;
        }
        
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public function toSource( indent:int = 0 ):String  
        {
            return "new graphics.geom.Quaternion(" +  x.toString()  + "," + y.toString()  + "," + z.toString() + "," + w.toString() + ")" ;
        }
        
        /**
         * Returns the string representation of the object.
         * @return the string representation of the object.
         */
        public function toString():String
        {
            return "[Quaternion x:" + x + " y:" + y + " z:" + z + " w:" + w + "]" ;
        }
        
        /**
         * Apply the negation of the quaternion.
         */
        public function unaryNegation():void
        {
            x *= -1 ;
            y *= -1 ;
            z *= -1 ;
            w *= -1 ;
        }
    }
}
