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

package system.data.maps 
{
    import system.Comparator;
    import system.Sortable;
    import system.hack;
    
    /**
     * This <code class="prettyprint">ArrayMap</code> can be sorted with a <code class="prettyprint">Comparator</code> object.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.data.maps.SortedArrayMap ;
     * 
     * import system.comparators.NumberComparator ;
     * import system.comparators.StringComparator ;
     * 
     * var map:SortedArrayMap = new SortedArrayMap( [0] , ["item0"] ) ;
     * 
     * map.put( 1 , "item8" ) ;
     * map.put( 3 , "item7" ) ;
     * map.put( 2 , "item6" ) ;
     * map.put( 5 , "item5" ) ;
     * map.put( 4 , "item4" ) ;
     * map.put( 7 , "item3" ) ;
     * map.put( 6 , "item2" ) ;
     * map.put( 8 , "item1" ) ;
     * 
     * trace("----- original Map") ;
     * 
     * trace( map ) ;
     * 
     * trace("----- sort by key with sort() method") ;
     * 
     * map.comparator = new NumberComparator() ;
     * 
     * map.options = SortedArrayMap.NUMERIC | SortedArrayMap.DESCENDING ;
     * map.sort() ;
     * trace( map ) ;
     * 
     * map.options = SortedArrayMap.NUMERIC ;
     * map.sort() ;
     * trace( map ) ;
     * 
     * trace("----- sort by value with sort() method") ;
     * 
     * map.comparator = new StringComparator() ;
     * map.sortBy = SortedArrayMap.VALUE ;
     * 
     * map.options = SortedArrayMap.DESCENDING ;
     * map.sort() ;
     * trace( map ) ;
     * 
     * map.options = SortedArrayMap.NONE ;
     * map.sort() ;
     * trace( map ) ;
     * </pre>
     */
    public class SortedArrayMap extends ArrayMap implements Sortable
    {
        use namespace hack ;
        
        /**
         * Creates a new SortedArrayMap instance.
         * @param keys An optional Array of all keys to fill in this Map.
         * @param values An optional Array of all values to fill in this Map. This Array must have the same size like the 'keys' argument.
         */  
        public function SortedArrayMap( ...arguments:Array )
        {
            super( arguments[0] , arguments[1] ) ;
            sortBy = SortedArrayMap.KEY ;
        }
        
        /**
         * Specifies case-insensitive sorting for the Array class sorting methods. You can use this constant
         * for the <code class="prettyprint">options</code> parameter in the <code class="prettyprint">sort()</code> or <code class="prettyprint">sortOn()</code> method. 
         * <p>The value of this constant is 1.</p>
         */
        public static const CASEINSENSITIVE:uint = 1;
        
        /**
         * Specifies descending sorting for the Array class sorting methods. 
         * You can use this constant for the <code class="prettyprint">options</code> parameter in the <code class="prettyprint">sort()</code>
         * or <code class="prettyprint">sortOn()</code> method. 
         * <p>The value of this constant is 2.</p>
         */
        public static const DESCENDING:uint = 2;
        
        /**
         * Defines the constant value of the sortPolicy property if the ArrayMap is sorted by "key".
         */
        public static const KEY:String = "key" ;
        
        /**
         * Specifies the default numeric sorting value for the Array class sorting methods.
         * <p>The value of this constant is 0.</p>
         */
        public static const NONE:uint = 0;
        
        /**
         * Specifies numeric (instead of character-string) sorting for the Array class sorting methods. 
         * Including this constant in the <code class="prettyprint">options</code>
         * parameter causes the <code class="prettyprint">sort()</code> and <code class="prettyprint">sortOn()</code> methods 
         * to sort numbers as numeric values, not as strings of numeric characters.  
         * Without the <code class="prettyprint">NUMERIC</code> constant, sorting treats each array element as a 
         * character string and produces the results in Unicode order. 
         *
         * <p>For example, given the array of values <code class="prettyprint">[2005, 7, 35]</code>, if the <code class="prettyprint">NUMERIC</code> 
         * constant is <strong>not</strong> included in the <code class="prettyprint">options</code> parameter, the 
         * sorted array is <code class="prettyprint">[2005, 35, 7]</code>, but if the <code class="prettyprint">NUMERIC</code> constant <strong>is</strong> included, 
         * the sorted array is <code class="prettyprint">[7, 35, 2005]</code>. </p>
         * 
         * <p>This constant applies only to numbers in the array; it does 
         * not apply to strings that contain numeric data such as <code class="prettyprint">["23", "5"]</code>.</p>
         * 
         * <p>The value of this constant is 16.</p>
         */
        public static const NUMERIC:uint = 16;
        
        /**
         * Specifies that a sort returns an array that consists of array indices as a result of calling
         * the <code class="prettyprint">sort()</code> or <code class="prettyprint">sortOn()</code> method. You can use this constant
         * for the <code class="prettyprint">options</code> parameter in the <code class="prettyprint">sort()</code> or <code class="prettyprint">sortOn()</code> 
         * method, so you have access to multiple views on the array elements while the original array is unmodified. 
         * <p>The value of this constant is 8.</p>
        */
        public static const RETURNINDEXEDARRAY:uint = 8;
        
        /**
         * Specifies the unique sorting requirement for the Array class sorting methods. 
         * You can use this constant for the <code class="prettyprint">options</code> parameter in the <code class="prettyprint">sort()</code> or <code class="prettyprint">sortOn()</code> method. 
         * The unique sorting option terminates the sort if any two elements or fields being sorted have identical values. 
         * <p>The value of this constant is 4.</p>
         */
        public static const UNIQUESORT:uint = 4;
        
        /**
         * Defines the constant value of the sortPolicy property if the ArrayMap is sorted by "value".
         */
        public static const VALUE:String = "value" ;
        
        /**
         * Determinates the Comparator object used in the map to sort the entries.
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
            _comparator = comp ;
        }
        
        /**
         * Indicates the options to sort the elements in the Map.
         */
        public function get options():uint
        {
            return _options ;
        }
        
        /**
         * @private
         */
        public function set options( o:uint ):void 
        {
            _options = o ;
        }
        
        /**
         * Indicates if the map entries are sorted by value or key.
         */
        public function get sortBy():String
        {
            return _sortBy ;
        }
        
        /**
         * @private
         */
        public function set sortBy( str:String ):void 
        {
            _sortBy = ( str == SortedArrayMap.VALUE ) ? SortedArrayMap.VALUE : SortedArrayMap.KEY ;
        }
        
        /**
         * Sorts the elements in Map by key or value with the current Comparator reference.
         * <p><b>Example :</b></p>
         * <code class="prettyprint">
         * import system.data.maps.SortedArrayMap ;
         * 
         * import system.comparators.NumberComparator ;
         * 
         * var map:SortedArrayMap = new SortedArrayMap() ;
         * 
         * map.comparator = new NumberComparator() ;
         * 
         * map.put( 1 , 4 ) ;
         * map.put( 3 , 2 ) ;
         * map.put( 4 , 3 ) ;
         * map.put( 2 , 1 ) ;
         * 
         * trace(map) ; // {1:4,3:2,4:3,2:1}
         * 
         * map.options = SortedArrayMap.DESCENDING ;
         * map.sort() ;
         * 
         * trace(map) ; // {4:3,3:2,2:1,1:4}
         * 
         * map.options = SortedArrayMap.NONE ;
         * map.sort() ;
         * 
         * trace(map) ; // {1:4,2:1,3:2,4:3}
         * 
         * map.sortBy = SortedArrayMap.VALUE ;
         * 
         * map.options = SortedArrayMap.DESCENDING ;
         * map.sort() ;
         * 
         * trace(map) ; // {1:4,4:3,3:2,2:1}
         * 
         * map.options = SortedArrayMap.NONE ;
         * map.sort() ;
         * 
         * trace(map) ; // {2:1,3:2,4:3,1:4}
         * </code>
         * @see SortedArrayMap#sortBy
         */
        public function sort():void  
        {
            var compare:Function = _comparator.compare as Function ;
            
            var max:uint = size() ;
            
            if (compare == null && !(max > 0) )
            {
                return ;
            }
            
            var result:Array ;
            var clone:Array ;
            
            if ( sortBy == KEY )
            {
                result = _keys.sort( compare , _options | Array.RETURNINDEXEDARRAY ) ;
                _keys.sort( compare , _options ) ;
                clone = getValues() ;
                while ( --max > -1 )
                {
                    _values[max] = clone[ result[max] ] ;
                }
            }
            else
            {
                result = _values.sort( compare , _options | Array.RETURNINDEXEDARRAY ) ;
                _values.sort( compare , _options ) ;
                clone = getKeys() ;
                while ( --max > -1 )
                {
                    _keys[max] = clone[ result[max] ] ;
                }
            }
        }
        
        /**
         * Sorts the elements in the list according to one or more fields in the array.
         * <p><b>Example :</b></p>
         * <code class="prettyprint">
         * import system.data.Iterator ;
         * import system.data.Map ;
         * import system.data.maps.SortedArrayMap ;
         * 
         * var map:SortedArrayMap = new SortedArrayMap() ;
         * 
         * map.put( { id:5 } , { name:'name4' } ) ;
         * map.put( { id:1 } , { name:'name1' } ) ;
         * map.put( { id:3 } , { name:'name5' } ) ;
         * map.put( { id:2 } , { name:'name2' } ) ;
         * map.put( { id:4 } , { name:'name3' } ) ;
         * 
         * var debug:Function = function( map:Map ):void
         * {
         * 
         *     var vit:Iterator = map.iterator() ;
         *     var kit:Iterator = map.keyIterator() ;
         *     var str:String = "{" ;
         *     
         *     var key:* ;
         *     var value:* ;
         *              *     
         *     while( vit.hasNext() )
         *     {
         *         value = vit.next() ;
         *         key   = kit.next() ;
         *         str += key.id + ":" + value.name ;
         *         if (vit.hasNext())
         *         {
         *             str += "," ;
         *         }
         *     }
         *     str += "}" ;
         *     trace(str) ;
         * }
         * 
         * trace("----- original Map") ;
         * 
         * debug( map ) ; // {5:name4,1:name1,3:name5,2:name2,4:name3}
         * 
         * trace("----- sort by key with sort() method") ;
         * 
         * map.sortBy = SortedArrayMap.KEY ; // default
         * map.options = SortedArrayMap.NUMERIC | SortedArrayMap.DESCENDING ;
         * map.sortOn("id") ;
         * debug( map ) ; // {5:name4,4:name3,3:name5,2:name2,1:name1}
         * 
         * map.options = SortedArrayMap.NUMERIC | SortedArrayMap.DESCENDING ;
         * map.sortOn("id") ;
         * debug( map ) ; // {5:name4,4:name3,3:name5,2:name2,1:name1}
         * 
         * trace("----- sort by value with sort() method") ;
         * 
         * map.sortBy = SortedArrayMap.VALUE ;
         * map.options = SortedArrayMap.DESCENDING ;
         * map.sortOn("name") ;
         * debug( map ) ; // {3:name5,5:name4,4:name3,2:name2,1:name1}
         * 
         * map.options = SortedArrayMap.NONE ;
         * map.sortOn("name") ;
         * debug( map ) ; // {1:name1,2:name2,4:name3,5:name4,3:name5}
         * </code>
         * @param fieldName A string that identifies a field to be used as the sort value.
         * @param opts (optional) The option number value to use to sort this map.
         * @see SortedArrayMap#sortBy 
         */
        public function sortOn( fieldName:* , opts:Number=NaN ):void 
        {
        
            var max:uint = size() ;
            
            if (fieldName == null && !(max > 0) )
            {
                return ;
            }
            
            if ( !isNaN(opts) )
            {
                _options = opts ;
            }
            
            var result:Array ;
            var clone:Array ;
            
            if ( sortBy == KEY )
            {
                result = _keys.sortOn( fieldName , _options | Array.RETURNINDEXEDARRAY ) ;
                _keys.sortOn( fieldName , _options ) ;
                clone = getValues() ;
                while ( --max > -1 )
                {
                    setValueAt( max , clone[ result[max] ] ) ;
                }
            }
            else
            {
                result = _values.sortOn( fieldName , _options | Array.RETURNINDEXEDARRAY ) ;
                _values.sortOn( fieldName  , _options ) ;
                clone = getKeys() ;
                while ( --max > -1 )
                {
                    _keys[max] = clone[ result[max] ] ;
                }
            }
        }
        
        /**
         * @private
         */
        protected var _comparator:Comparator ;
        
        /**
         * @private
         */
        protected var _options:uint ;
        
        /**
         * @private
         */
        private var _sortBy:String ;
    }
}
