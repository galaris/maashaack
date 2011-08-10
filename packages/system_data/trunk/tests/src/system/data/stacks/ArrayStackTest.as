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

package system.data.stacks 
{
    import buRRRn.ASTUce.framework.ArrayAssert;
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.Cloneable;
    import system.Equatable;
    import system.Serializable;
    import system.data.Collection;
    import system.data.Iterable;
    import system.data.Stack;
    import system.data.maps.ArrayMap;    

    public class ArrayStackTest extends TestCase 
    {

        public function ArrayStackTest(name:String = "")
        {
            super( name );
        }
        
        public function testConstructor():void
        {
            var s:ArrayStack = new ArrayStack() ;
            
            assertNotNull(s, "01-01 - ArrayStack constructor failed.") ;
            ArrayAssert.assertEquals( s.toArray(), [], "01-02 - ArrayStack constructor failed.") ;
            
            // initialize with an Array
                        
            var s1:ArrayStack = new ArrayStack([2,3,4]) ; 
            assertNotNull(s1, "02-01 - ArrayStack constructor failed.") ;
            ArrayAssert.assertEquals( s1.toArray(), [2,3,4], "02-02 - ArrayStack constructor failed.") ;
            
            // initialize with a Collection
            
            var s2:ArrayStack = new ArrayStack(s1) ; 
            assertNotNull(s2, "03-01 - ArrayStack constructor failed.") ;
            ArrayAssert.assertEquals( s2.toArray(), [2,3,4], "03-02 - ArrayStack constructor failed.") ;
            
            // initialize with an Iterable object
            
            s = new ArrayStack(new ArrayMap(["key1","key2","key3"],["value1","value2","value3"])) ; 
            assertNotNull(s, "04-01 - ArrayStack constructor failed.") ;
            ArrayAssert.assertEquals( s.toArray(), ["value1","value2","value3"], "04-02 - ArrayStack constructor failed.") ;
                        
            
        }
         
        public function testInterface():void
        {
            var c:ArrayStack = new ArrayStack() ;
            assertTrue( c is Collection   , "01 - ArrayStack implements the Collection interface.") ;
            assertTrue( c is Cloneable    , "02 - ArrayStack implements the Cloneable interface.") ;
            assertTrue( c is Equatable    , "03 - ArrayStack implements the Equatable interface.") ;
            assertTrue( c is Iterable     , "04 - ArrayStack implements the Iterable interface.") ;
            assertTrue( c is Serializable , "05 - ArrayStack implements the Serializable interface.") ;
            assertTrue( c is Stack        , "05 - ArrayStack implements the Stack interface.") ;
        }            
                
        public function testClone():void 
        {
            var co:ArrayStack = new ArrayStack() ;
            
            co.push( 2 ) ;
            co.push( 3 ) ;
            co.push( 4 ) ;
            
            var cl:ArrayStack = co.clone() as ArrayStack ;
            
            assertNotNull( cl, "01 - ArrayStack clone failed.") ;
            assertFalse( cl == co, "02 - ArrayStack clone failed.") ;  
            
            ArrayAssert.assertEquals( cl.toArray(), co.toArray(), "03 - ArrayStack clone failed.") ; 
        }        
        
        public function testPeek():void
        {
            var s:ArrayStack = new ArrayStack() ;
            
            s.push( 2 ) ;
            s.push( 3 ) ;
            s.push( 4 ) ;
            
            assertEquals( s.peek(), 4, "01 - ArrayStack peek failed.") ;
            
            s.pop() ;
            
            assertEquals( s.peek(), 3, "02 - ArrayStack peek failed.") ;
            
        }
        
        public function testPop():void
        {
            var s:ArrayStack = new ArrayStack() ;
            
            s.push( 2 ) ;
            s.push( 3 ) ;
            s.push( 4 ) ;
            
            assertEquals( s.pop()  , 4 , "01-01 - ArrayStack pop failed.") ;
            assertEquals( s.size() , 2 , "01-02 - ArrayStack pop failed.") ;
            
            assertEquals( s.pop()  , 3 , "02-01 - ArrayStack pop failed.") ;
            assertEquals( s.size() , 1 , "02-02 - ArrayStack pop failed.") ;
            
            assertEquals( s.pop()  , 2 , "03-01 - ArrayStack pop failed.") ;
            assertEquals( s.size() , 0 , "03-02 - ArrayStack pop failed.") ;
            
        }
        
        public function testPush():void
        {
            var s:ArrayStack = new ArrayStack() ;
            
            s.push( 2 ) ;
            
            ArrayAssert.assertEquals( s.toArray(), [2], "01 - ArrayStack push failed.") ;
            
            s.push( 3 ) ;
            
            ArrayAssert.assertEquals( s.toArray(), [2,3], "01 - ArrayStack push failed.") ;
            
            s.push( 4 ) ;
            
            ArrayAssert.assertEquals( s.toArray(), [2,3,4], "01 - ArrayStack push failed.") ;
            
        }
        
        public function testSearch():void
        {
            var s:ArrayStack = new ArrayStack() ;
            
            s.push("item1") ;
            s.push("item2") ;
            s.push("item3") ;
            
            assertEquals( s.search("item4") , -1 ,  "01 - ArrayStack search failed.") ;
            assertEquals( s.search("item1") ,  0 ,  "02 - ArrayStack search failed.") ;   
            assertEquals( s.search("item3") ,  2 ,  "03 - ArrayStack search failed.") ;

                    
        }

        public function testToArray():void 
        {
            var s:ArrayStack = new ArrayStack([2,3,4]) ; 
            ArrayAssert.assertEquals( s.toArray(), [2,3,4], "ArrayStack toArray failed.") ;
        }
        
        public function testToSource():void
        {
            var s:ArrayStack ;
            var a:Array = ["item1", "item2"] ;
            
            s = new ArrayStack() ;
            assertEquals(s.toSource() , "new system.data.stacks.ArrayStack()" , "01 - ArrayStack toSource failed") ;
            
            s = new ArrayStack( a ) ;
            assertEquals(s.toSource() , "new system.data.stacks.ArrayStack([\"item1\",\"item2\"])" , "02 - ArrayStack toSource failed") ;
        }
        
        public function testToString():void
        {
            var a:Array = ["item1", "item2", "item3", "item4"] ;
            var s:ArrayStack = new ArrayStack( a ) ;
            assertEquals(s.toString() , "{item1,item2,item3,item4}", "ArrayStack toString failed") ;
        }          
         
        
    }
}
