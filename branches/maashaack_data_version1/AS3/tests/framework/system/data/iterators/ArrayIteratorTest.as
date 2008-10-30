/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [MaasHaack framework]
  
  The Initial Developer of the Original Code is
  Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  
*/

package system.data.iterators 
{
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.data.Iterator;    

    public class ArrayIteratorTest extends TestCase 
    {

        public function ArrayIteratorTest( name:String = "" )
        {
            super( name );
        }
        
        public var ar:Array = ["item1", "item2", "item3"] ;
        
        public var it:Iterator ;
        
        public function setUp():void
        {
            it = new ArrayIterator(ar) ;
        }

        public function tearDown():void
        {
            it = undefined ;
        }         
        
        public function testConstructor():void
        {
        	var i:Iterator ;
            try
            {
                i = new ArrayIterator(null) ;
                fail( this + " test constructor failed if the passed-in Array is a null object.") ;  	
            }
            catch( e:Error )
            {
            	assertEquals( e.message , "[object ArrayIterator] constructor failed, the passed-in Array argument not must be 'null'." , this + " test constructor failed.");
            }
            assertNotNull(it, this + " the ArrayIterator not must be null") ; 
        }         

        public function testHasNext():void
        {
            assertTrue(it.hasNext(), "01 hasNext method failed") ;
            it.next() ; // item1
            assertTrue(it.hasNext(), "02 hasNext method failed") ;
            it.next() ; // item2
            assertTrue(it.hasNext(), "03 hasNext method failed") ;
            it.next() ; // item3
            assertFalse(it.hasNext(), "04 hasNext method failed") ;
            it.reset() ;
        }
    
        public function testKey():void
        {
            assertEquals(it.key(), -1, "01 key() method failed") ;
            it.next() ; // item1
            assertEquals(it.key(), 0, "02 key() method failed") ;
            it.next() ; // item2
            assertEquals(it.key(), 1, "03 key() method failed") ;
            it.next() ; // item3
            assertEquals(it.key(), 2, "04 key() method failed") ;
            it.reset() ;
        }    
    
        public function testNext():void
        {
            assertEquals( it.next() , "item1" , "01 next() method failed" ) ;
            assertEquals( it.next() , "item2" , "02 next() method failed" ) ;
            assertEquals( it.next() , "item3" , "03 next() method failed" ) ;
            it.reset() ;
        }
        
        public function testRemove():void
        {
        	it.next() ;
        	var result:* = it.remove() ; 
            assertEquals( result , "item1" , "01 remove() method failed" ) ;
            assertEquals( it.next()   , "item2" , "02 remove() method failed" ) ;
            it.reset() ;
            assertEquals( it.next() , "item2" , "03 remove() method failed" ) ;
            it.reset() ;
        }           
    
        public function testReset():void
        {
            it.next() ;
            it.next() ;
            it.reset() ;
            assertEquals( it.next() , "item1" , "reset() method failed" ) ;
            it.reset() ;
        }           
        
        public function testSeek():void
        {
            it.seek(1) ;
            it.next() ;
            assertEquals( it.next() , "item3" , "seek(1) method failed" ) ;
            it.reset() ;
        } 
        
    }
}
