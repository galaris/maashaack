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
    import system.data.ListIterator;
    import system.data.lists.LinkedList;
    import system.data.lists.LinkedListEntry;
    import system.errors.ConcurrencyError;
    import system.errors.NoSuchElementError;
    
    import flash.errors.IllegalOperationError;    

    /**
     * Converts a <code class="prettyprint">LinkedList</code> to a specific <code class="prettyprint">ListIterator</code>.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.data.lists.LinkedList ;
     * import system.data.ListIterator ;
     * 
     * var list:LinkedList = new LinkedList() ;
     * list.add("item1") ;
     * list.add("item2") ;
     * list.add("item3") ;
     * var it:ListIterator = list.listIterator(2) ;
     * trace( it.hasPrevious() + " : " + it.previous() ) ; // true : item2
     * </pre>
     */
    public class LinkedListIterator implements ListIterator 
    {
        
        /**
         * Creates a new LinkedListIterator instance.
         * @param index The position of the internal pointer of this Iterator
         * @param list The owner LinkedList of this iterator.
         */
        public function LinkedListIterator( list:LinkedList , index:uint = 0 )
        {
            this._list = list ;
            seek(index) ;
        }        

        /**
         * Inserts the specified element into the list (optional operation).
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.data.ListIterator ;
         * import system.data.lists.LinkedList ;
         * 
         * var list:LinkedList = new LinkedList() ;
         * 
         * list.add("item1") ;
         * list.add("item2") ;
         * list.add("item3") ;
         * 
         * var it:ListIterator = list.listIterator(1) ;
         * it.insert("item0") ;
         * 
         * trace(list) ;
         * </pre>
         * <p><b>Attention :</b> Dont' use this method in a loop with hasPrevious() and previous() method.</p> 
         */
        public function add(o:*):void
        {
            checkForComodification();
            _lastReturned = _list.getHeader() ;
            _list.addBefore(o, _next) ;
            _nextIndex ++ ;
            _expectedModCount ++ ;
        }
        
        /**
         * This method check the comodification of the LinkedList and test if the iterator is valid and can continue to process.
         */
        public function checkForComodification():void 
        {
            if ( _list.modCount != _expectedModCount )
            {
                throw new ConcurrencyError("LinkedListIterator check for comodification failed with a LinkedList." ) ;
            }
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the iteration has more elements.
         * @return <code class="prettyprint">true</code> if the iteration has more elements.
         */
        public function hasNext():Boolean
        {
            return _nextIndex != _list.size() ;
        }
        
        /**
         * Checks to see if there is a previous element that can be iterated to.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.data.ListIterator ;
         * import system.data.lists.LinkedList ;
         * 
         * var list:LinkedList = new LinkedList() ;
         * 
         * list.add("item1") ;
         * list.add("item2") ;
         * list.add("item3") ;
         * 
         * var it:ListIterator = list.listIterator( 2 ) ;
         * 
         * trace( it.hasPrevious() ) ;
         * </pre>
         */
        public function hasPrevious():Boolean
        {
            return this._nextIndex != 0 ;
        }
        
        /**
         * Illegal operation in this iterator, uses nextIndex() and previousIndex() method.
         * @throws IllegalOperationError if the user call this method, this method is unsupported.
         */
        public function key():*
        {
            throw new IllegalOperationError("LinkedListIterator.key() method is unsupported.") ;
            return null ;
        }
        
        /**
         * Returns the next element in the iteration.
         * @return the next element in the iteration.
         */
        public function next():*
        {
            checkForComodification();
            if ( _nextIndex == _list.size() )
            {
                throw new NoSuchElementError("LinkedListIterator.next() method failed.");
            }
            _lastReturned = _next ;
            _next         = _next.next ;
            _nextIndex ++ ;
            return _lastReturned.element ;
        }
        
        /**
         * Returns the index of the element that would be returned by a subsequent call to next.
         * @return the index of the element that would be returned by a subsequent call to next.
         */
        public function nextIndex():uint
        {
            return _nextIndex ; 
        }
        
        /**
         * Returns the previous element in the collection.
         * @return the previous element in the collection.
         */
        public function previous():*
        {
            if (this._nextIndex == 0)
            {
                throw new NoSuchElementError( "LinkedListIterator.previous() method failed.");
            }
            _lastReturned = this._next = this._next.previous ;
            _nextIndex-- ;
            checkForComodification();
            return _lastReturned.element ;
        }
        
        /**
         * Returns the index of the element that would be returned by a subsequent call to previous.
         * @return the index of the element that would be returned by a subsequent call to previous.
         */
        public function previousIndex():int
        {
            return _nextIndex - 1 ;
        }
        
        /**
         * Removes from the underlying collection the last element returned by the iterator (optional operation).
         */
        public function remove():* 
        {
            checkForComodification() ;
            var lastNext:LinkedListEntry = _lastReturned.next;
            try 
            {
                _list.removeEntry( _lastReturned ) ;
            }
            catch ( e:NoSuchElementError ) 
            {
                throw new NoSuchElementError( "LinkedListIterator.remove() method failed.") ;
            }
            if ( _next == _lastReturned)
            {
                _next = lastNext ;
            }
            else
            {
                _nextIndex-- ;
            }
            _lastReturned = this._list.getHeader() ;
            _expectedModCount++;
        }
        
        /**
         * Reset the internal pointer of the iterator (optional operation).
         */
        public function reset():void 
        {
            seek(0) ;
        }
        
        /**
         * Change the position of the internal pointer of the iterator (optional operation).
         */
        public function seek( position:* ):void
        {
            _lastReturned     = this._list.getHeader() ;
            _expectedModCount = this._list.modCount ;
            
            var size:Number   = _list.size() ;
            
            if ( !( position is Number) )
            {
                throw new ArgumentError(this + "LinkedListIterator.seek() method failed, the position parameter must be a Number value.") ;
            } 
            
            if ( position < 0 || position > size )
            {
                throw new RangeError( "LinkedListIterator.seek() method failed, index:" + position + ", size:" + size + "." ) ;
            }
            
            if ( position < ( size >> 1 ) ) 
            {
                _next = _list.getHeader().next ;
                for ( _nextIndex = 0 ; _nextIndex < position ; _nextIndex ++ )
                {
                    _next = _next.next ;
                }
            } 
            else 
            {
                _next = _list.getHeader()  ;
                for ( _nextIndex = size ; _nextIndex > position ; _nextIndex-- )
                {
                    _next = _next.previous ;
                }
            }
        
        }
        
        /**
         * Replaces the last element returned by next or previous with the specified element (optional operation).
         */
        public function set(o:*):void
        {
            if ( _lastReturned == _list.getHeader() )
            {
                throw new IllegalOperationError(this + "LinkedListIterator.set() method failed.");
            }
            checkForComodification();
            _lastReturned.element = o ;
        }
        
        /**
         * The internal expected mod count value.
         * @private
         */
        private var _expectedModCount:uint ;
        
        /**
         * The last list entry returned.
         * @private
         */
        private var _lastReturned:LinkedListEntry = null ;
        
        /**
         * The list reference of this iterator.
         * @private
         */
        private var _list:LinkedList ;
        
        /**
         * The next entry.
         * @private
         */
        private var _next:LinkedListEntry ;
        
        /**
         * The next index in the iterator.
         * @private
         */
        private var _nextIndex:Number ;
    }
}
