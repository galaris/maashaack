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
  Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  
*/

package system.data
{
    import buRRRn.ASTUce.framework.*;
    
    import system.data.arrays.*;
    import system.data.collections.*;
    import system.data.iterators.*;
    import system.data.lists.*;
    import system.data.maps.*;
    import system.data.queues.*;
    import system.data.sets.*;
    import system.data.stacks.*;    

    public class AllTests
    {
        
        public function AllTests()
        {
            //
        }
        
        public static function suite():ITest
        {
            
            var suite:TestSuite = new TestSuite( "system data tests" );
            
            // test system.data interfaces
            
            suite.addTestSuite( CollectionTest      ) ;
            suite.addTestSuite( EntryTest           ) ;
            suite.addTestSuite( IdentifiableTest    ) ;
            suite.addTestSuite( IterableTest        ) ;
            suite.addTestSuite( IteratorTest        ) ;
            suite.addTestSuite( ListTest            ) ;
            suite.addTestSuite( ListIterableTest    ) ;
            suite.addTestSuite( ListIteratorTest    ) ;
            suite.addTestSuite( MapTest             ) ;
            suite.addTestSuite( MultiMapTest        ) ;
            suite.addTestSuite( OrderedIteratorTest ) ;
            suite.addTestSuite( QueueTest           ) ;
            suite.addTestSuite( SetTest             ) ;
            suite.addTestSuite( StackTest           ) ;
                                    
            // arrays
            
            suite.addTest( system.data.arrays.AllTests.suite() );
            
            // collections
                 
            suite.addTest( system.data.collections.AllTests.suite() );  
                                 
            // iterators
            
            suite.addTest( system.data.iterators.AllTests.suite() );
            
            // lists
            
            suite.addTest( system.data.lists.AllTests.suite() );                        
            
            // maps
            
            suite.addTest( system.data.maps.AllTests.suite() );

            // queues
            
            suite.addTest( system.data.queues.AllTests.suite() );            
            
            // sets           
            
            suite.addTest( system.data.sets.AllTests.suite() );
            
            // stacks
            
            suite.addTest( system.data.stacks.AllTests.suite() );
            
            return suite;
        }
        
    }
    
}
