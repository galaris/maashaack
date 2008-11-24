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
  Portions created by the Initial Developers are Copyright (C) 2006-2008
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
    import system.data.List;
    import system.data.ListIterator;
    import system.data.collections.ArrayCollection;
    import system.data.errors.NoSuchElementError;
    import system.data.iterators.ArrayListIterator;    

    /**
     * Resizable-array implementation of the List interface. Implements all optional list operations, and permits all elements, including null.
     */
    public class ArrayList extends ArrayCollection implements List
    {
        
        /**
         * Creates a new ArrayList instance.
         * <p><b>Usage </b></p>
         * <pre class="prettyprint">
         *  new ArrayList() ;
         *  new ArrayList(ar:Array) ;
         *  new ArrayList(it:Iterable) ;
         *  new ArrayList(co:Collection) ;
         *  new ArrayList( capacity:uint ) ;
         * </pre>
         * @param init An optional Array or Collection or Iterable object to fill the collection. 
         * This parameter can be an uint value to determinates the default capacity of the list.
         * @see ensureCapacity 
         */
        public function ArrayList( init:* = null )
        {
            super(init);
            if (init is uint)
            {
                ensureCapacity( init as uint ) ;
            }
        }
        
        /**
         * Inserts the specified element at the specified position in this list (optional operation).
         */        
        public function addAt(id:uint, o:*):void
        {
            if ( id > size() ) 
            {
                throw new RangeError( this + " insertAt method failed, the specified index '" + id + "' is out of bounds.") ;
            }
            _a.splice(id, 0, o) ;        	
        }
        
        /**
         * Returns a shallow copy of this collection (optional operation).
         * @return a shallow copy of this collection (optional operation).
         */
        public override function clone():* 
        {
            return new ArrayList( toArray() ) ;
        }        
        
        /**
         * Increases the capacity of this ArrayList instance, if necessary, to ensure that it can hold at least the number of elements specified by the minimum capacity argument.
         */
        public function ensureCapacity( capacity:uint ):void 
        {
            _a.length = capacity ;
        }        
        
        /**
         * This method is used by the <code class="prettyprint">ListItr</code> class only.
         */
        public function getModCount():Number 
        {
            return _modCount ;
        }

        /**
         * Returns the index in this list of the last occurrence of the specified element, or -1 if this list does not contain this element.
         * @return the index in this list of the last occurrence of the specified element, or -1 if this list does not contain this element.
         */        
        public function lastIndexOf( o:* ):int
        {
        	return _a.lastIndexOf(o) ;
        }
        
        /**
         * Returns a ListIterator of the elements in this list (in proper sequence).
         * @return a ListIterator of the elements in this list (in proper sequence).
         */
        public function listIterator( position:uint=0 ):ListIterator 
        {
            var li:ListIterator = new ArrayListIterator( this ) ;
            li.seek(position) ;
            return li ;
        }        

        /**
         * Removes from this list all the elements that are contained between the specific <code class="prettyprint">id</code> position and the end of this list (optional operation).
         * @param id The index of the element or the first element to remove.
         * @param len The number of elements to remove (default 1).  
         */        
        public function removeAt(id:uint, len:int = 1):*
        {
        	len = len > 1 ? len : 1 ;
            var d:uint = len - id ;
            var old:* = _a.slice(id, d) ;
            _a.splice(id, len);
            return old ; 
        }
        
        /**
         * Removes from this list all the elements that are contained between the specific <code class="prettyprint">from</code> and the specific <code class="prettyprint">to</code> position in this list (optional operation).
         * @param fromIndex The from index to remove elements in the list.
         * @param toIndex The to index to remove elements in the list.
         */        
        public function removeRange( fromIndex:uint , toIndex:uint ):void
        {
            if ( fromIndex == 0 ) 
            {
            	return ;
            }
            var it:ListIterator = listIterator(fromIndex) ;
            var l:int = toIndex - fromIndex ;
            for (var i:int = 0 ; i<l ; i++) 
            {
                it.next() ; 
                it.remove() ;
            }        	
        }
        
        /**
         * Replaces the element at the specified position in this list with the specified element (optional operation).
         * @param id index of element to replace.
         * @param o element to be stored at the specified position.
         * @return the element previously at the specified position.
         */        
        public function setAt(id:uint, o:*):*
        {
            var i:ListIterator = listIterator(id) ;
            try 
            {
                var old:* = i.next() ;
                i.set(o) ;
                return old ;
            }
            catch( e:NoSuchElementError ) 
            {
                throw new RangeError("LinkedList setAt method failed, index:" + id ) ;
            }        	
        }
        
        /**
         * Sets the modCount property of this list.
         */
        public function setModCount( n:uint ):void
        {
            _modCount = n ;
        }        
        
        /**
         * Returns a view of the portion of this list between the specified fromIndex, inclusive, and toIndex, exclusive.
         * @return a view of the portion of this list between the specified fromIndex, inclusive, and toIndex, exclusive.
         */        
        public function subList(fromIndex:uint, toIndex:uint):List
        {
        	var l:List = new ArrayList() ;
        	//
        	return l ;
        }        
     
        /**
         * @private
         */
        private var _modCount:Number = 0 ;     
        
    }
}
