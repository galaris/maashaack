
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

package buRRRn.ASTUce.tests.extensions
    {
    import buRRRn.ASTUce.framework.*;
    import buRRRn.ASTUce.extensions.RepeatedTest;
    import buRRRn.ASTUce.tests.extensions.SuccessTest;
    
    public class RepeatedTestTest extends TestCase
        {
        private var _suite:TestSuite;
        
        public function RepeatedTestTest( name:String = "" )
            {
            super( name );
            
            _suite = new TestSuite();
            _suite.addTest( new SuccessTest() );
            _suite.addTest( new SuccessTest() );
            
            }
        
        public function testRepeatedOnce():void
            {
            var test:ITest = new RepeatedTest( _suite, 1 );
    		assertEquals( 2, test.countTestCases );
    		
    		var result:TestResult = new TestResult();
    		test.run( result );
    		assertEquals( 2, result.runCount );
            }
        
        public function testRepeatedMoreThanOnce():void
            {
            var test:ITest = new RepeatedTest( _suite, 3 );
            assertEquals( 6, test.countTestCases );
            
            var result:TestResult = new TestResult();
    		test.run( result );
    		assertEquals( 6, result.runCount );
            }
        
        public function testRepeatedZero():void
            {
            var test:ITest = new RepeatedTest( _suite, 0 );
            assertEquals( 0, test.countTestCases );
            
            var result:TestResult = new TestResult();
    		test.run( result );
    		assertEquals( 0, result.runCount );
            }
        
        public function testRepeatedNegative():void
            {
            try
                {
                new RepeatedTest( _suite, -1 );
                }
            catch( e:ArgumentError )
                {
                return;
                }
            
            fail( "Should throw an ArgumentError" );
            }
        
        }
    
    }

