/*
  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at
  http://www.mozilla.org/MPL/
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the
  License.
  
  The Original Code is [maashaack framework].
  
  The Initial Developers of the Original Code are
  Zwetan Kjukov <zwetan@gmail.com> and Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developers are Copyright (C) 2006-2011
  the Initial Developers. All Rights Reserved.
  
  Contributor(s):
  
  Alternatively, the contents of this file may be used under the terms of
  either the GNU General Public License Version 2 or later (the "GPL"), or
  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
  in which case the provisions of the GPL or the LGPL are applicable instead
  of those above. If you wish to allow use of your version of this file only
  under the terms of either the GPL or the LGPL, and not to allow others to
  use your version of this file under the terms of the MPL, indicate your
  decision by deleting the provisions above and replace them with the notice
  and other provisions required by the LGPL or the GPL. If you do not delete
  the provisions above, a recipient may use your version of this file under
  the terms of any one of the MPL, the GPL or the LGPL.
*/

package system.data
{
    import buRRRn.ASTUce.framework.ITest;
    import buRRRn.ASTUce.framework.TestSuite;
    
    import system.data.arrays.AllTests;
    import system.data.bags.AllTests;
    import system.data.collections.AllTests;
    import system.data.iterators.AllTests;
    import system.data.lists.AllTests;
    import system.data.maps.AllTests;
    import system.data.queues.AllTests;
    import system.data.sets.AllTests;
    import system.data.stacks.AllTests;
    import system.data.trees.AllTests;
    
    public class AllTests
    {
        public static function suite():ITest
        {
            
            var suite:TestSuite = new TestSuite("system data tests");
            
            // test system.data interfaces & class
            
            suite.addTestSuite(AliasesTest) ;
            suite.addTestSuite(BagTest) ;
            suite.addTestSuite(BoundableTest) ;
            suite.addTestSuite(CollectionTest) ;
            suite.addTestSuite(DataTest) ;
            suite.addTestSuite(EntryTest) ;
            suite.addTestSuite(IdentifiableTest) ;
            suite.addTestSuite(IterableTest) ;
            suite.addTestSuite(IteratorTest) ;
            suite.addTestSuite(ListTest) ;
            suite.addTestSuite(ListIterableTest) ;
            suite.addTestSuite(ListIteratorTest) ;
            suite.addTestSuite(MapTest) ;
            suite.addTestSuite(MultiMapTest) ;
            suite.addTestSuite(OrderedIteratorTest) ;
            suite.addTestSuite(ProxyReferenceTest) ;
            suite.addTestSuite(QueueTest) ;
            suite.addTestSuite(SetTest) ;
            suite.addTestSuite(StackTest) ;
            suite.addTestSuite(TypeableTest) ;
            suite.addTestSuite(ValidatorTest) ;
            suite.addTestSuite(WeakReferenceTest) ;
            
            // arrays
            suite.addTest(system.data.arrays.AllTests.suite());
            
            // bags
            suite.addTest(system.data.bags.AllTests.suite());
            
            // collections
            suite.addTest(system.data.collections.AllTests.suite());
            
            // iterators
            suite.addTest(system.data.iterators.AllTests.suite());
            
            // lists
            suite.addTest(system.data.lists.AllTests.suite());
            
            // maps
            suite.addTest(system.data.maps.AllTests.suite());
            
            // queues
            suite.addTest(system.data.queues.AllTests.suite());
            
            // sets
            suite.addTest(system.data.sets.AllTests.suite());
            
            // stacks
            suite.addTest(system.data.stacks.AllTests.suite());
            
            // trees
            suite.addTest(system.data.trees.AllTests.suite());
            
            return suite;
        }
    }
}
