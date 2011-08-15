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
    import library.ASTUce.framework.TestCase;
    
    import system.data.Iterator;
    import system.data.iterators.ArrayIterator;
    import system.data.iterators.MapIterator;
    
    public class ArrayMapTest extends TestCase 
    {
        public function ArrayMapTest(name:String = "")
        {
            super( name );
        }
        
        public var map:ArrayMap ;
        
        public function setUp():void
        {
            map = new ArrayMap(["key1", "key2"],["value1", "value2"]) ;
        }
        
        public function tearDown():void
        {
            map = undefined ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( map , "" ) ;
            
            assertEquals( map.get("key1") , "value1" , "1 - The ArrayMap constructor failed : map.get('key1')") ;
            assertEquals( map.get("key2") , "value2" , "2 - The ArrayMap constructor failed : map.get('key2')") ;
            
            var m1:ArrayMap = new ArrayMap() ;
            
            assertEquals( m1.size() , 0 , "3 - The ArrayMap constructor failed") ;
            
            var m2:ArrayMap = new ArrayMap(null,["value1", "value2"]) ;
            assertEquals( m2.size() , 0 , "4 - The ArrayMap constructor failed") ;
        }
        
        public function testClear():void
        {
            var m:ArrayMap = new ArrayMap(["key1", "key2"],["value1", "value2"]) ;
            m.clear() ;
            assertEquals( m.size() , 0 , "The ArrayMap clear method failed.") ;
        }
        
        public function testClone():void
        {
            var m:ArrayMap = map.clone() as ArrayMap ;
            assertNotNull( m , "1 - The ArrayMap clone method failed.") ;
            assertEquals( m.size()  , m.size()  , "1 - The ArrayMap clone method failed.") ;
            assertEquals( m["key1"] , m["key1"] , "2 - The ArrayMap clone method failed.") ;
            assertEquals( m["key2"] , m["key2"] , "3 - The ArrayMap clone method failed.") ;
        }
        
        public function testContainsKey():void
        {
            assertTrue( map.containsKey("key1") , "1 - The ArrayMap containsKey method failed.") ;
            assertTrue( map.containsKey("key2") , "2 - The ArrayMap containsKey method failed.") ;
            assertFalse( map.containsKey("key3") , "2 - The ArrayMap containsKey method failed.") ;
        }
        
        public function testContainsValue():void
        {
            assertTrue( map.containsValue("value1") , "1 - The ArrayMap containsValue method failed.") ;
            assertTrue( map.containsValue("value2") , "2 - The ArrayMap containsValue method failed.") ;
            assertFalse( map.containsValue("value3") , "2 - The ArrayMap containsValue method failed.") ;
        }
        
        public function testGet():void
        {
            assertEquals( map.get("key1") , "value1"  , "1 - The ArrayMap get method failed.") ;
            assertEquals( map.get("key2") , "value2"  , "2 - The ArrayMap get method failed.") ;
            assertUndefined( map.get("key3") , "3 - The ArrayMap get method failed.") ;
        }
        
        public function testGetKeyAt():void
        {
            assertEquals( map.getKeyAt(0) , "key1"  , "1 - The ArrayMap getKeyAt(0) method failed.") ;
            assertEquals( map.getKeyAt(1) , "key2"  , "2 - The ArrayMap getKeyAt(1) method failed.") ;
        }
       
        public function testGetKeys():void
        {
            var keys:Array = map.getKeys() ;
            assertTrue( keys.indexOf("key1") >  -1 , "1 - The ArrayMap getKeys method failed.") ;
            assertTrue( keys.indexOf("key2") >  -1 , "2 - The ArrayMap getKeys method failed.") ;
            assertTrue( keys.indexOf("key3") == -1 , "3 - The ArrayMap getKeys method failed.") ;
        }
        
        public function testGetValueAt():void
        {
            assertEquals( map.getValueAt(0) , "value1"  , "1 - The ArrayMap getValueAt(0) method failed.") ;
            assertEquals( map.getValueAt(1) , "value2"  , "2 - The ArrayMap getValueAt(1) method failed.") ;
        }
        
        public function testGetValues():void
        {
            var values:Array = map.getValues() ;
            assertTrue( values.indexOf("value1") >  -1 , "1 - The ArrayMap getValues method failed.") ;
            assertTrue( values.indexOf("value2") >  -1 , "2 - The ArrayMap getValues method failed.") ;
            assertTrue( values.indexOf("value3") == -1 , "3 - The ArrayMap getValues method failed.") ;
        }
        
        public function testIndexOfKey():void
        {
            assertEquals( map.indexOfKey("key1") , 0,  "1 - The ArrayMap indexOfKey method failed." )  ;
            assertEquals( map.indexOfKey("key2") , 1,  "2 - The ArrayMap indexOfKey method failed." )  ;
            assertEquals( map.indexOfKey("key3") , -1,  "3 - The ArrayMap indexOfKey method failed." )  ;
        }  
        
        public function testIndexOfValue():void
        {
            assertEquals( map.indexOfValue("value1") , 0,  "1 - The ArrayMap indexOfValue method failed." )  ;
            assertEquals( map.indexOfValue("value2") , 1,  "2 - The ArrayMap indexOfValue method failed." )  ;
            assertEquals( map.indexOfValue("value3") , -1,  "3 - The ArrayMap indexOfValue method failed." )  ;
        }
        
        public function testIsEmpty():void
        {
            var m:ArrayMap = new ArrayMap() ;
            
            assertTrue( m.isEmpty() , "1 - The ArrayMap isEmpty method failed." )  ;
            assertFalse( map.isEmpty() , "2 - The ArrayMap isEmpty method failed." )  ;
        }
        
        public function testIterator():void
        {
            var it:Iterator = map.iterator() ;
            assertNotNull(it, "1 - The ArrayMap iterator method failed." ) ;
            assertTrue(it is MapIterator, "2 - The ArrayMap iterator method failed, the iterator must be a MapIterator." ) ;
            assertTrue(it.hasNext(), "3 - The ArrayMap iterator method failed, the iterator must has a next value." ) ;
        }
        
        public function testKeyIterator():void
        {
            var it:Iterator = map.keyIterator() ;
            assertNotNull(it, "1 - The ArrayMap keysIterator method failed." ) ;
            assertTrue(it is ArrayIterator, "2 - The ArrayMap keysIterator method failed, the iterator must be a ArrayIterator." ) ;
            assertTrue(it.hasNext(), "3 - The ArrayMap keysIterator method failed, the iterator must has a next value." ) ;
        }
        
        public function testPut():void
        {
            assertNull(map.put("key3","value3"), "1 - The ArrayMap put method failed, with a new key must return null.") ;
            assertEquals(map.put("key3","value4"), "value3", "2 - The ArrayMap put method failed, with a key who already exist in the map, must return a value.") ;
            map.remove("key3") ;
        }
        
        public function testPutAll():void
        {
            var m1:ArrayMap = new ArrayMap(["key1", "key2"],["value1", "value2"]) ;
            var m2:ArrayMap = new ArrayMap(["key3", "key4"],["value3", "value4"]) ;
            
            m1.putAll(m2) ;
            
            assertTrue( m1.containsKey("key4")     , "1 - The ArrayMap putAll method failed.") ;
            assertTrue( m1.containsKey("key3")     , "2 - The ArrayMap putAll method failed.") ;
            assertTrue( m1.containsValue("value4") , "3 - The ArrayMap putAll method failed.") ;
            assertTrue( m1.containsValue("value3") , "4 - The ArrayMap putAll method failed.") ;
        }
        
        public function testRemove():void
        {
            map.put("key3", "value3") ;
            assertEquals( map.remove("key3") , "value3", "1 - The ArrayMap remove method failed.") ;
            assertNull( map.remove("key4") , "3 - The ArrayMap remove method failed.") ;
        }
       
        public function testSetKeyAt():void
        {
            var entry:MapEntry ;
            try
            {
                map.setKeyAt( 10 , "key3" ) ;
                fail("01-01 The setKeyAt method must throw a RangeError if the index is out of range") ;
            }
            catch( e:Error )
            {
                assertTrue( e is RangeError , "01-02 The setKeyAt method must throw a RangeError if the index is out of range") ;
                assertEquals( e.message , "ArrayMap.setKeyAt(10) failed with an index out of the range." , "01-03 The setKeyAt method must throw a RangeError if the index is out of range") ;
            }
            
            entry = map.setKeyAt( 0, "key2" ) ;
            assertNull(entry , "02 The ArrayMap.setKeyAt failed, must return null when the passed-in key already exist in the map.") ;
            
            entry = map.setKeyAt( 0, "key10" ) ;
            assertEquals( entry.key   , "key1"  , "03-01 - The ArrayMap setKeyAt method failed : " + entry ) ;
            assertEquals( entry.value , "value1" , "03-02 - The ArrayMap setKeyAt method failed : " + entry ) ;
            
            entry = map.setKeyAt( 0, "key1" ) ;
            
            assertEquals( entry.key   , "key10"   , "04-01 - The ArrayMap setKeyAt method failed : " + entry ) ;
            assertEquals( entry.value , "value1"  , "04-02 - The ArrayMap setKeyAt method failed : " + entry ) ;
            
        }
        
        public function testSetValueAt():void
        {
            try
            {
                map.setValueAt( 10 , "the value" ) ;
                fail("01-01 The setValueAt method must throw a RangeError if the index is out of range") ;
            }
            catch( e:Error )
            {
                assertTrue( e is RangeError , "01-02 The setValueAt method must throw a RangeError if the index is out of range") ;
                assertEquals( e.message , "ArrayMap.setValueAt(10) failed with an index out of the range." , "01-03 The setKeyAt method must throw a RangeError if the index is out of range") ;
            }
            
            var entry:MapEntry ;
            
            entry = map.setValueAt( 0, "value999" ) ;
            assertEquals( entry.key   , "key1"  , "03-01 - The ArrayMap setValueAt method failed : " + entry ) ;
            assertEquals( entry.value , "value1" , "03-02 - The ArrayMap setValueAt method failed : " + entry ) ;
            
            entry = map.setValueAt( 0, "value1" ) ;
            
            assertEquals( entry.key   , "key1"   , "04-01 - The ArrayMap setValueAt method failed : " + entry ) ;
            assertEquals( entry.value , "value999"  , "04-02 - The ArrayMap setValueAt method failed : " + entry ) ;
        }
       
        public function testSize():void
        {
            assertEquals(map.size() , 2, "The ArrayMap size method failed.") ;
        }
        
        public function testToSource():void
        {
            assertEquals
            ( 
                map.toSource() , 
                'new system.data.maps.ArrayMap(["key1","key2"],["value1","value2"])' , 
                "The ArrayMap toSource method failed."
            ) ;
        } 
        
        public function testToString():void
        {
            assertEquals( map.toString() ,"{key1:value1,key2:value2}" , "The ArrayMap toString method failed." ) ;
        }
    }
}
