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
 
package system.data.arrays 
{
    import buRRRn.ASTUce.framework.ArrayAssert;
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.data.Typeable;
    import system.data.Validator;    

    public class TypedArrayTest extends TestCase 
    {

        public function TypedArrayTest(name:String = "")
        {
            super(name);
        }
        
        public function testConstructorBasic():void
        {
            var ta:TypedArray = new TypedArray() ;
            assertNotNull( ta , "TypedArray constructor failed." ) ;    
        }

        public function testConstructorType():void
        {
            var ta:TypedArray = new TypedArray(String) ;
            assertNotNull( ta , "01-01 - TypedArray constructor failed." ) ;
            assertEquals( ta.type , String ,  "01-02 - TypedArray constructor failed." ) ;
            
            ta = new TypedArray() ;
            assertNotNull( ta , "02-01 - TypedArray constructor failed." ) ;
            assertNull( ta.type ,  "02-02 - TypedArray constructor failed." ) ;            

            ta = new TypedArray(null) ;
            assertNotNull( ta   , "03-01 - TypedArray constructor failed." ) ;
            assertNull( ta.type ,  "03-02 - TypedArray constructor failed." ) ;

            ta = new TypedArray(2) ;
            assertNotNull( ta   , "04-01 - TypedArray constructor failed." ) ;
            assertNull( ta.type ,  "04-02 - TypedArray constructor failed." ) ;
        }
        
        public function testConstructorValues():void
        {
            var ta:TypedArray = new TypedArray(String, "value1", "value2") ;
            assertNotNull( ta , "01 - TypedArray constructor with values failed." ) ;
            assertEquals( ta.length , 2 , "02 - TypedArray constructor with values failed." ) ;
            ArrayAssert.assertEquals( ta.toArray() , ["value1", "value2"] , "03 - TypedArray constructor with values failed." ) ;
        }        
        
        public function testConstructorInvalidValues():void
        {
            var ta:TypedArray = new TypedArray(String, "value1", 1, "value2") ;
            assertNotNull( ta , "01 - TypedArray constructor with invalid values failed." ) ;
            assertEquals( ta.length , 2 , "02 - TypedArray constructor with invalid values failed." ) ;
            ArrayAssert.assertEquals( ta.toArray() , ["value1", "value2"] , "03 - TypedArray constructor with invalid values failed." ) ;
        }     
        
        public function testInherit():void
        {
            var ta:TypedArray = new TypedArray(String) ;
            assertTrue( ta is ProxyArray , "The TypedArray class must extends the ProxyArray class." ) ;
        }
        
        public function testInterface():void
        {
            var ta:TypedArray = new TypedArray(String) ;
            assertTrue( ta is Typeable   , "01 - The TypedArray class must implement the Typeable interface." ) ;
            assertTrue( ta is Validator  , "02 - The TypedArray class must implement the Validator interface." ) ;
        }        
        
        // test methods and attributes

        public function testType():void
        {
            var ta:TypedArray = new TypedArray( String ) ;
            assertEquals( ta.type , String , "01 - The TypedArray type property failed." ) ;
            
            ta.type = Number ;
            assertEquals( ta.type , Number , "02 - The TypedArray type property failed." ) ;
            
            var clazz:Function = function():void {} ;
            ta.type = clazz ;
            assertEquals( ta.type , clazz , "03 - The TypedArray type property failed." ) ;
            
            ta.type = null ;
            assertNull( ta.type , "04 - The TypedArray type property failed." ) ;            

            ta.type = 2 ;
            assertNull( ta.type , "05 - The TypedArray type property failed." ) ;    
        }        
        
        public function testClone():void
        {
            var ta:TypedArray = new TypedArray( String , "value1", "value2"  ) ;
            var clone:TypedArray = ta.clone() as TypedArray ;
            assertNotNull( clone , "01 - The TypedArray clone method failed." ) ;
            assertEquals( ta.length , clone.length , "02 - The TypedArray clone method failed." ) ;
            ArrayAssert.assertEquals( ta.toArray() , clone.toArray() , "03 - The TypedArray clone method failed." ) ;
        }
        
        public function testConcat():void
        {
            var ta:TypedArray = new TypedArray( String ) ;
            var r:TypedArray ;
            
            r = ta.concat() ;
            ArrayAssert.assertEquals( r.toArray() , [] , "00-01 - TypedArray concat failed." );
            
            r = ta.concat(["value1","value2"], ["value3","value4"]) ;
            ArrayAssert.assertEquals( r.toArray() , ["value1","value2","value3","value4"] , "00-02 - TypedArray concat failed." );
            
            ta = new TypedArray( String ) ;
            
            try
            {
                r = ta.concat("value1", "value2") as TypedArray;
                assertNotNull(r, "01-01 - TypedArray concat failed.") ;
                ArrayAssert.assertEquals( r.toArray() , ["value1", "value2"] , "01-02 - TypedArray concat failed." );
            }
            catch( e:Error )
            {
               fail( "01-03 - TypedArray concat failed.") ;
            }
             
            try
            {
                r = ta.concat(1) ;
                fail("02-01 - TypedArray concat failed.") ;
            }
            catch( e:Error )
            {
                assertTrue( e is TypeError , "02-02 - TypedArray concat failed." ) ;
                assertEquals( e.message , "TypedArray.validate(1) is mismatch." , "02-03 - TypedArray concat failed." ) ;
            } 
            
            try
            {
                r = ta.concat([2]) ;
                fail("03-01 - TypedArray concat failed.") ;
            }
            catch( e:Error )
            {
                assertTrue( e is TypeError , "03-02 - TypedArray concat failed." ) ;
                assertEquals( e.message , "TypedArray.validate(2) is mismatch." , "03-03 - TypedArray concat failed." ) ;
            }              
             
        }        
        
        public function testPush():void
        {
            var ta:TypedArray = new TypedArray( String ) ;
            try
            {
                assertEquals(ta.push("value1", "value2"), 2 , "01-01 - TypedArray push failed." ) ;
                assertEquals( ta.length , 2 , "01-02 - TypedArray push failed." );
            }
            catch( e:Error )
            {
               fail( "01-03 - TypedArray push failed.") ;
            }
             
            try
            {
                ta.push(1) ;
                fail("02-01 - TypedArray push failed.") ;
            }
            catch( e:Error )
            {
                assertTrue( e is TypeError , "02-02 - TypedArray push failed." ) ;
                assertEquals( e.message , "TypedArray.validate(1) is mismatch." , "02-03 - TypedArray push failed." ) ;
            }            
        }
        
        public function testSupports():void
        {
            var ta:TypedArray = new TypedArray( String ) ;
            assertTrue( ta.supports("hello world") , "01 - Must support a String value in argument.") ;
            assertFalse( ta.supports(1) , "02 - Must support a String value in argument and not a number.") ;
        }
        
        public function testToArray():void
        {
            var ta:TypedArray = new TypedArray( String , "value1", "value2" ) ;
            ArrayAssert.assertEquals(ta.toArray() , ["value1", "value2"], "The TypedArray toArray method failed.") ;
        }
        
        public function testToSource():void
        {
            var tc:TypedArray = new TypedArray( String , "value1", "value2" ) ;
            assertEquals( tc.toSource() , 'new system.data.arrays.TypedArray(String,"value1","value2")' , "The TypedCollection toSource method failed." ) ;     
        }
        
        public function testToString():void
        {
            var ta:TypedArray = new TypedArray( String , "value1", "value2" ) ;
            assertEquals( ta.toString() , '[value1,value2]' , "The TypedArray toString method failed." ) ;     
        }
        
        public function testUnshift():void
        {
            var ta:TypedArray = new TypedArray( String ) ;
            try
            {
                assertEquals(ta.unshift("value1", "value2"), 2 , "01-01 - TypedArray unshift failed." ) ;
                assertEquals( ta.length , 2 , "01-02 - TypedArray unshift failed." );
            }
            catch( e:Error )
            {
               fail( "01-03 - TypedArray unshift failed.") ;
            }
             
            try
            {
                ta.unshift(1) ;
                fail("02-01 - TypedArray unshift failed.") ;
            }
            catch( e:Error )
            {
                assertTrue( e is TypeError , "02-02 - TypedArray unshift failed." ) ;
                assertEquals( e.message , "TypedArray.validate(1) is mismatch." , "02-03 - TypedArray unshift failed." ) ;
            }             
        }
        
        public function testValidate():void
        {
            var ta:TypedArray = new TypedArray( String ) ;
            try
            {
                ta.validate( "hello" ) ;         
            }
            catch( e:Error )
            {
                fail("01 - the validate method must validate a String value and not throw an error") ;
            }
            
            try
            {
                ta.validate( 1 ) ;
                fail("02-01 - the validate method must throw a TypeError.") ;
            }
            catch( e:Error )
            {
                assertTrue( e is TypeError , "02-02 - the validate method must throw a TypeError.") ;   
                assertEquals( e.message , "TypedArray.validate(1) is mismatch." , "02-03 - the validate method must throw a TypeError.") ;
            }
        }            
                
    }
}
