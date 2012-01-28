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

package system.data.bags
{
    import core.reflect.getClassName;
    import core.reflect.getClassPath;
    
    import system.data.Bag;
    import system.data.Collection;
    import system.data.Iterator;
    import system.data.List;
    import system.data.Map;
    import system.data.Set;
    import system.data.iterators.BagIterator;
    import system.data.lists.ArrayList;
    import system.data.maps.MapUtils;
    import system.data.sets.ArraySet;
    
    import flash.errors.IllegalOperationError;
    
    /**
     * This class provides a skeletal implementation of the <code class="prettyprint">Bag</code> interface, to minimize 
     * the effort required to implement this interface.
     * <p>To implement a bag, the programmer needs only to extend this class and provide implementations for the cursor, 
     * insert and size methods. For supporting the removal of elements, the cursor returned by the cursor method must 
     * additionally implement its remove method.</p>
     */
    public class CoreMapBag implements Bag
    {
        /**
         * Creates a new CoreMapBag instance.
         * @param map a Map reference used to register all elements in the Bag.
         * @param co a <code class="prettyprint">Collection</code> to constructs a bag containing all the members of the given collection.
         */
        public function CoreMapBag( map:Map = null , co:Collection = null )
        {
            setMap( map ) ;
            if ( co != null ) 
            {
                addAll(co) ;
            }
        }
        
        /**
         * This property is a protector used in the BagIterator object of this bag.
         */
        public function get modCount():int 
        {
            return _modCount ;
        }
        
        /**
         * @private
         */
        public function set modCount( i:int ):void
        {
            _modCount = i ;
        }
        
        /**
         * Add one copy of the given object to the bag and keep a count. 
         */ 
        public function add( o:* ):Boolean 
        {
            return addCopies( o , 1 ) ;
        }
        
        /**
         * Insert all elements represented in the given collection.
         */
        public function addAll( c:Collection ):Boolean 
        {
            var changed:Boolean = false;
            var i:Iterator = c.iterator() ;
            var added:Boolean ;
            while ( i.hasNext() ) 
            {
                added   = addCopies( i.next() , 1 )  ;
                changed = changed || added ;
            }
            return changed;
        }
        
        /**
         * Add n copies of the given object to the bag and keep a count. 
         * @return <code class="prettyprint">true</code> if the object was not already in the <code>uniqueSet</code>
         */
        public function addCopies( o:* , nCopies:uint ):Boolean 
        {
            _modCount++ ;
            if ( nCopies > 0 ) 
            {
                var count:int = nCopies + getCount(o) ;
                _map.put( o , count ) ;
                _size += nCopies ;
                return count == nCopies ;
            }
            else 
            {
                return false;
            }
        }
        
        /**
         * Removes all of the elements from this bag.
         */
        public function clear():void 
        {
            _modCount ++ ;
            _map.clear() ;
            _size = 0 ;
        }
        
        /**
         * Returns the shallow copy of this bag.
         * @return the shallow copy of this bag.
         */
        public function clone():*
        {
            var m:Map        = getMap().clone() ;
            var c:Collection = _extractList() ;
            m.clear() ;
            return new CoreMapBag( m , (c != null && c.size()) > 0 ? c : null ) ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if this bag contains the object passed in argument.
         * @return <code class="prettyprint">true</code> if this bag contains the object passed in argument.
         */
        public function contains(o:*):Boolean 
        {
            return _map.containsKey(o);
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if thie bag contains all object in the passed collection in argument.
         * @return <code class="prettyprint">true</code> if thie bag contains all object in the passed collection in argument.
         */
        public function containsAll( c:Collection ):Boolean 
        {
            if ( c == null ) 
            {
                return false ;
            }
            return containsAllInBag( new HashBag(c) ) ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if thie bag contains all object in the passed bag in argument.
         * @return <code class="prettyprint">true</code> if thie bag contains all object in the passed bag in argument.
         */
        public function containsAllInBag( b:Bag ):Boolean 
        {
            if ( b == null )
            {
                return false ;
            }
            var current:* ;
            var contains:Boolean ;
            var result:Boolean = true ;
            var i:Iterator = b.uniqueSet().iterator() ;
            while ( i.hasNext() ) 
            {
                current  = i.next();
                contains = getCount(current) >= b.getCount(current) ;
                result   = result && contains ;
            }
            return result;
        }
        
        /**
         * Compares this Bag to another. This Bag equals another Bag if it contains the same number of occurrences of the same elements.
         * @param o the Bag to compare to.
         * @return true if equal.
         */
        public function equals( o:* ):Boolean
        {
            if (o == this) 
            {
                return true;
            }
            if ( o is Bag == false ) 
            {
                return false;
            }
            var other:Bag = o as Bag ;
            if (other.size() != size()) 
            {
                return false;
            }
            var it:Iterator = uniqueSet().iterator() ;
            var element:* ;
            while(it.hasNext())
            {
                element = it.next();
                if (other.getCount(element) != getCount(element)) 
                {
                    return false;
                }
            }
            return true ;
        }
        
        /**
         * Unsupported by bag objects.
         * @throws IllegalOperationError the 'get' method is unsupported with a bag object.
         */
        public function get( key:* ):*
        {
            throw new IllegalOperationError( getClassName(this) + ", the get() method is unsupported.") ;
        }
        
        /**
         * Returns the count of the specified object passed in argument.
         * @return the count of the specified object passed in argument.
          */
        public function getCount(o:*):uint
        {
            return uint( MapUtils.getNumber( _map , o ) ) ;
        }
        
        /**
         * Unsupported by bag objects.
         * @throws IllegalOperationError the 'indexOf' method is unsupported with a bag object.
         */    
        public function indexOf(o:*, fromIndex:uint=0):int
        {
            throw new IllegalOperationError( getClassName(this) + ", the indexOf() method is unsupported.") ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the bag is empty.
         * @return <code class="prettyprint">true</code> if the bag is empty.
         */
        public function isEmpty():Boolean 
        {
            return _map.isEmpty() ;
        }
        
        /**
         * Returns the Iterator representation of the Bag.
         * @return the Iterator representation of the Bag.
         */
        public function iterator():Iterator 
        {
            return new BagIterator(this, _extractList().iterator()) ;
        }
        
        /**
         * Removes the object in argument in the bag.
         */
        public function remove(o:*):* 
        {
            return removeCopies(o, getCount(o));
        }
        
        /**
         * Removes objects from the bag according to their count in the specified collection.
         * @param c the collection to use.
         * @return true if the bag changed.
         */
        public function removeAll(c:Collection):Boolean 
        {
            var result:Boolean = false ;
            if (c != null) {
                var i:Iterator = c.iterator() ;
                while (i.hasNext()) 
                {
                    var next:* = i.next() ;
                    var changed:Boolean = removeCopies(next, 1) ;
                    result = result || changed ;
                }
            }
            return result ;
        }
        
        /**
         * Removes a specified number of copies of an object from the bag.
         * @param o the object to remove
         * @param nCopies the number of copies to remove
         * @return true if the bag changed
         */
        public function removeCopies(o:*, nCopies:uint):Boolean 
        {
            _modCount++;
            if ( nCopies == 0 ) 
            {
                return false ;
            }
            var result:Boolean ;
            var count:uint = getCount( o ) ;
            if ( count > nCopies ) 
            {
                _map.put( o, new int(count - nCopies)) ;
                result = true ;
                _size -= nCopies ;
            }
            else
            { 
                result = (_map.remove(o) != null) ; // need to remove all
                _size -= count ;
            }
            return result;
        } 
        
        /**
         * Removes any members of the bag that are not in the given collection, respecting cardinality.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.data.Collection;
         * import system.data.collections.ArrayCollection;
         * import system.data.bags.CoreMapBag;
         * import system.data.maps.ArrayMap;
         * 
         * var bag:CoreMapBag = new CoreMapBag( new ArrayMap() ) ;
         * 
         * bag.add("item1") ;
         * bag.add("item2") ;
         * bag.add("item2") ;
         * bag.add("item3") ;
         * bag.add("item3") ;
         * bag.add("item3") ;
         * 
         * var col:Collection = new ArrayCollection(["item1","item2","item3"]) ;
         * bag.retainAll(col) ;
         * trace( bag ) ; // {1:item1,2:item2}
         * </pre>
         * @param c the collection to retain.
         * @return <code class="prettyprint">true</code> if this call changed the collection.
         */
        public function retainAll( c:Collection ):Boolean 
        {
            return retainAllInBag( new HashBag(c) ) ;
        }
        
        /**
         * Removes any members of the bag that are not in the given bag, respecting cardinality.
         * @param b the bag to retain.
         * @return <code class="prettyprint">true</code> if this call changed the collection.
         */
        public function retainAllInBag( b:Bag ):Boolean 
        {
            if ( b == null )
            {
                b = new HashBag() ;
            }
            var cur:* ;
            var count1:uint ;
            var count2:uint ;
            var result:Boolean ;
            var excess:Bag = new HashBag() ;
            var i:Iterator = uniqueSet().iterator() ;
            while (i.hasNext()) 
            {
                cur = i.next() ;
                count1 = getCount(cur) ;
                count2 = b.getCount(cur) ;
                if ( 1 <= count2 && count2 <= count1) 
                {
                    excess.addCopies(cur, count1 - count2) ;
                }
                else 
                {
                    excess.addCopies(cur, count1) ;
                }
            }
            if ( !excess.isEmpty() ) 
            {
                result = removeAll(excess) ;
            }
            return result;
        }
        
        /**
         * Returns the number of elements in this bag (its cardinality).
         * @return the number of elements in this bag (its cardinality).
         */
        public function size():uint
        {
            return _size ;
        }
        
        /**
         * Returns the array representation of the bag.
         * @return the array representation of the bag.
         */
        public function toArray():Array 
        {
            return _extractList().toArray();
        }
        
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public function toSource( indent:int = 0 ):String  
        {
            return "new " + getClassPath(this, true) + "(" + _map.toSource() + ")" ; 
        }
        
        /**
         * Returns the string representation of this instance.
         * @return the string representation of this instance.
         */
        public function toString():String 
        {
            return formatter.format( this ) ;
        }
        
        /**
         * Returns the Set of unique members that represent all members in the bag.
         * @return the Set of unique members that represent all members in the bag.
         */
        public function uniqueSet():Set 
        {
            return new ArraySet( _map.getKeys() ) ;
        }
        
        /**
         * @private
         */
        protected function _calculateTotalSize():uint
        {
            _size = _extractList().size() ;
            return _size ;
        }
        
        /**
         * @private
         */
        protected function _extractList():List 
        {
            var result:List = new ArrayList() ;
            var i:Iterator  = uniqueSet().iterator();
            while ( i.hasNext() ) 
            {
                var current:* = i.next() ;
                var l:int     = getCount( current ) ;
                while (--l > -1) 
                {
                    result.add(current);
                }
            }
            return result ;
        }
        
        /**
         * @private
         */
        protected function getMap():Map 
        {
            return _map ;
        }
        
        /**
         * @private
         */
        protected function setMap( m:Map ):void
        {
            if ( m != null && m.isEmpty() ) 
            {
               _map = m ;
            }
            else
            {
               throw new ArgumentError( getClassName(this) + ", set the internal Map failed. The Map must be non-null and empty.") ;
            }
        }
        
        /**
         * @private
         */
        private var _map:Map ;
        
        /**
         * @private
         */
        private var _modCount:uint ;
        
        /**
         * @private
         */
        private var _size:uint ;
    }
}