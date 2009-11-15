
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

package buRRRn.ASTUce.tests.framework
    {
    import buRRRn.ASTUce.framework.*;
    
    public class TestListenerTest extends TestCase implements ITestListener
        {
        
        private var _result:TestResult;
        private var _startCount:int;
        private var _endCount:int;
        private var _failureCount:int;
        private var _errorCount:int;
        private var _validCount:int;
        
        public function TestListenerTest( name:String="" )
            {
            super( name );
            }
        
        public function addError( test:ITest, e:Error ):void
            {
            _errorCount++;
            }
        
        public function addFailure( test:ITest, afe:AssertionFailedError ):void
            {
            _failureCount++;
            }
        
        public function addValid( test:ITest ):void
            {
            _validCount++;
            }
        
        public function endTest( test:ITest ):void
            {
            _endCount++;
            }
        
        public function startTest( test:ITest ):void
            {
            _startCount++;
            }
        
        public function setUp():void
            {
            _result = new TestResult();
            _result.addListener( this );
            
            _startCount   = 0;
            _endCount     = 0;
            _failureCount = 0;
            }
        
        public function testError():void
            {
            var test:TestCase = new ErrorTestCaseLocal( "noop" );
            
            test.run( _result );
            
            assertEquals( 1, _errorCount );
            assertEquals( 1, _endCount );
            }
        
        public function testFailure():void
            {
            var test:TestCase = new FailureTestCase( "noop" );
            
            test.run( _result );
            
            assertEquals( 1, _failureCount );
            assertEquals( 1, _endCount );
            }
        
        public function testValid():void
            {
            var test:TestCase = new ValidTestCase( "noop" );
            
            test.run( _result );
            
            assertEquals( 1, _validCount );
            assertEquals( 1, _endCount );
            }
        
        public function testStartStop():void
            {
            var test:TestCase = new EmptyRunTestCase( "noop" );
            
            test.run( _result );
            
            assertEquals( 1, _startCount );
            assertEquals( 1, _endCount );
            }
        
        }
    
    }

