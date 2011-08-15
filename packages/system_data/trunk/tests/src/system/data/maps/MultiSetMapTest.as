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

    import system.data.Map;
    import system.data.MultiMap;
    import system.data.Set;
    import system.data.sets.ArraySet;
    import system.data.sets.HashSet;

    public class MultiSetMapTest extends TestCase 
    {

        public function MultiSetMapTest(name:String = "")
        {
            super( name );
        }
        
        public function testConstructor():void
        {
            var map:MultiSetMap = new MultiSetMap() ;
            assertNotNull(map , "1 - The MultiSetMap constructor failed.") ;
        }

        public function testConstructorWithFactory():void
        {
            
            var init:Map = new HashMap() ;
            init.put( "key1" , "value1" ) ;
            
            var map:MultiSetMap = new MultiSetMap( init , new ArrayMap() ) ;
            
            assertNotNull(map , "1 - The MultiSetMap constructor failed.") ;
            
            assertEquals
            ( 
               map.toSource() , 
               'new system.data.maps.MultiSetMap(new system.data.maps.ArrayMap(["key1"],[new system.data.sets.HashSet(["value1"])]))' ,
               "2 - The MultiSetMap constructor failed." 
            );
            
        }
        
        public function testInherit():void
        {
            var map:MultiSetMap = new MultiSetMap() ;
            assertTrue( map is MultiValueMap , "The MultiSetMap must extends the MultiValueMap class." ) ;
        }
        
        public function testInterface():void
        {
            var map:MultiSetMap = new MultiSetMap() ;
            assertTrue( map is MultiMap , "1 - The MultiSetMap must implement the MultiMap interface." ) ;
            assertTrue( map is Map      , "2 - The MultiSetMap must implement the Map interface." ) ;
        }
        
        public function testinternalBuildClass():void
        {
            var map:MultiSetMap = new MultiSetMap() ;
            
            assertEquals( map.internalBuildClass , HashSet , "01 - internalBuildClass failed" ) ;
            
            map.internalBuildClass = ArraySet ;
            assertEquals( map.internalBuildClass , ArraySet , "02 - internalBuildClass failed" ) ;
            
            map.internalBuildClass = null ;
            assertEquals( map.internalBuildClass , HashSet , "03 - internalBuildClass failed" ) ;
            
            map.internalBuildClass = Array ;
            assertEquals( map.internalBuildClass , HashSet , "04 - internalBuildClass failed" ) ;
        }
        
        public function testClear():void 
        {
            var map:MultiSetMap = new MultiSetMap() ;
            map.put("key1" , "value1") ;
            map.clear() ;
            assertTrue( map.isEmpty() , "The MultiSetMap clear failed.") ;
        }
        
        public function testClone():void
        {
            var map:MultiSetMap = new MultiSetMap() ;
            var clone:MultiSetMap = map.clone() as MultiSetMap ;
            
            assertNotNull( clone , "01 - The MultiSetMap clone method failed.") ;
            assertNotSame( map, clone , "02 - The MultiSetMap clone method failed.") ;
            
            clone.put("key1", "value1") ;
            
            clone = clone.clone() ;
            
            assertEquals( clone.size() , 1 , "03 - The MultiSetMap clone method failed.") ;
        }
        
        public function testContainsKey():void 
        {
            var o:Object = {} ;
            var map:MultiSetMap = new MultiSetMap() ;
            
            map.put("key1" , "value1") ;
            map.put(o , "value2") ;
            
            assertTrue ( map.containsKey( "key1" ) , "01 - The MultiSetMap containsKey method failed." ) ;
            assertTrue ( map.containsKey( o ) , "02 - The MultiSetMap containsKey method failed." ) ;
            
            map.put("key2" , "value1") ; // all values are unique
            assertFalse( map.containsKey( "key2" ) , "03 - The MultiSetMap containsKey method failed." ) ;
            
            assertFalse ( map.containsKey( "key2" ) , "04 - The MultiSetMap containsKey method failed." ) ;
        }
        
        public function testContainsValue():void 
        {
            var o:Object = {} ;
            var map:MultiSetMap = new MultiSetMap() ;
            map.put( "key1" , "value1" ) ;
            map.put( "key1" , "value3" ) ;
            map.put( "key2" , "value2" ) ;
            map.put( "key3" , o        ) ;
            
            assertTrue ( map.containsValue( "value1" ) , "01 - The MultiSetMap containsValue method failed." ) ;
            assertTrue ( map.containsValue( "value2" ) , "02 - The MultiSetMap containsValue method failed." ) ;
            assertTrue ( map.containsValue( "value3" ) , "03 - The MultiSetMap containsValue method failed." ) ;
            assertTrue ( map.containsValue( o        ) , "04 - The MultiSetMap containsValue method failed." ) ;
            
            assertFalse ( map.containsValue( "value4" ) , "05 - The MultiSetMap containsValue method failed." ) ;
        }
        
        public function testContainsValueByKey():void 
        {
            var map:MultiSetMap = new MultiSetMap() ;
            map.put( "key1" , "hello"   ) ;
            map.put( "key2" , "bonjour" ) ;
            assertTrue  ( map.containsValueByKey( "key1" , "hello"   ) , "01 - The MultiSetMap containsValueByKey method failed." ) ;
            assertFalse ( map.containsValueByKey( "key1" , "bonjour" ) , "02 - The MultiSetMap containsValueByKey method failed." ) ;
            assertFalse ( map.containsValueByKey( "key2" , "hello"   ) , "03 - The MultiSetMap containsValueByKey method failed." ) ;
            assertTrue  ( map.containsValueByKey( "key2" , "bonjour" ) , "04 - The MultiSetMap containsValueByKey method failed." ) ;
        }
        
        public function testCreateCollection():void
        {
            var map:MultiSetMap = new MultiSetMap() ;
            var set:Set = map.createCollection() as Set ;
            assertNotNull( set , "The MultiSetMap createCollection method failed." ) ;
        }
        
        public function testGetSet():void
        {
            var map:MultiSetMap = new MultiSetMap() ;
            map.put( "key1" , "hello"   ) ;
            map.put( "key2" , "bonjour" ) ;
            
            assertNotNull ( map.getSet( "key1" ) , "01 - The MultiSetMap getSet method failed." ) ;
            assertNotNull ( map.getSet( "key2" ) , "02 - The MultiSetMap getSet method failed." ) ;
            assertNull    ( map.getSet( "key3" ) , "03 - The MultiSetMap getSet method failed." ) ;
                        
            map.clear() ;  
        }
        
        public function testPut():void
        {
            var map:MultiSetMap = new MultiSetMap() ;
            assertTrue( map.put("key1" , "value1") , "1-1 - The MultiSetMap put method failed." )  ;
            assertTrue( map.put("key1" , "value2") , "1-2 - The MultiSetMap put method failed." )  ;
            assertFalse( map.put("key1" , "value2") , "1-3 - The MultiSetMap put method failed." )  ;
            
            assertTrue( map.put("key2" , "value3") , "2-21- The MultiSetMap put method failed." )  ;
            assertFalse( map.put("key2" , "value1") , "2-2 - The MultiSetMap put method failed." )  ;
        }   
        
        public function testToSource():void
        {
            var map:MultiSetMap = new MultiSetMap() ;
            map.put("key1" , "value1") ;
            assertEquals
            (
                map.toSource() , 
                'new system.data.maps.MultiSetMap(new system.data.maps.HashMap(["key1"],[new system.data.sets.HashSet(["value1"])]))' ,
                "The MultiSetMap toSource method failed." 
            ) ;
        }
        
        public function testTotalSize():void 
        {
            var map:MultiSetMap = new MultiSetMap() ;
            map.put("key1" , "value1") ;
            map.put("key1" , "value2") ;
            map.put("key2" , "value3") ;
            assertEquals( map.totalSize() , 3, "1 - The MultiSetMap totalSize method failed.") ;
            map.clear() ;
            assertEquals( map.totalSize() , 0 ,  "2 - The MultiSetMap totalSize method failed.") ;
        }
        
        public function testToString():void 
        {
            var map:MultiSetMap = new MultiSetMap() ;
            map.put("key1" , "value1") ;
            assertEquals( map.toString() , "{key1:{value1}}"  , "1 - The MultiValueMap toString method failed.") ;
            map.clear() ;    
            assertEquals( map.toString() , "{}" , "2 - The MultiSetMap toString method failed.") ;
        }
    }
}
