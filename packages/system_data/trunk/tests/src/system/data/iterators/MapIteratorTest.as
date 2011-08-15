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

package system.data.iterators 
{
    import library.ASTUce.framework.TestCase;
    
    import system.data.Iterator;
    import system.data.Map;
    import system.data.maps.ArrayMap;
    import system.data.maps.HashMap;    
    
    public class MapIteratorTest extends TestCase 
    {
        public function MapIteratorTest( name:String = "" )
        {
            super( name );
        }
        
        public var m:Map ;
        
        public var it:MapIterator ;
        
        public function setUp():void
        {
            m  = new HashMap(["key1","key2"],["value1","value2"]) ; 
            it = new MapIterator(m) ;
        }
        
        public function tearDown():void
        {
            m  = undefined ;
            it = undefined ;
        }
        
        public function testConstructor():void
        {
            var i:Iterator ;
            try
            {
                i = new MapIterator(null) ;
                fail( "01 - test constructor failed if the passed-in Map is a null object.") ;
            }
            catch( e:Error )
            {
                assertEquals( e.message , "[object MapIterator] constructor failed, the passed-in Map argument not must be 'null'." , "02 - test constructor failed.");
            }
            assertNotNull(it, "03 - the MapIterator not must be null") ; 
        } 
        
        public function testHasNext():void
        {
            assertTrue( it.hasNext(), "01 hasNext method failed" ) ;
            it.next() ;
            assertTrue( it.hasNext(), "02 hasNext method failed" ) ;
            it.next() ;
            assertFalse( it.hasNext(), "03 hasNext method failed" ) ;
            it.reset() ;
        }
        
        public function testKey():void
        {
            it.next() ; 
            assertTrue(it.key() == "key1" || "key2" , "01 - key() method failed") ;
            
            it.next() ; 
            assertTrue(it.key() == "key1" || "key2" , "02 - key() method failed") ;
            
            it.reset() ;
        }
        
        public function testNext():void
        {
            var r:* ;
            r = it.next() ;
            assertTrue( r == "value1" || r == "value2" , "01 next() method failed" ) ;
            r = it.next() ;
            assertTrue( r == "value1" || r == "value2" , "01 next() method failed" ) ;
            it.reset() ;
        }
        
        public function testRemove():void
        {
            
            var map:Map      = new ArrayMap(["key1","key2"],["value1","value2"]) ; 
            var itr:Iterator = new MapIterator( map ) ;
            
            itr.next() ;
            
            var r:* = itr.remove() ;
                         
             assertEquals( r , "value1" , "01-01 - remove() method." ) ;
             assertEquals( map.size()   , 1 , "01-02 - remove() method." ) ;
            
            itr.next() ;
            r = itr.remove() ;
            
            assertEquals( r , "value2" , "02-01 - remove() method." ) ;
            assertEquals( map.size()   , 0 , "02-02 - remove() method." ) ;
        }
        
        public function testReset():void
        {
            it.next() ;
            it.next() ;
            it.reset() ;
            var r:* = it.next() ;
            assertTrue( it.hasNext() , "01 - reset() method failed, the iterator.hasNext() method must return true." ) ;
            assertTrue( r == "value1" || r == "value2" , "02 - reset() method failed" ) ;
            it.reset() ;
        }
        
        public function testSeek():void
        {
            try
            {
                it.seek(0) ;
                fail( "01 - seek() method failed must throw an Error.") ;
            }
            catch( e:Error )
            {
                assertEquals( e.message , "This Iterator does not support the seek() method." , "02 - seek() failed.");
            }
        } 
    }
}
