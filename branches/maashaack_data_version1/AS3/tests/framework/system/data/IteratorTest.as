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

package system.data 
{
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.data.Iterator;
    import system.data._facks.IteratorClass;    

    public class IteratorTest extends TestCase 
    {

        public function IteratorTest( name:String = "" )
        {
            super( name );
        }

        public var i:IteratorClass ;
        
        public function setUp():void
        {
            i = new IteratorClass() ;
        }

        public function tearDown():void
        {
            i = undefined ;
        }            
        
        public function testInterface():void
        {
            assertTrue( i is Iterator ) ;
        }
        
        public function testHasNext():void
        {
            assertTrue( i.hasNext() , "test Iterator interface failed with the hasNext method." ) ;
        }
        
        public function testKey():void
        {
            assertEquals( i.key() , "key" , "test Iterator interface failed with the key method." ) ;
        }
        
        public function testNext():void
        {
            assertEquals( i.next() , "next" , "test Iterator interface failed with the next method." ) ;
        }
        
        public function testRemove():void 
        {
            assertEquals( i.remove() , "remove" , "test Iterator interface failed with the remove method." ) ;
        }
        
        public function testReset():void
        {    
            try
            {
            	i.reset() ;
            	fail( "01 - test Iterator interface failed with the reset method." ) ;           	
            }
            catch( e:Error )
            {
                assertEquals( e.message , "reset" , "01 - test Iterator interface failed with the reset method." ) ;
            }
        }
        
        public function testSeek():void
        {
            try
            {
                i.seek(10) ;
                fail( "02 - test Iterator interface failed with the seek method." ) ;               
            }
            catch( e:Error )
            {
                assertEquals( e.message , "seek:10" , "02 - test Iterator interface failed with the seek method." ) ;
            }
        }         
        
    }
}