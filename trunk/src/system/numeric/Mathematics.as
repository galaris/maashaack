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

package system.numeric
{
    import core.maths.ceil;
    import core.maths.clamp;
    import core.maths.floor;
    import core.maths.gcd;
    import core.maths.interpolate;
    import core.maths.map;
    import core.maths.normalize;
    import core.maths.percentage;
    import core.maths.round;
    import core.maths.sign;
    
    /**
     * The <code class="prettyprint">Mathematics</code> utility class is an all-static class with methods for working with numbers.
     */ 
    public class Mathematics
    {
        /**
         * Rounds and returns the ceiling of the specified number or expression. 
         * The ceiling of a number is the closest integer that is greater than or equal to the number.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.numeric.Mathematics ;
         * 
         * var n = Mathematics.ceil(4.572525153, 2) ;
         * trace ("n : " + n) ; // n : 4.58
         * 
         * var n = Mathematics.ceil(4.572525153, -1) ;
         * trace ("n : " + n) ; // n : 5
         * </pre>
         * @param n the number to round.
         * @param floatCount the count of number after the point.
         * @return the ceil value of a number by a count of floating points.
         */
        public static const ceil:Function = core.maths.ceil ;
        
        /**
         * Bounds a numeric value between 2 numbers.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.numeric.Mathematics ;
         * 
         * var n = Mathematics.clamp(4, 5, 10) ;
         * trace ("n : " + n) ; // 5
         * 
         * var n = Mathematics.clamp(12, 5, 10) ;
         * trace ("n : " + n) ; // 10
         * 
         * var n = Mathematics.clamp(6, 5, 10) ;
         * trace ("n : " + n) ; // 5
         * 
         * var n = Mathematics.clamp(NaN, 5, 10) ;
         * trace ("n : " + n) ; // NaN
         * </pre>
         * @param value the value to clamp.
         * @param min the min value of the range.
         * @param max the max value of the range.
         * @return a bound numeric value between 2 numbers.
         */
        public static const clamp:Function = core.maths.clamp ;
        
        /**
         * Rounds and returns a number by a count of floating points.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.numeric.Mathematics ;
         * 
         * var n = Mathematics.floor(4.572525153, 2) ;
         * trace ("n : " + n) ; // n : 4.57
         * 
         * var n = Mathematics.floor(4.572525153, -1) ;
         * trace ("n : " + n) ; // n : 4
         * </pre>
         * @param n the number to round.
         * @param floatCount the count of number after the point.
         * @return the floor value of a number by a count of floating points.
         */
        public static const floor:Function = core.maths.floor ;
        
        /**
         * Returns the greatest common divisor with the Euclidean algorithm.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.numeric.Mathematics ;
         * 
         * var gcd:int = Mathematics.gcd(320,240) ;
         * trace("Mathematics.gcd(320,240) : " + Mathematics.gcd(320,240) ) ; // Mathematics.gcd(320,240) : 80
         * </pre>
         * @param i1 The first integer value.
         * @param i2 The second integer value.
         * @return the greatest common divisor with the Euclidean algorithm.
         */
        public static const gcd:Function = core.maths.gcd ;
        
        /**
         * With a number value and a range this method returns the actual value for the interpolated value in that range.
         * <pre class="prettyprint">
         * import system.numeric.Mathematics ;
         * trace( Mathematics.interpolate( 0.5, 0 , 100 ) ) ; // 50
         * </pre>
         * @param value The normal number value to interpolate (value between 0 and 1).
         * @param minimum The minimum value of the interpolation.
         * @param maximum The maximum value of the interpolation.
         * @return the actual value for the interpolated value in that range.
         */
        public static const interpolate:Function = core.maths.interpolate ;
        
        /**
         * Takes a value in a given range (minimum1, maximum1) and finds the corresponding value in the next range(minimum2, maximum2).
         * <pre class="prettyprint">
         * import system.numeric.Mathematics ;
         * trace( Mathematics.map( 10,  0, 100, 20, 80  ) ) ; // 26
         * trace( Mathematics.map( 26, 20,  80,  0, 100 ) ) ; // 10
         * </pre>
         * @param value The number value to map.
         * @param minimum1 The minimum value of the first range of the value.
         * @param maximum1 The maximum value of the first range of the value.
         * @param minimum2 The minimum value of the second range of the value.
         * @param maximum2 The maximum value of the second range of the value.
         * @return value in a given range (minimum1, maximum1) and finds the corresponding value in the next range(minimum2, maximum2).
         */
        public static const map:Function = core.maths.map ;
        
        /**
         * Takes a value within a given range and converts it to a number between 0 and 1.
         * Actually it can be outside that range if the original value is outside its range.
         * <pre class="prettyprint">
         * import system.numeric.Mathematics ;
         * trace( Mathematics.normalize( 10, 0 , 100 ) ) ; // 0.1
         * </pre>         
         * @param value The number value to normalize.
         * @param minimum The minimum value of the normalization.
         * @param maximum The maximum value of the normalization.
         */
        public static const normalize:Function = core.maths.normalize ;
        
        /**
         * Returns a percentage or null.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.numeric.Mathematics ;
         * trace( Mathematics.percentage( 50 , 100 ) + "%" ) ; // 50%
         * trace( Mathematics.percentage( 68 , 425 ) + "%" ) ; // 16% 
         * </pre>
         * @param value the current value.
         * @param maximum the max value.
         * @return a percentage value or null.
         */
        public static const percentage:Function = core.maths.percentage ;
        
        /**
         * Rounds and returns a number by a count of floating points.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.numeric.Mathematics ;
         * 
         * var n = Mathematics.round(4.572525153, 2) ;
         * trace ("n : " + n) ; // 4.57
         * 
         * var n = Mathematics.round(4.572525153, -1) ;
         * trace ("n : " + n) ; // 5
         * </pre>
         * @param n the number to round.
         * @param floatCount the count of number after the point.
         * @return the round of a number by a count of floating points.
         */
        public static const round:Function = core.maths.round ;
        
        /**
         * Returns 1 if the value is positive or -1.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.numeric.Mathematics ;
         * 
         * n = Mathematics.sign(-150) ;
         * trace ("n : " + n) ; // -1
         * 
         * n = Mathematics.sign(200) ;
         * trace ("n : " + n) ; // 1
         * 
         * n = Mathematics.sign(0) ;
         * trace ("n : " + n) ; // 1
         * </pre>
         * @param n the number to defined this sign.
         * @return 1 if the value is positive or -1.
         * @throws IllegalOperationError if the passed-in value is NaN.
         */
        public static const sign:Function = core.maths.sign ;
    }
}