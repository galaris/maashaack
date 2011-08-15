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
    import library.ASTUce.framework.TestCase;
    
    import system.data.Iterator;
    import system.data.Stack;
    import system.data.Typeable;
    import system.data.Validator;    

    public class TypedStackTest extends TestCase 
    {

        public function TypedStackTest(name:String = "")
        {
            super( name );
        }
        
        // test constructor
        
        public function testConstructorBasic():void
        {
            var s:Stack = new ArrayStack() ;
            var t:TypedStack = new TypedStack( String , s ) ;
            assertNotNull(t, "TypedStack constructor failed.") ;
        }
        
        public function testConstructorTypeArgument():void
        {
            var s:Stack = new ArrayStack() ;
            var t:TypedStack  ;
            
            t = new TypedStack( String , s ) ;
            assertEquals( t.type , String , "01 - TypedStack constructor failed with a specific type argument in this constructor.") ;

            t = new TypedStack( null , s ) ;
            assertNull( t.type , "02 - TypedStack constructor failed with a specific type argument in this constructor.") ;

            t = new TypedStack( [] , s ) ; // 
            assertNull( t.type , "03 - TypedStack constructor failed with a specific type argument in this constructor, other type, must use a Class or a Function value.") ;
        }
        
        public function testConstructorStackArgument():void
        {
            var s:Stack = new ArrayStack() ;
            var t:TypedStack  ;  
            
            // 01 - test "stack" argument is null
            try
            {
                t = new TypedStack( String, null ) ;
                fail( "01-01 - TypedStack constructor failed." ) ;
            }
            catch( e:Error )
            {
                assertTrue( e is ArgumentError , "01-02 - TypedStack constructor failed." ) ;
                assertEquals( e.message , "The passed-in 'stack' argument not must be 'null' or 'undefined'.", "01-03 - TypedStack constructor failed." ) ;
            }           
                        
            // 02 - basic test with a no empty Collection
            
            s.push("item1") ;
            s.push("item2") ;
            
            t = new TypedStack( String , s ) ;
            assertNotNull(t, "02-01 - TypedStack constructor failed with a no empty collection of String values.") ;          
            assertEquals(t.size(), s.size() , "02-02 - TypedStack constructor failed with a no empty stack of String values.") ;
            
            // 03 - test "stack" argument contains an invalid value
            
            s.clear() ;
            s.push( 1 ) ;
            try
            {
                t = new TypedStack( String, s ) ;
                fail( "03-01 - TypedStack constructor failed." ) ;
            }
            catch( e:Error )
            {
                assertTrue( e is TypeError , "03-02 - TypedStack constructor failed." ) ;
                assertEquals( e.message , "TypedStack.validate(1) is mismatch.", "03-03 - TypedStack constructor failed." ) ;
            }
        }
        
        public function testInterface():void
        {
            var s:Stack      = new ArrayStack() ;
            var t:TypedStack = new TypedStack( String , s ) ;
            assertTrue( t is Stack      , "01 - The TypedStack class must implement the Stack interface." ) ;
            assertTrue( t is Typeable   , "02 - The TypedStack class must implement the Typeable interface." ) ;
            assertTrue( t is Validator  , "03 - The TypedStack class must implement the Validator interface." ) ;
        } 
        
        // test methods and attributes

        public function testType():void
        {
            var s:Stack      = new ArrayStack() ;
            var t:TypedStack = new TypedStack( String , s ) ;
            
            assertEquals( t.type , String , "01-01 - The TypedStack type property failed." ) ;
            
            t.push("item1") ;
            t.push("item2") ;
            
            t.type = String ;
            assertEquals( t.type   , String , "01-02 - The TypedStack type property failed." ) ;
            assertEquals( t.size() , 0 , "01-03 - The TypedStack type property failed, not must clean the stack." ) ;
            
            t.type = Number ;
            assertEquals( t.type , Number , "02-01 - The TypedStack type property failed." ) ;
            assertEquals( t.size() , 0 , "02-02 - The TypedStack type property failed, must clean the stack." ) ;
            t.clear() ;
            
            var clazz:Function = function():void {} ;
            t.type = clazz ;
            assertEquals( t.type , clazz , "03 - The TypedStack type property failed." ) ;
            
            t.type = null ;
            assertNull( t.type , "04 - The TypedStack type property failed." ) ;            

            t.type = 2 ;
            assertNull( t.type , "05 - The TypedStack type property failed." ) ; 
            
        }          
        
        public function testClear():void
        {
            var s:Stack      = new ArrayStack(["item1", "item2"]) ;
            var t:TypedStack = new TypedStack( String , s ) ;
            t.clear() ;
            assertEquals( t.size() , 0 , "01 - The TypedStack clear method failed." ) ;
            assertEquals( s.size() , 0 , "02 - The TypedStack clear method failed." ) ;
        }        
        
        public function testClone():void
        {
            var s:Stack      = new ArrayStack(["item1", "item2"]) ;
            var t:TypedStack = new TypedStack( String , s ) ;
            var clone:TypedStack = t.clone() as TypedStack ;
            assertNotNull( clone , "01 - The TypedStack clone method failed." ) ;
            assertEquals( t.size() , clone.size() , "02 - The TypedStack clone method failed." ) ;
        }         
        
        public function testIsEmpty():void
        {
            var s:Stack      = new ArrayStack(["item1", "item2"]) ;
            var t:TypedStack = new TypedStack( String , s ) ;
            assertFalse(t.isEmpty() , "01 - The TypedStack isEmpty method failed." ) ;     
            t.clear() ;
            assertTrue(t.isEmpty() , "02 - The TypedStack isEmpty method failed." ) ;
        } 
        
        public function testIterator():void
        {
            var s:Stack      = new ArrayStack(["item1", "item2"]) ;
            var t:TypedStack = new TypedStack( String , s ) ;
            var it:Iterator = t.iterator() ;
            assertNotNull( it, "The TypedStack iterator method failed." ) ;     
        }          
        
        public function testPeek():void
        {
            var s:Stack      = new ArrayStack() ;
            var t:TypedStack = new TypedStack( String , s ) ;
            
            t.push("item1") ;
            t.push("item2") ;
            
            assertEquals( t.peek() , "item2" , "01 - The TypedStack peek method failed." ) ;
            assertEquals( t.size() , 2      , "02 - The TypedStack peek method failed." ) ;
        }        
        
        public function testPop():void
        {
            var s:Stack      = new ArrayStack() ;
            var t:TypedStack = new TypedStack( String , s ) ;
            
            t.push("item1") ;
            t.push("item2") ;
            
            assertEquals( t.pop() , "item2" , "01-01 - The TypedStack pop method failed." ) ;
            assertEquals( t.size() , 1      , "01-02 - The TypedStack pop method failed." ) ;
            
            assertEquals( t.pop() , "item1" , "02-01 - The TypedStack pop method failed." ) ;
            assertEquals( t.size() , 0      , "02-02 - The TypedStack pop method failed." ) ;
            
            assertNull( t.pop() , "03 - The TypedStack pop method failed." ) ;
            
        }
        
        public function testPush():void
        {
            var s:Stack      = new ArrayStack() ;
            var t:TypedStack = new TypedStack( String , s ) ;
            
            t.push("item1") ;
            assertEquals( t.size() , 1 , "01 - The TypedStack push method failed." ) ;
            
            try
            {
                t.push(3) ;
                fail("02-01 - The TypedStack push method failed.") ;    
            }
            catch( e:Error )
            {
                assertTrue( e is TypeError , "02-02 - The TypedStack push method failed.") ;
                assertEquals( e.message, "TypedStack.validate(3) is mismatch." , "02-03 - The TypedStack push method failed." ) ;
            }
        }
        
        public function testSearch():void
        {
            var s:Stack      = new ArrayStack(["item1", "item2"]) ;
            var t:TypedStack = new TypedStack( String , s ) ;
            assertEquals( t.search("item2") , 1 , "01 - The TypedStack search method failed." ) ;     
            assertEquals( t.search("item4") , -1 , "02 - The TypedStack search method failed." ) ;
        }         
        
        public function testSize():void
        {
            var s:Stack      = new ArrayStack(["item1", "item2"]) ;
            var t:TypedStack = new TypedStack( String , s ) ;
            assertEquals( t.size() , s.size() , "The TypedStack size method failed." ) ;     
        } 
        
        public function testSupports():void
        {
            var s:Stack      = new ArrayStack(["item1", "item2"]) ;
            var t:TypedStack = new TypedStack( String , s ) ;
            assertTrue( t.supports("hello world") , "01 - Must support a String value in argument.") ;
            assertFalse( t.supports(1) , "02 - Must support a String value in argument and not a number.") ;
        }
        
        public function testToSource():void
        {
            var s:Stack      = new ArrayStack() ;
            var t:TypedStack = new TypedStack( String , s ) ;
            assertEquals( t.toSource() , 'new system.data.stacks.TypedStack(String)' , "1 - The TypedStack toSource method failed." ) ;     
            
            t.push("item1") ;
            t.push("item2") ;
            
            assertEquals( t.toSource() , 'new system.data.stacks.TypedStack(String,new system.data.stacks.ArrayStack(["item1","item2"]))' , "The TypedStack toSource method failed." ) ;
        }

        public function testToString():void
        {
            var s:ArrayStack = new ArrayStack(["item1", "item2"]) ;
            var t:TypedStack = new TypedStack( String , s ) ;
            assertEquals( t.toString() , s.toString() , "The TypedStack toString method failed." ) ;     
        }
                
        public function testValidate():void
        {
            var s:ArrayStack = new ArrayStack(["item1", "item2"]) ;
            var t:TypedStack = new TypedStack( String , s ) ;
            
            try
            {
                t.validate( "hello" ) ;         
            }
            catch( e:Error )
            {
                fail("01 - the validate method must validate a String value and not throw an error") ;
            }
            
            try
            {
                t.validate( 1 ) ;
                fail("02-01 - the validate method must throw a TypeError.") ;
            }
            catch( e:Error )
            {
                assertTrue( e is TypeError , "02-02 - the validate method must throw a TypeError.") ;   
                assertEquals( e.message , "TypedStack.validate(1) is mismatch." , "03-02 - the validate method must throw a TypeError.") ;
            }
            
        }            
        
    }
}
