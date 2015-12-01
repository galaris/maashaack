# The system.data.Map interface #

<a href='http://creativecommons.org/licenses/by-sa/3.0/'><img src='http://i.creativecommons.org/l/by-sa/2.0/uk/88x31.png' alt='Licence Creative Commons' /></a> author : Marc ALCARAZ ([ekameleon](https://code.google.com/u/109962507657971592081/))



## Generality ##

The **Map** interface is inspired on the [Java Collection Framework](http://download.oracle.com/javase/1.4.2/docs/api/java/util/Map.html).

This interface defines an object that maps keys to values. A map cannot contain duplicate keys ; each key can map to at most one value.

The **system.data.Map** interface defines a group of basic methods :

**The test methods**

| isEmpty	| return true if the collection no contains entries. |
|:--------|:---------------------------------------------------|
| containsKey | return true if the map contains a mapping for the specified key. |
| containsValue | return true if the map maps one or more keys to the specified value. |


**The insert and change methods**

| put( key:`*` , value:`*`) | Associates the specified value with the specified key in the map. |
|:--------------------------|:------------------------------------------------------------------|
| putAll( m:Map )           | Copies all of the mappings from the specified map to the map.     |

**The remove methods**

| clear() | Removes all mappings from this map. |
|:--------|:------------------------------------|
| remove(key) | Removes the mapping for this key from this map if it is present. |

**The copy methods**

| clone() | Returns a shallow copy of the Map. |
|:--------|:-----------------------------------|

**The getter and enumeration methods**

| get(key) | Returns the value to which this map maps the specified key. |
|:---------|:------------------------------------------------------------|
| getKeys():Array | Returns an Array representation of all keys of the Map.     |
| getValues():Array | Returns an Array representation of all values of the Map.   |
| iterator():Iterator | Returns the iterator of this collection (This Iterator is an MapIterator? reference). |
| keyIterator():Iterator | Returns the Iterator of all keys of the Map.                |

**The information methods**

| size():Number | Returns the number of key-value mappings in the Map. |
|:--------------|:-----------------------------------------------------|
| toString():String | Returns the custom string representation of the Map. |
| toSource():String | Returns the source of the Map object (to serialize it for example). |

The **Map** implementations are define in the **system.data.maps** package with the classes :

  * system.data.map.HashMap
  * system.data.map.ArrayMap
  * system.data.map.SortedArrayMap
  * system.data.map.TypedMap
  * system.data.map.MultiValueMap
  * system.data.set.MultiSetMap

## The implementations of the Map interface ##

### The system.data.maps.`HashMap` class ###

This class is an easy representation of the **Map** interface.

In **AS3** the **HashMap** class does not guarantee as to the order of the map. The **AS3** implementation use the [flash.utils.Dictionnary](http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/utils/Dictionary.html) class to map the key/value entries.

**example**

```
import system.data.Iterator;
import system.data.Map ;
import system.data.maps.HashMap;
 
var map:Map = new HashMap() ;
 
trace("put key1 -> value0 : " + map.put("key1", "value0") ) ;
trace("put key1 -> value1 : " + map.put("key1", "value1") ) ;            
trace("put key2 -> value2 : " + map.put("key2", "value2") ) ;
       
trace("map : " + map) ;
trace("map toSource : " + map.toSource()) ;
 
trace("> iterator") ;

var it:Iterator = map.iterator() ;

while( it.hasNext() )
{
      var v = it.next() ;
      var k = it.key() ;
      trace( "   " + k + " : " + v ) ;
}
             
trace( "remove key1 : " + map.remove("key1")) ;

trace( "size : " + map.size() ) ;      
             
map.clear() ;  
  
trace( "isEmpty : " + map.isEmpty() ) ;
```

### The system.data.map.`ArrayMap` class ###

This class uses two Arrays to map the key/value entries.

This class contains all method of the **Map** interface and two news methods :

| setKeyAt( index:Number , key ) | This method change the value of a key in the map at the index position, this method don't change the value of the key. |
|:-------------------------------|:-----------------------------------------------------------------------------------------------------------------------|
| setValueAt( index:Number, value ) | This method change the value of a key at the index position specified in argument.                                     |

**example**

```
import system.data.maps.ArrayMap ;

var map:ArrayMap = new ArrayMap() ;

map.put("key1", "value1");
map.put("key2", "value2");
map.put("key3", "value3");

trace(map) ; // {key1:value1,key2:value2,key3:value3}

map.setKeyAt(1, "myKey") ;

trace(map) ; // {key1:value1,myKey:value2,key3:value3}

map.setValueAt(2, "myValue") ;

trace(map) ; // {key1:value1,myKey:value2,key3:myValue}
```

### The system.data.maps.`SortedArrayMap` class ###

This class extends the **ArrayMap** class and contains all methods of the **ArrayMap** but this class can sort the entries key/value of the map with the sorting methods of the **Array** class.

The **SortedArrayMap** instances can sort this keys or this values :

  * We can choose with the property **sortBy** if the sort target the keys or the values. We can use the constants **SortedArrayMap.KEY** or **SortedArrayMap.VALUE** constants to defines the sorting target.
  * The **sort()** method of the **SortedArrayMap** use a **system.Comparator** object to sort the map. See the package **system.comparators** or use the **Comparator** interface to implements your custom comparator objects.
  * We can use an **options** property to defines the sorting filter of the internal Arrays of the Map. This options use the **Array.DESCENDING**, **Array.NUMERIC** etc.. constants to defines the option to use during the sort process. You can use the constants defines in the **SortedArrayMap** class to creates your custom sort filter.
  * The method **sortOn()** of the **SortedArrayMap** to sort the keys or the values with the **Array.sortOn()** methods.

**example 1 : use the 'sort' method.**

```
import system.data.maps.SortedArrayMap ;

import system.comparators.AlphaComparator ;
import system.comparators.NumberComparator ;
 
var map:SortedArrayMap = new SortedArrayMap( [0] , ["item0"] ) ;
 
map.put( 1 , "item8" ) ;
map.put( 3 , "item7" ) ;
map.put( 2 , "item6" ) ;
map.put( 5 , "item5" ) ;
map.put( 4 , "item4" ) ;
map.put( 7 , "item3" ) ;
map.put( 6 , "item2" ) ;
map.put( 8 , "item1" ) ;
 
trace("----- original Map") ;
 
trace( map ) ;
 
trace("----- sort by key with sort() method") ;
 
map.comparator = new NumberComparator() ;
 
map.options = SortedArrayMap.NUMERIC | SortedArrayMap.DESCENDING ;
map.sort() ;

trace( map ) ;
 
map.options = SortedArrayMap.NUMERIC ;
map.sort() ;

trace( map ) ;

trace("----- sort by value with sort() method") ;
 
map.comparator = new AlphaComparator() ;
 
map.sortBy = SortedArrayMap.VALUE;
 
map.options = SortedArrayMap.DESCENDING;
map.sort() ;
trace( map ) ;
 
map.options = SortedArrayMap.NONE;
map.sort() ;
trace( map ) ;
```

**example 2 : use the 'sortOn' method**

```
import system.data.Iterator ;
import system.data.Map ;
import system.data.maps.SortedArrayMap ;
 
var map:SortedArrayMap = new SortedArrayMap() ;
 
map.put( { id:5 } , { name:'name4' } ) ;
map.put( { id:1 } , { name:'name1' } ) ;
map.put( { id:3 } , { name:'name5' } ) ;
map.put( { id:2 } , { name:'name2' } ) ;
map.put( { id:4 } , { name:'name3' } ) ;
 
var debug:Function = function( map:Map ):void
{
 
    var vit:Iterator = map.iterator() ;
    var kit:Iterator = map.keyIterator() ;
       
    var str:String = "{" ;
       
    while( vit.hasNext() )
    {
        var value = vit.next() ;
        var key   = kit.next() ;
        str += key.id + ":" + value.name ;
        if (vit.hasNext())
        {
            str += "," ;
        }
    }
    str += "}" ;
    trace(str) ;
}
 
trace("----- original Map") ;
 
debug( map ) ; // {5:name4,1:name1,3:name5,2:name2,4:name3}
 
trace("----- sort by key with sort() method") ;
 
map.sortBy = SortedArrayMap.KEY ; // default
 
map.options = SortedArrayMap.NUMERIC | SortedArrayMap.DESCENDING ;
map.sortOn("id") ;
debug( map ) ; // {5:name4,4:name3,3:name5,2:name2,1:name1}
 
map.options = SortedArrayMap.NUMERIC  ;
map.sortOn("id") ;
debug( map ) ; // {1:name1,2:name2,3:name5,4:name3,5:name4}
 
trace("----- sort by value with sort() method") ;

map.sortBy = SortedArrayMap.VALUE ;

map.options = SortedArrayMap.DESCENDING ;
map.sortOn("name") ;
debug( map ) ; // {3:name5,5:name4,4:name3,2:name2,1:name1}
 
map.options = SortedArrayMap.NONE ;
map.sortOn("name") ;
debug( map ) ; // {1:name1,2:name2,4:name3,5:name4,3:name5}
```

### The system.data.maps.`TypedMap` class ###

This class is a wrappers who encapsulate a **Map** object and test the type of the values of its **Map** during the **put()** or the **putAll()** call.

This class implements the **Map**, **Typeable** and **Validator** interfaces defines in the **system.data** package.

**example**

```
import system.data.Iterator ;
import system.data.Map ;

import system.data.maps.HashMap ;
import system.data.maps.TypedMap ;

var map1:HashMap = new HashMap() ;
var map2:HashMap = new HashMap() ;

map1.put("key1", "value1") ;
map1.put("key2", "value2") ;
map1.put("key3", "value3") ;

map2.put("key4", "value1") ;
map2.put("key5", "value5") ;
map2.put("key6", "value6") ;

var tm:TypedMap = new TypedMap( String , map1 ) ;

tm.put( "key1" , "value0" ) ;
tm.putAll(map2) ;

trace( "typedMap : " + ™ ) ;

trace( "typedMap toSource : " + tm.toSource() ) ;

try
{
    tm.put("key7", 2) ;
}
catch( e:Error )
{
    trace( e.toString() ) ; // TypeError: TypedMap.validate(2) is mismatch.
}
```

### The system.data.maps.MultiValueMap class ###

The **MultiValueMap** class is inspired by the implementation if the [Jakarta Collections Framework](http://commons.apache.org/collections/api-3.2/org/apache/commons/collections/map/MultiValueMap.html). This class implements the **MultiMap** interface.

A **MultiMap** is a Map with slightly different semantics. Putting a value into the map will add the value to a **Collection** at that key. Getting a value will return a **Collection**, holding all the values put to that key.

**usage**

```
new MultiValueMap( map:Map = null , factory:* = null )
```

**example**

```
import system.data.Iterator;
import system.data.MultiMap;
import system.data.maps.HashMap;
import system.data.maps.MultiValueMap;

var map1:HashMap = new HashMap() ;

map1.put("key1", "valueD1") ;
map1.put("key2", "valueD2") ;

trace("> map1 : " + map1) ;
trace("> map1 containsKey 'key1' : " + map1.containsKey("key1")) ;

trace("\r--- use a map argument in constructor") ;

var map:MultiValueMap = new MultiValueMap(map1) ;

map.put("key1", "valueA1") ;
map.put("key1", "valueA2") ;
map.put("key1", "valueA3") ;
map.put("key2", "valueA2") ;
map.put("key2", "valueB1") ;
map.put("key2", "valueB2") ;
map.put("key3", "valueC1") ;
map.put("key3", "valueC2") ;

trace("init map    : " + map) ;
trace("map toSource : " + map.toSource()) ;

trace("key1 >> " + map.get("key1")) ;
trace("key2 >> " + map.get("key2")) ;
trace("key3 >> " + map.get("key3")) ;

var r:* = map.removeByKey("key1", "valueA2") ;
trace( "map.removeByKey('key1', 'valueA2') : " + r ) ;

// trace ("\r--- remove a value in key1 >> " + map.get("key1")) ;

var it:Iterator ;

trace("\r--- use iterator") ;

it = map.iterator() ;
while(it.hasNext()) 
{
	trace("\t * " + it.next()) ;
}

trace("\r--- use a key iterator : key1") ;
it = map.iteratorByKey("key1") ;
while(it.hasNext()) 
{
	trace("\t * " + it.next()) ;
}

trace("\r--- putCollection key2 in key1") ;

map.putCollection("key1", map.get("key2")) ;

trace("key1 >> " + map.get("key1")) ;

trace("\r--- different size") ;

trace("map size : " + map.size()) ;

trace("map totalSize : " + map.totalSize()) ;

trace("\r--- clone MultiMap") ;

var clone:MultiMap = map.clone() as MultiMap ;

clone.remove("key1") ;

trace("clone : " + clone) ;
trace("clone size : " + clone.totalSize()) ;
trace("map size : " + map.totalSize()) ;

trace("\r--- valueIterator") ;
it = map.valueIterator() ;
while( it.hasNext() ) 
{
	trace("\t> " + it.next()) ;
}
```

### The system.data.maps.MultiSetMap class ###

The **MultiSetMap** class is a original implementation. This class extends the **MultiValueMap** class but use a Set to register all values of a specified key in the **Map** and not a basic **Collection**.

A **Set** is a collection that contains no duplicate elements. We can't insert in a **MultiSetMap** two same values with a specified key. But we can use two same values with two different keys.

**usage**

```
new MultiSetMap( map:Map=null , factory:* = null )
```

**example**

```
import system.data.Collection;
import system.data.collections.ArrayCollection;
import system.data.maps.MultiSetMap;
	
var map:MultiSetMap = new MultiSetMap() ;

trace("put key1:valueA1 : " + map.put("key1", "valueA1")) ;
trace("put key1:valueA2 : " + map.put("key1", "valueA2")) ;
trace("put key1:valueA2 : " + map.put("key1", "valueA2")) ;
trace("put key1:valueA3 : " + map.put("key1", "valueA3")) ;
trace("put key2:valueA2 : " + map.put("key2", "valueA2")) ;
trace("put key2:valueB1 : " + map.put("key2", "valueB1")) ;
trace("put key2:valueB2 : " + map.put("key2", "valueB2")) ;

trace("size : " + map.size()) ;
trace("totalSize : " + map.totalSize()) ;

var ar:Array = map.toArray() ;
trace("map.toArray : " + ar) ;

trace("contains valueA1 : " + map.contains("valueA1") ) ;
trace("contains valueA1 in key1 : " + map.containsByKey("key1", "valueA1") ) ;
trace("contains valueA1 in key2 : " + map.containsByKey("key2", "valueA1") ) ;

trace("remove key1:valueA2 : " + map.removeByKey("key1", "valueA2")) ;
trace("put    key1:valueA2 : " + map.put("key1", "valueA2")) ;
trace("put    key1:valueA2 : " + map.put("key1", "valueA2")) ;

trace("remove key2 : " + map.remove("key2")) ;
trace("size : " + map.size()) ;

var co:Collection = new ArrayCollection(["valueA1", "valueA4", "valueA1"]) ;

map.putCollection("key1", co) ;

trace( "map : " + map ) ;
```