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

package system.data.iterators 
{
    import core.maths.clamp;

    import system.data.ListIterator;
    import system.data.lists.ArrayList;
    import system.errors.ConcurrencyError;
    import system.errors.NoSuchElementError;

    import flash.errors.IllegalOperationError;

    [ExcludeClass]

    /**
     * The basic implementation of the <code class="prettyprint">ListIterator</code> used in the <code class="prettyprint">ArrayList</code> class.
     * <p>This class is public but you not must use it directly.</p>
     */
    public class ArrayListIterator implements ListIterator 
    {
        
        /**
         * Creates a new ArrayListIterator instance.
         * @param li The ArrayList reference of this Iterator.
         * @param position The optional position of the iterator (default 0).
         * @throws ArgumentError If the 'list' argument is 'null' or 'undefined'.
         */
        public function ArrayListIterator( list:ArrayList , position:uint = 0 )
        {
            if ( list == null ) 
            {
                throw new ArgumentError( "ListIterator constructor failed, the 'list' argument not must be 'null' or 'undefined'.") ;
            }
            _list             = list ;
            _key              = 0 ;
            _listast          = -1 ;
            _expectedModCount = _list.modCount ;  
            seek( position ) ;         
        }
        
        /**
         * Inserts an object in the list during the iteration process.
         */
        public function add( o:* ):void 
        {
            checkForComodification() ;
            try 
            {
                _list.addAt( _key++ , o ) ;
                _listast = -1 ;
                _expectedModCount = _list.modCount ;
            } 
            catch ( e:Error ) 
            {
                throw e ;
            }   
        }        
        
        /**
         * Invoked to check for comodification.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.data.lists.ArrayList ;
         * import system.data.Iterator ;
         * 
         * var list:ArrayList = new ArrayList() ;
         * 
         * list.add("item1") ;
         * list.add("item2") ;
         * list.add("item3") ;
         * 
         * trace( list.modCount ) ;
         * 
         * var next:* ;
         * 
         * var it:Iterator = list.listIterator() ;
         * 
         * while( it.hasNext() )
         * {
         *     next = it.next() ;
         *     if ( next == "item2")
         *     {
         *         list.add("item4") ; // enforce a modification in the list but not use the iterator.
         *         it.remove() ; // ConcurrentModificationError: ListIterator modification failed, the list is changed during the iteration.
         *     }
         * }
         * </pre>
         */
        public function checkForComodification():void 
        {
            if ( _list.modCount != _expectedModCount) 
            {
                throw new ConcurrencyError( "ListIterator modification failed, the list is changed during the iteration.") ;
            }
        }
    
        /**
         * Returns <code class="prettyprint">true</code> if the iteration has more elements.
         * @return <code class="prettyprint">true</code> if the iteration has more elements.
         */ 
        public function hasNext():Boolean 
        {
            return _key < _list.size() ;
        }

        /**
         * Checks to see if there is a previous element that can be iterated to.
         */
        public function hasPrevious():Boolean 
        { 
            return _key != 0 ;
        }
                
        /**
         * Returns the current key of the internal pointer of the iterator (optional operation).
         * @return the current key of the internal pointer of the iterator (optional operation).
         */
        public function key():*
        {
            return _key ;
        }

        /**
         * Returns the next element in the iteration.
         * @return the next element in the iteration.
         */
        public function next():* 
        {
            if ( hasNext() ) 
            {
                var next:* = _list.get( _key ) ;
                _listast   = _key ;
                _key++ ;
                return next ;
            }
            else 
            {   
                throw new NoSuchElementError( "ListIterator.next() method failed." ) ;
            }
        }
        
        /**
         * Returns the next index value of the iterator.
         * @return the next index value of the iterator.
         */
        public function nextIndex():uint 
        {
            return _key ;
        }
        
        /**
         * Returns the previous element in the collection.
         * @return the previous element in the collection.
         */
        public function previous():*
        {
            checkForComodification() ;
            try 
            {
                var i:Number = _key - 1 ;
                var prev:*   = _list.get(i) ;
                _listast     = _key  = i ;
                return prev ;
            }
            catch( e:Error ) 
            {
                checkForComodification() ;
                throw new NoSuchElementError( "ListIterator.previous method failed.") ;
            }
        }

        /**
         * Returns the previous index value of the iterator.
         * @return the previous index value of the iterator.
         */
        public function previousIndex():int 
        {
            return _key - 1 ;
        }
        
        /**
         * Removes from the underlying collection the last element returned by the iterator (optional operation).
         */
        public function remove():*
        {
            if (_listast == -1) 
            {
                throw new IllegalOperationError( "ListIterator.remove() failed, the iterator state is not valid.") ;
            }
            checkForComodification() ;
            try 
            {
                _list.removeAt(_listast) ;
                if (_listast < _key) 
                {
                    _key -- ;
                }
                _listast = -1 ;
                _expectedModCount = _list.modCount ;
            } 
            catch ( e:ConcurrencyError ) 
            {
                throw new ConcurrencyError( "ListIterator.remove() method failed.") ;
            }
        }   

        /**
         * Reset the internal pointer of the iterator (optional operation).
         */
        public function reset():void 
        {
            _key = 0 ;
        }
            
        /**
        * Change the position of the internal pointer of the iterator (optional operation).
        */
        public function seek( position:* ):void 
        {
            _key = clamp( position, 0, _list.size() ) ;
            _listast = _key - 1 ;
        }
            
        /**
         * Sets the last element returned by the iterator.
         */
        public function set( o:* ):void
        {
            if (_listast == -1) 
            {
                throw new IllegalOperationError( "ListIterator.set() failed, the iterator state is not valid.") ;
            }
            checkForComodification() ;
            try 
            {
                _list.set( _listast , o ) ;
                _expectedModCount = _list.modCount ;
            }
            catch ( e:Error ) 
            {
                throw e ;
            }
        }
        
        /**
         * @private
         */
        private var _expectedModCount:Number ;
        
        /**
         * @private
         */
        private var _key:uint ;
        
        /**
         * @private
         */
        private var _list:ArrayList ;
        
        /**
         * @private
         */
        private var _listast:int ;
    }
}
