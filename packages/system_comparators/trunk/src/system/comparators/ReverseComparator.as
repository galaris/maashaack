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
    import system.Sortable;
    
    /**
     * Reverse a Comparator object. For example if the comparator must return 1 the reverse comparator return -1.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.comparators.ReverseComparator ;
     * import system.comparators.StringComparator ;
     * 
     * var c:StringComparator  = new StringComparator() ;
     * var s:ReverseComparator = new ReverseComparator( c ) ;
     * 
     * trace( c.compare( "hello", "world" ) ) ; // -1
     * trace( s.compare( "hello", "world" ) ) ; // 1
     * </pre>
     */
    public class ReverseComparator implements Comparator, Sortable
    {
        /**
         * Creates a new ReverseComparator instance.
         * @param comp the <code class="prettyprint">Comparator</code> to be reverse.
         */
        public function ReverseComparator( comp:Comparator=null )
        {
            comparator = comp ;
        }
        
        /**
         * Determinates the internal <code class="prettyprint">Comparator</code> instance to reverse.
         * @throws ReferenceError If the 'comparator' property is 'null'.
         */
        public function get comparator():Comparator
        {
            return _comparator ;
        }
        
        /**
         * @private
         */
        public function set comparator( comp:Comparator ):void 
        {
            if ( comp != null )
            {
                _comparator = comp ;
            }
            else
            {
                throw new ReferenceError( "The ReverseComparator 'comparator' property not must be 'null'") ;  
            }           
        }
                
        /**
         * Returns an integer value to compare two objects (reverse the value).
         * @param o1 the first object to compare.
         * @param o2 the second object to compare.
         * @param options An optional object used to compare the two objects.
         * @return <p>
         * <li>-1 if o1 is "lower" than (less than, before, etc.) o2 ;</li>
         * <li> 1 if o1 is "higher" than (greater than, after, etc.) o2 ;</li>
         * <li> 0 if o1 and o2 are equal.</li>
         * </p>
         */
        public function compare(o1:*, o2:*, options:*=null):int
        {
            return comparator.compare( o2, o1, options) ;
        }
        
        /**
         * @private
         */
        private var _comparator:Comparator ;
    }
}