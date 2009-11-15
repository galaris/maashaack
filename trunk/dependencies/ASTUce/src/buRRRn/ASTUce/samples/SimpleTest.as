
/*
The contents of this file are subject to the Mozilla Public License Version
1.1 (the "License"); you may not use this file except in compliance with
the License. You may obtain a copy of the License at 
http://www.mozilla.org/MPL/ 
  
Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
for the specific language governing rights and limitations under the License. 
  
The Original Code is [ASTUce: ActionScript Test Unit compact edition AS3]. 
  
The Initial Developer of the Original Code is
Zwetan Kjukov <zwetan@gmail.com>.
Portions created by the Initial Developer are Copyright (C) 2006-2008
the Initial Developer. All Rights Reserved.
  
Contributor(s):
 */

package buRRRn.ASTUce.samples
{
    import buRRRn.ASTUce.framework.TestCase;
    
    public class SimpleTest extends TestCase
    {
        public var value1:int;
        
        public var value2:int;
        
        public function SimpleTest( name:String = "" )
        {
            super(name);
        }
        
        public function setUp():void
        {
            value1 = 2;
            value2 = 3;
        }
        
        public function testAdd():void
        {
            var result:int = value1 + value2 + 1; //force failure with +1
            //var result:int = value1 + value2 ;
            assertTrue(result == 5, "result is not 5");
        }
        
        public function testDivideByZero():void
        {
            var zero:int = 0;
            var result:int = 8 / zero;
            
            //forced failure
            assertEquals(8, result);
            
            //passing test
            //assertEquals( 0, result );
        }
        
        public function testEquals():void
        {
            assertEquals(12, 12);
            
            var twelve:String = (12).toString(16);
            assertEquals(twelve, "c");
            
            assertEquals(0x000000000c, 0x000000000c);
            
            //forced failure
            assertEquals(12.0, 11.99, "Capacity");
            
            //passing test
            //assertEquals( 12.0, 12, "Capacity" );
        }
        
        public function testEqualsObject():void
        {
            var obj1:Object = {a:1, b:2, c:3};
            var obj2:Object = {a:1, b:2, c:4};
            //var obj3:Object = obj1;
            
            //forced failure
            assertEquals(obj1, obj2);
            
            //passing test
            //assertEquals( obj1, obj3 );
        }
        
        public function testErrorThrow():void
        {
            throw new Error("this is a basic error");
        }
    }
}

