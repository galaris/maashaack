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

package system.comparators
{
    import core.reflect.getClassName;
    
    import system.Comparator;
    
    /**
     * This comparator compare two Number objects.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.comparators.NumberComparator ;
     * 
     * var c:NumberComparator = new NumberComparator() ;
     * 
     * trace( c.compare(0,0) ) ; // 0
     * trace( c.compare(1,1) ) ; // 0
     * trace( c.compare(-1,-1) ) ; // 0
     * trace( c.compare(0.1,0.1) ) ; // 0
     * trace( c.compare( Number(Math.cos(25)) , 0.9912028118634736 ) ) ; // 0
     * trace( c.compare(1, 0) ) ; // 1
     * trace( c.compare(0, 1) ) ; // -1
     * 
     * c.fixed = true ;
     * c.fractionDigits = 3 ;
     * trace( c.compare(  1.2356 , 1.2358 ) ) ; // 0
     * 
     * c.fractionDigits = 4 ;
     * trace( c.compare(  1.2356 , 1.2358 ) ) ; // -1
     * 
     * c.fractionDigits = 0 ;
     * trace( c.compare( Math.cos(25) , 1 ) ) ; // 0
     * </pre>
     */
    public class NumberComparator implements Comparator
    {
        /**
         * Creates a new NumberComparator instance.
         * @param fixed Indicates if the two numbers are round to the specified number of decimal places (see the fractionDigits property).
         * @param fractionDigits An integer between 0 and 20, inclusive, that represents the desired number of decimal places.
         */
        public function NumberComparator( fixed:Boolean = false , fractionDigits:uint = 0 ) 
        {
            this.fixed          = fixed ;
            this.fractionDigits = fractionDigits ;
        }
        
        /**
         * An integer between 0 and 20, inclusive, that represents the desired number of decimal places.
         */
        public var fractionDigits:uint ;
        
        /**
         * Indicates if the two numbers are round to the specified number of decimal places (see the fractionDigits property).
         */
        public var fixed:Boolean ;
        
        /**
         * Returns an integer value to compare two Number objects.
         * @param o1 the first Number object to compare.
         * @param o2 the second Number object to compare.
         * @return <p>
         * <li>-1 if o1 is "lower" than (less than, before, etc.) o2 ;</li>
         * <li> 1 if o1 is "higher" than (greater than, after, etc.) o2 ;</li>
         * <li> 0 if o1 and o2 are equal.</li>
         * </p>
         * @throws ArgumentError if compare(a, b) and 'a' and 'b' must be Number objects.
         * @throws RangeError Throws an exception if the fractionDigits argument is outside the range 0 to 20 (only if fixed is true).
         */
        public function compare(o1:*, o2:*, options:* = null):int
        {
            if ( (o1 is Number) && (o2 is Number ) ) 
            {
                if ( fixed )
                {
                    o1 = Number( (o1 as Number).toFixed( fractionDigits ) ) ;
                    o2 = Number( (o2 as Number).toFixed( fractionDigits ) ) ;
                }
                if( o1 < o2 )
                {
                    return -1 ;
                }
                else if( o1 > o2 )
                {
                    return 1 ;
                }
                else 
                {
                    return 0 ;
                }
            }
            else 
            {
                throw new ArgumentError( getClassName(this) + " compare(" + o1 + "," + o2 + ") failed, the two arguments must be Number objects." ) ;
            }
        }
    }
}