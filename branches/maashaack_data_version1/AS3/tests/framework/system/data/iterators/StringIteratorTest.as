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
    
    import flash.errors.IllegalOperationError;    

    public class StringIteratorTest extends TestCase 
    {

        public function StringIteratorTest( name:String = "" )
        {
            super( name );
        }
        
        public var it:StringIterator ;
        
        public function setUp():void
        {
            it = new StringIterator("hello") ;
        }

        public function tearDown():void
        {
            it = undefined ;
        }            
        
        public function testConstructor():void
        {
            var i:StringIterator ;
            try
            {
                i = new StringIterator(null) ;
                fail( this + " test constructor failed if the passed-in String is a null object.") ;     
            }
            catch( e:Error )
            {
                assertEquals( e.message , "[object StringIterator] constructor failed, the passed-in String argument not must be 'null'." , this + " test constructor failed.");
            }
            assertNotNull(it, this + " the StringIterator instance not must be null") ; 
        }         

        public function testHasNext():void
        {
            assertTrue(it.hasNext(), "01 hasNext method failed") ;
            it.next() ; // h
            assertTrue(it.hasNext(), "02 hasNext method failed") ;
            it.next() ; // e
            assertTrue(it.hasNext(), "03 hasNext method failed") ;
            it.next() ; // l
            assertTrue(it.hasNext(), "04 hasNext method failed") ;
            it.next() ; // l
            assertTrue(it.hasNext(), "05 hasNext method failed") ;
            it.next() ; // o
            assertFalse(it.hasNext(), "06 hasNext method failed") ;
            it.reset() ;
        }
    
        public function testKey():void
        {
            assertEquals(it.key(), -1, "01 key() method failed") ;
            it.next() ; // h
            assertEquals(it.key(), 0, "02 key() method failed") ;
            it.next() ; // e
            assertEquals(it.key(), 1, "03 key() method failed") ;
            it.next() ; // l
            assertEquals(it.key(), 2, "04 key() method failed") ;
            it.next() ; // l
            assertEquals(it.key(), 3, "04 key() method failed") ;
            it.next() ; // o
            assertEquals(it.key(), 4, "04 key() method failed") ;
            it.reset() ;
        }    
    
        public function testNext():void
        {
            assertEquals( it.next() , "h" , "01 next() method failed" ) ;
            assertEquals( it.next() , "e" , "02 next() method failed" ) ;
            assertEquals( it.next() , "l" , "03 next() method failed" ) ;
            assertEquals( it.next() , "l" , "04 next() method failed" ) ;
            assertEquals( it.next() , "o" , "05 next() method failed" ) ;
            
            assertEquals( it.next() , "" , "06 next() method failed" ) ;
            assertEquals( it.next() , "" , "07 next() method failed" ) ;
            
            it.reset() ;
        }
        
        public function testRemove():void
        {
            it.next() ;
            try
            {
                it.remove() ;
                fail( this + " remove() failed must throws an IllegalOperationError.") ;   
            }
            catch( e:Error )
            {
            	assertTrue( e is IllegalOperationError , "remove() failed, must throws a IllegalOperationError error") ;
            }
            it.reset() ;
        }           
    
        public function testReset():void
        {
            it.next() ;
            it.next() ;
            it.reset() ;
            assertEquals( it.next() , "h" , "reset() method failed" ) ;
            it.reset() ;
        }           
        
        public function testSeek():void
        {
            
            it.seek(2) ;
            it.next() ;
            assertEquals( it.next() , "l" , "01 seek(1) method failed" ) ;
            
            it.seek(1) ;
            assertEquals( it.next() , "e" , "02 seek(1) method failed" ) ;
            
            it.reset() ;
        }        
        
    }
}
