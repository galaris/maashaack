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

package system.data.lists 
{
    import core.reflect.getClassName;

    import system.data.Collection;
    import system.data.List;
    import system.data.ListIterator;
    import system.data.collections.ArrayCollection;
    import system.data.iterators.ArrayListIterator;
    
    /**
     * Resizable-array implementation of the List interface. Implements all optional list operations, and permits all elements, including null.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.data.lists.ArrayList ;
     * 
     * var list:ArrayList = new ArrayList() ;
     * 
     * list.add("item1") ;
     * list.add("item3") ;
     * list.addAt( 1 , "item2" ) ;
     *  
     * trace( list ) ; // {item1,item2,item3}
     * trace( list.toSource() ) ; // new system.data.lists.ArrayList(["item1","item2","item3"])
     * </pre>
     */
    public class ArrayList extends ArrayCollection implements List
    {
        /**
         * Creates a new ArrayList instance.
         * <p><b>Usage </b></p>
         * <pre class="prettyprint">
         *  new ArrayList() ;
         *  new ArrayList( ar:Array ) ;
         *  new ArrayList( it:Iterable ) ;
         *  new ArrayList( co:Collection ) ;
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
            _modCount = 0 ;
        }
        
        /**
         * This property is a protector used in the ListIterator object of this List.
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
         * Inserts an element in the collection.
         */
        public override function add( o:* ):Boolean
        {
            _modCount ++ ;
            return super.add( o ) ;
        }
        
        /**
         * Appends all of the elements in the specified collection to the end of this Collection, in the order that they are returned by the specified collection's iterator (optional operation).
         * @return <code class="prettyprint">true</code> if this list changed as a result of the call.
         */
        public override function addAll( c:Collection ):Boolean 
        {
            _modCount ++ ;
            return super.addAll( c ) ;
        }
        
        /**
         * Inserts the specified element at the specified position in this list (optional operation).
         */
        public function addAt( index:uint, o:*):void
        {
            if ( index > size() ) 
            {
                throw new RangeError( getClassName(this) + ".addAt method failed, the specified index '" + index + "' is out of bounds.") ;
            }
            _modCount++ ;
            _a.splice( index , 0 , o ) ;
        }
        
        /**
         * Removes all elements in the collection.
         */
        public override function clear():void
        {
            _modCount ++ ;
            super.clear() ;
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
            _modCount++ ;
            _a.length = capacity ;
        }
        
        /**
         * Returns the index in this list of the last occurrence of the specified element, or -1 if this list does not contain this element.
         * @return the index in this list of the last occurrence of the specified element, or -1 if this list does not contain this element.
         */
        public function lastIndexOf( o:* , fromIndex:int = 0x7FFFFFFF ):int
        {
            return _a.lastIndexOf( o , fromIndex ) ;
        }
        
        /**
         * Returns a ListIterator of the elements in this list (in proper sequence).
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.data.lists.ArrayList ;
         * import system.data.ListIterator ;
         * 
         * var a:Array = ["item0", "item1", "item2", "item3", "item4"] ;
         * 
         * var list:ArrayList = new ArrayList( a ) ;
         * var it:ListIterator = list.listIterator(2) ;
         * 
         * trace ("---- ListIterator hasPrevious/previous") ;
         * 
         * while(it.hasNext())
         * {
         *     trace(">> " + it.next() + " : " + it.key()) ;
         *     it.remove() ;
         * }
         * trace ("next : " + list) ;
         * 
         * trace ("---- ListIterator hasPrevious/previous") ;
         * 
         * var cpt:uint = list.size() ;
         * while(it.hasPrevious())
         * {
         *     it.previous() ;
         *     it.set("element" +  cpt--) ;
         * }
         * trace ("list : " + list) ;
         * </pre>
         * @return a ListIterator of the elements in this list (in proper sequence).
         */
        public function listIterator( position:uint=0 ):ListIterator 
        {
            return new ArrayListIterator( this , position) ;
        }
        
        /**
         * Removes a single instance of the specified element from this collection, if it is present (optional operation).
         */
        public override function remove( o:* ):*
        {
            _modCount++ ;
            return super.remove( o ) ;
        }
        
        /**
         * Removes from this list all the elements that are contained between the specific <code class="prettyprint">id</code> position and the end of this list (optional operation).
         * @param id The index of the element or the first element to remove.
         * @param len The number of elements to remove (default 1).  
         * @return The Array representation of all elements removed in the original list.
         */        
        public function removeAt(id:uint, len:int = 1):*
        {
            _modCount ++ ;
            len = len > 1 ? len : 1 ;
            var old:* = _a.splice(id, len);
            return old ; 
        }
        
        /**
         * Removes from this List all of the elements whose index is between fromIndex, inclusive and toIndex, exclusive. 
         * <p>Shifts any succeeding elements to the left (reduces their index).</p> 
         * <p>This call shortens the list by (toIndex - fromIndex) elements. (If toIndex==fromIndex, this operation has no effect.)</p>
         * @param fromIndex The from index (inclusive) to remove elements in the list.
         * @param toIndex The to index (exclusive) to remove elements in the list.
         */        
        public function removeRange( fromIndex:uint , toIndex:uint ):*
        {
            if ( fromIndex == toIndex )
            {
                return null ;
            }
            var len:int = toIndex - fromIndex ;
            return removeAt( fromIndex , len ) ;
        }
        
        /**
         * Replaces the element at the specified position in this list with the specified element (optional operation).
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.data.lists.ArrayList ;
         * 
         * var list:ArrayList = new ArrayList( [ "item1", "item2", "item3", "item4" ] ) ;
         * 
         * list.set(0, "item") ;
         * trace(list) ;
         * // {item,item2,item3,item4}
         * 
         * list.set(1, undefined) ;
         * trace(list) ;
         * // {item,item3,item4}
         * 
         * list.set( 5 , "item" ) ;
         * trace(list) ;
         * // RangeError: The ArrayList.set() method failed, the index '5' argument is out of the size limit.
         * </pre>
         * @param index index of element to replace.
         * @param o element to be stored at the specified position or if o is <code class="prettyprint">undefined</code> the stored value is remove (like with the removeAt() method).
         * @return the element previously at the specified position or undefined.
         */
        public function set( index:uint , o:*):*
        {
            if ( index > size() - 1 )
            {
                throw new RangeError( "The " + getClassName(this) + ".set() method failed, the index '" + index + "' argument is out of the size limit." ) ;
            }
            var old:* = _a[index] ;
            if ( old === undefined )
            {
                return undefined ;
            }
            if ( o === undefined )
            {
                removeAt( index ) ;
            }
            else
            {
                _modCount++ ;
                _a[index] = o ;
            }
            return old ;
        }
          
        /**
         * Returns a view of the portion of this list between the specified fromIndex, inclusive, and toIndex, exclusive.
         * @return a view of the portion of this list between the specified fromIndex, inclusive, and toIndex, exclusive.
         */
        public function subList( fromIndex:uint , toIndex:uint ):List
        {
            if ( fromIndex > size()  )
            {
                throw new RangeError( "The " + getClassName(this) + ".subList() method failed, the fromIndex '" + fromIndex + "' argument is out of the size limit." ) ;
            }  
            else if ( toIndex > size() )
            {
                throw new RangeError( "The " + getClassName(this) + ".subList() method failed, the toIndex '" + toIndex + "' argument is out of the size limit." ) ;
            }
            var ar:Array = [] ;
            for ( var i:int = fromIndex ; i < toIndex ; i++ ) 
            {
                ar.push( get(i) ) ;
            }
            return new ArrayList( ar ) ;
        }
        
        /**
         * @private
         */
        protected var _modCount:int ;
    }
}
