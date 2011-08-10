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

package system.data.lists 
{
    import system.Comparator;
    import system.Sortable;
    import system.data.Collection;
    import system.data.lists.ArrayList;    

    /**
     * A SortedArrayList stores is elements in order with a Comparator object.
     */
    public class SortedArrayList extends ArrayList implements Sortable
    {
        
        /**
         * Creates a new SortedArrayList instance.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.data.lists.SortedArrayList ;
         * 
         * import system.comparators.AlphaComparator ;
         * import system.comparators.NumberComparator ;
         * 
         * trace( "-----" ) ;
         * 
         * var list:SortedArrayList ;
         * 
         * list = new SortedArrayList( [ 4 , 3 , 12, 24 ] ) ;
         * 
         * trace( list ) ;
         * 
         * list.comparator = new NumberComparator() ;
         * 
         * trace( list ) ;
         * 
         * trace( "-----" ) ;
         * 
         * list = new SortedArrayList( ["pink" , "red" , "blue" , "black" ] ) ;
         * 
         * trace( list ) ;
         * 
         * list.sort( new AlphaComparator() ) ;
         * 
         * trace( list ) ;
         * </pre>
         * @param init An optional Array or Collection or Iterable object to fill the collection. This parameter can be an uint value to determinates the default capacity of the list.
         * @param comp The Comparator object used in the map to sort the entries.
         * @param opts The options to sort the elements in the list.
         */
        public function SortedArrayList( init:* = null , comp:Comparator = null , opts:uint = 0 )
        {
            _comparator = comp ;
            _options    = opts ;            
            super( init );
            _sort() ;            
        }
        
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
            _sort() ;
        }
        
        /**
         * Indicates the options to sort the elements in the list.
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
            _sort() ;
        }
        
        /**
         * Inserts an element in the collection.
         */
        public override function add( o:* ):Boolean
        {
            var b:Boolean = super.add( o ) ;
            _sort() ;
            return b ;
        }
        
        /**
         * Appends all of the elements in the specified collection to the end of this Collection, in the order that they are returned by the specified collection's iterator (optional operation).
         * @return <code class="prettyprint">true</code> if this list changed as a result of the call.
         */
        public override function addAll( c:Collection ):Boolean 
        {
            var b:Boolean = super.addAll( c ) ;
            _sort() ;
            return b ;
        }         
        
        /**
         * Inserts the specified element at the specified position in this list (optional operation).
         */        
        public override function addAt( index:uint, o:* ):void
        {
            super.addAt( index , o ) ;
            _sort() ;        
        }        
        
        /**
         * Returns a shallow copy of the instance.
         * @return a shallow copy of the instance.
         */
        public override function clone():*
        {
            return new SortedArrayList( toArray() , comparator, options) ;
        } 
        
        /**
         * Sorts the elements in the list.
         */
        public function sort( compare:* = null , opts:uint = 0 ):Array  
        {
            if ( compare == null) 
            {
                return null ;
            }
            var f:Function ;
            if (compare is Comparator) 
            {
                f = (compare as Comparator).compare ;
            }
            else if (compare is Function)
            {
                f = compare ;
            }
            else
            {
                return null ;
            }
            return _a.sort(f , opts) ;
        }        
     
        /**
         * Sorts the elements in the list according to one or more fields in the array.
         * @param fieldName A string that identifies a field to be used as the sort value, or an array in which the first element represents the primary sort field, the second represents the secondary sort field, and so on.
         * @param options One or more numbers or names of defined constants, separated by the bitwise OR (|) operator, that change the sorting behavior. The following values are acceptable for the options parameter:
         * <p><li>Array.CASEINSENSITIVE or 1</li><li>Array.DESCENDING or 2</li><li>Array.UNIQUESORT or 4</li><li>Array.RETURNINDEXEDARRAY or 8</li><li>Array.NUMERIC or 16</li></p>
         * @return The return value depends on whether you pass any parameters : <p><li>If you specify a value of 4 or Array.UNIQUESORT for the options parameter, and two or more elements being sorted have identical sort fields, a value of 0 is returned and the array is not modified.</li><li>If you specify a value of 8 or Array.RETURNINDEXEDARRAY for the options parameter, an array is returned that reflects the results of the sort and the array is not modified.</li><li>Otherwise, nothing is returned and the array is modified to reflect the sort order.</li></p>
         */
        public function sortOn( fieldName:* , opts:* = null ):Array  
        {
            return _a.sortOn( fieldName , opts ) ;
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
        private function _sort():void 
        {
            sort( _comparator, _options) ;
        }        
        
    }
}
