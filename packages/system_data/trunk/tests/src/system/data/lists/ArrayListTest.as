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

package system.data.lists 
{
    import library.ASTUce.framework.ArrayAssert;
    import library.ASTUce.framework.TestCase;
    
    import system.Equatable;
    import system.data.Collection;
    import system.data.List;
    import system.data.ListIterator;
    import system.data.collections.ArrayCollection;    

    public class ArrayListTest extends TestCase 
    {

        public function ArrayListTest(name:String = "")
        {
            super(name);
        }
        
        public function testConstructor():void
        {
            var list:ArrayList ;
            
            list = new ArrayList() ;
            assertNotNull( list , "The ArrayList constructor failed." ) ;
            ArrayAssert.assertEquals( list.toArray(), [], "01-02 - ArrayList constructor failed.") ;
            
            // initialize with an Array
                        
            list = new ArrayList([2,3,4]) ; 
            assertNotNull(list, "02-01 - ArrayCollection constructor failed.") ;
            ArrayAssert.assertEquals( list.toArray(), [2,3,4], "02-02 - ArrayList constructor failed.") ;
            
            // initialize with a Collection
            
            list = new ArrayList( new ArrayCollection([2,3,4])) ; 
            assertNotNull(list, "03-01 - ArrayList constructor failed.") ;
            ArrayAssert.assertEquals( list.toArray(), [2,3,4], "03-02 - ArrayList constructor failed.") ;
            
            // initialize with the capacity value
            
            list = new ArrayList( 3 ) ; 
            assertNotNull(list, "04-01 - ArrayList constructor failed.") ;
            ArrayAssert.assertEquals( list.toArray(), [undefined,undefined,undefined], "04-02 - ArrayList constructor failed.") ;            
            
        }
        
        public function testInterface():void
        {
            var list:ArrayList = new ArrayList() ;
            assertTrue( list is Collection , "01 - ArrayList must implement the Collection interface" ) ;
            assertTrue( list is Equatable  , "02 - ArrayList must implement the Equatable interface" ) ;
            assertTrue( list is List       , "03 - ArrayList must implement the List interface" ) ;
        }
        
        public function testModcount():void
        {
            var list:ArrayList = new ArrayList() ;
            assertEquals( list.modCount , 0 , "01 - ArrayList modCount property failed."  ) ;
            list.modCount = 2 ;
            assertEquals( list.modCount , 2 , "02 - ArrayList modCount property failed."  ) ;
        }
        
        public function testAdd():void
        {
            var list:ArrayList = new ArrayList() ;
            var count:int = list.modCount ;
            assertTrue( list.add("item1") , "01 - ArrayList add method failed." ) ;
            assertEquals( list.modCount , count + 1  , "02 - ArrayList modCount property failed."  ) ;
            assertEquals( list.size() , 1 , "03 - ArrayList add method failed." ) ;
        }      

        public function testAddAll():void
        {
            var list:ArrayList = new ArrayList() ;
            var count:int = list.modCount ;
            assertTrue( list.addAll( new ArrayCollection(["item1","item2"]) ) , "01 - ArrayList addAll method failed." ) ;
            assertEquals( list.modCount , count + 3  , "02 - ArrayList addAll method failed."  ) ; // count + number of items in added in the collection + one modification == 3
            assertEquals( list.size() , 2 , "03 - ArrayList addAll method failed." ) ;
            assertFalse( list.addAll( new ArrayCollection() ) , "04 - ArrayList addAll method failed." ) ;            
            assertFalse( list.addAll(null) , "05 - ArrayList addAll method failed." ) ;
        }
        
        public function testAddAt():void
        {
            var list:ArrayList = new ArrayList([ "item1", "item2", "item3" ] ) ;
            var count:int = list.modCount ;
            list.addAt( 1 , "item4" ) ;
            assertEquals( list.modCount , count + 1  , "01 - ArrayList addAt method failed."  ) ; // count + number of items in added in the collection + one modification == 3
            assertEquals( list.size() , 4 , "02 - ArrayList addAt method failed." ) ;
            try
            {
                list.addAt(100, "value");
                fail(  "03-01 - ArrayList addAt method failed, must throw a RangeError." ) ;
            }
            catch( e:Error )
            {
                assertTrue( e is RangeError , "03-02 - ArrayList addAt method failed, must throw a RangeError.") ;
                assertEquals( e.message , "ArrayList.addAt method failed, the specified index '100' is out of bounds.", "03-03 - ArrayList addAt method failed, must throw a RangeError.") ;
            }
        }         
        
        public function testClear():void
        {
            var list:ArrayList = new ArrayList([ "item1", "item2", "item3" ] ) ;
            var count:int = list.modCount ;
            list.clear() ;
            assertEquals( list.modCount , count + 1  , "01 - ArrayList clear method failed."  ) ; 
            assertEquals( list.size() , 0 , "02 - ArrayList clear method failed." ) ;
        }     
        
        public function testClone():void
        {
            var list:ArrayList = new ArrayList([ "item1", "item2", "item3" ] ) ;
            var clone:ArrayList = list.clone() as ArrayList ;
            assertNotNull( clone , "01 - ArrayList clone method failed." ) ;
            assertEquals( list.size() , 3 , "02 - ArrayList clone method failed." ) ;
            ArrayAssert.assertEquals( list.toArray(), clone.toArray(), "03 - ArrayList clone method failed.") ;              
        }
        
        public function testEnsureCapacity():void
        {
            var list:ArrayList = new ArrayList() ;
            list.ensureCapacity( 0 ) ;
            assertEquals( list.size() , 0 , "01 - ArrayList ensureCapacity method failed." ) ;
            list.ensureCapacity( 2 ) ;
            assertEquals( list.size() , 2 , "02-01 - ArrayList ensureCapacity method failed." ) ;
            ArrayAssert.assertEquals( list.toArray(), [undefined, undefined], "02-02 - ArrayList ensureCapacity method failed.") ;
            list.ensureCapacity( 0 ) ;            
            assertEquals( list.size() , 0 , "02-01 - ArrayList ensureCapacity method failed." ) ;
            ArrayAssert.assertEquals( list.toArray(), [], "03 - ArrayList ensureCapacity method failed.") ;              
        } 
        
        public function testLastIndexOf():void
        {
            var list:ArrayList = new ArrayList( ["item1", "item2" , "item3" , "item2" , "item4" ]) ;
            assertEquals( list.lastIndexOf("item2") , 3 , "01 - ArrayList lastIndexOf method failed." ) ;            
            assertEquals( list.lastIndexOf("item2", 2) , 1 , "02 - ArrayList lastIndexOf method failed." ) ;
            assertEquals( list.lastIndexOf("item10") , -1 , "03 - ArrayList lastIndexOf method failed." ) ;
        }
        
        public function testListIterator():void
        {
            var list:ArrayList = new ArrayList( ["item1", "item2" , "item3" , "item4" ]) ;
            var it:ListIterator = list.listIterator() ;
            
            assertNotNull( it , "01 - ArrayList listIterator method failed.") ;
            
            assertTrue(it.hasNext(), "02-01 - ArrayList listIterator method failed.") ;
            assertEquals(it.next(), "item1", "02-02 - ArrayList listIterator method failed.") ;
            
            assertTrue(it.hasNext(), "03-01 - ArrayList listIterator method failed.") ;
            assertEquals(it.next(), "item2", "03-02 - ArrayList listIterator method failed.") ;

            assertTrue(it.hasPrevious(), "04-01 - ArrayList listIterator method failed.") ;
            assertEquals(it.previous(), "item2", "04-02 - ArrayList listIterator method failed.") ;

            assertTrue(it.hasPrevious(), "05-01 - ArrayList listIterator method failed.") ;
            assertEquals(it.previous(), "item1" , "05-02 - ArrayList listIterator method failed.") ;
        }
        
        public function testRemove():void
        {
            
            var list:ArrayList = new ArrayList( ["item1", "item2" , "item3" , "item4" ] ) ;
            
            var count:int = list.modCount ;
            
            assertTrue   ( list.remove("item3") , "01 - ArrayList remove method failed." ) ;
            assertEquals ( list.modCount        , count + 1  , "02 - ArrayList remove method failed."  ) ;
            assertEquals ( list.size()          , 3          , "03 - ArrayList remove method failed." ) ;
            
            assertFalse( list.remove("item10") , "04 - ArrayList remove method failed." ) ;
            
            ArrayAssert.assertEquals( list.toArray(), ["item1", "item2" ,  "item4"], "05 - ArrayList remove method failed.") ;
            
            list = new ArrayList( ["item1", null , "item2" , null , "item3"] ) ;
            
            assertTrue( list.remove(null) , "06-01 - ArrayList remove method failed." ) ;
            ArrayAssert.assertEquals( list.toArray(), ["item1", "item2" , null,  "item3"], "06-02 - ArrayList remove method failed.") ;
            
            assertTrue( list.remove(null) , "06-03 - ArrayList remove method failed." ) ;
            ArrayAssert.assertEquals( list.toArray(), ["item1", "item2" , "item3"], "06-04 - ArrayList remove method failed.") ;
            
            assertFalse(list.remove(null) , "06-05 - ArrayList remove method failed." ) ;
                                
        }
        
        public function testRemoveAt():void
        {
            var list:ArrayList ;
            
            list = new ArrayList( ["item1", "item2" , "item3" , "item4" , "item5" ] ) ; 
            
            var count:int ;
            
            count = list.modCount ;
            
            ArrayAssert.assertEquals( list.removeAt(1) , ["item2"] , "01-01 - ArrayList removeAt method failed." ) ;
            assertEquals( list.modCount    , count + 1 , "01-02 - ArrayList removeAt method failed."  ) ;
            assertEquals( list.size()      , 4         , "01-03 - ArrayList removeAt method failed." ) ;
            ArrayAssert.assertEquals( list.toArray()   , ["item1","item3","item4", "item5"] , "01-04 - ArrayList removeAt method failed." ) ;
            
            count = list.modCount ;
            
            ArrayAssert.assertEquals( list.removeAt(1,2) , ["item3","item4"] , "02-01 - ArrayList removeAt method failed." ) ;
            assertEquals( list.modCount    , count + 1 , "02-02 - ArrayList removeAt method failed."  ) ;
            assertEquals( list.size()      , 2         , "02-03 - ArrayList removeAt method failed." ) ;
            ArrayAssert.assertEquals( list.toArray()   , ["item1", "item5"] , "02-04 - ArrayList removeAt method failed." ) ;
            
        }
        
        public function testRemoveRange():void
        {
            var list:ArrayList ;
            var count:int ;
            var result:* ;
                        
            list   = new ArrayList( ["item1", "item2" , "item3" , "item4" , "item5" ] ) ; 
            count  = list.modCount ;
            result = list.removeRange(1,1) ;
            assertNull( result , "01-01 - ArrayList removeRange method failed." ) ;
            assertEquals( list.modCount    , count     , "01-02 - ArrayList removeRange method failed."  ) ;
            assertEquals( list.size()      , 5         , "01-03 - ArrayList removeRange method failed." ) ;
            ArrayAssert.assertEquals( list.toArray()   , ["item1","item2","item3","item4", "item5"] , "01-04 - ArrayList removeRange method failed." ) ;
            
            list   = new ArrayList( ["item1", "item2" , "item3" , "item4" , "item5" ] ) ; 
            count  = list.modCount ;
            result = list.removeRange(1,2) ;
            assertNotNull( result as Array             , "02-01 - ArrayList removeRange method failed." ) ;
            assertEquals( list.modCount    , count + 1 , "02-02 - ArrayList removeRange method failed."  ) ;
            assertEquals( list.size()      , 4         , "02-03 - ArrayList removeAt method failed." ) ;
            ArrayAssert.assertEquals( result           , ["item2"] , "02-04 - ArrayList removeRange method failed." ) ;
            ArrayAssert.assertEquals( list.toArray()   , ["item1","item3","item4", "item5"] , "02-05 - ArrayList removeRange method failed." ) ;         
            
            list   = new ArrayList( ["item1", "item2" , "item3" , "item4" , "item5" ] ) ; 
            count  = list.modCount ;
            result = list.removeRange(1,3) ;
            assertNotNull( result as Array             , "03-01 - ArrayList removeRange method failed." ) ;
            assertEquals( list.modCount    , count + 1 , "03-02 - ArrayList removeRange method failed."  ) ;
            assertEquals( list.size()      , 3         , "03-03 - ArrayList removeRange method failed." ) ;
            ArrayAssert.assertEquals( result           , ["item2","item3"] , "03-04 - ArrayList removeRange method failed." ) ;
            ArrayAssert.assertEquals( list.toArray()   , ["item1","item4", "item5"] , "03-05 - ArrayList removeRange method failed." ) ;    
        }
        
        public function testSet():void
        {
            var count:int ; 
            var list:ArrayList = new ArrayList( [ "item1", "item2", "item3", "item4" ] ) ;
            
            count = list.modCount ;
            assertEquals( list.set(0, "hello") , "item1" , "01-01 - ArrayList set method failed." ) ;
            ArrayAssert.assertEquals( list.toArray() , ["hello","item2","item3","item4"] , "01-02 - ArrayList set method failed." ) ;
            assertEquals( list.modCount    , count + 1 , "01-03 - ArrayList set method failed."  ) ;
            
            // set use the removeAt method
            
            count = list.modCount ;
            assertEquals( list.set(1, undefined) , "item2" , "02-01 - ArrayList set method failed." ) ;
            ArrayAssert.assertEquals( list.toArray() , ["hello","item3","item4"] , "02-02 - ArrayList set method failed." ) ;
            assertEquals( list.modCount , count + 1 , "01-03 - ArrayList set method failed."  ) ;
            
            try
            {
                list.set( 3 , "hello" ) ;
                fail("03-01 - ArrayList set method failed, must throw a RangeError.") ;
            }
            catch( e:Error )
            {
                
                assertTrue
                ( 
                    e is RangeError , 
                    "03-02 - ArrayList set method failed, must throw a RangeError."
                ) ;
                
                assertEquals
                ( 
                    e.message , 
                    "The ArrayList.set() method failed, the index '3' argument is out of the size limit." , 
                    "03-02 - ArrayList set method failed."
                ) ;
                
            }

        }

        public function testSubList():void
        {
            var sub:List ;
            var list:ArrayList = new ArrayList( [ "item1", "item2", "item3", "item4" ] ) ;
            
            sub = list.subList( 0, 0 ) as ArrayList ;
            assertNotNull(sub, "01-01 - ArrayList.subList method failed.") ;
            ArrayAssert.assertEquals( sub.toArray() , [] , "01-02 - ArrayList.subList method failed." ) ;

            sub = list.subList( 0, 1 ) as ArrayList ;
            ArrayAssert.assertEquals( sub.toArray() , ["item1"] , "02 - ArrayList.subList method failed." ) ;
            
            sub = list.subList( 0, 2 ) as ArrayList ;
            ArrayAssert.assertEquals( sub.toArray() , ["item1","item2"] , "03 - ArrayList.subList method failed." ) ;

            sub = list.subList( 0, 3 ) as ArrayList ;
            ArrayAssert.assertEquals( sub.toArray() , ["item1", "item2","item3"] , "04 - ArrayList.subList method failed." ) ;

            sub = list.subList( 0, 4 ) as ArrayList ;
            ArrayAssert.assertEquals( sub.toArray() , ["item1", "item2","item3","item4"] , "05 - ArrayList.subList method failed." ) ;

            sub = list.subList( 1, 3 ) as ArrayList ;
            ArrayAssert.assertEquals( sub.toArray() , ["item2","item3"] , "06 - ArrayList.subList method failed." ) ;

            sub = list.subList( 4, 4 ) as ArrayList ;
            ArrayAssert.assertEquals( sub.toArray() , [] , "07 - ArrayList.subList method failed." ) ;

            try
            {
                sub = list.subList( 5, 5 ) as ArrayList ;
                fail("08-01 - ArrayList subList method failed, must throw a RangeError.") ;
            }
            catch( e:Error )
            {
                
                assertTrue
                ( 
                    e is RangeError , 
                    "08-02 - ArrayList subList method failed, must throw a RangeError."
                ) ;
                
                assertEquals
                ( 
                    e.message , 
                    "The ArrayList.subList() method failed, the fromIndex '5' argument is out of the size limit." , 
                    "08-03 - ArrayList set method failed."
                ) ;
                
            }

            try
            {
                sub = list.subList( 2, 5 ) as ArrayList ;
                fail("09-01 - ArrayList subList method failed, must throw a RangeError.") ;
            }
            catch( e:Error )
            {
                
                assertTrue
                ( 
                    e is RangeError , 
                    "09-02 - ArrayList subList method failed, must throw a RangeError."
                ) ;
                
                assertEquals
                ( 
                    e.message , 
                    "The ArrayList.subList() method failed, the toIndex '5' argument is out of the size limit." , 
                    "09-03 - ArrayList set method failed."
                ) ;
                
            }

        }
        
        
    }
}
