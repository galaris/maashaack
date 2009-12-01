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
  Portions created by the Initial Developers are Copyright (C) 2006-2010
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

package graphics.numeric 
{
    import graphics.geom.Polar;
    import graphics.geom.Vector2;
    
    /**
     * Implements the static behaviours of the trigometric manipulations.
     */
    public final class Trigo 
    {
        /**
         * This constant change degrees to radians : <b>Math.PI/180</b>.
         * <p><b>Example</b></p>
         * <code class="prettyprint">
         * trace (Trigo.DEG2RAD * 180) ;
         * </code>
         */
        public static const DEG2RAD:Number = Math.PI / 180 ;
        
        /**
         * Represents the smallest positive Single value greater than zero.
         * <p><b>Example</b></p>
         * <code class="prettyprint">
         * trace ( Trigo.EPSILON ) ;
         * </code>
         */
        public static const EPSILON:Number = 0.000000001;
        
        /**
         * This constant is the Euler-Mascheroni constant (lambda or C) :
         * <p>
         * <code class="prettyprint">
         * ( n )
         * lim( sigma 1/k - ln(n) )
         * n->oo    ( k=1 )
         * </code>
         * <p><b>Example</b></p>
         * <code class="prettyprint">
         * trace (Trigo.LAMBDA) ;
         * </code>
         */
        public static const LAMBDA:Number = 0.57721566490143;
        
        /**
         * This constant change radians to degrees : <b>180/Math.PI</b>.
         * <p><b>Example</b></p>
         * <code class="prettyprint">
         * trace (Trigo.RAD2DEG * Math.PI) ;
         * </code>
         */
        public static const RAD2DEG:Number = 180 / Math.PI ;
        
        /**
         * This constant is the golden mean (phi) : <b>( 1 + Math.sqrt(5) ) / 2</b>.
         * <p><b>Example</b></p>
         * <code class="prettyprint">
         * trace (Trigo.PHI) ;
         * </code>
         */
        public static const PHI:Number = 1.61803398874989;
        
        /**
         * Returns the angle in degrees between 2 points with this coordinates passed in argument.
         * @param x1 the x coordinate of the first point.
         * @param y1 the y coordinate of the first point.
         * @param x2 the x coordinate of the second point.
         * @param y2 the y coordinate of the second point.
         * @return the angle in degrees between 2 points with this coordinates passed in argument.
         */
        public static function angleOfLine(x1:Number, y1:Number, x2:Number, y2:Number):Number 
        {
            return Degrees.atan2D(y2 - y1, x2 - x1) ;
        }
        
        /**
         * Converts a vector in cartesian in a polar vector.
         * @return a vector in cartesian in a polar vector.
         */
        public static function cartesianToPolar( p:* ):Object 
        {
            return ( { r : Math.sqrt(p.x * p.x + p.y * p.y), t : Degrees.atan2D(p.y, p.x) } ) ;
        }
        
        /**
         * Converts an angle in degrees in radians
         * @return an angle in degrees in radians.
         */
        public static function degreesToRadians(angle:Number):Number 
        {
            return angle * DEG2RAD ;
        }
        
        /**
         * Returns the distance between 2 points with the coordinates of the 2 points.
         * @param x1 the x coordinate of the first point.
         * @param y1 the y coordinate of the first point.
         * @param x2 the x coordinate of the second point.
         * @param y2 the y coordinate of the second point.
         * @return the length between 2 points.
         */
        public static function distance(x1:Number, y1:Number, x2:Number, y2:Number):Number 
        {
            var dx:Number = x2 - x1 ;
            var dy:Number = y2 - y1 ;
            return Math.sqrt(dx * dx + dy * dy) ;
        }
        
        /**
         * Returns the distance between 2 points with the coordinates of the 2 points.
         * @param p1 the first point to determinate the distance.
         * @param p2 the second point to determinate the distance.
         * @return the length between 2 points.
         */
        public static function distanceByObject( p1:* , p2:* ):Number 
        {
            return distance(p1.x, p1.y, p2.x, p2.y) ;
        }
        
        /**
         * Fixs an angle in degrees between 0 and 360 degrees.
         * @param angle the passed angle value in degrees.
         * @return an angle in degrees between 0 and 360 degrees. 
         */
        public static function fixAngle(angle:Number):Number 
        {
            if ( isNaN(angle) ) 
            {    
                angle = 0 ;
            }
            angle %= 360 ;
            return (angle < 0) ? angle + 360 : angle ;
        }
        
        /**
         * Calculates the hypothenuse value of the two passed-in triangle sides value.
         * <p>A hypotenuse is the longest side of a right triangle (Right-angled triangle in British English), the side opposite the right angle. The length of the hypotenuse of a right triangle can be found using the Pythagorean theorem, which states that the square of the length of the hypotenuse equals the sum of the squares of the lengths of the other two sides.</p>
         */
        public static function hypothenuse( v1:Number, v2:Number):Number 
        {
            return Math.sqrt(v1 * v1 + v2 * v2);
        }
        
        
        /**
         * Linear interpolation from start to end by the given percent.
         * <p><b>Basically :</b> <code class="prettyprint">((1 - percent) * start) + (percent * end)</code></p>
         * @param percent The percent value to use.
         * @param start the begining value.
         * @param end The ending value.
         * @return The interpolated value between start and end.
         */
        public static function lerp( percent:Number, start:Number, end:Number ):Number
        {
            if ( start == end ) 
            {
                return start ;
            }
            return ( (1 - percent) * start) + ( percent * end );
        }
        
        /**
         * Calculates the log10 of the specified value.
         */
        public static function log10( value:Number ):Number 
        {
            return Math.log( value ) / Math.LN10;
        }
        
        /**
         * Calculates the logN of the specified value.
         */
        public static function logN( value:Number , base:int ):Number 
        {
            return Math.log(value) / Math.log(base) ;
        }
        
        /**
         * Converts an angle in radians in degrees.
         * @return an angle in radians in degrees.
         */
        public static function radiansToDegrees(angle:Number):Number 
        {
            return angle * RAD2DEG ;
        }
        
        /**
         * Converts a Polar object in a cartesian vector.
         * @param polar The polar object to transform.
         * @param degrees Indicates if the angle of the polar object is in degrees or radians.
         * @return a Vector2 cartesian representation of the specified Polar object.
         */
        public static function polarToCartesian( polar:Polar , degrees:Boolean = true ):Vector2 
        {
            return new Vector2(polar.radius * (degrees ? Degrees.cosD(polar.angle) : Math.cos(polar.angle)), polar.radius * (degrees ? Degrees.sinD(polar.angle) : Math.sin(polar.angle))) ;
        }
    }
}
