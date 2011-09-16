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

package system.data.maps
{
    import core.dump;
    import core.reflect.getClassPath;
    
    import system.data.Iterator;
    import system.data.Map;
    import system.data.iterators.ArrayIterator;
    import system.data.iterators.MapIterator;
    
    import flash.utils.Dictionary;
    
    /**
     * Hash table based implementation of the Map interface. This implementation provides all of the optional map operations, and permits null values and the null key.
     * <p>This class makes no guarantees as to the order of the map; in particular, it does not guarantee that the order will remain constant over time.</p>
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.data.Map ;
     * import system.data.maps.HashMap;
     * import system.data.iterator.Iterator;
     * 
     * var map:Map = new HashMap() ;
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
     * 
     * trace("--- dynamic insertion ") ;
     * 
     * map["key4"] = "value4" ; // dynamic insertion
     * 
     * trace("map : " + map) ;
     * 
     * trace("--- use delete") ;
     * 
     * delete map["key4"] ;
     * 
     * trace(" map : " + map) ;
     * 
     * trace("--- remove 'key1'") ;
     * 
     * trace("remove key1 : " + (delete map["key1"]) ) ; //.remove("key1")) ;
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
    public dynamic class HashMap implements Map
    {
        /**
         * Creates a new HashMap instance.
         */
        public function HashMap( ...arguments:Array )
        {
            clear() ;
            var k:Array = (arguments[0] as Array) ;
            var v:Array = (arguments[1] as Array) ;
            if ( k != null && v != null )
            {
                if (k.length > 0 && k.length == v.length)
                {
                    var count:int = k.length ;
                    for(var i:int = 0 ; i < count ; i++) 
                    {
                        put(k[i], v[i]) ;
                    }
                }
            }
        }
        
        /**
         * Removes all mappings from this map.
         */  
        public function clear():void
        {
            _keys   = new Dictionary(true) ;
            _values = new Dictionary(true) ;
            _size = 0 ;
        }
        
        /**
         * Returns a shallow copy of this HashMap instance: the keys and values themselves are not cloned.
         * @return a shallow copy of this HashMap instance: the keys and values themselves are not cloned.
         */
        public function clone():*
        {
            var m:HashMap = new HashMap() ;
            m.putAll(this) ;
            return m ;
        }
        
        /**
         * Returns true if this map contains a mapping for the specified key.
         * @return true if this map contains a mapping for the specified key.
         */
        public function containsKey(key:*):Boolean
        {
            return _keys[ key ] !== undefined ;
        }
        
        /**
         * Returns true if this map maps one or more keys to the specified value.
         * @return true if this map maps one or more keys to the specified value.
         */
        public function containsValue(value:*):Boolean
        {
            return _values[ value ] !== undefined ;
        }
        
        /**
         * Returns the value to which this map maps the specified key.
         * @return the value to which this map maps the specified key.
         */
        public function get(key:*):* 
        {
            return _keys[ key ] ;
        }
        
        /**
         * Returns an array representation of all keys in the map.
         * @return an array representation of all keys in the map.
         */
        public function getKeys():Array
        {
            var ar:Array = [] ;
            for (var key:* in _keys) 
            {
                ar.push( key ) ;
            }
            return ar ;
        }
        
        /**
         * Returns an array representation of all values in the map.
         * @return an array representation of all values in the map.
         */
        public function getValues():Array
        {
            var ar:Array = [] ;
            for each (var value:* in _keys) 
            {
                ar.push(value) ;
            }
            return ar ;
        }
        
        /**
         * Returns true if this map contains no key-value mappings.
         * @return true if this map contains no key-value mappings.
         */
        public function isEmpty():Boolean
        {
            return _size == 0 ;
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
            return new ArrayIterator(getKeys()) ;
        }
        
        /**
         * Associates the specified value with the specified key in this map.
         */
        public function put( key:*, value:* ):*
        {
            var r:* = null ;
            if ( _keys[ key ] !== undefined )
            {
                r = _keys[ key ] ;
                remove( key );
            }
            var count:uint = uint(_values[ value ]) ;
            _values[ value ] = (count > 0) ? count+1 : 1 ;
            _size++ ;
            _keys[ key ] = value ;
            return r ;
        }
        
        /**
         * Copies all of the mappings from the specified map to this one.
         */
        public function putAll( m:Map ):void
        {
            var v:Array = m.getValues() ;
            var k:Array = m.getKeys() ;
            var l:int   = k.length ;
            for ( var i:int ; i < l ; i = i - (-1) ) 
            {
                put( k[i] , v[i] ) ;
            }
        }
        
        /**
         * Removes the mapping for this key from this map if present.
         * @param o The key whose mapping is to be removed from the map.
         * @return previous value associated with specified key, or null if there was no mapping for key. A null return can also indicate that the map previously associated null with the specified key.
         */
        public function remove( o:* ):*
        {
            var value:* ;
            if ( containsKey( o ) ) 
            {
                _size -- ;
                value = _keys[ o ];
                var count:uint = _values[ value ];
                if (count > 1)
                {
                    _values[ value ] = count - 1;
                } 
                else
                {
                    delete _values[ value ];
                }
                delete _keys[ o ] ;
                return value ;
            }
            else 
            {
                return null ;
            }
        }
        
        /**
         * Returns the number of key-value mappings in this map.
         * @return the number of key-value mappings in this map.
         */
        public function size():uint
        {
            return _size ;
        }
        
        /**
         * Returns the source representation of the object.
         * @return the source representation of the object.
         */
        public function toSource( indent:int = 0 ):String 
        {
            return "new " + getClassPath(this, true) + "(" + dump( getKeys() ) + "," + dump( getValues() ) + ")" ;
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
        private var _keys:Dictionary ;
        
        /**
         * @private
         */
        private var _size:uint ;
        
        /**
         * @private
         */
        private var _values:Dictionary ;
    }
}
