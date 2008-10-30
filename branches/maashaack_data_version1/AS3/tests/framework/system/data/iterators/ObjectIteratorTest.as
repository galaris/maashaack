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

    public class ObjectIteratorTest extends TestCase 
    {

        public function ObjectIteratorTest( name:String = "" )
        {
            super( name );
        }
        
        public var o:Object ;
        
        public var it:ObjectIterator ;
        
        public function setUp():void
        {
        	o  = { x:10 , y:20 } ; 
            it = new ObjectIterator(o) ;
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
                i = new ObjectIterator(null) ;
                fail( this + " test constructor failed if the passed-in Array is a null object.") ;     
            }
            catch( e:Error )
            {
                assertEquals( e.message , "[object ObjectIterator] constructor failed, the passed-in Object argument not must be 'null'." , this + " test constructor failed.");
            }
            assertNotNull(it, this + " the ObjectIterator not must be null") ; 
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
            assertTrue(it.key() == "x" || "y" , "01 key() method failed") ;
            
            it.next() ; 
            assertTrue(it.key() == "x" || "y" , "02 key() method failed") ;
            
            it.reset() ;
        }    
    
        public function testNext():void
        {
        	var r:* ;
        	r = it.next() ;
            assertTrue( r == 10 || r == 20 , "01 next() method failed" ) ;
            r = it.next() ;
            assertTrue( r == 10 || r == 20 , "01 next() method failed" ) ;
            it.reset() ;
        }
        
        public function testRemove():void
        {
        	var v:Object         = { x:100 , y : 200} ;
        	var i:ObjectIterator = new ObjectIterator( v ) ;
            i.next() ;
            var r:* = i.remove() ; 
            assertTrue( r == "x" , "remove() method failed" ) ;
            it.reset() ;
        }           
    
        public function testReset():void
        {
            it.next() ;
            it.reset() ;
            var r:* = it.index() ;
            assertEquals( r , -1 , "reset() method failed" ) ;
        }           
        
        public function testSeek():void
        {
            var v:Object         = { x:100 , y : 200} ;
            var i:ObjectIterator = new ObjectIterator( v ) ;        	
            i.seek(1) ;
            assertEquals( i.next() , 200 , "seek(1) method failed" ) ;
            it.reset() ;
        }        
        
    }
}
