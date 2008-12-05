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
Portions created by the Initial Developers are Copyright (C) 2006-2009
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
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.data.Bag;
    import system.data.Collection;
    import system.data.collections.ArrayCollection;
    import system.data.maps.ArrayMap;
    import system.data.maps.HashMap;    

    public class CoreBagTest extends TestCase 
    {

        public function CoreBagTest(name:String = "")
        {
            super( name );
        }
        
        public var bag:CoreBag ;
        
        public function setUp():void
        {
            bag = new CoreBag( new ArrayMap() ) ;
        }

        public function tearDown():void
        {
            bag = undefined ;
        }        
        
        public function testConstructor():void
        {
            
            assertNotNull( bag , "01 - CoreBag constructor failed." ) ;
            
            var b:Bag ;
            
            try
            {
                b = new CoreBag() ;
                fail( "02-01 - CoreBag constructor failed."  ) ;
            }
            catch( e:Error )
            {
                assertTrue( e is ArgumentError ,  "02-02 - CoreBag constructor failed."  ) ;
                assertEquals( e.message , "CoreBag, set the internal Map failed. The Map must be non-null and empty.", "02-03 - CoreBag constructor failed."  ) ;
            }
            
            try
            {
                b = new CoreBag(null) ;
                fail( "03-01 - CoreBag constructor failed."  ) ;
            }
            catch( e:Error )
            {
                assertTrue( e is ArgumentError ,  "03-02 - CoreBag constructor failed."  ) ;
                assertEquals( e.message , "CoreBag, set the internal Map failed. The Map must be non-null and empty.", "03-03 - CoreBag constructor failed."  ) ;
            }            
            
            var co:ArrayCollection = new ArrayCollection([1,2,3,3,4]) ;
            var ma:ArrayMap        = new ArrayMap() ;
            
            b = new CoreBag( ma , co ) ;            
            
            assertEquals( b.size()      , 5 , "04-01 - CoreBag constructor failed."  ) ;
            assertEquals( b.getCount(1) , 1 , "04-02 - CoreBag constructor failed."  ) ;
            assertEquals( b.getCount(2) , 1 , "04-03 - CoreBag constructor failed."  ) ;
            assertEquals( b.getCount(3) , 2 , "04-04 - CoreBag constructor failed."  ) ;
            assertEquals( b.getCount(4) , 1 , "04-04 - CoreBag constructor failed."  ) ;
            
            
        }
        
        public function testInterface():void
        {
            assertTrue( bag is Bag        , "CoreBag must implement the Bag interface." ) ;
            assertTrue( bag is Collection , "CoreBag must implement the Collection interface." ) ;	
        }
        
        public function testModCount():void
        {
            assertEquals( bag.modCount , 0 , "01 - CoreBag modCount property failed" ) ;	
            bag.modCount ++ ;
            assertEquals( bag.modCount , 1 , "02 - CoreBag modCount property failed" ) ;
            bag.modCount = 0 ;
            assertEquals( bag.modCount , 0 , "03 - CoreBag modCount property failed" ) ;
        }
            
        public function testAdd():void 
        {
            var bag:Bag = new CoreBag( new HashMap() ) ;
            bag.add("item1") ;
            assertEquals( bag.getCount("item1") , 1 , "01-01 - addCopies failed : " + bag) ;
            assertEquals(bag.size()             , 1 , "01-02 - CoreBag add method failed : " + bag) ;
            bag.add("item1") ;
            assertEquals( bag.getCount("item1") , 2 , "02-01 - addCopies failed : " + bag) ;
            assertEquals(bag.size()             , 2 , "02-02 - CoreBag add method failed : " + bag) ;
            bag.add("item2") ;
            assertEquals( bag.getCount("item2") , 1 , "03-01 - addCopies failed : " + bag) ;
            assertEquals(bag.size()             , 3 , "03-02 - CoreBag add method failed : " + bag) ;
        }

        public function testAddAll():void 
        {
            var bag:Bag = new CoreBag( new ArrayMap() ) ;
            var c:Collection = new ArrayCollection( ["item1", "item2", "item3", "item4", "item5"] ) ;
            bag.addAll(c) ;
            assertEquals( bag.size() , 5, "CoreBag addAll failed : " + bag ) ;
        }
        
        public function testAddCopies():void 
        {
            var bag:CoreBag = new CoreBag( new ArrayMap() ) ;
            
            bag.addCopies("item2", 2) ;
            assertEquals( bag.getCount("item2") , 2, "01-01 - CoreBag addCopies failed : " + bag) ;
            assertEquals( bag.size()            , 2, "01-02 - CoreBag addCopies failed : " + bag) ;
            assertEquals( bag.modCount          , 1, "01-03 - CoreBag addCopies failed : " + bag) ;
            
            bag.addCopies("item3", 1) ;
            assertEquals( bag.getCount("item3") , 1, "02-01 - CoreBag addCopies failed : " + bag) ;
            assertEquals( bag.size()            , 3, "02-02 - CoreBag addCopies failed : " + bag) ;
            assertEquals( bag.modCount          , 2, "02-03 - CoreBag addCopies failed : " + bag) ;
                        
        } 
        
        public function testClear():void 
        {
            var bag:CoreBag = new CoreBag( new ArrayMap() ) ;
            bag.add("item1") ;
            bag.add("item1") ;
            bag.clear() ;
            assertTrue( bag.isEmpty(), "01 - CoreBag clear failed.") ;
        }        
              
        public function testClone():void 
        {
            var bag:CoreBag = new CoreBag( new ArrayMap() ) ;
            bag.add("item1") ;
            bag.add("item2") ;      	        
            bag.add("item2") ;
            
            var clone:CoreBag = bag.clone() as CoreBag ;
            
            assertNotNull( clone         , "01 - CoreBag clone failed." ) ;
            assertNotSame( bag   , clone , "02 - CoreBag clone failed." ) ;
            
            assertEquals( clone.size() , bag.size() , "03 - CoreBag clone failed." ) ;
            
            assertEquals( clone.getCount("item1") , bag.getCount("item1") , "04-01 - CoreBag clone failed." ) ;
            assertEquals( clone.getCount("item2") , bag.getCount("item2") , "04-02 - CoreBag clone failed." ) ;
            
        }
        
        public function testContains():void 
        {
            var bag:CoreBag = new CoreBag( new ArrayMap() ) ;
            bag.add("item1") ;
            bag.add("item2") ;                  
            bag.add("item2") ;
            
            assertTrue( bag.contains("item1") , "01 - CoreBag contains failed." ) ;
            assertTrue( bag.contains("item2") , "02 - CoreBag contains failed." ) ;
            assertFalse( bag.contains("item3") , "03 - CoreBag contains failed." ) ;
        }        
        
        public function testContainsAll():void 
        {
            var bag:CoreBag = new CoreBag( new ArrayMap() ) ;
            
            bag.add("item1") ;
            bag.add("item2") ;                  
            bag.add("item3") ;
            bag.add("item4") ;
            bag.add("item5") ;
            
            var c1:Collection = new ArrayCollection( ["item1", "item2", "item3", "item4", "item5"] ) ;
            var c2:Collection = new ArrayCollection( ["item1", "item2"] ) ;
            // TODO var c3:Collection = new ArrayCollection( ["item5", "item4"] ) ;
            
            assertTrue ( bag.containsAll( c1 ) , "01 - CoreBag containsAll failed : " + bag ) ;
            assertTrue ( bag.containsAll( c2 ) , "02 - CoreBag containsAll failed : " + bag ) ;
            // TODO assertFalse( bag.containsAll( c3 ) , "03 - CoreBag containsAll failed : " + bag ) ;
        }        
        
    }
}
