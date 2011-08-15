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
package system.models.maps 
{
    import library.ASTUce.framework.TestCase;

    import system.data.Iterable;
    import system.data.Map;
    import system.data.maps.ArrayMap;
    import system.data.maps.HashMap;
    import system.models.ChangeModel;
    import system.signals.Signaler;
    
    public class MapModelTest extends TestCase 
    {
        public function MapModelTest(name:String = "")
        {
            super( name );
        }
        
        public var model:MapModel ;
        
        public function setUp():void
        {
            model = new MapModel() ;
        }
        
        public function tearDown():void
        {
            model = null ;
        }
        
        public function testDEFAUT_PRIMARY_KEY():void
        {
            assertEquals( "id" , MapModel.DEFAULT_PRIMARY_KEY ) ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( model ) ;
        }
        
        public function testConstructorWithFactory():void
        {
            model = new MapModel( new ArrayMap() ) ;
            assertNotNull( model.getMap() as ArrayMap , "#1" ) ;
            
            model = new MapModel( null ) ;
            assertNotNull( model.getMap() as HashMap , "#2" ) ;
        }
        
        public function testConstructorWithKey():void
        {
            model = new MapModel( null , "key" ) ;
            assertNotNull( model.getMap() as HashMap , "#1" ) ;
            assertEquals( "key" , model.primaryKey , "#2" ) ;
        }
        
        public function testInherit():void
        {
            assertTrue( model is ChangeModel ) ;
        }
        
        public function testAdded():void
        {
            assertNotNull( model.added as Signaler ) ;
        }
        
        public function testPrimaryKey():void
        {
            assertEquals( "id" , model.primaryKey ) ;
            model.add( { id : "key1" , value : "value1" } ) ;
            model.add( { id : "key2" , value : "value2" } ) ;
            model.primaryKey = "key" ;
            assertEquals( "key" , model.primaryKey ) ;
            assertEquals( 0 , model.length ) ;
        }
        
        public function testRemoved():void
        {
            assertNotNull( model.removed as Signaler ) ;
        }
        
        public function testUpdated():void
        {
            assertNotNull( model.updated as Signaler ) ;
        }
        
        public function testClear():void
        {
            model.add( { id : "key1" , value : "value1" } ) ;
            model.add( { id : "key2" , value : "value2" } ) ;
            model.current = { id : "key3" , value : "value3" } ;
            model.clear() ;
            assertNull( model.current , "#1" ) ;
            assertEquals( 0 , model.length , "#2" ) ;
        }
        
        public function testContains():void
        {
            var o1:Object = { id : "key1" , value : "value1" } ;
            var o2:Object = { id : "key2" , value : "value2" } ;
            var o3:Object = { id : "key3" , value : "value3" } ;
            
            model.add( o1 ) ;
            model.add( o2 ) ;
            
            assertTrue( model.contains( o1 ) ) ;
            assertTrue( model.contains( o2 ) ) ;
            assertFalse( model.contains( o3 ) ) ;
        }
        
        public function testContainsKey():void
        {
            model.add( { id : "key1" , value : "value1" } ) ;
            model.add( { id : "key2" , value : "value2" } ) ;
            assertTrue( model.containsKey( "key1" ) ) ;
            assertTrue( model.containsKey( "key2" ) ) ;
            assertFalse( model.containsKey( "key3" ) ) ;
        }
        
        public function testContainsByProperty():void
        {
            model.add( { id : "key1" , value : "value1" } ) ;
            model.add( { id : "key2" , value : "value2" } ) ;
            
            assertTrue( model.containsByProperty( "id" , "key1" ) , "#1-1" ) ;
            assertTrue( model.containsByProperty( "id" , "key2" ) , "#1-2" ) ;
            assertFalse( model.containsByProperty( "id" , "key3" ) , "#1-3" ) ;
            
            assertTrue( model.containsByProperty( "value" , "value1" ) , "#2-1" ) ;
            assertTrue( model.containsByProperty( "value" , "value2" ) , "#2-2" ) ;
            assertFalse( model.containsByProperty( "value" , "value3" ) , "#2-3" ) ;
            
            assertFalse( model.containsByProperty( "unknow" , "value1" ) , "#3-1" ) ;
            assertFalse( model.containsByProperty( "unknow" , "value2" ) , "#3-2" ) ;
        }
        
        public function testGet():void
        {
            var o1:Object = { id : "key1" , value : "value1" } ;
            var o2:Object = { id : "key2" , value : "value2" } ;
            
            model.add( o1 ) ;
            model.add( o2 ) ;
            
            assertEquals( o1 , model.get( "key1" ) , "#1" ) ;
            assertEquals( o2 , model.get( "key2" ) , "#2" ) ;
            
            assertNull( model.get( "key3" ) , "#3" ) ;
        }
        
        public function testGetByProperty():void
        {
            var o1:Object = { id : "key1" , value : "value1" } ;
            var o2:Object = { id : "key2" , value : "value2" } ;
            
            model.add( o1 ) ;
            model.add( o2 ) ;
            
            assertEquals( o1 , model.getByProperty( "value" , "value1" ) , "#1" ) ;
            assertEquals( o2 , model.getByProperty( "value" , "value2" ) , "#2" ) ;
            
            assertNull( model.getByProperty( "value" , "value3" ) , "#3" ) ;
        }
        
        public function testGetSetMap():void
        {
            assertNotNull( model.getMap() as Map , "#1-1" ) ;
            assertNotNull( model.getMap() as HashMap , "#1-2" ) ;
            
            var map:ArrayMap = new ArrayMap() ;
            
            model.setMap( map ) ;
            assertNotNull( model.getMap() as ArrayMap , "#2-1" ) ;
            assertEquals( map , model.getMap() , "#2-1" ) ;
            
            model.setMap( null ) ;
            assertNotNull( model.getMap() as HashMap , "#3-1" ) ;
        }
        
        public function testIterator():void
        {
            assertTrue( model is Iterable , "#1" ) ;
            assertNotNull( model.iterator() , "#2" ) ; 
        }
        
        public function testKeyIterator():void
        {
            assertNotNull( model.keyIterator() ) ; 
        }
        
        // TODO Mock to receive message from signals !
    }
}