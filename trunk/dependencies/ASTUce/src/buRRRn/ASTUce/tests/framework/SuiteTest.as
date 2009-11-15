
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
    
    public class SuiteTest extends TestCase
        {
        
        protected var result:TestResult;
        
        public function SuiteTest( name:String = "" )
            {
            super( name );
            }
        
        /* note:
           build the suite manually, because some of the suites
           are testing the functionality that automatically builds suites.
        */
        static public function suite():ITest
            {
            var suite:TestSuite = new TestSuite( "SuiteTest" );
            
            suite.addTest( new SuiteTest( "testOneTestCase" ) );
            suite.addTest( new SuiteTest( "testInheritedTests" ) );
            suite.addTest( new SuiteTest( "testNoTestCaseClass" ) );
            suite.addTest( new SuiteTest( "testNoTestCases" ) );
            suite.addTest( new SuiteTest( "testNotExistingTestCase" ) );
            //suite.addTest( new SuiteTest( "testNotPublicTestCase" ) ); //Will NOT be implemented
            //suite.addTest( new SuiteTest( "testNotVoidTestCase" ) ); //not implemented yet
            suite.addTest( new SuiteTest( "testShadowedTests" ) );
            suite.addTest( new SuiteTest( "testAddTestSuite" ) );
            
            return suite;
            }
        
        public function setUp():void
            {
            result = new TestResult();
            }
        
        
        public function testOneTestCase():void
            {
            var t:ITest = new TestSuite( OneTestCase );
            t.run( result );
            assertTrue( result.runCount     == 1 );
            assertTrue( result.failureCount == 0 );
            assertTrue( result.errorCount   == 0 );
            assertTrue( result.wasSuccessful() );
            }
        
        
        public function testInheritedTests():void
            {
            var suite:TestSuite = new TestSuite( InheritedTestCase );
            suite.run( result );
            assertTrue( result.wasSuccessful() );
            assertTrue( result.runCount == 2, "see buRRRn.ASTUce.config.testInheritedTests" );
            }
        
        public function testNoTestCaseClass():void
            {
            var t:ITest = new TestSuite( NoTestCaseClass );
            t.run( result );
            assertEquals( 1, result.runCount ); //warning test
            assertTrue( !result.wasSuccessful() );
            }
        
        public function testNoTestCases():void
            {
            var t:ITest = new TestSuite( NoTestCases );
            t.run( result );
            assertEquals( 1, result.runCount ); //warning test
            assertTrue( result.failureCount == 1 );
            assertTrue( !result.wasSuccessful() );
            }
        
        public function testNotExistingTestCase():void
            {
            var t:ITest = new SuiteTest( "notExistingMethod" );
            t.run( result );
            assertTrue( result.runCount     == 1 );
            assertTrue( result.failureCount == 1 );
            assertTrue( result.errorCount   == 0 );
            }
        
        /* note:
           There are no way for now to access private members in AS3.
        */
        /*
        public function testNotPublicTestCase():void
            {
            
            }
        */
        
        /* note:
           ES4a system Reflection does not allow us yet to
           tell if a method return void(undefined).
        */
        /*
        public function testNotVoidTestCase():void
            {
            
            }
        */
        
        
        public function testShadowedTests():void
            {
            var t:ITest = new TestSuite( OverrideTestCase );
            t.run( result );
            assertEquals( 1, result.runCount );
            }
        
        
        public function testAddTestSuite():void
            {
            var suite:TestSuite = new TestSuite();
            suite.addTestSuite( OneTestCase );
            suite.run( result );
            assertEquals( 1, result.runCount );
            }
        
        }
    
    }

