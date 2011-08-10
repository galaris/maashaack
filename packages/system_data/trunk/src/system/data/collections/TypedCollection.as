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
    import core.reflect.getClassName;
    import core.reflect.getClassPath;
    
    import system.data.Collection;
    import system.data.Iterator;
    import system.data.Typeable;
    import system.data.Validator;
    
    /**
     * TypedCollection is a wrapper for Collection instances that ensures that only values of a specific type can be added to the wrapped collection.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.data.collections.ArrayCollection ;
     * import system.data.collections.TypedCollection ;
     * 
     * var co:ArrayCollection = new ArrayCollection(["item1", "item2"]) ;
     * var tc:TypedCollection = new TypedCollection( String , co ) ;
     * 
     * tc.add( "item3" ) ;
     * trace( tc ) ; // {item1,item2,item3}
     * 
     * try
     * {
     *     tc.add( 10 ) ;
     * }
     * catch( e:Error )
     * {
     *     trace( e.message ) ; // TypedCollection.validate(10) is mismatch.
     * }
     * </pre>
     */
    public class TypedCollection implements Collection, Typeable, Validator
    {
        /**
         * Creates a new TypedCollection instance.
         * @param type the type of this Typeable object (a Class or a Function).
         * @param collection The Collection reference of this wrapper.
         * @throws ArgumentError if the type is null or undefined.
         * @throws TypeError if a value in the passed-in Collection object isn't valid.
         */ 
        public function TypedCollection( type:* , collection:Collection )
        {
            if (collection == null) 
            {
                throw new ArgumentError("The passed-in 'collection' argument not must be 'null' or 'undefined'.") ;
            }
            this.type = type ;
            if ( collection.size() > 0 ) 
            {
                var it:Iterator = collection.iterator() ;
                while ( it.hasNext() ) 
                {
                    validate(it.next()) ;
                }
            }
            _co = collection ;
        }
        
        /**
         * Indicates the type of the Typeable object. 
         * <p>If the type change the clear() method is invoked.</p>
         */
        public function get type():*
        {
            return _type ;
        }
        
        /**
         * @private
         */
        public function set type( type:* ):void
        {
            if ( _type != type )
            {
                if ( _co != null && _co.size() > 0 )
                {
                    _co.clear() ;
                }
                _type = type is Class ? type as Class : ( ( type is Function ) ? type as Function : null ) ;
            }
        }
        
        /**
         * Inserts an element in the collection.
         */
        public function add( o:* ):Boolean
        {
            validate(o) ;
            return _co.add( o ) ;
        }
        
        /**
         * Removes all elements in the collection.
         */
        public function clear():void
        {
            _co.clear() ;
        }
        
        /**
         * Returns a shallow copy of this collection.
         * @return a shallow copy of this collection.
         */
        public function clone():*
        {
            return new TypedCollection( type , _co ) ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if this collection contains the specified element.
         * @return <code class="prettyprint">true</code> if this collection contains the specified element.
         */
        public function contains(o:*):Boolean
        {
            return _co.contains(o) ;
        }
        
        /**
         * Returns the element from this collection at the passed key index.
         * @return the element from this collection at the passed key index.
         */
        public function get( key:* ):*
        {
            return _co.get(key) ;
        }
        
        /**
         * Returns the index of an element in the collection.
         * @return the index of an element in the collection.
         */
        public function indexOf(o:*, fromIndex:uint = 0):int
        {
            return _co.indexOf( o , fromIndex ) ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if this collection contains no elements.
         * @return <code class="prettyprint">true</code> if this collection contains no elements.
         */
        public function isEmpty():Boolean
        {
            return _co.isEmpty() ;
        }
        
        /**
         * Returns an iterator over the elements in this collection.
         * @return an iterator over the elements in this collection.
         */
        public function iterator():Iterator
        {
            return _co.iterator();
        }
        
        /**
         * Removes a single instance of the specified element from this collection, if it is present (optional operation).
         */
        public function remove(o:*):*
        {
            return _co.remove(o);
        }
        
        /**
         * Returns the number of elements in this collection.
         * @return the number of elements in this collection.
         */
        public function size():uint
        {
            return _co.size() ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the specific value is valid.
         * @return <code class="prettyprint">true</code> if the specific value is valid.
         */
        public function supports( value:* ):Boolean
        {
            return type == null || value is _type ;
        }
        
        /**
         * Returns an array containing all of the elements in this collection.
         * <p><b>Note:</b> The returned Array is a reference of the internal Array used in the Collection to store the items. It's not a shallow copy of it.</p>
         * @return an array containing all of the elements in this collection.
         */
        public function toArray():Array
        {
            return _co.toArray() ;
        }
        
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public function toSource(indent:int = 0):String
        {
            var s:String = "new " + getClassPath(this, true) + "(" ;
            s += getClassPath( type , true ) ;
            if ( size() >  0 )
            {
                s += "," + dump(_co) ;
            }
            s += ")" ;
            return s ;
        }
        
        /**
         * Returns the String representation of the object.
         * @return the String representation of the object.
         */
        public function toString():String
        {
            return (_co as Object).toString() ;
        }
        
        /**
         * Evaluates the specified value and throw a <code class="prettyprint">TypeError</code> object if the value is not valid.
         * @throws TypeError if the value is not valid.
         */
        public function validate( value:* ):void
        {
            if (!supports(value)) 
            {
                throw new TypeError( getClassName(this) + ".validate(" + value + ") is mismatch.") ;
            }
        }
        
        /**
         * @private
         */
        protected var _co:Collection ;
        
        /**
         * @private
         */
        private var _type:* ;
    }
}
