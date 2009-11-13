
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
    
    import buRRRn.ASTUce.extensions.ErrorTestCase;
    
    public class ErrorTestCaseTest extends TestCase
        {
        
        public function ErrorTestCaseTest( name:String = "" )
            {
            super( name );
            }
        
        public function testErrorTest():void
            {
            var test:ErrorTestCase = new ErrorTestCase( "test", Error );
            var result:TestResult = new TestResult();
            test.run( result );
            assertEquals( 1, result.runCount );
            assertTrue( result.wasSuccessful() );
            }
        
        public function testErrorSubclass():void
            {
            var test:ErrorTestCase = new ThrowErrorTestCase( "test", Error );
            var result:TestResult = new TestResult();
            test.run( result );
            assertEquals( 1, result.runCount );
            assertTrue( result.wasSuccessful() );
            }
        
        public function testFailure():void
            {
            var test:ErrorTestCase = new ThrowRuntimeErrorTestCase( "test", RangeError );
            var result:TestResult = new TestResult();
            test.run( result );
            assertEquals( 1, result.runCount );
            assertEquals( 1, result.errorCount );
            }
        
        public function testNoError():void
            {
            var test:ErrorTestCase = new ThrowNoErrorTestCase( "test", Error );
            var result:TestResult = new TestResult();
            test.run( result );
            assertEquals( 1, result.runCount );
            assertEquals( 1, result.failureCount );
            }
        
        public function testWrongError():void
            {
            var test:ErrorTestCase = new ThrowRuntimeErrorTestCase( "test", RangeError );
            var result:TestResult = new TestResult();
            test.run( result );
            assertEquals( 1, result.runCount );
            assertEquals( 1, result.errorCount );
            }
        
        }
    
    }


