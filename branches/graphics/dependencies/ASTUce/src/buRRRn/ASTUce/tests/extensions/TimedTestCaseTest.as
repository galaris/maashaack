
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
    
    import buRRRn.ASTUce.extensions.TimedTestCase;
    
    public class TimedTestCaseTest extends TestCase
        {
        private var _globalTimeout:int;
        private var _lowTimeout:int;
        private var _highTimeout:int;
        
        public function TimedTestCaseTest( name:String = "" )
            {
            super( name );
            }
        
        public function setUp():void
            {
            _globalTimeout = TimedTestCase.timeout;
            _lowTimeout  = 10;
            _highTimeout = 300;
            }
        
        public function tearDown():void
            {
            TimedTestCase.timeout = _globalTimeout;
            }
        
        public function testTime():void
            {
            var test:ITest = new SampleTimedTest( "testShortTime" );
            var result:TestResult = new TestResult();
            test.run( result );
            assertEquals( 1, result.runCount );
            assertTrue( result.wasSuccessful() );
            }
        
        /* If this test fail it's probably because your machine is too fast ;)
           and indeed after changing my machine to a faster one this test failed
        */
        public function testTimeExceeded():void
            {
            var test:ITest = new SampleTimedTest( "testLongTime", 1 );
            var result:TestResult = new TestResult();
            test.run( result );
            assertEquals( 1, result.runCount, "should run once" );
            assertEquals( 1, result.failureCount, "should have 1 failure" );
            assertTrue( !result.wasSuccessful() );
            }
        
        public function testTimeSuite():void
            {
            var test:ITest = new TestSuite( SampleTimedTest );
            var result:TestResult = new TestResult();
            test.run( result );
            assertEquals( 2, result.runCount );
            assertTrue( result.wasSuccessful() );
            }
        
        /* If this test fail it's probably because your machine is too fast ;)
        */
        public function testTimeSuiteExceeded():void
            {
            TimedTestCase.timeout = _lowTimeout;
            
            var test:ITest = new TestSuite( NoTimeoutTimedTest );
            var result:TestResult = new TestResult();
            test.run( result );
            assertEquals( 2, result.runCount, "should run twice" );
            assertEquals( 1, result.failureCount, "should have 1 failure" );
            assertTrue( !result.wasSuccessful() );
            }
        
        public function testTimeSuiteLargeTimeout():void
            {
            TimedTestCase.timeout = _highTimeout;
            
            var test:ITest = new TestSuite( NoTimeoutTimedTest );
            var result:TestResult = new TestResult();
            test.run( result );
            assertEquals( 2, result.runCount );
            assertEquals( 0, result.failureCount );
            assertTrue( result.wasSuccessful() );
            }
        
        public function testErrorsWhileRunning():void
            {
            var test:ITest = new TestSuite( ErrorTimedTest );
            var result:TestResult = new TestResult();
            test.run( result );
            assertEquals( 2, result.runCount );
            assertEquals( 1, result.errorCount );
            assertEquals( 1, result.failureCount );
            assertTrue( !result.wasSuccessful() );
            }
        
        }
    
    }

