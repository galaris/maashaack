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
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.Comparator;    

    public class DateComparatorTest extends TestCase 
    {

        public function DateComparatorTest(name:String = "")
        {
            super(name);
        }

        public var comparator:Comparator ;
        
        public function setUp():void
        {
            comparator = new DateComparator() ;
        }

        public function tearDown():void
        {
            comparator = null ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( comparator , "The DateComparator constructor failed." ) ;
            assertTrue( comparator is Comparator , "The DateComparator constructor failed." ) ;
        }
        
        /* TODO:
           date diff on different time zone need to be fixed
        */
        /*
        public function testCompare():void
        {
            
            var d1:Date   = new Date(2007, 1, 1, 0, 0, 0, 0) ;
            var d2:Number = 1170284400000 ;
            var d3:Date   = new Date(2007, 2, 2, 0, 0, 0, 0) ;
            var d4:Number = 1172790000000 ;
            
            assertEquals( comparator.compare(d1, d1) ,  0 , "01 - The DateComparator compare failed." ) ;
            assertEquals( comparator.compare(d1, d2) ,  0 , "02 - The DateComparator compare failed." ) ;
            assertEquals( comparator.compare(d2, d1) ,  0 , "03 - The DateComparator compare failed." ) ;
            assertEquals( comparator.compare(d1, d3) , -1 , "04 - The DateComparator compare failed." ) ;
            assertEquals( comparator.compare(d1, d4) , -1 , "05 - The DateComparator compare failed." ) ;
            assertEquals( comparator.compare(d3, d1) ,  1 , "06 - The DateComparator compare failed." ) ;
            assertEquals( comparator.compare(d4, d1) ,  1 , "07 - The DateComparator compare failed." ) ;
            
        }
        */
        
    }
}
