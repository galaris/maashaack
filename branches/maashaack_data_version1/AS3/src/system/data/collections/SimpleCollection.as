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

package system.data.collections 
{
    import system.Reflection;
    import system.data.Collection;
    import system.data.Iterator;
    import system.data.iterators.ArrayIterator;
    import system.serializers.eden.BuiltinSerializer;        

    /**
     * This class provides a basic implementation of the <code class="prettyprint">Collection</code> interface, to minimize the effort required to implement this interface.
     */
    public class SimpleCollection implements Collection 
    {

        /**
         * Creates a new SimpleCollection instance.
         * @param ar An optional Array to fill the collection.
         */
        public function SimpleCollection( ar:Array = null )
        {
            if( ar as Array != null && ar.length > 0 ) 
            {   
                _a = ar.slice() ;   
            }
            else 
            {
                _a = new Array() ;
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
            return new SimpleCollection(toArray()) ;
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
            else {
                
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
         * Returns the number of elements in this collection.
         * @return the number of elements in this collection.
         */        
        public function size():uint
        {
            return _a.length ;
        }
        
        /**
         * Returns an array containing all of the elements in this collection.
         * @return an array containing all of the elements in this collection.
         */
        public function toArray():Array
        {
            return [].concat(_a) ;
        }
        
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public function toSource(indent:int = 0):String
        {
            return "new " + Reflection.getClassName(this) + "(" + BuiltinSerializer.emitArray(toArray()) + ")" ;
        }
        
        /**
         * Returns the string representation of this instance.
         * @return the string representation of this instance.
         */
        public function toString():String
        {
            return formatter.format( this ) ;
        }
        
        protected var _a:Array ;        
        
    }
}
