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

package system.data.maps 
{
    import system.data.Collection;
    import system.data.Iterable;
    import system.data.Iterator;
    import system.data.Map;
    import system.data.MultiMap;
    import system.data.collections.ArrayCollection;
    import system.data.iterators.ArrayIterator;    

    /**
     * A Map with multiple values to keys. It's the basic implementation of the <code class="prettyprint">MultiMap</code> interface. 
     */
    public class MultiHashMap implements MultiMap 
    {

        /**
         * Creates a new MultiHashMap instance.
         * @param map Optional Map reference to initialize this MultiMap.
         */
        public function MultiHashMap( map:Map = null )
        {
            _map = new HashMap() ;
            if (map == null) 
            {
                return ;
            }
            if ( map.size() > 0 ) 
            {
                putAll( map.clone() ) ;
            }
        }

        /**
         * Removes all elements in this map.
         */
        public function clear():void 
        {
            _map.clear() ;
        }
        
        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public function clone():* 
        {
            var m:MultiHashMap = new MultiHashMap() ;
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
         * <code class="prettyprint">
         * var b:Boolean = map.containsKey( "key" ) ;
         * </code>
         * @return <code class="prettyprint">true</code> if the Map contains the specified key.
         */
        public function containsKey( key:* ):Boolean 
        {
            return _map.containsKey( key ) ;
        }

        /**
         * Checks whether the map contains the value specified.
         * <p><b>Example :</b></p>
         * <code class="prettyprint">
         * var b:Boolean = map.containsValue( "value" ) ;
         * </code>
         * @return <code class="prettyprint">true</code> if the List contains the specified value.
         */
        public function containsValue( value:* ):Boolean 
        {
            var it:Iterator = _map.iterator() ;
            while (it.hasNext()) 
            {
                var cur:Collection = it.next() as Collection ;
                if ( cur != null && cur.contains(value) ) 
                {
                    return true;
                }
            }
            return false ;
        } 

        /**
         * Checks whether the map contains the value specified or at the specified key contains the value.
         * <p><b>Example :</b></p>
         * <code class="prettyprint">
         * var b:Boolean = map.containsValueByKey("key", "value") ;
         * </code>
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
            return new ArrayCollection() ; 
        }         
        
        /**
         * Gets the collection mapped to the specified key.
         * <p> This method is a convenience method to typecast the result of get(key).</p>
         */
        public function get( key:* ):*
        {
            return _map.get(key) ;
        }
        
        /**
         * Checks whether the map contains the key specified .
         */        
        public function getKeys():Array
        {
            return _map.getKeys() ;
        }
        
        /**
         * Returns an array containing the combination of values from all keys.
         * @return An array containing the combination of values from all keys.
         */
        public function getValues():Array 
        {
            var result:Array = [] ;
            var values:Array = _map.getValues() ;
            var l:int = values.length ;
            for ( var i:int = 0 ; i<l ; i++ ) 
            {
                result = result.concat( values[i].toArray() ) ;
            }
            return result ;
        }
        
        /**
         * Returns whether this object contains any mappings.
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
         */
        public function iteratorByKey( key:* ):Iterator
        {
            return ( _map.get(key) as Iterable ).iterator() ;
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
         */        
        public function put( key:*, value:* ):*
        {
            if (!containsKey(key)) 
            {
                _map.put( key , createCollection() ) ;
            }
            var c:Collection = _map.get( key ) ;
            var b:Boolean = c.add( value ) ;
            return b ? value : null ;
        }
        
        /**
         * Override superclass to ensure that MultiMap instances are correctly handled.
         */
        public function putAll( map:Map ):void
        {
            var it:Iterator = map.iterator() ;
            while (it.hasNext()) 
            {
                var value:* = it.next() ;
                var key:* = it.key() ;
                if (value is Collection) 
                {
                    putCollection(key, value) ;
                }
                else 
                {
                    put(key, value) ;
                }
            }
        }      
        
        /**
         * Adds a collection of values to the collection associated with the specified key.
         */
        public function putCollection(key:*, c:Collection):void 
        {
            if (!containsKey(key)) 
            {
                _map.put(key , createCollection()) ;
            }
            _map.get(key).insertAll(c) ;
        }
        
        /**
         * Removes a specific value from map with a specific key.
         * @param o the key to remove in the map.
         */
        public function remove( o:* ):*
        {
            return _map.remove(o) ; // TODO use MapEntry ????
        }
        
        /**
         * Removes a specific value from all the map.
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
                var r:*          = c.remove(value) ; // TODO use MapEntry ?????
                return (r != null) ? r : null ;
            }
        }        
        
        /**
         * Returns the size of the collection mapped to the specified key.
         * @return the size of the collection mapped to the specified key.
         */
        public function size():uint
        {
            return _map.size() ;
        }     

        /**
         * Returns a Eden representation of the object.
         * @return a string representing the source code of the object.
         */
        public function toSource(indent:int = 0):String
        {
            return null;
        }   

        /**
         * Returns the string representation of this instance.
         * @return the string representation of this instance
         */
        public function toString():String 
        {
            return formatter.format(this) ;
        }

        /**
         * Returns the total size of the map by counting all the values.
         * @return the total size of the map by counting all the values.
         */
        public function totalSize():uint 
        {
            var result:uint = 0 ;
            var it:Iterator = _map.iterator() ;
            while (it.hasNext()) 
            {
                var c:Collection = it.next() ;
                var s:int        = c.size() ;
                result += s ;
            }
            return result ;
        }
        
        /**
         * Returns a Collection of all values in the MultiHashMap.
         * @return a Collection of all values in the MultiHashMap.
         */
        public function values():Collection 
        {
            var ar:Array = getValues() ;
            return new ArrayCollection(ar) ;
        }
    
        /**
         * Returns the iterator of all values in the MultiHashMap.
         * @return the iterator of all values in the MultiHashMap.
         */
        public function valueIterator():Iterator 
        {
            return new ArrayIterator( _map.getValues() ) ;
        }
        
        /**
         * The internal Map of this MultiHashMap class.
         * @private
         */
        protected var _map:HashMap ;

    }
}
