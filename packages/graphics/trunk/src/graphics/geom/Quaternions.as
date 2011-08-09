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
    import core.maths.EPSILON;
    import core.maths.clamp;
    
    /**
     * Manipulates and transforms <code class="prettyprint">Quaternion</code> references.
     */
    public class Quaternions 
    {
        /**
         * Adds the values of the two specified Quaternion.
         * @param q1 The first quaternion.
         * @param q2 The second quaternion.
         * @return The new Quaternion.
         */
        public static function add( q1:Quaternion, q2:Quaternion ):Quaternion
        {
            return new Quaternion(  q1.x + q2.x , q1.y + q2.y , q1.z + q2.z , q1.w + q2.w ) ;
        }
        
        /**
         * Returns a new Quaternion conjugate of the specified Quaternion.
         * @return a new Quaternion conjugate of the specified Quaternion.
         */
        public static function getConjugate( q:Quaternion ):Quaternion
        {    
            return q.clone().conjugate() ;
        }
        
        /**
         * Returns the multiplication of two Quaternions.
         * @return the multiplication of two Quaternions.
         */
        public static function getMultiply( q1:Quaternion , q2:Quaternion ):Quaternion
        {
            return q1.clone().mutiply( q2 ) ;
        }
        
        /**
         * Returns the multiplication of one Quaternions with a Vector3.
         * @return the multiplication of one Quaternions with a Vector3.
         */
        public static function getMultiplyVector3( q:Quaternion , v:Vector3 ):Quaternion
        {
            var x1:Number = q.x ; 
            var y1:Number = q.y ;
            var z1:Number = q.z ; 
            var w1:Number = q.w ;
            var x2:Number = v.x ; 
            var y2:Number = v.y ;
            var z2:Number = v.z ; 
            var w2:Number = 0   ;
            return new Quaternion
            (
                ( w1 * x2 ) + ( x1 * w2 ) + ( y1 * z2 ) - ( z1 * y2 ) , 
                ( w1 * y2 ) + ( y1 * w2 ) + ( z1 * x2 ) - ( x1 * z2 ) , 
                ( w1 * z2 ) + ( z1 * w2 ) + ( x1 * y2 ) - ( y1 * x2 ) , 
                ( w1 * w2 ) - ( x1 * x2 ) - ( y1 * y2 ) - ( z1 * z2 )
            ) ;
        }
        
        /**
         * Transform a Quaternion to a Matrix4 object. 
         * Calculates the rotation matrix of the quaternion.
         * @param q The Quaternion to transform.
         * @return The rotation matrix of the specified Quaternion.
         */
        public function getRotationMatrix( q:Quaternion ):Matrix4 
        {
            return Matrixs4.setByQuaternion( q ) ;
        }
        
        /**
         * Sets the specified Quaternion with the Matrix4 reference passed in argument.
         * @param m the Matrix4 reference used to fill the Quaternion.
         * @param q the option Quaternion reference to set. If parameter value is null a new Quaternion is created. 
         */
        public static function setByMatrix( matrix:Matrix4 , quaternion:Quaternion = null ):Quaternion
        {
            if ( quaternion == null )
            {
               quaternion = new Quaternion() ;
            }
            var s:Number ;
            var tr:Number = matrix.n11 + matrix.n22 + matrix.n33 ;
            if ( tr > 0 ) 
            {
                s = Math.sqrt( tr + 1 );
                quaternion.w = s / 2 ;
                s = 0.5 / s ;
                quaternion.x = (matrix.n32 - matrix.n23) * s;
                quaternion.y = (matrix.n13 - matrix.n31) * s;
                quaternion.z = (matrix.n21 - matrix.n12) * s;
            } 
            else 
            {   
                var i:int ; // 0
                var j:int ;
                var k:int ;
                
                var q:Array    = new Array(4);
                var next:Array = [ 1 , 2 , 0 ] ;
                var m:Array    = matrix.toArray() ;
                
                if ( m[1][1] > m[0][0] ) 
                {
                    i = 1 ;
                }
                
                if ( m[2][2] > m[i][i] ) 
                {
                    i = 2 ;
                }
                
                j = next[i] ;
                k = next[j] ;
                
                s = Math.sqrt((m[i][i] - (m[j][j] + m[k][k])) + 1.0) ;
                
                quaternion[i] = s * 0.5 ;
                
                if ( s != 0 ) 
                {
                    s = 0.5 / s ;
                }
                
                q[3] = (m[k][j] - m[j][k]) * s ;
                q[j] = (m[j][i] + m[i][j]) * s ;
                q[k] = (m[k][i] + m[i][k]) * s ;
                
                quaternion.x = q[0];
                quaternion.y = q[1];
                quaternion.z = q[2];
                quaternion.w = q[3];
            }
            return quaternion ;
        }
        
        /**
         * Interpolates between two quaternions, using spherical linear interpolation (SLERP).
         * <p><b>See the wikipedia page about</b> : <a href="http://en.wikipedia.org/wiki/Slerp"> SLERP</a>.</p>
         * @param q1 The first quaternion.
         * @param q2 The second quaternion.
         * @param t the amount (between 0 and 1) to interpolate between the two quaternions. 
         * @return The interpolated quaternion with the spherical linear interpolation.
         */ 
        public static function slerp( q1:Quaternion, q2:Quaternion, t:Number = 0 ):Quaternion
        {
            t = clamp( ( isNaN(t) ? 0 : t ) , 0 , 1 ) ;
            var a:Number = q1.dot( q2 ) ;
            if ( a < 0 )
            {
                q1.x *= -1 ;
                q1.y *= -1 ;
                q1.z *= -1 ;
                q1.w *= -1 ;
                a    *= -1 ;
            }
            var ratio1:Number ;
            var ratio2:Number ;
            if ( ( a + 1 ) > EPSILON )
            {
                if ( ( 1 - a ) >= EPSILON )  // spherical interpolation
                {
                    var theta:Number = Math.acos( a ) ;
                    var inv:Number   = 1 / Math.sin( theta ) ;
                    ratio1           = Math.sin( theta * ( 1 - t ) ) * inv ;
                    ratio2           = Math.sin( theta * t ) * inv ;
                }
                else // linear interploation
                {
                    ratio1 = 1 - t ;
                    ratio2 = t ;
                }
            }
            else
            {
                q2.y   = -q1.y ;
                q2.x   =  q1.x ;
                q2.w   = -q1.w ;
                q2.z   =  q1.z ;
                ratio1 = Math.sin( Math.PI * ( 0.5 - t ) ) ;
                ratio2 = Math.sin( Math.PI * t ) ;
            }
            var q:Quaternion = new Quaternion();
            q.x = ( q1.x * ratio1 ) + ( q2.x * ratio2 ) ;
            q.y = ( q1.y * ratio1 ) + ( q2.y * ratio2 ) ;
            q.z = ( q1.z * ratio1 ) + ( q2.z * ratio2 ) ;
            q.w = ( q1.w * ratio1 ) + ( q2.w * ratio2 ) ;
            return q ;
        }
        
        /**
         * Substracts the values of the two specified Quaternion.
         * @param q1 The first quaternion.
         * @param q2 The second quaternion.
         * @return The new Quaternion.
         */
        public static function substract( q1:Quaternion, q2:Quaternion ):Quaternion
        {
            return new Quaternion(  q1.x - q2.x , q1.y - q2.y , q1.z - q2.z , q1.w - q2.w ) ;
        }
    }
}
