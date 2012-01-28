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
    import core.dump;
    import core.reflect.getClassName;
    import core.reflect.getClassPath;

    import system.data.Iterator;
    import system.data.Map;
    import system.data.Typeable;
    import system.data.Validator;
    
    /**
     * TypedMap is a wrapper for Map instances that ensures that only values of a specific type can be added to the wrapped Map.
     */
    public class TypedMap implements Map, Typeable, Validator 
    {
        /**
         * Creates a new TypedMap instance.
         * @param type the type of this Typeable object (a Class or a Function).
         * @param map The Map reference of this wrapper.
         * @throws ArgumentError if the type is null or undefined.
         * @throws TypeError if a value in the init object isn't valid.
         */ 
        public function TypedMap( type:* , map:Map )
        {
            if ( map == null ) 
            {
                throw new ArgumentError("The passed-in Map argument not must be 'null' or 'undefined'.") ;
            }
            this.type = type ;
            if ( map.size() > 0 ) 
            {
                var it:Iterator = map.iterator() ;
                while ( it.hasNext() ) 
                {
                    validate( it.next() ) ;
                }
            }
            _map = map ;
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
                if ( _map != null && _map.size() > 0 )
                {
                    _map.clear() ;
                }
                _type = type is Class ? type as Class : ( ( type is Function ) ? type as Function : null ) ;
            }
        }
        
        /**
         * Removes all mappings from this map (optional operation).
         */
        public function clear():void
        {
            _map.clear() ;
        }
        
        /**
         * Returns a shallow copy of the map.
         * @return a shallow copy of the map.
         */
        public function clone():*
        {
            return new TypedMap( type , _map ) ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if this map contains a mapping for the specified key.
         * @return <code class="prettyprint">true</code> if this map contains a mapping for the specified key.
         */
        public function containsKey(key:*):Boolean
        {
            return _map.containsKey(key) ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if this map maps one or more keys to the specified value.
         * @return <code class="prettyprint">true</code> if this map maps one or more keys to the specified value.
         */
        public function containsValue(value:*):Boolean
        {
            return _map.containsValue(value) ;
        }
        
        /**
         * Returns the value to which this map maps the specified key.
         * @return the value to which this map maps the specified key.
         */
        public function get( key:* ):*
        {
            return _map.get(key) ;
        }
        
        /**
         * Returns an Array of all the keys in the map.
         * @return an Array of all the keys in the map.
         */
        public function getKeys():Array
        {
            return _map.getKeys() ;
        }
        
        /**
         * Returns an Array of all the values in the map.
         * @return an Array of all the values in the map.
         */        
        public function getValues():Array
        {
            return _map.getValues() ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if this map contains no key-value mappings.
         * @return <code class="prettyprint">true</code> if this map contains no key-value mappings.
         */
        public function isEmpty():Boolean
        {
            return _map.isEmpty() ;
        }
        
        /**
         * Returns the iterator reference of the object.
         * @return the iterator reference of the object.
         */
        public function iterator():Iterator
        {
            return _map.iterator() ;
        }
        
        /**
         * Returns the keys iterator of this map.
         * @return the keys iterator of this map.
         */
        public function keyIterator():Iterator
        {
            return _map.keyIterator() ;
        }
        
        /**
         * Associates the specified value with the specified key in this map (optional operation).
         */
        public function put(key:*, value:*):*
        {
            validate(value) ;
            return _map.put(key, value) ;
        }
        
        /**
         * Copies all of the mappings from the specified map to this one.
         */
        public function putAll(m:Map):void
        {
            var it:Iterator = m.iterator() ;
            while( it.hasNext() ) 
            {
                validate( it.next() ) ;
            }
            _map.putAll( m ) ;
        }
        
        /**
         * Removes the mapping for this key from this map if it is present (optional operation).
         */        
        public function remove(o:*):*
        {
            return _map.remove(o) ;
        }
        
        /**
         * Returns the number of key-value mappings in this map.
         * @return the number of key-value mappings in this map.
         */        
        public function size():uint
        {
            return _map.size() ;
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
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public function toSource(indent:int = 0):String
        {
            var s:String = "new " + getClassPath(this, true) + "(" ;
            s += getClassPath( type , true ) ;
            if ( size() >  0 )
            {
                s += "," + dump(_map) ;
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
            return (_map as Object).toString() ;
        }
        
        /**
         * Evaluates the condition it checks and updates the IsValid property.
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
        private var _map:Map ;
        
        /**
         * The internal type function.
         */
        private var _type:* ;
    }
}
