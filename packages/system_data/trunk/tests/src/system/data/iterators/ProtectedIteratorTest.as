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
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.data.samples.IteratorClass;
    
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

