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
 
package system.data.bags 
{
    import library.ASTUce.framework.ArrayAssert;
    import library.ASTUce.framework.TestCase;
    
    import system.Equatable;
    import system.data.Bag;
    import system.data.Collection;
    import system.data.Iterator;
    import system.data.collections.ArrayCollection;
    import system.data.iterators.BagIterator;
    import system.data.maps.ArrayMap;
    import system.data.maps.HashMap;
    
    import flash.errors.IllegalOperationError;    

    public class CoreMapBagTest extends TestCase 
    {

        public function CoreMapBagTest(name:String = "")
        {
            super( name );
        }
                
        public function testConstructor():void
        {
            
            var b:Bag ;
            
            // 01 - classic usage
            
            b = new CoreMapBag( new ArrayMap() ) ;
            
            assertNotNull( b , "01 - CoreMapBag constructor failed." ) ;
            
            
            // 02 - no argument passed-in
            
            try
            {
                b = new CoreMapBag() ;
                fail( "02-01 - CoreMapBag constructor failed."  ) ;
            }
            catch( e:Error )
            {
                assertTrue( e is ArgumentError ,  "02-02 - CoreMapBag constructor failed."  ) ;
                assertEquals( e.message , "CoreMapBag, set the internal Map failed. The Map must be non-null and empty.", "02-03 - CoreMapBag constructor failed."  ) ;
            }
            
            // 03 - Map argument is null
            
            try
            {
                b = new CoreMapBag(null) ;
                fail( "03-01 - CoreMapBag constructor failed."  ) ;
            }
            catch( e:Error )
            {
                assertTrue( e is ArgumentError ,  "03-02 - CoreMapBag constructor failed."  ) ;
                assertEquals( e.message , "CoreMapBag, set the internal Map failed. The Map must be non-null and empty.", "03-03 - CoreMapBag constructor failed."  ) ;
            }            
            
            var co:ArrayCollection = new ArrayCollection([1,2,3,3,4]) ;
            var ma:ArrayMap        = new ArrayMap() ;
            
            b = new CoreMapBag( ma , co ) ;            
            
            assertEquals( b.size()      , 5 , "04-01 - CoreMapBag constructor failed."  ) ;
            assertEquals( b.getCount(1) , 1 , "04-02 - CoreMapBag constructor failed."  ) ;
            assertEquals( b.getCount(2) , 1 , "04-03 - CoreMapBag constructor failed."  ) ;
            assertEquals( b.getCount(3) , 2 , "04-04 - CoreMapBag constructor failed."  ) ;
            assertEquals( b.getCount(4) , 1 , "04-05 - CoreMapBag constructor failed."  ) ;
            
            // 04 - no empty map

            ma = new ArrayMap(["item1"],[1]) ;
            
            try
            {
                b = new CoreMapBag(ma) ;
                fail( "05-01 - CoreMapBag constructor failed."  ) ;
            }
            catch( e:Error )
            {
                assertTrue( e is ArgumentError ,  "05-02 - CoreMapBag constructor failed."  ) ;
                assertEquals( e.message , "CoreMapBag, set the internal Map failed. The Map must be non-null and empty.", "05-03 - CoreMapBag constructor failed."  ) ;
            }
        }
        
        public function testInterface():void
        {
            var b:CoreMapBag = new CoreMapBag( new ArrayMap() ) ;            
            assertTrue( b is Bag        , "01 - CoreMapBag must implement the Bag interface." ) ;
            assertTrue( b is Collection , "02 - CoreMapBag must implement the Collection interface." ) ;
            assertTrue( b is Equatable  , "03 - CoreMapBag must implement the Equatable interface." ) ;        
        }
        
        public function testModCount():void
        {
            var b:CoreMapBag = new CoreMapBag( new ArrayMap() ) ;
            assertEquals( b.modCount , 0 , "01 - CoreMapBag modCount property failed" ) ;    
            b.modCount ++ ;
            assertEquals( b.modCount , 1 , "02 - CoreMapBag modCount property failed" ) ;
            b.modCount = 0 ;
            assertEquals( b.modCount , 0 , "03 - CoreMapBag modCount property failed" ) ;
        }
            
        public function testAdd():void 
        {
            var bag:CoreMapBag = new CoreMapBag( new HashMap() ) ;
            bag.add("item1") ;
            assertEquals( bag.getCount("item1") , 1 , "01-01 - addCopies failed : " + bag) ;
            assertEquals(bag.size()             , 1 , "01-02 - CoreMapBag add method failed : " + bag) ;
            bag.add("item1") ;
            assertEquals( bag.getCount("item1") , 2 , "02-01 - addCopies failed : " + bag) ;
            assertEquals(bag.size()             , 2 , "02-02 - CoreMapBag add method failed : " + bag) ;
            bag.add("item2") ;
            assertEquals( bag.getCount("item2") , 1 , "03-01 - addCopies failed : " + bag) ;
            assertEquals(bag.size()             , 3 , "03-02 - CoreMapBag add method failed : " + bag) ;
        }

        public function testAddAll():void 
        {
            var bag:CoreMapBag = new CoreMapBag( new ArrayMap() ) ;
            var c:Collection = new ArrayCollection( ["item1", "item2", "item3", "item4", "item5"] ) ;
            bag.addAll(c) ;
            assertEquals( bag.size() , 5, "CoreMapBag addAll failed : " + bag ) ;
        }
        
        public function testAddCopies():void 
        {
            var bag:CoreMapBag = new CoreMapBag( new ArrayMap() ) ;
            
            bag.addCopies("item2", 2) ;
            assertEquals( bag.getCount("item2") , 2, "01-01 - CoreMapBag addCopies failed : " + bag) ;
            assertEquals( bag.size()            , 2, "01-02 - CoreMapBag addCopies failed : " + bag) ;
            assertEquals( bag.modCount          , 1, "01-03 - CoreMapBag addCopies failed : " + bag) ;
            
            bag.addCopies("item3", 1) ;
            assertEquals( bag.getCount("item3") , 1, "02-01 - CoreMapBag addCopies failed : " + bag) ;
            assertEquals( bag.size()            , 3, "02-02 - CoreMapBag addCopies failed : " + bag) ;
            assertEquals( bag.modCount          , 2, "02-03 - CoreMapBag addCopies failed : " + bag) ;
                        
        } 
        
        public function testClear():void 
        {
            var bag:CoreMapBag = new CoreMapBag( new ArrayMap() ) ;
            bag.add("item1") ;
            bag.add("item1") ;
            bag.clear() ;
            assertTrue( bag.isEmpty(), "01 - CoreMapBag clear failed.") ;
        }        
              
        public function testClone():void 
        {
            var bag:CoreMapBag = new CoreMapBag( new ArrayMap() ) ;
            bag.add("item1") ;
            bag.add("item2") ;                  
            bag.add("item2") ;
            
            var clone:CoreMapBag = bag.clone() as CoreMapBag ;
            
            assertNotNull( clone         , "01 - CoreMapBag clone failed." ) ;
            assertNotSame( bag   , clone , "02 - CoreMapBag clone failed." ) ;
            
            assertEquals( clone.size() , bag.size() , "03 - CoreMapBag clone failed." ) ;
            
            assertEquals( clone.getCount("item1") , bag.getCount("item1") , "04-01 - CoreMapBag clone failed." ) ;
            assertEquals( clone.getCount("item2") , bag.getCount("item2") , "04-02 - CoreMapBag clone failed." ) ;
            
        }
        
        public function testContains():void 
        {
            var bag:CoreMapBag = new CoreMapBag( new ArrayMap() ) ;
            bag.add("item1") ;
            bag.add("item2") ;                  
            bag.add("item2") ;
            
            assertTrue( bag.contains("item1") , "01 - CoreMapBag contains failed." ) ;
            assertTrue( bag.contains("item2") , "02 - CoreMapBag contains failed." ) ;
            assertFalse( bag.contains("item3") , "03 - CoreMapBag contains failed." ) ;
        }        
        
        public function testContainsAll():void 
        {
            var bag:CoreMapBag = new CoreMapBag( new ArrayMap() ) ;
            
            bag.add("item1") ;
            bag.add("item2") ;
            bag.add("item2") ;                  
            bag.add("item3") ;
            bag.add("item4") ;
            bag.add("item5") ;
            
            var c1:Collection = new ArrayCollection( ["item1", "item2", "item2", "item3", "item4", "item5"] ) ;
            var c2:Collection = new ArrayCollection( ["item1", "item2"] ) ;
            var c3:Collection = new ArrayCollection( ["item5", "item4"] ) ;
            var c4:Collection = new ArrayCollection( ["item5", "item6"] ) ;
            
            assertTrue ( bag.containsAll( c1   ) , "01 - CoreMapBag containsAll failed : " + bag ) ;
            assertTrue ( bag.containsAll( c2   ) , "02 - CoreMapBag containsAll failed : " + bag ) ;
            assertTrue ( bag.containsAll( c3   ) , "03 - CoreMapBag containsAll failed : " + bag ) ;
            assertFalse( bag.containsAll( c4   ) , "04 - CoreMapBag containsAll failed : " + bag ) ;
            assertFalse( bag.containsAll( null ) , "05 - CoreMapBag containsAll failed : " + bag ) ;
            
        }   
        
        public function testContainsAllInBag():void 
        {
            var bag:CoreMapBag = new CoreMapBag( new ArrayMap() ) ;
            
            bag.add("item1") ;
            bag.add("item2") ;
            bag.add("item2") ;                  
            bag.add("item3") ;
            bag.add("item4") ;
            bag.add("item5") ;
            
            var b1:HashBag = new HashBag( new ArrayCollection(["item1", "item2", "item2", "item3", "item4", "item5"] ) ) ;
            var b2:HashBag = new HashBag( new ArrayCollection(["item1", "item2"] ) ) ;
            var b3:HashBag = new HashBag( new ArrayCollection(["item5", "item4"] ) ) ;
            var b4:HashBag = new HashBag( new ArrayCollection(["item5", "item6"] ) ) ;
            
            assertTrue ( bag.containsAllInBag( b1   ) , "01 - CoreMapBag containsAllInBag failed : " + bag ) ;
            assertTrue ( bag.containsAllInBag( b2   ) , "02 - CoreMapBag containsAllInBag failed : " + bag ) ;
            assertTrue ( bag.containsAllInBag( b3   ) , "03 - CoreMapBag containsAllInBag failed : " + bag ) ;
            assertFalse( bag.containsAllInBag( b4   ) , "04 - CoreMapBag containsAllInBag failed : " + bag ) ;
            assertFalse( bag.containsAllInBag( null ) , "05 - CoreMapBag containsAllInBag failed : " + bag ) ;
            
        }  
        
        public function testEquals():void 
        {
            
            var bag:CoreMapBag = new CoreMapBag( new ArrayMap() ) ;
            
            bag.add("item1") ;
            bag.add("item2") ;
            bag.add("item2") ;                  
            bag.add("item3") ;
            bag.add("item4") ;
            bag.add("item5") ;            
            
            var b1:Bag  = new HashBag( new ArrayCollection(["item1", "item2", "item2", "item3", "item4", "item5"] ) ) ;
            var b2:Bag  = new ArrayBag( new ArrayCollection(["item1", "item2", "item2", "item3", "item4", "item5"] ) ) ;
            var b3:Bag  = new HashBag( new ArrayCollection(["item1", "item2"] ) ) ;

            assertTrue ( bag.equals( bag  ) , "00 - CoreMapBag equals failed : " + bag ) ;
            assertTrue ( bag.equals( b1   ) , "01 - CoreMapBag equals failed : " + bag ) ;
            assertTrue ( bag.equals( b2   ) , "02 - CoreMapBag equals failed : " + bag ) ;
            
            assertFalse( bag.equals( b3   ) , "03 - CoreMapBag equals failed : " + bag ) ;
            assertFalse( bag.equals( null ) , "04 - CoreMapBag equals failed : " + bag ) ;
 
        }
             
        public function testGet():void 
        {
            var bag:CoreMapBag = new CoreMapBag( new ArrayMap() ) ;
            try
            {
                bag.get("key") ;
                fail( "01 - CoreMapBag get method failed." ) ;  
            }
            catch( e:Error )
            {
                assertTrue( e is IllegalOperationError ,  "02 - CoreMapBag get method failed."  ) ;
                assertEquals( e.message , "CoreMapBag, the get() method is unsupported.", "03 - CoreMapBag get method failed."  ) ;
            }
        }
        
        public function testGetCount():void 
        {
            var bag:CoreMapBag = new CoreMapBag( new ArrayMap() ) ;
            bag.add("item1") ;
            bag.add("item2") ;
            bag.add("item2") ;
            
            assertEquals( bag.getCount('item1') , 1 , "01 - CoreMapBag getCount('item1') failed : " + bag ) ;              
            assertEquals( bag.getCount('item2') , 2 , "02 - CoreMapBag getCount('item2') failed : " + bag ) ;
            assertEquals( bag.getCount('item3') , 0 , "03 - CoreMapBag getCount('item3') failed : " + bag ) ;
            
        }
        
        public function testIndexOf():void 
        {
            var bag:CoreMapBag = new CoreMapBag( new ArrayMap() ) ;
            try
            {
                bag.indexOf("key", 0) ;
                fail( "01 - CoreMapBag indexOf method failed." ) ;  
            }
            catch( e:Error )
            {
                assertTrue( e is IllegalOperationError ,  "02 - CoreMapBag indexOf method failed."  ) ;
                assertEquals( e.message , "CoreMapBag, the indexOf() method is unsupported.", "03 - CoreMapBag indexOf method failed."  ) ;
            }
        }        
        
        public function testIsEmpty():void 
        {
            var bag:CoreMapBag = new CoreMapBag( new ArrayMap() ) ;
            assertTrue( bag.isEmpty() , "01 - CoreMapBag isEmpty method failed." ) ;
            bag.add("item1") ;
            assertFalse( bag.isEmpty() , "02 - CoreMapBag isEmpty method failed." ) ;
        }        
        
        public function testIterator():void 
        {
            var bag:CoreMapBag = new CoreMapBag( new ArrayMap() ) ;
            
            bag.add("item1") ;
            bag.add("item2") ;
            bag.add("item2") ;
            
            var it:Iterator = bag.iterator() ;
            
            assertNotNull( it , "01 - CoreMapBag iterator method failed."  )  ;
            assertTrue( it is BagIterator , "02 - CoreMapBag iterator method failed."  )  ;
            assertTrue( it.hasNext() , "03 - CoreMapBag iterator method failed."  )  ;
            assertEquals( it.next() , "item1", "04 - CoreMapBag iterator method failed."  )  ;
            
        }           
        
        public function testRemove():void 
        {
            var bag:CoreMapBag = new CoreMapBag( new ArrayMap() ) ;
            
            var modCount:uint = bag.modCount ;
            
            bag.add("item1") ;
            bag.add("item2") ;
            bag.add("item2") ;
            
            assertTrue( bag.remove("item1") , "01-01 - CoreMapBag remove method failed." ) ;
            assertEquals( bag.getCount("item1") , 0, "01-02 - CoreMapBag remove method failed." ) ;
            
            assertTrue( bag.remove("item2") , "02-01 - CoreMapBag remove method failed." ) ;
            assertEquals( bag.getCount("item2") , 0, "02-02 - CoreMapBag remove method failed." ) ;
            
            assertFalse( bag.remove("item3") , "03-01 - CoreMapBag remove method failed." ) ;
            assertEquals( bag.getCount("item3") , 0, "03-02 - CoreMapBag remove method failed." ) ;
            
            assertTrue( bag.modCount > modCount , "04 - CoreMapBag remove method failed." ) ; 
            
        }
        
        public function testRemoveAll():void 
        {
            var bag:CoreMapBag  ;
            var col:Collection ;
            
            // 01
            
            bag = new CoreMapBag( new ArrayMap() ) ;
            bag.add("item1") ;
            bag.add("item2") ;
            bag.add("item2") ;                  
            bag.add("item3") ;
            bag.add("item4") ;
            bag.add("item5") ;
            
            col = new ArrayCollection(["item1", "item2", "item2", "item3", "item4", "item5"] ) ;
            
            assertTrue ( bag.removeAll( col  ) , "01-01 - CoreMapBag removeAll failed : " + bag ) ;
            assertEquals( bag.size() , 0 , "01-02 - CoreMapBag removeAll failed : " + bag ) ;

            // 02

            bag = new CoreMapBag( new ArrayMap() ) ;
            bag.add("item1") ;
            bag.add("item2") ;
            bag.add("item2") ;                  
            bag.add("item3") ;
            bag.add("item4") ;
            bag.add("item5") ;
             
            col = new ArrayCollection(["item1", "item2"] ) ;
            
            assertTrue ( bag.removeAll( col  ) , "02-01 - CoreMapBag removeAll failed : " + bag ) ;
            assertEquals( bag.size() , 4 , "02-02 - CoreMapBag removeAll failed : " + bag ) ;
            assertEquals( bag.getCount("item2") , 1 , "02-03 - CoreMapBag removeAll failed : " + bag ) ;

            // 03

            bag = new CoreMapBag( new ArrayMap() ) ;
            bag.add("item1") ;
            bag.add("item2") ;
            bag.add("item2") ;                  
            bag.add("item3") ;
            bag.add("item4") ;
            bag.add("item5") ;
            
            col = new ArrayCollection(["item5", "item4", "item2"] ) ;
            
            assertTrue ( bag.removeAll( col  ) , "03-01 - CoreMapBag removeAll failed : " + bag ) ;
            assertEquals( bag.size() , 3 , "03-02 - CoreMapBag removeAll failed : " + bag ) ;            
            
            // 04

            bag = new CoreMapBag( new ArrayMap() ) ;
            bag.add("item1") ;
            bag.add("item2") ;
            bag.add("item2") ;                  
            bag.add("item3") ;
            bag.add("item4") ;
            bag.add("item5") ;
            
            col = new ArrayCollection(["item6"] ) ;
            
            assertFalse( bag.removeAll( col  ) , "04 - CoreMapBag removeAll failed : " + bag ) ;
                        
        } 
        
        public function testRemoveCopies():void 
        {

            var bag:CoreMapBag = new CoreMapBag( new ArrayMap() ) ;
            
            bag.add("item1") ;
            bag.add("item2") ;
            bag.add("item2") ;                  
            bag.add("item3") ;
            bag.add("item3") ;
            bag.add("item3") ;
            
            assertFalse( bag.removeCopies('item1', 0), "01-02 - CoreMapBag removeCopies('item1', 0) failed : " + bag ) ;            
            assertFalse( bag.removeCopies('item8', 1), "01-02 - CoreMapBag removeCopies('item8', 1) failed : " + bag ) ;
            assertFalse( bag.removeCopies('item8', 2), "01-03 - CoreMapBag removeCopies('item8', 2) failed : " + bag ) ;
            
            assertTrue( bag.removeCopies('item3', 3), "02-01 - CoreMapBag removeCopies('item3', 3) failed : " + bag ) ;
            assertEquals( bag.size() , 3 , "02-02 - CoreMapBag removeCopies('item3', 3) failed : " + bag ) ;
            
            // remove all
            
            assertTrue( bag.removeCopies('item2', 10), "03-01 - CoreMapBag removeCopies('item2', 10) failed : " + bag ) ;
            assertEquals( bag.size() , 1 , "03-02 - CoreMapBag removeCopies('item2', 10) failed : " + bag ) ;            
                    
        }
        
        public function testRetainAll():void
        {
            var col:Collection ;
            var bag:CoreMapBag = new CoreMapBag( new ArrayMap() ) ;
            
            // 01 - empty passed in collection
            
            bag.add("item1") ;
            bag.add("item2") ;
            bag.add("item2") ;                  
            bag.add("item3") ;
            bag.add("item3") ;
            bag.add("item3") ;
            
            assertTrue( bag.retainAll(null ), "01-01 - CoreMapBag retainAll failed : " + bag ) ;
            assertEquals( bag.size() , 0 , "01-02 - CoreMapBag retainAll failed : " + bag ) ;            
            
            // 02 - empty passed in collection
            
            bag.add("item1") ;
            bag.add("item2") ;
            bag.add("item2") ;                  
            bag.add("item3") ;
            bag.add("item3") ;
            bag.add("item3") ;
            
            col = new ArrayCollection() ;
            
            assertTrue( bag.retainAll(col), "02-01 - CoreMapBag retainAll failed : " + bag ) ;
            assertEquals( bag.size() , 0 , "02-02 - CoreMapBag retainAll failed : " + bag ) ;
            
            // 03 
            
            bag.add("item1") ;
            bag.add("item2") ;
            bag.add("item2") ;                  
            bag.add("item3") ;
            bag.add("item3") ;
            bag.add("item3") ;
            
            col = new ArrayCollection(["item1","item2","item2"]) ;
            
            assertTrue( bag.retainAll(col), "03-01 - CoreMapBag retainAll failed : " + bag ) ;
            assertEquals( bag.size() , 3 , "03-02 - CoreMapBag retainAll failed : " + bag ) ;
                        
        }
        
        public function testRetainAllInBag():void
        {
            var test:Bag ;
            var bag:CoreMapBag = new CoreMapBag( new ArrayMap() ) ;
            
            // 01 - empty passed in collection
            
            bag.add("item1") ;
            bag.add("item2") ;
            bag.add("item2") ;                  
            bag.add("item3") ;
            bag.add("item3") ;
            bag.add("item3") ;
            
            assertTrue( bag.retainAllInBag(null ), "01-01 - CoreMapBag retainAllInBag failed : " + bag ) ;
            assertEquals( bag.size() , 0 , "01-02 - CoreMapBag retainAllInBag failed : " + bag ) ;            
            
            // 02 - empty passed-in Bag
            
            bag.add("item1") ;
            bag.add("item2") ;
            bag.add("item2") ;                  
            bag.add("item3") ;
            bag.add("item3") ;
            bag.add("item3") ;
            
            test = new HashBag() ;
            
            assertTrue( bag.retainAllInBag(test), "02-01 - CoreMapBag retainAllInBag failed : " + bag ) ;
            assertEquals( bag.size() , 0 , "02-02 - CoreMapBag retainAllInBag failed : " + bag ) ;
            
            // 03 
            
            bag.add("item1") ;
            bag.add("item2") ;
            bag.add("item2") ;                  
            bag.add("item3") ;
            bag.add("item3") ;
            bag.add("item3") ;
            
            test = new HashBag(new ArrayCollection(["item1","item2","item2"]) ) ;
            
            assertTrue( bag.retainAllInBag(test), "03-01 - CoreMapBag retainAllInBag failed : " + bag ) ;
            assertEquals( bag.size() , 3 , "03-02 - CoreMapBag retainAllInBag failed : " + bag ) ;
                        
        }        
        
        public function testSize():void 
        {
            var bag:CoreMapBag  ;

            bag = new CoreMapBag( new ArrayMap() ) ;
            
            assertEquals( bag.size() , 0 , "01 - CoreMapBag size failed : " + bag ) ;
            
            bag.add("item1") ;
            bag.add("item2") ;
            bag.add("item2") ;                  
            bag.add("item3") ;

            
            assertEquals( bag.size() , 4 , "02 - CoreMapBag size failed : " + bag ) ;
            
        }         
       
        public function testToArray():void 
        {
            var bag:CoreMapBag  ;

            bag = new CoreMapBag( new ArrayMap() ) ;
            
            ArrayAssert.assertEquals( bag.toArray() , [] , "01 - CoreMapBag toArray failed : " + bag ) ;
            
            bag.add("item1") ;
            bag.add("item2") ;
            bag.add("item2") ;                  
            bag.add("item3") ;
            
            ArrayAssert.assertEquals( bag.toArray() , ["item1","item2","item2","item3"] , "024 - CoreMapBag toArray failed : " + bag ) ;
            
        }  

        public function testToSource():void 
        {
            var bag:CoreMapBag  ;

            bag = new CoreMapBag( new ArrayMap() ) ;
            
            assertEquals( bag.toSource() , "new system.data.bags.CoreMapBag(new system.data.maps.ArrayMap([],[]))" , "01 - CoreMapBag toSource failed : " + bag ) ;
            
            bag.add("item1") ;
            bag.add("item2") ;
            bag.add("item2") ;                  
            bag.add("item3") ;
            
            assertEquals( bag.toSource() , 'new system.data.bags.CoreMapBag(new system.data.maps.ArrayMap(["item1","item2","item3"],[1,2,1]))' , "02 - CoreMapBag toSource failed : " + bag ) ; 
                       
        }

        public function testToString():void 
        {
            var bag:CoreMapBag  ;

            bag = new CoreMapBag( new ArrayMap() ) ;
            
            assertEquals( bag.toString() , "{}" , "01 - CoreMapBag toString failed : " + bag ) ;
            
            bag.add("item1") ;
            bag.add("item2") ;
            bag.add("item2") ;                  
            bag.add("item3") ;
            
            assertEquals( bag.toString() , "{1:item1,2:item2,1:item3}" , "02 - CoreMapBag toString failed : " + bag ) ; 
                       
        }             
        
    }
}
