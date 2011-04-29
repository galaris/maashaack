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
            o  = undefined ;
            it = undefined ;
        }         
        
        public function testConstructor():void
        {
            var i:Iterator ;
            try
            {
                i = new ObjectIterator(null) ;
                fail( this + " test constructor failed if the passed-in Object is a null object.") ;     
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
            assertTrue( r == "x" || r == "y" , "remove() method failed" ) ;
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
            var r:* = i.next() ;
            assertTrue( r == 200 || r == 100 , "seek(1) method failed" ) ;
            it.reset() ;
        }        
        
    }
}
