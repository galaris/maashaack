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
    import core.reflect.getClassPath;
    
    import system.data.Iterator;
    import system.data.Map;
    import system.data.iterators.ArrayIterator;
    import system.data.iterators.MapIterator;
    import system.hack;
    
    /**
     * Hash table based implementation of the Map interface. 
     * This implementation provides all of the optional map operations, and permits null values and the null key.
     * <p>This class makes guarantees to the order of the map.</p>
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.data.Map ;
     * import system.data.map.ArrayMap;
     * import system.data.iterator.Iterator;
     * 
     * var map:Map = new ArrayMap() ;
     * 
     * trace("put key1 -> value0 : " + map.put("key1", "value0") ) ;
     * trace("put key1 -> value1 : " + map.put("key1", "value1") ) ;
     * trace("put key2 -> value2 : " + map.put("key2", "value2") ) ;
     * trace("put key3 -> value3 : " + map.put("key3", "value3") ) ;
     * 
     * trace("map : " + map) ;
     * 
     * trace("--- clone") ;
     * 
     * var clone:Map = map.clone() ;
     * trace("clone : " + clone) ;
     * 
     * trace("--- map toSource") ;
     * 
     * trace("map toSource : " + map.toSource()) ;
     * 
     * trace("--- iterator") ;
     * 
     * var it:Iterator = map.iterator() ;
     * while( it.hasNext() )
     * {
     *     var v:* = it.next() ;
     *     var k:* = it.key() ;
     *     trace( "   -> " + k + " : " + v ) ;
     * }
     * trace("map : " + map) ;
     * 
     * trace("remove key1 : " + map.remove("key1")) ;
     * 
     * trace("size : " + map.size()) ;
     * 
     * trace("map : " + map) ;
     * 
     * trace("--- clear and isEmpty") ;
     * 
     * map.clear() ;
     * 
     * trace("isEmpty : " + map.isEmpty()) ;  
     * </pre>
     */
    public dynamic class ArrayMap implements Map
    {
        use namespace hack ;
        
        /**
         * Creates a new ArrayMap instance.
         * @param keys An optional Array of all keys to fill in this Map.
         * @param values An optional Array of all values to fill in this Map. This Array must have the same size like the 'keys' argument.
         */
        public function ArrayMap( ...arguments:Array )
        {
            var k:Array = arguments[0] as Array ;
            var v:Array = arguments[1] as Array ;
            if ( k == null ||  v == null ) 
            {
                _keys   = [] ;
                _values = [] ;
            }
            else
            {
                var b:Boolean =  ( k.length > 0 && k.length == v.length ) ;
                _keys   = b ? [].concat(k) : [] ;
                _values = b ? [].concat(v) : [] ;
            }
        }
        
        /**
         * Removes all mappings from this map.
         */  
        public function clear():void
        {
            _keys   = [] ;
            _values = [] ;
        }
        
        /**
         * Returns a shallow copy of this HashMap instance: the keys and values themselves are not cloned.
         * @return a shallow copy of this HashMap instance: the keys and values themselves are not cloned.
         */
        public function clone():*
        {
            var m:ArrayMap = new ArrayMap() ;
            m.putAll(this) ;
            return m ;
        }
        
        /**
         * Returns true if this map contains a mapping for the specified key.
         * @return true if this map contains a mapping for the specified key.
         */
        public function containsKey(key:*):Boolean
        {
            return indexOfKey(key) > -1 ;
        }
        
        /**
         * Returns true if this map maps one or more keys to the specified value.
         * @return true if this map maps one or more keys to the specified value.
         */
        public function containsValue(value:*):Boolean
        {
            return indexOfValue(value) > -1 ;
        }
        
        /**
         * Returns the value to which this map maps the specified key.
         * @return the value to which this map maps the specified key.
         */
        public function get(key:*):* 
        {
            return _values[ indexOfKey(key) ] ;
        }
        
        /**
         * Returns the key registered at the specified index in the array map.
         * @return the key registered at the specified index in the array map.
         */
        public function getKeyAt( index:uint ):*
        {
            return _keys[index] ;
        }
        
        /**
         * Returns an array representation of all keys in the map.
         * @return an array representation of all keys in the map.
         */
        public function getKeys():Array
        {
            return _keys.slice() ;
        }
        
        /**
         * Returns the value registered at the specified index in the array map.
         * @return the value registered at the specified index in the array map.
         */
        public function getValueAt( index:uint ):*
        {
            return _values[index] ;
        }
        
        /**
         * Returns an array representation of all values in the map.
         * @return an array representation of all values in the map.
         */
        public function getValues():Array
        {
            return _values.slice() ;
        }
        
        /**
         * Returns the index position in the ArrayMap of the specified key.
         * @return the index position in the ArrayMap of the specified key.
         */
        public function indexOfKey( key:* ):int 
        {
            return _keys.indexOf( key ) ;
        }
        
        /**
         * Returns the index position in the ArrayMap of the specified value.
         * @return the index position in the ArrayMap of the specified value.
         */
        public function indexOfValue( value:* ):int
        {
            return _values.indexOf(value) ;
        }
        
        /**
         * Returns true if this map contains no key-value mappings.
         * @return true if this map contains no key-value mappings.
         */
        public function isEmpty():Boolean
        {
            return size() < 1 ;
        }
        
        /**
         * Returns the values iterator of this map.
         * @return the values iterator of this map.
         */
        public function iterator():Iterator
        {
            return new MapIterator( this ) ;
        }
        
        /**
         * Returns the keys iterator of this map.
         * @return the keys iterator of this map.
         */
        public function keyIterator():Iterator
        {
            return new ArrayIterator( _keys ) ;
        }
        
        /**
         * Associates the specified value with the specified key in this map.
         * @param key the key to register the value.
         * @param value the value to be mapped in the map.
         */
        public function put( key:* , value:* ):*
        {
            var r:* ;
            var i:int = indexOfKey( key ) ;
            if ( i < 0 ) 
            {
                _keys.push( key ) ;
                _values.push( value ) ;
                return null ;
            }
            else 
            {
                r = _values[i] ;
                _values[i] = value ;
                return r ;
            }
        }
        
        /**
         * Copies all of the mappings from the specified map to this one.
         */
        public function putAll( m:Map ):void
        {
            var aV:Array = m.getValues() ;
            var aK:Array = m.getKeys() ;
            var l:int    = aK.length ;
            for (var i:int ; i < l ; i = i - (-1) ) 
            {
                put(aK[i], aV[i]) ;
            }
        }
        
        /**
         * Removes the mapping for this key from this map if present.
         * @param o The key whose mapping is to be removed from the map.
         * @return previous value associated with specified key, or null if there was no mapping for key. A null return can also indicate that the map previously associated null with the specified key.
         */
        public function remove( o:* ):*
        {
            var k:* ;
            var v:*   = null ;
            var i:int = indexOfKey( o ) ;
            if ( i > -1 ) 
            {
                k = _keys[i]   ; // FIXME not used ??
                v = _values[i] ;
                _values.splice(i, 1) ;
                _keys.splice(i, 1) ;
            }
            return v ;
        }
        
        /**
         * Sets the value of the "key" in the ArrayMap with the specified index.
         * @param index The position of the entry in the ArrayMap.
         * @param value The value of the entry to change. 
         * @return A MapEntry who corresponding the old key/value entry or null if the key already exist or the specified index don't exist.
         * @throws RangeError If the index is out of the range of the Map size.
         */
        public function setKeyAt( index:uint, key:* ):* 
        {
            if ( index >= size() )
            {
                throw new RangeError( "ArrayMap.setKeyAt(" + index + ") failed with an index out of the range.") ;
            }
            if ( containsKey( key ) )
            {
                return null ;
            }
            var k:* = _keys[index] ;
            if (k === undefined)
            {
                return null ;   
            }
            var v:* = _values[index] ; 
            _keys[index] = key ;
            return new MapEntry(k,v) ;
        }
        
        /**
         * Sets the value of the "value" in the ArrayMap with the specified index.
         * @param index The position of the entry in the ArrayMap.
         * @param value The value of the entry to change.
         * @return A MapEntry who corresponding the old key/value entry or null if no value exist with the specified index.
         * @throws RangeError If the index is out of the range of the Map size.
         */
        public function setValueAt( index:uint, value:* ):* 
        {
            if ( index >= size() )
            {
                throw new RangeError( "ArrayMap.setValueAt(" + index + ") failed with an index out of the range.") ;
            }
            var v:* = _values[index] ;  // TODO refactoring
            if (v === undefined)
            {
                return null ;
            }
            var k:* = _keys[index] ;
            _values[index] = value ;
            return new MapEntry(k,v) ;
        }
        
        /**
         * Returns the number of key-value mappings in this map.
         * @return the number of key-value mappings in this map.
         */
        public function size():uint
        {
            return _keys.length ;
        }
        
        /**
         * Returns the source representation of this map.
         * @return the source representation of this map.
         */
        public function toSource( indent:int = 0 ):String 
        {
            return "new " + getClassPath(this, true) + "(" + dump( _keys ) + "," + dump( _values ) + ")" ;
        }
        
        /**
         * Returns the String representation of this map.
         * @return the String representation of this map.
         */
        public function toString():String
        {
            return formatter.format( this ) ;
        }
        
        /**
         * @private
         */
        hack var _keys:Array ;
        
        /**
         * @private
         */
        hack var _values:Array ;
    }
}
