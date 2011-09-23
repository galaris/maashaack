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
    import core.reflect.hasInterface;
    
    import system.data.Collection;
    import system.data.Iterator;
    import system.data.Map;
    import system.data.Set;
    import system.data.sets.HashSet;
    import system.hack;
    
    /**
     * The MultiSetMap is a MutltiMap that contains no duplicate elements in a specified key.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.data.Collection ;
     * import system.data.collections.ArrayCollection ;
     * 
     * import system.data.maps.MultiSetMap ;
     * 
     * var s:MultiSetMap = new MultiSetMap() ;
     * 
     * trace("----- Test put()") ;
     * 
     * trace("insert key1:valueA1 : " + s.put("key1", "valueA1")) ;
     * trace("insert key1:valueA2 : " + s.put("key1", "valueA2"))
     * trace("insert key1:valueA2 : " + s.put("key1", "valueA2")) ;
     * trace("insert key1:valueA3 : " + s.put("key1", "valueA3")) ;
     * trace("insert key2:valueA2 : " + s.put("key2", "valueA2")) ;
     * trace("insert key2:valueB1 : " + s.put("key2", "valueB1")) ;
     * trace("insert key2:valueB2 : " + s.put("key2", "valueB2")) ;
     * 
     * trace("size : " + s.size()) ;
     * trace("totalSize : " + s.totalSize()) ;
     * 
     * trace("---- Test toArray") ;
     * 
     * var ar:Array = s.toArray() ;
     * trace("s.toArray : " + ar) ;
     * 
     * trace("----- Test contains") ;
     * 
     * trace("contains valueA1 : " + s.contains("valueA1") ) ;
     * trace("contains valueA1 in key1 : " + s.containsByKey("key1", "valueA1") ) ;
     * trace("contains valueA1 in key2 : " + s.containsByKey("key2", "valueA1") ) ;
     * 
     * trace("---- Test removeBy(key, value)") ;
     * 
     * trace("remove key1:valueA2 : " + s.removeByKey("key1", "valueA2")) ;
     * trace("insert key1:valueA2 : " + s.put("key1", "valueA2")) ;
     * trace("insert key1:valueA2 : " + s.put("key1", "valueA2")) ;
     * 
     * trace("---- Test remove(key)") ;
     * 
     * trace("remove key2 : " + s.remove("key2")) ;
     * trace("size : " + s.size()) ;
     * 
     * trace("---- Test putCollection(key, co:Collection)") ;
     * 
     * var co:Collection = new ArrayCollection(["valueA1", "valueA4", "valueA1"]) ;
     * 
     * s.putCollection("key1", co) ;
     * 
     * trace("s : " + s) ;
     * </pre>
     * @see system.data.MultiMap
     */
    public class MultiSetMap extends MultiValueMap
    {
        use namespace hack ;
        
        /**
         * Creates a new MultiSetMap instance.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.data.sets.MultiSetMap ;
         * 
         * var s:MultiSetMap = new MultiSetMap() ;
         * 
         * trace( s ) ;
         * </pre>
         * @param map Optional Map reference to initialize and fill this MultiMap.
         * @param factory Optional Map reference to create the internal Map of the MultiSetMap.
         */
        public function MultiSetMap( map:Map=null , factory:* = null )
        {
            internalSet = new HashSet() ;
            super( map , factory ) ;
        }
        
        /**
         * Determinates the internal build class used in the createCollection() method to create a new collection to register all values with a new key. 
         * The class must implements the Set interface and by default the HashSet class is used. 
         */
        public override function get internalBuildClass():Class
        {
            if ( _internalBuildClass == null )
            {
                _internalBuildClass = HashSet ;
            }
            return _internalBuildClass ;
        }
        
        /**
         * @private
         */
        public override function set internalBuildClass( clazz:Class ):void
        {
            _internalBuildClass = hasInterface(clazz,Set) ? clazz : HashSet ;
        }
        
        /**
         * This clears each collection in the map, and so may be slow.
         */
        public override function clear():void
        {
            super.clear() ;
            internalSet.clear() ;
        }
        
        /**
         * Returns the shallow copy of this object.
         * @return the shallow copy of this object.
         */
        public override function clone():*
        {
            var m:MultiSetMap = new MultiSetMap() ;
            var kItr:Iterator = keyIterator() ;
            var vItr:Iterator = valueIterator() ;
            var key:* ;
            var value:* ;
            while ( kItr.hasNext() ) 
            {
                key   = kItr.next() ;
                value = vItr.next() ;
                m.putCollection(key, value) ;
            }
            return m ;
        }
                
        /**
         * Checks whether the map contains the value specified .
         * @param o the object to search in this instance.
         * @return <code class="prettyprint">true</code> if the MultiSetMap container the passed-in object.
         */
        public function contains(o:*):Boolean
        {
            var value:* = o ;
            var it:Iterator = _map.iterator() ;
            while ( it.hasNext() ) 
            {
                var cur:Collection = it.next() as Collection ;
                if (cur == null) 
                {
                    continue ;
                }
                else if ( cur.contains( value ) ) 
                {
                    return true;
                }
            }
            return false ;
        }
        
        /**
         * Checks whether the map contains the value specified with the specified key.
         * @param key the specified key in the MultiSetMap to search the value.
         * @param value the object to search in this instance.
         * @return <code class="prettyprint">true</code> if the MultiSetMap container the passed-in object.
         */
        public function containsByKey(key:*, value:*):Boolean
        {
            var s:Set = getSet( key ) ;
            return (s == null) ? false : s.contains( value ) ; 
        }
        
        /**
         * Returns the Set defined in the map with the specified key.
         * @param key the key in the map 
         * @return the Set defined in the map with the specified key.
         */
        public function getSet( key:* ):Set 
        {
            return get( key ) as Set ;
        }
        
        /**
         * Adds the value to the Set associated with the specified key.
         * @return <code class="prettyprint">true</code> if the value is inserted in the object.
         */
        public override function put(key:*, value:*):*
        {
            if(internalSet.contains(value)) 
            {
                return false ;
            }
            if ( !containsKey(key) ) 
            {
                _map.put(key , createCollection()) ;
            }
            _map.get( key ).add( value ) ; // TODO fix the null value 
            return internalSet.add(value) ;
        }
        
        /**
         * Adds a collection of values to the collection associated with the specified key.
         */
        public override function putCollection(key:*, c:Collection):void 
        {
            if (!containsKey(key)) 
            {
                _map.put(key , createCollection()) ;
            }
            var s:HashSet = _map.get(key) ;
            var it:Iterator = c.iterator() ;
            var value:* ;
            while(it.hasNext()) 
            {
                value = it.next() ;
                if (internalSet.add(value)) 
                {
                    s.add(value) ;
                }
            }
        }
        
        /**
         * Removes a specific value from map with a specific key.
         */
        public override function remove(o:*):*
        {
            var s:Set = _map.get(o) ;
            if (s != null) 
            {
                var it:Iterator = s.iterator() ;
                while(it.hasNext()) 
                {
                    internalSet.remove(it.next()) ;
                }
                _map.remove(o) ;
                return true ;
            }
            else 
            {
                return false ;
            }
        }
           
        /**
         * Removes a specific value from map with the specific passed-in key value.
         * <p><b>Note :</b> Use Set implementation and not Map implementation !</p>
         */
        public override function removeByKey( key:*, value:* ):*
        {
            var c:Collection = _map.get(key) as Collection ;
            if ( c == null ) 
            {
                return null ;
            }
            if (c.remove(value))
            {
                return internalSet.remove(value) ;
            }
            else 
            {
                return null ;
            }
        }

        /**
         * Returns an Array containing the combination of values from all keys.
         * @return an Array containing the combination of values from all keys.
         */
        public function toArray():Array
        {
            return getValues() ;
        }
        
        /**
         * @private
         */
        hack var internalSet:HashSet ;
    }
}