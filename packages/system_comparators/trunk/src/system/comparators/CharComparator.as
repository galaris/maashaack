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
     * This comparator compare characters (String with one character) objects.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.comparators.CharComparator ;
     * 
     * var c:CharComparator = new CharComparator() ;
     * 
     * trace( c.compare( "A" , "A" ) ) ; // 0
     * trace( c.compare( "A" , "a" ) ) ; // 1
     * trace( c.compare( "A" , "b" ) ) ; // 1
     * 
     * trace("--") ;
     * 
     * trace( c.compare( "a" , "A" ) ) ; // -1
     * trace( c.compare( "a" , "a" ) ) ; //  0
     * trace( c.compare( "a" , "b" ) ) ; // -1
     * trace( c.compare( "a" , "B" ) ) ; // -1
     * 
     * trace("--") ;
     * 
     * trace( c.compare( "b" , "A" ) ) ; // -1
     * trace( c.compare( "b" , "a" ) ) ; //  1
     * trace( c.compare( "b" , "b" ) ) ; //  0
     * trace( c.compare( "b" , "B" ) ) ; // -1
     * 
     * trace("--") ;
     * 
     * trace( c.compare( "B" , "a" ) ) ; // 1
     * trace( c.compare( "B" , "b" ) ) ; // 1
     * trace( c.compare( "B" , "B" ) ) ; // 0
     * </pre>
     */
    public class CharComparator implements Comparator 
    {
        /**
         * Creates a new CharComparator instance.
         */
        public function CharComparator()
        {
            //
        }
        
        /**
         * Returns 0 if the passed string is lower case else 1.
         * @return 0 if the passed string is lower case else 1.
         */
        public static function caseValue( str:String ):uint
        {
            return ( str.toLowerCase() == str ) ? 0 : 1 ;
        }
        
        /**
         * Returns an integer value to compare two String characters objects.
         * @param o1 the first character object to compare.
         * @param o2 the second character object to compare.
         * @param options Not implemented.
         * @return <p>
         * <li>-1 if o1 is "lower" than (less than, before, etc.) o2 ;</li>
         * <li> 1 if o1 is "higher" than (greater than, after, etc.) o2 ;</li>
         * <li> 0 if o1 and o2 are equal.</li>
         * </p>
         */
        public function compare( o1:* , o2:* , options:* = null ):int
        {
            var a:String = String(o1).charAt(0) ;
            var b:String = String(o2).charAt(0) ;
            if ( caseValue(a) < caseValue(b) ) 
            {
                return -1;
            }
            if ( caseValue(a) > caseValue(b) ) 
            {
                return 1 ;
            }
            if ( a < b ) 
            {
                return -1;
            }
            if ( a > b ) 
            {
                return 1;
            }
            return 0 ;
        }
    }
}
