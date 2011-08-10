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
    
    public class StringComparatorTest extends TestCase 
    {
        public function StringComparatorTest(name:String = "")
        {
            super(name);
        }
        
        public var comparator:StringComparator ;
        
        public function setUp():void
        {
            comparator = new StringComparator() ;
        }
        
        public function tearDown():void
        {
            comparator = undefined ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( comparator , "01 - The StringComparator constructor failed." ) ;
            assertFalse( comparator.ignoreCase  , "02 - The StringComparator constructor failed." ) ;
            
            var c:StringComparator ;
            
            c = new StringComparator(true) ;
            assertTrue( c.ignoreCase  , "03 - The StringComparator constructor failed." ) ;
            
            c = new StringComparator(false) ;
            assertFalse( c.ignoreCase  , "04 - The StringComparator constructor failed." ) ;
        }
        
        public function testIgnoreCase():void
        {
            comparator.ignoreCase = true ;
            
            assertTrue( comparator.ignoreCase , "01 - The StringComparator ignoreCase failed.") ;
            
            comparator.ignoreCase = false ;
            
            assertFalse( comparator.ignoreCase , "02 - The StringComparator ignoreCase failed.") ;
        }
        
        public function testCompare():void
        {
            var comp1:StringComparator = new StringComparator() ;
            var comp2:StringComparator = new StringComparator(true) ; // ignore case
            
            var s0:String = "HELLO" ;
            var s1:String = "hello" ;
            var s2:String = "welcome" ;
            var s3:String = "world" ;
            
            assertEquals( comp1.compare(s1, s2) , -1 , "01-01 - The StringComparator compare failed." ) ;
            assertEquals( comp1.compare(s2, s1) ,  1 , "01-02 - The StringComparator compare failed." ) ;
            assertEquals( comp1.compare(s1, s3) ,  1 , "01-03 - The StringComparator compare failed." ) ;
            assertEquals( comp1.compare(s1, s1) ,  0 , "01-04 - The StringComparator compare failed." ) ;
            
            assertEquals( comp1.compare(s1, s0) , -1 , "01-05 - The StringComparator compare failed." ) ;
            assertEquals( comp2.compare(s1, s0) ,  0 , "01-06 - The StringComparator compare failed." ) ;
            
            // test the "options" argument
            
            assertEquals( comp1.compare("aa", "aa", true) , 0 , "02-01 - The StringComparator compare failed." ) ;
            assertEquals( comp1.compare("AA", "aa", true) , 0 , "02-02 - The StringComparator compare failed." ) ;
            assertEquals( comp1.compare("aa", "AA", true) , 0 , "02-03 - The StringComparator compare failed." ) ;
            
            assertTrue( comp1.ignoreCase  , "02-04 - The StringComparator compare failed." ) ;
            
            assertEquals( comp1.compare("aa", "aa", false) ,  0 , "03-01 - The StringComparator compare failed." ) ;
            assertEquals( comp1.compare("AA", "aa", false) ,  1 , "03-02 - The StringComparator compare failed." ) ;
            assertEquals( comp1.compare("aa", "AA", false) , -1 , "03-03 - The StringComparator compare failed." ) ;
            
            assertFalse( comp1.ignoreCase  , "03-04 - The StringComparator compare failed." ) ;
        } 
        
        public function testIgnoreCaseStringComparator():void
        {
            var c1:StringComparator = StringComparator.ignoreCaseComparator ;
            var c2:StringComparator = StringComparator.ignoreCaseComparator ;
            
            assertNotNull( c1 as Comparator , "01 - StringComparator.ignoreCaseComparator failed." ) ;
            assertNotNull( c2 as Comparator , "02 - StringComparator.ignoreCaseComparator failed." ) ;
            assertSame(c1, c2 , "03 - StringComparator.getIgnoreCaseStringComparator failed." );
        }
        
        public function testComparator():void
        {
            var c1:StringComparator = StringComparator.comparator ;
            var c2:StringComparator = StringComparator.comparator ;
            
            assertNotNull( c1 as Comparator , "01 - StringComparator.comparator failed." ) ;
            assertNotNull( c2 as Comparator , "02 - StringComparator.comparator failed." ) ;
            assertSame(c1, c2 , "03 - StringComparator.getStringComparator failed." );
        } 
    }
}
