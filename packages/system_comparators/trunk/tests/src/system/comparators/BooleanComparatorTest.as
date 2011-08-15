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

package system.comparators 
{
    import library.ASTUce.framework.TestCase;

    public class BooleanComparatorTest extends TestCase
    {
        public function BooleanComparatorTest(name:String = "")
        {
            super(name);
        }
        
        public var comparator:BooleanComparator ;
        
        public function setUp():void
        {
            comparator = new BooleanComparator() ;
        }
        
        public function tearDown():void
        {
            comparator = null ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( comparator , "01 - The BooleanComparator constructor failed." ) ;
            
            var c1:BooleanComparator = new BooleanComparator(true) ;
            assertTrue( c1.trueFirst , "02 - The BooleanComparator constructor failed.") ;
            
            var c2:BooleanComparator = new BooleanComparator(true) ;
            assertTrue( c2.trueFirst , "03 - The BooleanComparator constructor failed.") ;
            
            var c3:BooleanComparator = new BooleanComparator(false) ;
            assertFalse( c3.trueFirst , "04 - The BooleanComparator constructor failed.") ;
            
        }
        
        public function testCompare():void
        {
            comparator.trueFirst = true ;
            assertEquals( comparator.compare(true, true)   ,  0 , "01 - The BooleanComparator compare method failed." ) ;
            assertEquals( comparator.compare(true, false)  ,  1 , "02 - The BooleanComparator compare method failed." ) ;
            assertEquals( comparator.compare(false, true)  , -1 , "03 - The BooleanComparator compare method failed." ) ;
            assertEquals( comparator.compare(false, false) ,  0 , "04 - The BooleanComparator compare method failed." ) ;
            
            comparator.trueFirst = false ;
            assertEquals( comparator.compare(true, true)   ,  0  ,  "01 - The BooleanComparator compare method failed." ) ;
            assertEquals( comparator.compare(true, false)  , -1  ,  "02 - The BooleanComparator compare method failed." ) ;
            assertEquals( comparator.compare(false, true)  ,  1  ,  "03 - The BooleanComparator compare method failed." ) ;
            assertEquals( comparator.compare(false, false) ,  0  ,  "04 - The BooleanComparator compare method failed." ) ;
        }
        
        public function testFalseFirstComparator():void
        {
            var c:BooleanComparator = BooleanComparator.falseFirst ;
            assertNotNull( c , "The BooleanComparator.getTrueFirstComparator singleton not must be null.") ;
            assertFalse( c.trueFirst , "The BooleanComparator.getTrueFirstComparator.trueFirst value must be false.") ;
        }
        
        public function testTrueFirstComparator():void
        {
            var c:BooleanComparator = BooleanComparator.trueFirst ;
            assertNotNull( c , "The BooleanComparator.getTrueFirstComparator singleton not must be null.") ;
            assertTrue( c.trueFirst , "The BooleanComparator.getTrueFirstComparator.trueFirst value must be true.") ;
        }
        
    }
}
