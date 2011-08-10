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

package system.data.collections 
{
    import core.dump;
    import core.reflect.getClassPath;

    import system.Equatable;
    import system.data.Collection;
    import system.data.Iterable;
    import system.data.Iterator;
    import system.data.iterators.ArrayIterator;

    /**
     * This class provides a basic implementation of the <code class="prettyprint">Collection</code> interface, to minimize the effort required to implement this interface.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.data.collections.ArrayCollection ;
     * import system.data.Iterator ;
     * 
     * var ar:Array           = ["item1", "item2", "item3", "item4"] ;
     * var co:ArrayCollection = new ArrayCollection( ar ) ;
     * 
     * trace ("---- Collection methods") ;
     * 
     * trace ( "insert item5 : " + co.add("item5") ) ;
     * trace ( "contains items : " + co.contains("item2") ) ;
     * trace ( "get(2) : " + co.get(2) ) ;
     * trace ( "isEmpty : " + co.isEmpty() ) ;
     * 
     * trace ( "remove : " + co.remove("item5") ) ;
     * 
     * trace ( "size : " + co.size() ) ;
     * 
     * trace ("toArray : " + co.toArray() ) ;
     * trace ( "toString : " + co.toString() ) ;
     * trace ( "toSource : " + co.toSource()) ;
     * 
     * trace ("---- iterator") ;
     * 
     * var it:Iterator = co.iterator() ;
     * 
     * while ( it.hasNext() )
     * {
     *     trace ( it.next() ) ;
     * }
     * 
     * trace ("---- optional methods") ;
     * 
     * var c1:ArrayCollection = new ArrayCollection(["item1", "item3"]) ;
     * var c2:ArrayCollection = new ArrayCollection(["item5", "item6"]) ;
     * var c3:ArrayCollection = new ArrayCollection(["item2", "item4"]) ;
     * 
     * trace("co : " + co) ;
     * trace("c1 : " + c1) ;
     * trace("c2 : " + c2) ;
     * 
     * trace("co containsAll c1 : " + co.containsAll( c1 ) ) ;
     * trace("co containsAll c2 : " + co.containsAll( c2 ) ) ;
     * trace("co insertAll c2 : " + co.addAll( c2 ) ) ;
     * trace("co removeAll c2 : " + co.removeAll( c1 ) ) ;
     * trace("co retainAll c3 : " + co.retainAll( c3 ) ) ;
     * 
     * trace("co : " + co) ;
     * </pre>
     */
    public class ArrayCollection implements Collection, Equatable
    {
        /**
         * Creates a new ArrayCollection instance.
         * @param init An optional Array or Collection or Iterable object to fill the collection.
         */
        public function ArrayCollection( init:* = null )
        {
            if ( init is Collection )
            {
                init = init.toArray() ;
            }
            else if ( init is Iterable )
            {
                var ar:Array    = [] ;
                var it:Iterator = (init as Iterable).iterator() ;
                while( it.hasNext() )
                {
                    ar.push(it.next()) ;
                }
                init = ar ;
            }
            if( init as Array != null && init.length > 0 ) 
            {   
                _a = init.slice() ;   
            }
            else 
            {
                _a = [] ;
            }
        }
        
        /**
         * Inserts an element in the collection.
         */
        public function add( o:* ):Boolean
        {
            if ( o === undefined ) 
            {
                return false ;
            }
            _a.push(o) ;
            return true ;
        }
        
        /**
         * Appends all of the elements in the specified collection to the end of this Collection, in the order that they are returned by the specified collection's iterator (optional operation).
         * @return <code class="prettyprint">true</code> if this list changed as a result of the call.
         */
        public function addAll( c:Collection ):Boolean 
        {
            if ( c == null )
            {
                return false ;
            }
            if ( c.size() > 0 ) 
            {
                var it:Iterator = c.iterator() ;
                while(it.hasNext()) 
                {
                    add( it.next() ) ;
                }
                return true ;
            }
            else 
            {
                return false ;
            }
        }
        
        /**
         * Removes all elements in the collection.
         */
        public function clear():void
        {
            _a.splice(0) ;
        }
        
        /**
         * Returns a shallow copy of this collection (optional operation).
         * @return a shallow copy of this collection (optional operation).
         */        
        public function clone():*
        {
            return new ArrayCollection(toArray()) ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if this collection contains the specified element.
         * @return <code class="prettyprint">true</code> if this collection contains the specified element.
         */
        public function contains( o:* ):Boolean
        {
            return _a.indexOf( o ) >- 1  ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if this collection contains all of the elements of the specified collection.
         * @return <code class="prettyprint">true</code> if this collection contains all of the elements of the specified collection.
         */
        public function containsAll( c:Collection ):Boolean 
        {
            var it:Iterator = c.iterator() ;
            while(it.hasNext()) 
            {
                if ( !contains(it.next()) ) 
                {
                    return false ;
                }
            }
            return true ;
        }
        
        /**
         * Compares the specified object with this object for equality.
         * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
         */
        public function equals( o:* ):Boolean 
        {
            if (o == this) 
            {
                return true ;
            }
            if ( getClassPath(this) != getClassPath(o) ) 
            {
                return false ;
            }
            var c:Collection = o as Collection ;
            if (c == null || ( c.size() != size() ) )
            {
                return false ;
            }
            return this.containsAll(c) ;
        }
        
        /**
         * Returns the element from this collection at the passed key index.
         * @return the element from this collection at the passed key index.
         */
        public function get( key:* ):*
        {
            return _a[key] ;
        }
        
        /**
         * Returns the index of an element in the collection.
         * @return the index of an element in the collection.
         */
        public function indexOf( o:* , fromIndex:uint = 0 ):int
        {
            return _a.indexOf(o, fromIndex) ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if this collection contains no elements.
         * @return <code class="prettyprint">true</code> if this collection contains no elements.
         */
        public function isEmpty():Boolean
        {
            return _a.length == 0 ;
        }
        
        /**
         * Returns the iterator reference of the object.
         * @return the iterator reference of the object.
         */  
        public function iterator():Iterator
        {
            return new ArrayIterator( toArray() ) ;
        }
        
        /**
         * Removes a single instance of the specified element from this collection, if it is present (optional operation).
         */
        public function remove( o:* ):*
        {
            var it:Iterator = iterator() ;
            if ( o == null ) 
            {
                while(it.hasNext()) 
                {
                    if ( it.next() == null ) 
                    {
                        it.remove() ;
                        return true ;
                    }
                }   
            }
            else 
            {
                while ( it.hasNext() ) 
                {
                    var v:* = it.next() ;
                    if (o == v) 
                    {
                        it.remove() ;
                        return true ;
                    }
                }
            }
            return false ;
        }
        
        /**
         * Removes from this Collection all the elements that are contained in the specified Collection (optional operation).
         */
        public function removeAll( c:Collection ):Boolean 
        {
            var b:Boolean ;
            var it:Iterator = iterator() ;
            while (it.hasNext()) 
            {
                if ( c.contains(it.next()) ) 
                {
                    it.remove() ;
                    b = true ;
                }
            }
            return b ;
        }
        
        /**
         * Retains only the elements in this Collection that are contained in the specified Collection (optional operation).
         */
        public function retainAll(c:Collection):Boolean 
        {
            var b:Boolean ;
            var it:Iterator = iterator() ;
            while( it.hasNext() ) 
            {
                if ( ! c.contains( it.next() ) ) 
                {
                    it.remove() ;
                    b = true ;
                }
            }
            return b ;
        }
        
        /**
         * Returns the number of elements in this collection.
         * @return the number of elements in this collection.
         */
        public function size():uint
        {
            return _a.length ;
        }
        
        /**
         * Returns an array containing all of the elements in this collection.
         * <p><b>Note:</b> The returned Array is a reference of the internal Array used in the Collection to store the items. It's not a shallow copy of it.</p>
         * @return an array containing all of the elements in this collection.
         */
        public function toArray():Array
        {
            return _a ;
        }
        
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public function toSource(indent:int = 0):String
        {
            var source:String = "new " + getClassPath(this, true) ;
            source += "(" ;
            var ar:Array = toArray() ;
            if ( ar.length > 0 )
            {
                source += dump( ar ) ;
            } 
            source += ")" ;
            return source ;
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
         * @private
         */
        protected var _a:Array ;
    }
}
