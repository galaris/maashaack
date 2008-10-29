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

    public class ProtectedIteratorTest extends TestCase 
    {

        public function ProtectedIteratorTest( name:String = "" )
        {
            super( name );
        }
        
        public var it:ProtectedIterator ;
        
        public function setUp():void
        {
            it = new ProtectedIterator( new IteratorClass() ) ;
        }

        public function tearDown():void
        {
            it = undefined ;
        }         
        
        public function testConstructor():void
        {
        	try
        	{
        		new ProtectedIterator(null) ;
        		fail( "The ProtectedIterator constructor not support a null argument and must throws an ArgumentError.") ;
        	}
        	catch(e:Error)
        	{
                assertTrue( e is ArgumentError , "ProtectedIterator constructor must throws an ArgumentError") ;
                assertEquals( e.message, "ProtectedIterator constructor don't support a null iterator in argument." , "The message in the ArgumentError isn't valid.") ;
        	}
        }         

        public function testHasNext():void
        {
        	assertTrue( it.hasNext() , "ProtectedIterator.hasNext() method failed." ) ;
        }

        public function testKey():void
        {
        	assertEquals( it.key() , "key" , "ProtectedIterator.key() method failed." ) ;
        }    
    
        public function testNext():void
        {
        	assertEquals( it.next() , "next" , "ProtectedIterator.next() method failed." ) ;
        }
        
        public function testRemove():void
        {
        	try
        	{
        		it.remove() ;
        		fail( "ProtectedIterator.remove method must throw an IllegalOperationError.") ;
        	}
        	catch( e:Error )
        	{
        		assertTrue( e is IllegalOperationError , "ProtectedIterator.remove method must throw an IllegalOperationError.") ;
                assertEquals( e.message, "This Iterator does not support the remove() method." , "The message in the IllegalOperationError isn't valid.") ;
        	}
        }           
    
        public function testReset():void
        {
            try
            {
                it.reset() ;
                fail( "ProtectedIterator.reset method must throw an IllegalOperationError.") ;
            }
            catch( e:Error )
            {
                assertTrue( e is IllegalOperationError , "ProtectedIterator.reset method must throw an IllegalOperationError.") ;
                assertEquals( e.message, "This Iterator does not support the reset() method." , "The message in the IllegalOperationError isn't valid.") ;
            }        	
        }           
        
        public function testSeek():void
        {
            try
            {
                it.seek(0) ;
                fail( "ProtectedIterator.seek method must throw an IllegalOperationError.") ;
            }
            catch( e:Error )
            {
                assertTrue( e is IllegalOperationError , "ProtectedIterator.seek method must throw an IllegalOperationError.") ;
                assertEquals( e.message, "This Iterator does not support the seek() method." , "The message in the IllegalOperationError isn't valid.") ;
            }           	
        }        
        
    }
}

import system.data.Iterator;

class IteratorClass implements Iterator
{

    public function IteratorClass()
    {
    }

    public function hasNext():Boolean
    {
        return true ;
    }
    
    public function key():*
    {
        return "key" ;
    }
    
    public function next():*
    {
        return "next" ;
    }
    
    public function remove():*
    {
        return "remove" ;
    }
    
    public function reset():void
    {
        throw new Error("reset") ;
    }
    
    public function seek(position:*):void
    {
        throw new Error( "seek:" + position ) ;
    }
}
