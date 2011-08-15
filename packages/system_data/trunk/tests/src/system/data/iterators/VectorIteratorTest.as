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
    import library.ASTUce.framework.TestCase;
    
    import system.data.Iterator;
    
    public class VectorIteratorTest extends TestCase 
    {
        public function VectorIteratorTest( name:String = "" )
        {
            super( name );
        }
        
        public var iterator:Iterator ;
        
        public var vector:Vector.<String> ; 
        
        public function setUp():void
        {
            vector   = new Vector.<String>() ;
            
            vector[0] = "item1" ;
            vector[1] = "item2" ;
            vector[2] = "item3" ;
            
            iterator = new VectorIterator( vector ) ;
        }
        
        public function tearDown():void
        {
            iterator = null ;
            vector   = null ;
        }
        
        public function testConstructor():void
        {
            assertNotNull(iterator, this + " the VectorIterator not must be null") ; 
        }
        
        public function testConstructorWithNullArgument():void
        {
            var i:Iterator ;
            try
            {
                i = new VectorIterator(null) ;
                fail( this + " test constructor failed if the passed-in Vector is a null object.") ;
            }
            catch( e:Error )
            {
                assertEquals( e.message , "[object VectorIterator] constructor failed, the passed-in Vector argument not must be 'null'." , this + " test constructor failed.");
            }
            assertNotNull(iterator, this + " the VectorIterator not must be null") ; 
        }
        
        public function testConstructorWithNoVectorArgument():void
        {
            var i:Iterator ;
            try
            {
                i = new VectorIterator( "hello" ) ;
                fail( this + " test constructor failed if the passed-in argument type is not 'Vector'.") ;
            }
            catch( e:Error )
            {
                assertEquals( e.message , "[object VectorIterator] constructor failed, the passed-in Vector argument must be a 'Vector' object." , this + " test constructor failed.");
            }
        }
        
        public function testHasNext():void
        {
            assertTrue(iterator.hasNext(), "01 hasNext method failed") ;
            iterator.next() ; // item1
            assertTrue(iterator.hasNext(), "02 hasNext method failed") ;
            iterator.next() ; // item2
            assertTrue(iterator.hasNext(), "03 hasNext method failed") ;
            iterator.next() ; // item3
            assertFalse(iterator.hasNext(), "04 hasNext method failed") ;
        }
        
        public function testKey():void
        {
            assertEquals(iterator.key(), 0, "01 - key() method failed") ;
            iterator.next() ; // item1
            assertEquals(iterator.key(), 1, "02 - key() method failed") ;
            iterator.next() ; // item2
            assertEquals(iterator.key(), 2, "03 - key() method failed") ;
            iterator.next() ; // item3
            assertEquals(iterator.key(), 3, "04 - key() method failed") ;
        }
        
        public function testNext():void
        {
            assertEquals( iterator.next() , "item1" , "01 next() method failed" ) ;
            assertEquals( iterator.next() , "item2" , "02 next() method failed" ) ;
            assertEquals( iterator.next() , "item3" , "03 next() method failed" ) ;
        }
        
        public function testRemove():void
        {
            iterator.next() ;
            var result:* = iterator.remove() ; 
            assertEquals( result , "item1" , "01 - remove() method failed" ) ;
            assertEquals( iterator.next()   , "item2" , "02 - remove() method failed" ) ;
            iterator.reset() ;
            assertEquals( iterator.next() , "item2" , "03 - remove() method failed" ) ;
        }
        
        public function testReset():void
        {
            iterator.next() ;
            iterator.next() ;
            iterator.reset() ;
            assertEquals( iterator.next() , "item1" , "reset() method failed" ) ;
        }
        
        public function testSeek():void
        {
            iterator.seek(1) ;
            assertEquals( iterator.next() , "item2" , "seek(1) method failed" ) ;
        } 
    }
}
