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
    
    import system.Comparator;    

    public class CharComparatorTest extends TestCase 
    {
        
        public function CharComparatorTest( name:String = "" )
        {
            super( name );
        }
        
        public function testConstructor():void
        {
            var comparator:CharComparator = new CharComparator() ;
            assertNotNull( comparator , "01 - The CharComparator constructor failed." ) ;
        }
        
        public function testInterface():void
        {
            var comparator:CharComparator = new CharComparator() ;
            assertTrue( comparator is Comparator ) ;
        }
        
        public function testCaseValue():void
        {
            assertEquals( CharComparator.caseValue("h") , 0 , "CharComparator.caseValue('h') failed." ) ;
            assertEquals( CharComparator.caseValue("H") , 1 , "CharComparator.caseValue('H') failed." ) ;
        }        
                
        public function testCompare():void
        {

            var comparator:CharComparator = new CharComparator() ;

            var c1:String = "a" ;
            var c2:String = "b" ;
            var c3:String = "A" ;
            var c4:String = "B" ;
            
            assertEquals( comparator.compare(c1, c1) ,  0 , "01-00 - The CharComparator compare failed." ) ;
            assertEquals( comparator.compare(c1, c2) , -1 , "01-01 - The CharComparator compare failed." ) ;
            assertEquals( comparator.compare(c1, c3) , -1 , "01-02 - The CharComparator compare failed." ) ;
            assertEquals( comparator.compare(c1, c4) , -1 , "01-03 - The CharComparator compare failed." ) ;
            
            assertEquals( comparator.compare(c2, c2) , 0  , "02-00 - The CharComparator compare failed." ) ;
            assertEquals( comparator.compare(c2, c1) , 1  , "02-01 - The CharComparator compare failed." ) ;
            assertEquals( comparator.compare(c2, c3) , -1 , "02-02 - The CharComparator compare failed." ) ;
            assertEquals( comparator.compare(c2, c4) , -1 , "02-03 - The CharComparator compare failed." ) ;
            
            assertEquals( comparator.compare(c3, c3) , 0  , "03-00 - The CharComparator compare failed." ) ;
            assertEquals( comparator.compare(c3, c1) , 1  , "03-01 - The CharComparator compare failed." ) ;
            assertEquals( comparator.compare(c3, c2) , 1  , "03-02 - The CharComparator compare failed." ) ;
            assertEquals( comparator.compare(c3, c4) , -1 , "03-03 - The CharComparator compare failed." ) ;
            
            assertEquals( comparator.compare(c4, c4) , 0 , "04-00 - The CharComparator compare failed." ) ;
            assertEquals( comparator.compare(c4, c1) , 1 , "04-01 - The CharComparator compare failed." ) ;
            assertEquals( comparator.compare(c4, c2) , 1 , "04-02 - The CharComparator compare failed." ) ;
            assertEquals( comparator.compare(c4, c3) , 1 , "04-03 - The CharComparator compare failed." ) ;            
            
        } 
                
        
    }
}
