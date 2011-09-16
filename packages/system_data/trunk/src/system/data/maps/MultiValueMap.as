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

    import system.Reflection;
    import system.data.Collection;
    import system.data.Iterable;
    import system.data.Iterator;
    import system.data.Map;
    import system.data.MultiMap;
    import system.data.collections.ArrayCollection;
    import system.data.iterators.ArrayIterator;
    import system.hack;
    
    /**
     * A Map with multiple values to keys. It's the basic implementation of the <code class="prettyprint">MultiMap</code> interface.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.data.maps.MultiValueMap ;
     * 
     * var map:MultiValueMap = new MultiValueMap() ;
     * 
     * map.put("key1" , "value1") ;
     * map.put("key1" , "value2") ;
     * map.put("key2" , "value3") ;
     * 
     * trace( map ) ;
     * </pre>
     */
    public class MultiValueMap implements MultiMap 
    {
        use namespace hack ;
         
        /**
         * Creates a new MultiValueMap instance.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.data.maps.MultiValueMap ;
         * var map:MultiValueMap = new MultiValueMap() ;
         * </pre>
         * @param map Optional Map reference to initialize and fill this MultiMap.
         * @param factory Optional Map reference to create the internal Map of the MultiValueMap
         */
        public function MultiValueMap( map:Map = null , factory:Map = null )
        {
            _map = factory || new HashMap() ;
            if ( map && map.size() > 0 ) 
            {
                putAll( map ) ;
            }
        }
        
        /**
         * Determinates the internal build class used in the createCollection() method to create a new collection to register all values with a new key. 
         * The class must implements the Collection interface and by default the ArrayCollection class is used. 
         */
        public function get internalBuildClass():Class
        {
            if ( _internalBuildClass == null )
            {
                _internalBuildClass = ArrayCollection ;
            }
            return _internalBuildClass ;
        }
        
        /**
         * @private
         */
        public function set internalBuildClass( clazz:Class ):void
        {
            _internalBuildClass = Reflection.getClassInfo(clazz).hasInterface(Collection) ? clazz : ArrayCollection ;
        }
        
        /**
         * Removes all elements in this map.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.data.maps.MultiValueMap ;
         * 
         * var map:MultiValueMap = new MultiValueMap() ;
         * 
         * map.put( "key1" , "hello"   ) ;
         * map.put( "key2" , "bonjour" ) ;
         * 
         * map.clear() ;
         * 
         * trace( map ) ; // {}
         * </pre>
         */
        public function clear():void 
        {
            _map.clear() ;
        }
        
        /**
         * Returns a shallow copy of this object.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.data.maps.MultiValueMap ;
         * 
         * var map:MultiValueMap = new MultiValueMap() ;
         * 
         * map.put("keyA" , "itemA_1" ) ;
         * map.put("keyA" , "itemA_2" ) ;
         * map.put("keyB" , "itemB_2" ) ;
         * 
         * var clone:MultiValueMap = map.clone() ;
         * trace( clone ) ;
         * </pre>
         * @return a shallow copy of this object.
         */
        public function clone():* 
        {
            var m:MultiValueMap = new MultiValueMap() ;
            var kItr:Iterator = keyIterator() ;
            var vItr:Iterator = valueIterator() ;
            while (kItr.hasNext()) 
            {
                var key:*   = kItr.next() ;
                var value:* = vItr.next() ;
                m.putCollection( key , value ) ;
            }
            return m ;
        }
       
        /**
         * Checks whether the map contains the key specified.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.data.maps.MultiValueMap ;
         * 
         * var map:MultiValueMap = new MultiValueMap() ;
         * 
         * map.put( "key1" , "hello world" ) ;
         * 
         * trace( map.containsKey( "key1" ) ) ; // true
         * trace( map.containsKey( "key2" ) ) ; // false
         * </pre>
         * @return <code class="prettyprint">true</code> if the Map contains the specified key.
         */
        public function containsKey( key:* ):Boolean 
        {
            return _map.containsKey( key ) ;
        }
        
        /**
         * Checks whether the map contains the value specified.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.data.maps.MultiValueMap ;
         * 
         * var map:MultiValueMap = new MultiValueMap() ;
         * 
         * map.put( "key1" , "hello"   ) ;
         * map.put( "key2" , "bonjour" ) ;
         * 
         * trace( map.containsValue( "hello"       ) ) ; // true
         * trace( map.containsValue( "bonjour"     ) ) ; // true
         * trace( map.containsValue( "buenos dias" ) ) ; // false
         * </pre>
         * @return <code class="prettyprint">true</code> if the List contains the specified value.
         */
        public function containsValue( value:* ):Boolean 
        {
            var c:Collection ;
            var it:Iterator = _map.iterator() ;
            while (it.hasNext()) 
            {
                c = it.next() as Collection ;
                if ( c != null && c.contains(value) ) 
                {
                    return true ;
                }
            }
            return false ;
        } 
        
        /**
         * Checks whether the map contains the value specified or at the specified key contains the value.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.data.maps.MultiValueMap ;
         * 
         * var map:MultiValueMap = new MultiValueMap() ;
         * 
         * map.put( "key1" , "hello"   ) ;
         * map.put( "key2" , "bonjour" ) ;
         * 
         * trace( map.containsValueByKey( "key1" , "hello"   ) ) ; // true
         * trace( map.containsValueByKey( "key1" , "bonjour" ) ) ; // false
         * 
         * trace( map.containsValueByKey( "key2" , "hello"       ) ) ; // false
         * trace( map.containsValueByKey( "key2" , "bonjour"     ) ) ; // true
         * </pre>
         */
        public function containsValueByKey( key:*, value:* ):Boolean 
        {
            return ( get( key ) as Collection ).contains( value ) == true ;
        }
        
        /**
         * Creates a new instance of the map value Collection container.
         * This method can be overridden to use your own collection type.
         */
        public function createCollection():Collection 
        {
            return new internalBuildClass() as Collection ; 
        }
        
        /**
         * Gets the collection mapped to the specified key.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.data.maps.MultiValueMap ;
         * 
         * var map:MultiValueMap = new MultiValueMap() ;
         * 
         * map.put( "key1" , "hello"   ) ;
         * map.put( "key2" , "bonjour" ) ;
         * 
         * trace( map.get( "key1"  ) ) ; // {hello}
         * trace( map.get( "key2"  ) ) ; // {bonjour}
         * trace( map.get( "key3"  ) ) ; // undefined
         * </pre>
         */
        public function get( key:* ):*
        {
            return _map.get(key) ;
        }
        
        /**
         * Gets the collection mapped to the specified key.
         * <p> This method is a convenience method to typecast the result of get(key).</p>
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.data.maps.MultiValueMap ;
         * 
         * var map:MultiValueMap = new MultiValueMap() ;
         * 
         * map.put( "key1" , "hello"   ) ;
         * map.put( "key2" , "bonjour" ) ;
         * 
         * trace( map.getCollection( "key1"  ) ) ; // {hello}
         * trace( map.getCollection( "key2"  ) ) ; // {bonjour}
         * trace( map.getCollection( "key3"  ) ) ; // null
         * </pre>
         */
        public function getCollection( key:* ):Collection
        {
            return _map.get(key) as Collection ;
        }
        
        /**
         * Returns an Array containing the combination of all keys in the Map.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.data.maps.MultiValueMap ;
         * 
         * var map:MultiValueMap = new MultiValueMap() ;
         * 
         * map.put( "key1" , "hello"   ) ;
         * map.put( "key2" , "bonjour" ) ;
         * 
         * trace( map.getKeys() ) ; // key1,key2
         * </pre>
         * @return An Array containing the combination of all keys in the Map.
         */        
        public function getKeys():Array
        {
            return _map.getKeys() ;
        }
        
        /**
         * Returns an Array containing the combination of values from all keys.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.data.maps.MultiValueMap ;
         * 
         * var map:MultiValueMap = new MultiValueMap() ;
         * 
         * map.put( "key1" , "A1"   ) ;
         * map.put( "key2" , "B1" ) ;
         * map.put( "key2" , "B2" ) ;
         * map.put( "key3" , "C1" ) ;
         * 
         * trace( map.getValues() ) ; // no order if the internal Map is a HashMap (default)
         * </pre>
         * @return An Array containing the combination of values from all keys.
         */
        public function getValues():Array 
        {
            var result:Array = [] ;
            var values:Array = _map.getValues() ;
            var l:int   = values.length ;
            for ( var i:int ; i < l ; i++ ) 
            {
                result = result.concat( values[i].toArray() ) ;
            }
            return result ;
        }
        
        /**
         * Returns whether this object contains any mappings.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.data.maps.MultiValueMap ;
         * 
         * var map:MultiValueMap = new MultiValueMap() ;
         * 
         * trace( map.isEmpty() ) ;  // true
         * 
         * map.put( "key" , "value"   ) ;
         * 
         * trace( map.isEmpty() ) ; // false
         * </pre>
         * @return <code class="prettyprint">true</code> if this MultiHashSet contains any mappings else <code class="prettyprint">false</code>
         */
        public function isEmpty():Boolean 
        {
            return _map.isEmpty() ;
        }
        
        /**
         * Returns the Iterator representation of the object.
         * @return the Iterator representation of the object.
         */        
        public function iterator():Iterator
        {
            return _map.iterator() ;
        }
        
        /**
         * Gets an Iterator for the collection mapped to the specified key.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.data.maps.MultiValueMap ;
         * 
         * var map:MultiValueMap = new MultiValueMap() ;
         * 
         * map.put("key1" , "value1") ;
         * map.put("key1" , "value2") ;
         * map.put("key2" , "value3") ;
         * 
         * trace( map.iteratorByKey( "key1" ) ) ; // [object ArrayIterator]
         * trace( map.iteratorByKey( "key3" ) ) ; // null
         * </pre>
         * @return the iterator of the collection at the key, null if key not in map
         */
        public function iteratorByKey( key:* ):Iterator
        {
            var it:Iterable = _map.get(key) as Iterable ;
            return it == null ? null : it.iterator() ; 
        }
        
        /**
         * Gets an iterator for the map to iterate keys.
         */
        public function keyIterator():Iterator
        {
            return _map.keyIterator() ;
        }
        
        /**
         * Adds the value to the collection associated with the specified key.
         * <p>Unlike a normal Map the previous value is not replaced. Instead the new value is added to the collection stored against the key.</p>
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.data.maps.MultiValueMap ;
         * 
         * var map:MultiValueMap = new MultiValueMap() ;
         * 
         * map.put("keyA" , "itemA_1" ) ;
         * map.put("keyA" , "itemA_2" ) ;
         * 
         * map.put("keyB" , "itemB_2" ) ;
         * 
         * trace( map ) ; // {keyB:{itemB_2},keyA:{itemA_1,itemA_2}}
         * </pre>
         * @param key the key to store against.
         * @param value the value to add to the collection at the key.
         * @return the value added if the map changed and null if the map did not change.
         */
        public function put( key:*, value:* ):*
        {
            if ( !_map.containsKey( key ) ) 
            {
                _map.put( key , createCollection() ) ;
            }
            var c:Collection = _map.get( key ) as Collection ;
            var b:Boolean = c.add( value ) ;
            return b ? value : null ;
        }
        
        /**
         * Override superclass to ensure that MultiMap instances are correctly handled.
         * <p>If you call this method with a normal map, each entry is added using put(key:*,value:*). 
         * If you call this method with a multi map, each entry is added using putCollection( key:*, co:Collection ).</p>
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.data.collections.ArrayCollection ;
         * 
         * import system.data.maps.ArrayMap ;
         * import system.data.maps.MultiValueMap ;
         * 
         * var am1:ArrayMap = new ArrayMap( [ "key1" , "key2" ] , ["value1" , "value2" ] ) ;
         * var am2:ArrayMap = new ArrayMap( [ "key1" ]          , [ new ArrayCollection( [ "value3" ] ) ] ) ;
         * 
         * var mm:MultiValueMap = new MultiValueMap() ;
         * 
         * mm.putAll( am1 ) ; // {key2:{value2},key1:{value1}}
         * 
         * trace( mm ) ;
         * 
         * mm.putAll( am2 ) ; // {key2:{value2},key1:{value1,value3}}
         * 
         * trace( mm ) ;
         * </pre>
         */
        public function putAll( map:Map ):void
        {
            var it:Iterator = map.iterator() ;
            while ( it.hasNext() ) 
            {
                var value:* = it.next() ;
                var key:*   = it.key() ;
                if ( value is Collection ) 
                {
                    putCollection( key , value ) ;
                }
                else 
                {
                    put( key , value ) ;
                }
            }
        }
        
        /**
         * Adds a collection of values to the collection associated with the specified key.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.data.collections.ArrayCollection ;
         * import system.data.maps.MultiValueMap ;
         * 
         * var map:MultiValueMap = new MultiValueMap() ;
         * 
         * map.putCollection( "key1" , new ArrayCollection(["value1", "value2"])) ;
         * map.putCollection( "key1" , new ArrayCollection(["value3", "value4"])) ;
         * map.putCollection( "key2" , new ArrayCollection(["value5"])) ;
         * 
         * trace( map ) ; // {key2:{value5},key1:{value1,value2,value3,value4}}
         * </pre>
         */
        public function putCollection( key:* , c:Collection ):void 
        {
            if ( c == null || c.size() == 0 )
            {
                return ;
            }
            var co:Collection ;
            if (! containsKey(key) ) 
            {
                co = createCollection() ;
                if ( co != null )
                {
                    _map.put(key , co ) ;
                }
            }
            else
            {
                co = _map.get(key) as Collection ;
            }
            if ( co != null )
            {
                var it:Iterator = c.iterator() ;
                while(it.hasNext()) 
                {
                    co.add( it.next() ) ;
                }
            }
        }
        
        /**
         * Removes a specific value from map with a specific key.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.data.maps.MultiValueMap ;
         * 
         * var map:MultiValueMap = new MultiValueMap() ;
         * 
         * map.put("key1" , "value1") ;
         * map.put("key1" , "value2") ;
         * map.put("key2" , "value3") ;
         * 
         * trace( map.remove("key1") ) ; // {value1,value2}
         * </pre>
         * @param o the key to remove in the map.
         */
        public function remove( o:* ):*
        {
            return _map.remove(o) ;
        }
        
        /**
         * Removes a specific value from all the map.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.data.maps.MultiValueMap ;
         * 
         * var map:MultiValueMap = new MultiValueMap() ;
         * 
         * map.put("key1" , "value1") ;
         * map.put("key1" , "value2") ;
         * map.put("key2" , "value3") ;
         * 
         * trace( map.removeByKey("key1" , "value1" ) ) ; // true
         * trace( map.removeByKey("key1" , "value5" ) ) ; // false
         * 
         * trace( map ) ; // {key2:{value3},key1:{value2}}
         * </pre>
         * @param key the key to remove in the map
         * @param value (optional) if this value is defined removes a specific value from map else removes all values associated with the specified key.
         * @return the removed value.
         */
        public function removeByKey( key:* , value:* ):*
        {
            if ( key === undefined || value === undefined ) 
            {
                return null ;
            }   
            else
            {
                var c:Collection = _map.get(key) ;
                var r:*          = c.remove(value) ;
                return (r != null) ? r : null ;
            }
        }
        
        /**
         * Returns the size of the collection mapped to the specified key.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.data.maps.MultiValueMap ;
         * 
         * var map:MultiValueMap = new MultiValueMap() ;
         * 
         * trace( map.size() ) ;  // 0
         * 
         * map.put( "key1" , "value1" ) ;
         * map.put( "key1" , "value2" ) ;
         * map.put( "key2" , "value3" ) ;
         * 
         * trace( map.size() ) ; // 2
         * </pre>
         * @return the size of the collection mapped to the specified key.
         */
        public function size():uint
        {
            return _map.size() ;
        }
        
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public function toSource(indent:int = 0):String
        {
             return "new " + getClassPath(this, true) + "(" + dump( _map ) + ")" ;
        } 
        
        /**
         * Returns the string representation of this instance.
         * @return the string representation of this instance
         */
        public function toString():String 
        {
            return multiformatter.format(this) ;
        }
        
        /**
         * Returns the total size of the map by counting all the values.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.data.maps.MultiValueMap ;
         * 
         * var map:MultiValueMap = new MultiValueMap() ;
         * 
         * trace( map.totalSize() ) ;  // 0
         * 
         * map.put( "key1" , "value1" ) ;
         * map.put( "key1" , "value2" ) ;
         * map.put( "key2" , "value3" ) ;
         * 
         * trace( map.totalSize() ) ; // 3
         * </pre>
         * @return the total size of the map by counting all the values.
         */
        public function totalSize():uint 
        {
            var result:uint = 0 ;
            var it:Iterator = _map.iterator() ;
            while (it.hasNext()) 
            {
                result += (it.next() as Collection).size() ;
            }
            return result ;
        }
        
        /**
         * Returns the iterator representation of all Collections register in the MultiValueMap, all collections represents a key.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.data.Iterator ;
         * import system.data.maps.MultiValueMap ;
         * 
         * var map:MultiValueMap = new MultiValueMap() ;
         * 
         * map.put( "key1" , "A1"   ) ;
         * map.put( "key2" , "B1" ) ;
         * map.put( "key2" , "B2" ) ;
         * map.put( "key3" , "C1" ) ;
         * 
         * var it:Iterator = map.valueIterator() ;
         * 
         * trace( it ) ;
         * 
         * while( it.hasNext() )
         * {
         *     trace( it.next() ) ;
         * }
         * </pre>
         * @return the iterator representation of all Collections of values in the MultiValueMap.
         */
        public function valueIterator():Iterator 
        {
            return new ArrayIterator( _map.getValues() ) ;
        }
        
        /**
         * Returns a Collection of all values in the MultiValueMap.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.data.Collection ;
         * import system.data.maps.MultiValueMap ;
         * 
         * var map:MultiValueMap = new MultiValueMap() ;
         * 
         * map.put( "key1" , "A1"   ) ;
         * map.put( "key2" , "B1" ) ;
         * map.put( "key2" , "B2" ) ;
         * map.put( "key3" , "C1" ) ;
         * 
         * var c:Collection = map.values() ;
         * 
         * trace( c ) ;
         * </pre> 
         * @return a Collection of all values in the MultiValueMap.
         */
        public function values():Collection 
        {
            return new ArrayCollection( getValues() ) ;
        }
        
        /**
         * Returns an Iterator representation of all values in the MultiValueMap.
         * <pre class="prettyprint">
         * import system.data.Iterator ;
         * import system.data.maps.MultiValueMap ;
         * 
         * var map:MultiValueMap = new MultiValueMap() ;
         * 
         * map.put( "key1" , "A1"   ) ;
         * map.put( "key2" , "B1" ) ;
         * map.put( "key2" , "B2" ) ;
         * map.put( "key3" , "C1" ) ;
         * 
         * var it:Iterator = map.valuesIterator() ;
         * 
         * trace( it ) ;
         * 
         * while( it.hasNext() )
         * {
         *     trace( it.next() ) ;
         * }
         * </pre>
         * @return an Iterator representation of all values in the MultiValueMap.
         */
        public function valuesIterator():Iterator
        {
            return new ArrayIterator( getValues() ) ;
        }
        
        /**
         * The internal Map of this MultiValueMap class.
         * @private
         */
        protected var _map:Map ;
        
        /**
         * @private
         */
        hack var _internalBuildClass:Class ;
    }
}
