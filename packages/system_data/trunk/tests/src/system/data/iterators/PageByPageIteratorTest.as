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
    import buRRRn.ASTUce.framework.ArrayAssert;
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.data.Iterator;
    import system.data.OrderedIterator;
    
    import flash.errors.IllegalOperationError;
    
    public class PageByPageIteratorTest extends TestCase 
    {
        public function PageByPageIteratorTest( name:String = "" )
        {
            super( name );
        }
        
        public var i:PageByPageIterator ;
        
        public function setUp():void
        {
            i = new PageByPageIterator([1,2,3,4,5,6], 2) ;
        }
        
        public function tearDown():void
        {
            i = undefined ;
        }
        
        public function testConstructor():void
        {
            var it:PageByPageIterator ;
            
            assertNotNull( i , "01 - constructor failed, the instance not must be null." ) ;
            
            try
            {
                it = new PageByPageIterator(null) ;
                fail("02-01 - The PageByPageIterator constructor first argument (Array) not must be null.") ;
            }
            catch( e:Error )
            {
                assertTrue( e is IllegalOperationError , "02-02 - PageByPageIterator constructor failed." ) ;
                assertEquals
                ( 
                   e.message , 
                   "PageByPageIterator constructor failed, data length not must be empty" ,
                   "02-03 - PageByPageIterator constructor failed." 
                ) ;
            }
            
            try
            {
                it = new PageByPageIterator([]) ;
                fail("03-01 The PageByPageIterator constructor first argument (Array) not must be empty.") ;
            }
            catch( e:Error )
            {
                assertTrue( e is IllegalOperationError , "03-02 - PageByPageIterator constructor failed." ) ;
                assertEquals
                ( 
                   e.message , 
                   "PageByPageIterator constructor failed, data length not must be empty" ,
                   "03-03 - PageByPageIterator constructor failed." 
                ) ;
            } 
            
            it = new PageByPageIterator([2,3,4], 0) ;
            assertEquals( it.getStepSize() , PageByPageIterator.DEFAULT_STEP, "04-01 - constructor failed." ) ;
            
            it = new PageByPageIterator([2,3,4], 1) ;
            assertEquals( it.getStepSize() , PageByPageIterator.DEFAULT_STEP, "04-02 - constructor failed." ) ;
            
            it = new PageByPageIterator([2,3,4], 2) ;
            assertEquals( it.getStepSize() , 2, "04-03 - constructor failed." ) ;
        }
        
        public function testInterface():void
        {
            assertTrue( i is Iterator        , "The instance must implements the Iterator interface") ;
            assertTrue( i is OrderedIterator , "The instance must implements the OrderedIterator interface") ;
        }
        
        public function testDEFAULT_STEP():void
        {
            assertEquals( PageByPageIterator.DEFAULT_STEP, 1, "The PageByPageIterator.DEFAULT_STEP value isn't valid.") ;     
        }
        
        public function testCurrent():void
        {
            var it:PageByPageIterator = new PageByPageIterator( [1,2,3,4,5,6] , 2 ) ;
            assertUndefined( it.current() , "01 - current failed." ) ;
            it.next() ;
            ArrayAssert.assertEquals( it.current() , [1,2], "02 - current failed." ) ;
            it.seek(3) ;
            ArrayAssert.assertEquals( it.current() , [5,6], "03 - current failed." ) ;
            it.previous() ;
            ArrayAssert.assertEquals( it.current() , [3,4], "04 - current failed." ) ;
        }
        
        public function testCurrentPage():void
        {
            var it:PageByPageIterator = new PageByPageIterator( [1,2,3,4,5,6] , 2 ) ;
            assertEquals( it.currentPage() , 0, "01 - currentPage failed." ) ;
            it.next() ;
            assertEquals( it.currentPage() , 1, "02 - currentPage failed." ) ;
        }
        
        public function testGetStepSize():void
        {
            var it:PageByPageIterator ;
            
            it = new PageByPageIterator( [1,2,3,4,5,6] , 2 ) ;
            assertEquals( it.getStepSize() , 2, "01 - getStepSize() failed." ) ;
            
            it = new PageByPageIterator( [1,2,3,4,5,6]) ;
            assertEquals( it.getStepSize() , PageByPageIterator.DEFAULT_STEP, "02 - getStepSize() failed." ) ;
        }
        
        public function testHasNext():void
        {
            var it:PageByPageIterator = new PageByPageIterator( [1,2,3,4,5,6] , 2) ;
            assertTrue( it.hasNext() , "hasNext() failed : " + it.hasNext() ) ;
        }
        
        public function testHasPrevious():void
        {
            var it:PageByPageIterator = new PageByPageIterator( [1,2,3,4,5,6] , 2) ;
            
            assertFalse( it.hasPrevious() , "01 - hasPrevious() failed." ) ;
            
            it.next() ; it.next() ;
            
            assertTrue( it.hasPrevious() , "02 - hasPrevious() failed." ) ;
        }
        
        public function testKey():void
        {        
            var it:PageByPageIterator = new PageByPageIterator( [1,2,3,4,5,6] , 2) ;
            assertEquals( it.key() , 0, "01 -key() failed." ) ;
            it.next() ;
            assertEquals( it.key() , 1, "02 - key() failed." ) ;
        }
        
        public function testFirstPage():void
        {
            var it:PageByPageIterator = new PageByPageIterator( [1,2,3,4,5,6] , 2 ) ;
            it.firstPage() ;
            assertEquals( it.key() , 1, "01 - firstPage() failed." ) ;
            ArrayAssert.assertEquals( it.current() , [1,2], "02 - firstPage() failed." ) ;
        }
        
        public function testLastPage():void
        {
            var it:PageByPageIterator = new PageByPageIterator( [1,2,3,4,5,6] , 2 ) ;
            it.lastPage() ;
            assertEquals( it.key() , 3, "lastPage() failed." ) ;
        }
        
        public function testNext():void
        {
            var it:PageByPageIterator ;
            
            ArrayAssert.assertEquals( i.next() , [1,2], "01 : next() failed." ) ;
            ArrayAssert.assertEquals( i.next() , [3,4], "02 - next() failed." ) ;
            ArrayAssert.assertEquals( i.next() , [5,6], "03 - next() failed." ) ;
            
            i.reset() ;
            
            it = new PageByPageIterator( [1,2,3,4,5,6] ) ;
            
            assertEquals  ( it.next() , 1, "04 : next() failed." ) ;
        }
        
        public function testPageCount():void
        {
            assertEquals( i.pageCount() , 3, "pageCount() method failed.") ;
        }
        
        public function testPrevious():void
        {
            i.lastPage() ;
            ArrayAssert.assertEquals ( i.previous() , [3,4] , "01 - previous() failed." ) ;
            ArrayAssert.assertEquals  ( i.previous() , [1,2], "03 - previous() failed." ) ;
            i.reset() ;
            
            var it:PageByPageIterator = new PageByPageIterator( [1,2,3,4,5,6] ) ;
            it.lastPage() ;
            assertEquals ( it.previous() , 5, "04 - previous() failed." ) ;
        }
        
        public function testRemove():void
        {
             var it:PageByPageIterator = new PageByPageIterator( [1,2,3] , 2 ) ;
             try
             {
                it.remove() ;
                fail("PageByPageIterator.remove() method failed, must throw an IllegalOperationError object.") ;
                    
             }
             catch(e:Error)
             {
                 assertTrue(e is IllegalOperationError, "PageByPageIterator.remove() method failed, must throw an IllegalOperationError object.") ;
                 assertEquals(e.message, "The PageByPageIterator remove method is unsupported.", "PageByPageIterator.remove() method failed, must throw an IllegalOperationError object.") ;
             }
            
        }
        
        public function testReset():void
        {
            i.next() ;
            i.next() ;
            i.reset() ;
            assertEquals ( i.key() , 0, "01 - reset() failed." ) ;
            ArrayAssert.assertEquals ( i.next() , [1,2], "02 - reset() failed." ) ;
            i.reset() ;
        }
        
        public function testSeek():void
        {
            i.seek(1) ;
            ArrayAssert.assertEquals ( i.next() , [3,4], "seek() failed." ) ;
        }
    }
}
