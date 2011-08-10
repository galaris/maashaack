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
    
    import system.data.Iterator;    

    public class ArrayFieldIteratorTest extends TestCase 
    {

        public function ArrayFieldIteratorTest( name:String = "" )
        {
            super( name );
        }
        
        public var item1:Object = { label : "item1" , date : new Date(2005 , 10 , 12 ) } ;
        public var item2:Object = { label : "item2" , date : new Date(2004 , 2  , 22 ) } ;
        public var item3:Object = { label : "item3" , date : new Date(2005 , 4  , 3  ) } ;
        
        public var ar:Array = [ item1 , item2  , item3 ] ;
        public var it1:ArrayFieldIterator ;
        public var it2:ArrayFieldIterator ;
        
        public function setUp():void
        {
            it1 = new ArrayFieldIterator( ar , "label" ) ;
            it2 = new ArrayFieldIterator( ar ) ;
        }

        public function tearDown():void
        {
            it1 = undefined ;
            it2 = undefined ;
        }         
        
        public function testConstructor():void
        {
            var i:Iterator ;
            try
            {
                i = new ArrayFieldIterator(null) ;
                fail( this + "Test constructor failed if the passed-in Array is a null object.") ;     
            }
            catch( e:Error )
            {
                assertEquals( e.message , "[object ArrayFieldIterator] constructor failed, the passed-in Array argument not must be 'null'." , this + " test constructor failed.");
            }
            assertNotNull( it1 , "01 - The ArrayFieldIterator not must be null." ) ; 
            assertNotNull( it2 , "02 - The ArrayFieldIterator not must be null." ) ;
        }         

        public function testHasNext():void
        {
            assertTrue(it2.hasNext(), "01-01 hasNext method failed") ;
            it2.next() ; 
            assertTrue(it2.hasNext(), "01-02 hasNext method failed") ;
            it2.next() ; 
            assertTrue(it2.hasNext(), "01-03 hasNext method failed") ;
            it2.next() ; 
            assertFalse(it2.hasNext(), "01-04 hasNext method failed") ;
            it2.reset() ;
            
            assertTrue(it1.hasNext(), "02-01 hasNext method failed") ;
            it1.next() ; 
            assertTrue(it1.hasNext(), "02-02 hasNext method failed") ;
            it1.next() ; 
            assertTrue(it1.hasNext(), "02-03 hasNext method failed") ;
            it1.next() ; 
            assertFalse(it1.hasNext(), "02-04 hasNext method failed") ;
            it1.reset() ;
        }
    
        public function testKey():void
        {
            assertEquals(it1.key(), -1, "01-01 key() method failed") ;
            it1.next() ;
            assertEquals(it1.key(), 0, "01-02 key() method failed") ;
            it1.next() ;
            assertEquals(it1.key(), 1, "01-03 key() method failed") ;
            it1.next() ;
            assertEquals(it1.key(), 2, "01-04 key() method failed") ;
            it1.reset() ;
            
            assertEquals(it2.key(), -1, "02-01 key() method failed") ;
            it2.next() ;
            assertEquals(it2.key(), 0, "02-02 key() method failed") ;
            it2.next() ;
            assertEquals(it2.key(), 1, "02-03 key() method failed") ;
            it2.next() ;
            assertEquals(it2.key(), 2, "02-04 key() method failed") ;
            it2.reset() ;            
        }    
    
        public function testNext():void
        {
            assertEquals( it1.next() , "item1" , "01 next() method failed" ) ;
            assertEquals( it1.next() , "item2" , "02 next() method failed" ) ;
            assertEquals( it1.next() , "item3" , "03 next() method failed" ) ;
            it1.reset() ;
            
            assertEquals( it2.next() , ar[0] , "01 next() method failed" ) ;
            assertEquals( it2.next() , ar[1] , "02 next() method failed" ) ;
            assertEquals( it2.next() , ar[2] , "03 next() method failed" ) ;
            it2.reset() ;            
        }
        
        public function testRemove():void
        {
            it1.next() ;
            assertEquals( it1.remove() , item1 , "01 remove() method failed" ) ;
            assertEquals( it1.next()   , "item2" , "02 remove() method failed" ) ;
            it1.reset() ;
            assertEquals( it1.next() , "item2" , "03 remove() method failed" ) ;
            it1.reset() ;
        }           
    
        public function testReset():void
        {
            it1.next() ;
            it1.next() ;
            it1.reset() ;
            assertEquals( it1.next() , "item1" , "reset() method failed" ) ;
            it1.reset() ;
        }           
        
        public function testSeek():void
        {
            it1.seek(1) ;
            it1.next() ;
            assertEquals( it1.next() , "item3" , "seek(1) method failed" ) ;
            it1.reset() ;
        } 
    }
}
