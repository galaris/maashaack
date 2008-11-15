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
  Portions created by the Initial Developers are Copyright (C) 2006-2008
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

package system.data.collections 
{
    import buRRRn.ASTUce.framework.ArrayAssert;
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.Cloneable;
    import system.Serializable;
    import system.data.Collection;
    import system.data.Iterable;
    import system.data.Iterator;
    import system.data.iterators.ArrayIterator;    

    public class SimpleCollectionTest extends TestCase
    {

        public function SimpleCollectionTest( name:String = "" )
        {
            super( name );
        }
        
        public function testConstructor():void
        {
        	
        	var c:SimpleCollection = new SimpleCollection() ;
        	
        	assertNotNull(c, "01-01 - SimpleCollection constructor failed.") ;
            ArrayAssert.assertEquals( c.toArray(), [], "01-02 - SimpleCollection constructor failed.") ;
            
            // initialize with an Array
                    	
        	var co1:SimpleCollection = new SimpleCollection([2,3,4]) ; 
        	assertNotNull(co1, "02-01 - SimpleCollection constructor failed.") ;
            ArrayAssert.assertEquals( co1.toArray(), [2,3,4], "02-02 - SimpleCollection constructor failed.") ;
        	
        	// initialize with a Collection
        	
            var co2:SimpleCollection = new SimpleCollection(co1) ; 
            assertNotNull(co2, "03-01 - SimpleCollection constructor failed.") ;
            ArrayAssert.assertEquals( co2.toArray(), [2,3,4], "03-02 - SimpleCollection constructor failed.") ;
            
        	
        }
        
        public function testInterface():void
        {
        	var c:SimpleCollection = new SimpleCollection() ;
            assertTrue( c is Collection   , "01 - SimpleCollection implements the Collection interface.") ;
            assertTrue( c is Cloneable    , "02 - SimpleCollection implements the Collection interface.") ;
            assertTrue( c is Iterable     , "03 - SimpleCollection implements the Collection interface.") ;
            assertTrue( c is Serializable , "04 - SimpleCollection implements the Collection interface.") ;
        }        
        
        public function testAdd():void
        {
            var c:SimpleCollection = new SimpleCollection() ;
            assertTrue( c.add(2)          , "01 - SimpleCollection add method failed." ) ;
            assertTrue( c.add(null)       , "02 - SimpleCollection add method failed." ) ;
            assertFalse( c.add(undefined) , "03 - SimpleCollection add method failed." ) ;
        }
        
        public function testAddAll():void
        {
        	
            // initialize with an Array
                        
            var co1:SimpleCollection = new SimpleCollection([2,3,4]) ; 
            var co2:SimpleCollection = new SimpleCollection() ;
            
            var co:SimpleCollection = new SimpleCollection() ;
            
            assertTrue( co.addAll(co1) , "01-01 - SimpleCollection addAll method failed." ) ;
            ArrayAssert.assertEquals( co.toArray(), [2,3,4], "01-02 - SimpleCollection addAll method failed.") ;   
             
            assertFalse( co.addAll(co2), "02-01 - SimpleCollection addAll method failed." ) ;
        	
        }        
        
        public function testClear():void
        {
        	
            var co:SimpleCollection = new SimpleCollection([2,3,4]) ;
            var old:int = co.size() ;
            co.clear() ; 
            assertTrue( old > co.size(), "01 - SimpleCollection clear failed.") ;
            ArrayAssert.assertEquals( co.toArray(), [], "02 - SimpleCollection clear failed.") ;
            assertTrue( co.isEmpty(), "03 - SimpleCollection clear failed.") ;        	
        	
        }
        
        public function testClone():void
        {
            
            var co:SimpleCollection = new SimpleCollection([2,3,4]) ;
            var cl:SimpleCollection = co.clone() as SimpleCollection ;
            
            assertNotNull( cl, "01 - SimpleCollection clone failed.") ;
            assertFalse( cl == co, "02 - SimpleCollection clone failed.") ;  
            ArrayAssert.assertEquals( cl.toArray(), co.toArray(), "03 - SimpleCollection clone failed.") ;   	
        }
        
        public function testContains():void
        {
            var co:SimpleCollection = new SimpleCollection() ;
            co.add("item") ;
            
            assertTrue( co.contains("item") ,  "01 - SimpleCollection contains failed.") ;
            assertFalse( co.contains("test") ,  "02 - SimpleCollection contains failed.") ;
            
        }
        
        public function testContainsAll():void
        {
        
        }        
        
        public function testGet():void
        {
            var co:SimpleCollection = new SimpleCollection() ;
            co.add("test") ;
            assertEquals( co.get(0) , "test" ,  "01 - SimpleCollection get failed.") ;
            assertUndefined( co.get(1)       ,  "02 - SimpleCollection get failed." ) ;
        }
        
        public function testIndexOf():void
        {
            var co:SimpleCollection = new SimpleCollection() ;
            co.add("item1") ;
            co.add("item2") ;
            co.add("item3") ;
            
            assertEquals( co.indexOf("item4") , -1 ,  "01 - SimpleCollection indexOf failed.") ;
            assertEquals( co.indexOf("item1") , 0  ,  "02 - SimpleCollection indexOf failed.") ;   
            assertEquals( co.indexOf("item3") , 2  ,  "03 - SimpleCollection indexOf failed.") ;
            
            assertEquals( co.indexOf("item3", 1) , 2  ,  "04 - SimpleCollection indexOf failed.") ;
                 	
        }
        
        public function testIsEmpty():void
        {
            var co:SimpleCollection = new SimpleCollection() ;
            
            assertTrue( co.isEmpty() , "01 - SimpleCollection isEmpty failed.") ;
            
            co.add("test") ;
            
            assertFalse( co.isEmpty() , "02 - SimpleCollection isEmpty failed.") ;
            
            co.remove("test") ;
            
            assertTrue( co.isEmpty() , "03 - SimpleCollection isEmpty failed.") ;
        }
        
        public function testIterator():void
        {
        	var co:SimpleCollection = new SimpleCollection() ;
        	var it:Iterator         = co.iterator() ;
        	assertTrue  ( it is ArrayIterator , "01 - SimpleCollection iterator failed." ) ;
        }        
        
        public function testRemove():void
        {
            var co:SimpleCollection = new SimpleCollection() ;
            
            co.add("item1") ;
            co.add("item2") ;
            
            assertTrue  ( co.remove("item1") , "01 - SimpleCollection remove failed." ) ;
            assertFalse ( co.remove("item5") , "02 - SimpleCollection remove failed." ) ;
                    	
        }
        
        public function testRemoveAll():void
        {
        
        }        
        
        public function testRetainAll():void
        {
        
        } 
        
        public function testSize():void
        {
            var co:SimpleCollection = new SimpleCollection() ;
            assertEquals( co.size() , 0 ,  "01 - SimpleCollection size failed.") ;                    
            co.add("test") ;
            assertEquals( co.size() , 1 ,  "02 - SimpleCollection size failed.") ;        	
        }
        
        public function testToArray():void
        {
            
            var c:SimpleCollection ;
            var a:Array ;
            
            // empty collection
            
            // initialize with an Array
                        
            c = new SimpleCollection() ;
            a = c.toArray() ;
            
            assertNotNull( a , "01-02 - SimpleCollection toArray failed.") ;
            ArrayAssert.assertEquals( a , [], "01-02 - SimpleCollection toArray failed.") ;            
            
            c.add(2) ;
            c.add(3) ;
            c.add(4) ; 
            
            a = c.toArray() ;
            
            assertNotNull( a , "02-02 - SimpleCollection constructor failed.") ;
            ArrayAssert.assertEquals( a , [2,3,4], "02-02 - SimpleCollection constructor failed.") ;
  	
        }
                        
        public function testToSource():void
        {
        	var co:SimpleCollection ;
        	var ar:Array = ["item1", "item2"] ;
        	
        	co = new SimpleCollection() ;
            assertEquals(co.toSource() , "new system.data.collections.SimpleCollection()" ) ;
        	
            co = new SimpleCollection( ar ) ;
            assertEquals(co.toSource() , "new system.data.collections.SimpleCollection([\"item1\",\"item2\"])" ) ;
        }
        
        public function testToString():void
        {
            var ar:Array = ["item1", "item2", "item3", "item4"] ;
            var co:SimpleCollection = new SimpleCollection( ar ) ;
            assertEquals(co.toString() , "{item1,item2,item3,item4}", "SimpleCollection toString failed") ;
        }        
        
    }
}
