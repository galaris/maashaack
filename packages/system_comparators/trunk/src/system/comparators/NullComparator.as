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

package system.comparators
{
    import system.Comparator;
    
    /**
     * This comparator compare Null objects.
     * When comparing two non-null objects, the ComparableComparator is used if the nonNullComparator isnt' define.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.comparators.NullComparator;
     * 
     * var comp1:NullComparator = new NullComparator(null, true) ;
     * var comp2:NullComparator = new NullComparator(null, false) ;
     * 
     * var n = null ;
     * var o = {} ;
     * 
     * trace( comp1.compare(n, n) ) ; // 0
     * trace( comp1.compare(n, o) ) ; // 1
     * trace( comp1.compare(o, n) ) ; // -1
     * 
     * trace("----") ;
     * 
     * trace( comp2.compare(n, n) ) ; // 0
     * trace( comp2.compare(n, o) ) ; // -1
     * trace( comp2.compare(o, n) ) ; // 1
     * </pre>
     */
    public class NullComparator implements Comparator
    {
        /**
         * Creates a new NullComparator instance.
         * @param nonNullComparator the comparator to use when comparing two non-null objects.
         * @param nullsAreHigh a <code class="prettyprint">true</code> value indicates that null should be compared as higher than a non-null object. A <code class="prettyprint">false</code> value indicates that null should be compared as lower than a non-null object. 
         */
        public function NullComparator( nonNullComparator:Comparator = null , nullsAreHigh:Boolean = false )
        {
            this.nonNullComparator = nonNullComparator ;
            this.nullsAreHigh      = nullsAreHigh      ;
            _comp                  = new ComparableComparator() ;
        }
        
        /**
         * Defines the comparator to use when comparing two non-null objects.
         */
        public var nonNullComparator:Comparator = null ;
        
        /**
         * Defines that null should be compared as higher than a non-null object. 
         */
        public var nullsAreHigh:Boolean = false ;
        
        /**
         * Performs a comparison between two objects. 
         * If both objects are null, a 0 value is returned. 
         * If one object is null and the other is not, the result is determined on whether the Comparator was constructed to have nulls as higher or lower than other objects.
         * If neither object is null, an underlying comparator specified in the constructor (or the default) is used to compare the non-null objects.
         * The default Comparator used to compare two non-null objects is the ComparableComparator.
         * @param o1 the first 'null' object to compare.
         * @param o2 the second 'null' object to compare.
         * @return <p>
         * <li>-1 if o1 is "lower" than (less than, before, etc.) o2 ;</li>
         * <li> 1 if o1 is "higher" than (greater than, after, etc.) o2 ;</li>
         * <li> 0 if o1 and o2 are equal.</li>
         * </p>
         * @see system.comparators.ComparableComparator
         */
        public function compare(o1:*, o2:*, options:*=null):int
        {
            if (o1 == null && o2 == null)
            {
                return 0 ;
            }
            else if (o1 == null && o2 != null)
            {
                return nullsAreHigh ? 1 : -1 ;
            }
            else if (o1 != null && o2 == null)
            {
                return nullsAreHigh ? -1 : 1 ;
            }
            else if ( nonNullComparator != null )
            {
                return nonNullComparator.compare(o1, o2, options) ;
            }
            else
            {
                return _comp.compare(o1, o2, options) ;
            }
        }
        
        /**
         * @private
         */
        private var _comp:ComparableComparator ;
    }
}