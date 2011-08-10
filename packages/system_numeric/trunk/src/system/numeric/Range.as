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
    import core.maths.clamp;
    
    import system.Equatable;
    import system.Serializable;
    
    /**
     * Represents an immutable range of values.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.numeric.Range ;
     * 
     * var r1:Range = new Range(10, 120) ;
     * var r2:Range = new Range(100, 150) ;
     * 
     * trace ("r1 : " + r1) ; // r1 : [Range$lt;10,120$gt;]
     * trace ("r2 : " + r2) ; // r2 : [Range$lt;100,150$gt;]
     * 
     * trace ("r2.toSource()     : " + r2.toSource()      ) ; // r2.toSource() : new system.numeric.Range(100,150)
     * trace ("r1 contains 50    : " + r1.contains(50)    ) ; // r1 contains 50 : true
     * trace ("r1 isOutOfRange 5 : " + r1.isOutOfRange(5) ) ; // r1 isOutOfRange 5 : true
     * trace ("r1 overlap r2     : " + r1.overlap(r2)     ) ; // r1 overlap r2 : true
     * trace ("r1 clamp 5        : " + r1.clamp(5)        ) ; // r1 clamp 5 : 10
     * trace ("r1 clamp 121      : " + r1.clamp(121)      ) ; // r1 clamp 121 : 120
     * </pre>
     */
    public class Range implements Equatable, Serializable
    {
        /**
         * Creates a new Range instance.
         * <p><b>Usage :</b></p>
         * <pre class="prettyprint">var r:Range = new Range( min:Number, max:Number) ;</pre>
         */ 
        public function Range( min:Number, max:Number)
        {
            if ( max < min)
            {
                throw new RangeError( "Range constructor : 'max' argument is < of 'min' argument" ) ;
            }
            this.min = min ;
            this.max = max ;
        }
        
        /**
         * Range reference between -255 and 255.
         */
        public static const COLOR:Range = new Range( - 255, 255 ) ;
        
        /**
         * Range reference between 0 and 360.
         */
        public static const DEGREE:Range = new Range( 0, 360 ) ;
        
        /**
         * Range reference between 0 and 100.
         */
        public static const PERCENT:Range = new Range( 0, 100 ) ;
        
        /**
         * Range reference between 0 and 1.
         */
        public static const UNITY:Range = new Range( 0, 1 ) ;
        
        /**
         * The max value of the range.
         */    
        public var max:Number ;
        
        /**
         * The min value of the range.
         */
        public var min:Number ;
        
        /**
         * Clamp a value in the current range.
         */
        public function clamp(value:Number):Number 
        {
            return core.maths.clamp( value, min, max ) ;
        }
        
        /**
         * Returns a shallow copy of the object.
         * @return a shallow copy of the object.
         */
        public function clone():*
        {
            return new Range( min, max ) ;
        }
        
        /**
         * Creates a new range by combining two existing ranges.
         * @param range the range to combine, <code class="prettyprint">null</code> permitted.
         */
        public function combine( range:Range ):Range
        {
            if (range == null)
            {
                return clone() ;
            }
            else
            {
                var lower:Number = Math.min( min , range.min ) ;
                var upper:Number = Math.max( max , range.max ) ;
                return new Range( lower, upper ) ;
            }
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the Range instance contains the value passed in argument.
         * @return <code class="prettyprint">true</code> if the Range instance contains the value passed in argument.
         */
        public function contains(value:Number):Boolean 
        {
            return ! isOutOfRange( value ) ;
        }
        
        /**
         * Indicates whether some other object is "equal to" this one.
         */
        public function equals(o:*):Boolean
        {
            if (o is Range) 
            {
                return ((o as Range).min == min) && ((o as Range).max == max) ;
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Creates a new range by adding margins to an existing range.
         * @param lowerMargin the lower margin (expressed as a percentage of the range length).
         * @param upperMargin the upper margin (expressed as a percentage of the range length).
         * @return The expanded range.
         */
        public function expand( lowerMargin:Number = 1, upperMargin:Number = 1):Range
        {
            var l:Number = size() ;
            var lower:Number = l * lowerMargin ;
            var upper:Number = l * upperMargin ;
            return new Range( min - lower, max + upper ) ;
        }
        
        /**
         * Filters the passed-in Number value, if the value is NaN the return value is the default value in second argument.
         * @param value The Number value to filter, if this value is NaN the value is changed.
         * @param defaultValue The default value to apply over the specified value if this value is NaN (default 0).
         * @return The filter Number value.
         */
        public static function filterNaNValue( value:Number, defaultValue:Number = 0 ):Number
        {
            return isNaN( value ) ? defaultValue : value ;
        }
        
        /**
         * Returns the central value for the range.
         * @return The central value.
         */
        public function getCentralValue():Number
        {
            return (min + max) / 2 ;
        }
        
        /**
         * Returns a random floating-point number between two numbers.
         * @return a random floating-point number between two numbers.
         */
        public function getRandomFloat():Number
        {
            return Math.random() * ( max - min ) + min ;
        }
        
        /**
         * Returns a random integer number between two numbers.
         * @return a random integer number between two numbers.
         */
        public function getRandomInteger():int
        {
            return Math.floor( getRandomFloat() ) ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the value is out of the range.
         * @return <code class="prettyprint">true</code> if the value is out of the range.
         */
        public function isOutOfRange(value:Number):Boolean 
        {
            return (value > max ) || (value < min) ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the range in argument overlap the current range.
         * @return <code class="prettyprint">true</code> if the range in argument overlap the current range.
         */
        public function overlap(r:Range):Boolean 
        {
            return max >= r.min && r.max >= min ;
        }
        
        /**
         * Returns the length of the range.
         * @return the length of the range.
         */
        public function size():Number
        {
            return max - min ;
        }
        
        /**
         * Returns the source represensation of the object.
         * @return the source represensation of the object.
         */
        public function toSource( indent:int = 0 ):String  
        {
            return "new system.numeric.Range(" + min + "," + max + ")";
        }
        
        /**
         * Returns the string representation of this instance.
         * @return the string representation of this instance.
         */
        public function toString():String 
        {
            return "[Range min:" + min + " max:" + max + "]";
        }
    }
}