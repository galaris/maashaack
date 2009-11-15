
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

	public class AllTests
        {
        
        static public function suite():ITest
            {
            var suite:TestSuite = new TestSuite( "Extensions Tests" );
            //suite.simpleTrace = true;
            
            suite.addTestSuite( ExtensionTest );
            suite.addTestSuite( ErrorTestCaseTest );
            suite.addTestSuite( RepeatedTestTest );
            
            /* note:
               The following tests are based on time and CPU,
               and off course can also be influenced if you
               run them inside the flash debug player or not,
               so we don't include them on the main tests.
               
               TimedTestCase and TimedTest are working,
               but you should mainly use them as performance tests
               and set them up based on your machine speed and/or
               your performance target.
               
               example:
               You got a very fast CPU, and somebody report bugs
               on a slower CPU, then you can build a test for them ;).
            */
            /*
            suite.addTestSuite( TimedTestCaseTest );
            suite.addTestSuite( TimedTestTest );
            suite.addTest( new TimedTest( new TestSuite(TimedTestTest), 100 ) );
            */
            
            return suite;
            }
        
        }
    
    }

