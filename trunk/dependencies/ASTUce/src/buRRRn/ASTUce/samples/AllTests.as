
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
    import buRRRn.ASTUce.framework.ITest;
    import buRRRn.ASTUce.framework.TestSuite;
    import buRRRn.ASTUce.Runner;
    import buRRRn.ASTUce.samples.money.MoneyTest;
    
    /**
     * TestSuite that runs all the sample tests
     */
    public class AllTests
    {
        public function AllTests()
        {
        }
        
        public static function main( ...args ):void
        {
            Runner.run(suite());
        }
        
        public static function suite():ITest
        {
            var suite:TestSuite = new TestSuite("All ASTUce sample tests");
            //suite.simpleTrace = true;
            
            /* note:
            adding the SimpleTest will generate
            3 failures and 1 error
               
            note2:
            When adding a class you can do it in 2 different way
            suite.addTest( new TestSuite( className ) );
            or
            suite.addTestSuite( className );
             */
            //suite.addTest( new TestSuite( SimpleTest ) );
            //suite.addTestSuite( SimpleTest );
            suite.addTest(ArrayTest.suite());
            suite.addTestSuite(MoneyTest);
            
            /* note:
            want to run a lot of tests ?
            try the following...
             */
            /*
            suite.addTestSuite( MoneyTest );
            suite.addTestSuite( MoneyTest );
            suite.addTestSuite( MoneyTest );
            suite.addTestSuite( MoneyTest );
            suite.addTestSuite( MoneyTest );
            suite.addTestSuite( MoneyTest );
            suite.addTestSuite( MoneyTest );
            suite.addTestSuite( MoneyTest );
             */
            return suite;
        }
    }
}
