/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [MaasHaack framework]
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
    - Marc ALCARAZ <ekameleon@gmail.com>
*/

package system
{
    import buRRRn.ASTUce.framework.*;
    
    import system.cli.AllTests;
    import system.evaluators.AllTests;
    import system.formatters.AllTests;
    import system.numeric.AllTests;
    import system.reflection.AllTests;
    import system.serializers.AllTests;    

    /**
      * TestSuite that runs all the ES4a tests
      */
    public class AllTests
        {
        
        public function AllTests()
            {
            
            }
        
        static public function suite():ITest
            {
            var suite:TestSuite = new TestSuite( "ES4a core tests" );
            
            /* core framework */
            
            //core2
            suite.addTestSuite( StringsTest );
            
            //others
            
            suite.addTestSuite( CloneableTest );
            suite.addTestSuite( VersionTest );
            suite.addTestSuite( ReflectionTest );
            suite.addTestSuite( EqualityTest );
            suite.addTestSuite( SerializationTest );
            
            /* packages */
            
            //reflection
            suite.addTest( system.reflection.AllTests.suite() );
            
            //serializers
            suite.addTest( system.serializers.AllTests.suite() );
            
            //evaluators
            suite.addTest( system.evaluators.AllTests.suite() );
            
            //formatters
            suite.addTest( system.formatters.AllTests.suite() );
            
            //numeric
            suite.addTest( system.numeric.AllTests.suite() );
            
            //CLI
            suite.addTest( system.cli.AllTests.suite() );
                        
            return suite;
            }
        
        }
    
    }
