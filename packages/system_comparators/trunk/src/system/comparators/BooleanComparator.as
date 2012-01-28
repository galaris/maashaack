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
    import system.Comparator;
    
    /**
     * An Comparator for <code class="prettyprint">Boolean</code> objects that can sort either <code class="prettyprint">true</code> or <code class="prettyprint">false</code> first.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.Comparator ;
     * import system.comparators.BooleanComparator ;
     * 
     * var c:Comparator = new BooleanComparator() ;
     * trace(c.compare(true, true)) ; // 0
     * trace(c.compare(true, false)) ; // 1
     * trace(c.compare(false, true)) ; // -1
     * trace(c.compare(false, false)) ; // 0
     * </pre>
     */
    public class BooleanComparator implements Comparator
    {
        /**
         * Creates a BooleanComparator that sorts trueFirst values before !trueFirst values.
         * Please use the static factories instead whenever possible.
         * @param trueFirst when true, sort true boolean values before false
         */
        public function BooleanComparator( trueFirst:Boolean=true ) 
        {
            this.trueFirst = trueFirst ;
        }
        
        /**
         * This <code class="prettyprint">BooleanComparator</code> singleton that sorts false values before true values.
         * Clients are encouraged to use the value returned from this constant instead of constructing a new instance to reduce allocation and garbage collection overhead when multiple BooleanComparators may be used in the same application.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.comparators.BooleanComparator ;
         * import system.Comparator ;
         * 
         * var c:Comparator = BooleanComparator.falseFirst ;
         * 
         * trace( c.compare( true  , true  ) ) ; //  0
         * trace( c.compare( true  , false ) ) ; // -1
         * trace( c.compare( false , true  ) ) ; //  1
         * trace( c.compare( false , false ) ) ; //  0
         * </pre>
         */
        public static const falseFirst:BooleanComparator = new BooleanComparator( false ) ;
        
        /**
         * This <code class="prettyprint">BooleanComparator</code> singleton that sorts true values before false values.
         * Clients are encouraged to use the value returned from this constant instead of constructing a new instance to reduce allocation and garbage collection overhead when multiple BooleanComparators may be used in the same application.
         * <pre class="prettyprint">
         * import system.comparators.BooleanComparator ;
         * import system.Comparator ;
         * 
         * var c:Comparator = BooleanComparator.trueFirst ;
         * 
         * trace( c.compare( true  , true  ) ) ; //  0
         * trace( c.compare( true  , false ) ) ; //  1
         * trace( c.compare( false , true  ) ) ; // -1
         * trace( c.compare( false , false ) ) ; //  0
         * </pre> 
         */
        public static const trueFirst:BooleanComparator = new BooleanComparator(true) ;
        
        /**
         * When <code class="prettyprint">true</code> sort <code class="prettyprint">true</code> boolean values before <code class="prettyprint">false</code>.
         */
        public var trueFirst:Boolean ; 
        
        /**
         * Returns an integer value to compare two Boolean objects.
         * @param o1 the first Number object to compare.
         * @param o2 the second Number object to compare.
         * @return <p>
         * <li>-1 if o1 is "lower" than (less than, before, etc.) o2 ;</li>
         * <li> 1 if o1 is "higher" than (greater than, after, etc.) o2 ;</li>
         * <li> 0 if o1 and o2 are equal.</li>
         * </p>
         * @throws ArgumentError if the first argument is null and not a Boolean object.
         * @throws ArgumentError when either argument is not Boolean
         */
        public function compare( o1:* , o2:* , options:* = null ):int
        {
            if (o1 == null)
            {
                throw ArgumentError(this + " compare method failed if the first argument is null.") ;
            }    
            if ( o1 is Boolean && o2 is Boolean ) 
            {
                if( o1 == o2 )
                {
                    return 0 ;
                }
                else if( o1 == true && o2 == false )
                {
                    return trueFirst ? 1 : -1 ;
                }
                else 
                {
                    return trueFirst ? -1 : 1 ;
                }
            }
            else 
            {
                throw new ArgumentError(this + " compare method failed, The two arguments must be Booleans.") ;
            }
        }
    }
}