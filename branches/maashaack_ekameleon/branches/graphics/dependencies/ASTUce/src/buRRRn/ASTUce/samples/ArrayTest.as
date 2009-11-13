
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
    import buRRRn.ASTUce.framework.*;
    
    /**
     * A sample test case, testing Array.
     */
    public class ArrayTest extends TestCase
    {
        public static function main():void
        {
            //TestRunner.run (suite());
        }
        
        public static function suite():ITest
        {
            return new TestSuite(ArrayTest);
        }
        
        //---------------------------------------
        
        private var empty:Array;
        
        private var full:Array;
        
        public function ArrayTest( name:String = "" )
        {
            super(name);
        }
        
        public function setUp():void
        {
            empty = [];
            full = [];
            full.push(0, 1, 2, 3);
        }
        
        public function testCapacity():void
        {
            var size:int = full.length;
            for( var i:int ; i < 100 ; i++ )
            {
                full.push(i);
            }
            assertEquals(full.length, size + 100);
        }
        
        public function testClone():void
        {
            var clone:Array = full.concat() ;
            assertTrue(clone.length == full.length);
        }
        
        public function testElementAt():void
        {
            var i:int = full[0];
            assertTrue(i == 0);
        }
        
        public function testFilter():void
        {
            try
            {
                empty["filter"](0);
            }
            catch( e:Error )
            {
                return;
            }
            
            fail("Should raise an Error.");
        }
        
        public function testRemoveAll():void
        {
            full.splice(0, full.length);
            assertTrue(full.length == 0);
        }
        
        public function testRemoveElement():void
        {
            full.splice(0, 1);
            assertTrue(!(full.indexOf(0) > -1));
        }
    }
}
