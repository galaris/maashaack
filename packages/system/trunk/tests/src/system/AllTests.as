
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

package system
{
    import library.ASTUce.framework.*;
    
    import system.broadcasters.AllTests;
    import system.cli.AllTests;
    import system.comparators.AllTests;
    import system.data.AllTests;
    import system.errors.AllTests;
    import system.evaluators.AllTests;
    import system.events.AllTests;
    import system.formatters.AllTests;
    import system.ioc.AllTests;
    import system.logging.AllTests;
    import system.models.AllTests;
    import system.network.AllTests;
    import system.numeric.AllTests;
    import system.process.AllTests;
    import system.reflection.AllTests;
    import system.remoting.AllTests;
    import system.rules.AllTests;
    import system.signals.AllTests;
    
    /**
     * TestSuite that runs all the Maashaack tests
     */
    public class AllTests
    {
        public static function suite():Test
        {
            var suite:TestSuite = new TestSuite("system package tests");
            
            /* core framework */
            
            //core2
            suite.addTestSuite( StringsTest );
            suite.addTestSuite( ObjectsTest );
            suite.addTestSuite( ArraysTest );
            suite.addTestSuite( CharTest );
            
            //others
            
            suite.addTestSuite( ByteArraysTest ) ;
            suite.addTestSuite( CloneableTest );
            suite.addTestSuite( ComparableTest );
            suite.addTestSuite( ComparatorTest );
            suite.addTestSuite( EnumTest );
            suite.addTestSuite( SortableTest );
            suite.addTestSuite( VersionTest );
            suite.addTestSuite( ReflectionTest );
            suite.addTestSuite( EqualityTest );
            suite.addTestSuite( SerializationTest) ;
            suite.addTestSuite( URITest );
            
            /* special cases */
            
//            TAMARIN::exclude
//            {
                //data
                suite.addTest( system.data.AllTests.suite() );
//            }
            
            
            /* packages */
            
            suite.addTest( system.reflection.AllTests.suite() );
            suite.addTest( system.rules.AllTests.suite() );
            suite.addTest( system.broadcasters.AllTests.suite() );
            suite.addTest( system.comparators.AllTests.suite() );
            suite.addTest( system.errors.AllTests.suite() );
            suite.addTest( system.evaluators.AllTests.suite() );
            suite.addTest( system.events.AllTests.suite() );
            suite.addTest( system.formatters.AllTests.suite() );
            suite.addTest( system.logging.AllTests.suite() );
            suite.addTest( system.models.AllTests.suite() );
            suite.addTest( system.numeric.AllTests.suite() );
            suite.addTest( system.cli.AllTests.suite());
            suite.addTest( system.process.AllTests.suite() );
            suite.addTest( system.network.AllTests.suite() );
            suite.addTest( system.signals.AllTests.suite() );
            
            suite.addTest( system.ioc.AllTests.suite() );
            suite.addTest( system.remoting.AllTests.suite() );
            
            return suite;
        }
    }
}
