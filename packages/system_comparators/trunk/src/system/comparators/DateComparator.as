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
     * This comparator compare Date objects.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.comparators.DateComparator;
     * 
     * var comp:DateComparator = new DateComparator() ;
     * 
     * var d1:Date   = new Date(2007, 1, 1) ;
     * var d2:Number =  1170284400000 ;
     * var d3:Date   = new Date(2007, 2, 2) ;
     * var d4:Number = 1172790000000 ;
     * 
     * trace( comp.compare(d1, d1) ) ; // 0
     * trace( comp.compare(d1, d2) ) ; // 0
     * trace( comp.compare(d2, d1) ) ; // 0
     * trace( comp.compare(d1, d3) ) ; // -1
     * trace( comp.compare(d1, d4) ) ; // -1
     * trace( comp.compare(d3, d1) ) ; // 1
     * trace( comp.compare(d4, d1) ) ; // 1
     * </pre>
     */
    public class DateComparator implements Comparator
    {
        /**
         * Creates a new DateComparator instance.
         */
        public function DateComparator()
        {
            _comp = new NumberComparator() ;
        }
        
        /**
         * Returns an integer value to compare two Date objects.
         * @param o1 the first Date object to compare.
         * @param o2 the second Date object to compare.
         * @return <p>
         * <li>-1 if o1 is "lower" than (less than, before, etc.) o2 ;</li>
         * <li> 1 if o1 is "higher" than (greater than, after, etc.) o2 ;</li>
         * <li> 0 if o1 and o2 are equal.</li>
         * </p>
         * @throws ArgumentError if compare(a, b) and 'a' and 'b' must be Date or uint objects.
         */
        public function compare(o1:*, o2:*, options:* = null):int
        {
            var b1:Boolean = (o1 is Number) || (o1 is Date) ;
            var b2:Boolean = (o2 is Number) || (o2 is Date) ;
            if ( b1 && b2 ) 
            {
                var a:Number = (o1 is Date) ? (o1 as Date).valueOf() : o1 ;
                var b:Number = (o2 is Date) ? (o2 as Date).valueOf() : o2 ;
                return _comp.compare(a, b, options) ;
            }
            else 
            {
                throw new ArgumentError(this + ".compare(a, b), 'a' and 'b' must be Date or Number objects.") ;
            }
        }
        
        /**
         * @private
         */
        private static var _comp:NumberComparator ;
    }
}