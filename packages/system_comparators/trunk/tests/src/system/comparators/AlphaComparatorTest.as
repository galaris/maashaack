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

    public class AlphaComparatorTest extends TestCase 
    {

        public function AlphaComparatorTest(name:String = "")
        {
            super(name);
        }
        
        public var comparator:AlphaComparator ;
        
        public function setUp():void
        {
            comparator = new AlphaComparator() ;
        }

        public function tearDown():void
        {
            comparator = undefined ;
        }
        
        public function testConstructor():void
        {

            assertNotNull( comparator , "01 - The AlphaComparator constructor failed." ) ;
            assertFalse( comparator.ignoreCase  , "02 - The AlphaComparator constructor failed." ) ;
            
            var c:AlphaComparator ;
            
            c = new AlphaComparator(true) ;
            assertTrue( c.ignoreCase  , "03 - The AlphaComparator constructor failed." ) ;
            
            c = new AlphaComparator(false) ;
            assertFalse( c.ignoreCase  , "04 - The AlphaComparator constructor failed." ) ;
            
        }
        
        public function testIgnoreCase():void
        {
            comparator.ignoreCase = true ;
            
            assertTrue( comparator.ignoreCase , "01 - The AlphaComparator ignoreCase failed.") ;
            
            comparator.ignoreCase = false ;
            
            assertFalse( comparator.ignoreCase , "02 - The AlphaComparator ignoreCase failed.") ;
        }
        
        public function testCompare():void
        {
            var comp1:AlphaComparator = new AlphaComparator() ;
            var comp2:AlphaComparator = new AlphaComparator(true) ; // ignore case
            
            var s1:String = "HELLO" ;
            var s2:String = "hello" ;
            var s3:String = "welcome" ;
            var s4:String = "world" ;
            
            assertEquals( comp1.compare(s1, s2) , 1 , "01-01 - The AlphaComparator compare failed." ) ;
            assertEquals( comp1.compare(s1, s3) , 1 , "01-02 - The AlphaComparator compare failed." ) ;
            assertEquals( comp1.compare(s1, s4) , 1 , "01-03 - The AlphaComparator compare failed." ) ;
            
            assertEquals( comp2.compare(s1, s2) ,  0 , "02-01 - The AlphaComparator compare failed." ) ;
            assertEquals( comp2.compare(s1, s3) , -1 , "02-02 - The AlphaComparator compare failed." ) ;
            assertEquals( comp2.compare(s1, s4) , -1 , "02-03 - The AlphaComparator compare failed." ) ;               
            
            assertEquals( comp1.compare(s2, s1) , -1 , "03-01 - The AlphaComparator compare failed." ) ;
            assertEquals( comp1.compare(s2, s3) , -1 , "03-02 - The AlphaComparator compare failed." ) ;
            assertEquals( comp1.compare(s2, s4) , -1 , "03-03 - The AlphaComparator compare failed." ) ;            
            
            assertEquals( comp1.compare(s3, s1) , -1 , "04-01 - The AlphaComparator compare failed." ) ;
            assertEquals( comp1.compare(s3, s2) ,  1 , "04-02 - The AlphaComparator compare failed." ) ;
            assertEquals( comp1.compare(s3, s4) , -1 , "04-03 - The AlphaComparator compare failed." ) ;  
            
            assertEquals( comp1.compare(s4, s1) , -1 , "05-01 - The AlphaComparator compare failed." ) ;
            assertEquals( comp1.compare(s4, s2) ,  1 , "05-02 - The AlphaComparator compare failed." ) ;
            assertEquals( comp1.compare(s4, s3) ,  1 , "05-03 - The AlphaComparator compare failed." ) ;                          
              
            
        } 
        
    }
}
