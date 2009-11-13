
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
    
    /* Test an implementor of buRRRn.ASTUce.framework.ITest
       other than TestCase or TestSuite.
    */
    public class TestImplementorTest extends TestCase
        {
        
        private var _test:DoubleTestCase;
        
        public function TestImplementorTest(name:String="")
            {
            super( name );
            var testcase:TestCase = new EmptyRunTestCase( "empty" );
            
            _test = new DoubleTestCase( testcase );
            }
        
        public function testSuccessfulRun():void
            {
            var result:TestResult = new TestResult();
            _test.run( result );
            assertEquals( _test.countTestCases, result.runCount );
            assertEquals( 0, result.errorCount );
            assertEquals( 0, result.failureCount );
            }
        
        }
    
    }

