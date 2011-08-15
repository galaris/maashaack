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
    import system.samples.ComparableClass;    

    public class NullComparatorTest extends TestCase 
    {

        public function NullComparatorTest(name:String = "")
        {
            super(name);
        }
        
        public function testConstructor():void
        {
            var comp1:NullComparator = new NullComparator(null, true) ;
            var comp2:NullComparator = new NullComparator(null, false) ;
            var comp3:NullComparator = new NullComparator( new NumberComparator() , true) ;
            
            assertNotNull( comp1 , "01-01 - The NullComparator constructor failed." ) ;
            assertNotNull( comp2 , "01-02 -The NullComparator constructor failed." ) ;
            assertNotNull( comp3 , "01-03 -The NullComparator constructor failed." ) ;
            
        }

        public function testNonNullComparator():void
        {
            var comp:NullComparator = new NullComparator() ;
            
            assertNull( comp.nonNullComparator, "01 - NullComparator nonNullComparator failed." ) ;
            
            var nc:Comparator = new NumberComparator() ;
            
            comp.nonNullComparator = nc ;
            
            assertEquals( comp.nonNullComparator, nc, "02 - NullComparator nonNullComparator failed." ) ;
            
            comp.nonNullComparator = null ;
            
            assertNull( comp.nonNullComparator, "03 - NullComparator nonNullComparator failed." ) ;
            
        }
        
        public function testNullsAreHigh():void
        {
            var comp:NullComparator = new NullComparator() ;
            
            assertFalse( comp.nullsAreHigh , "01 - NullComparator nullsAreHigh failed." ) ;
            
            comp.nullsAreHigh = true ;
            
            assertTrue( comp.nullsAreHigh , "02 - NullComparator nullsAreHigh failed." ) ;
            
            comp.nullsAreHigh = false ;
            
            assertFalse( comp.nullsAreHigh , "01 - NullComparator nullsAreHigh failed." ) ;
        }
        
        public function testCompare():void
        {
            var comp1:NullComparator = new NullComparator(null, true) ;
            var comp2:NullComparator = new NullComparator(null, false) ;
            
            var n:* = null ;
            var o:Object = {} ;
            
            // compare with one or two null objects.
            
            assertEquals( comp1.compare(n, n) , 0  , "01-01 - NullComparator compare failed." ) ;
            assertEquals( comp1.compare(n, o) , 1  , "01-02 - NullComparator compare failed." ) ;
            assertEquals( comp1.compare(o, n) , -1 , "01-03 - NullComparator compare failed." ) ;
            
            assertEquals( comp2.compare(n, n) ,  0 , "02-01 - NullComparator compare failed." ) ;
            assertEquals( comp2.compare(n, o) , -1 , "02-02 - NullComparator compare failed." ) ;
            assertEquals( comp2.compare(o, n) ,  1 , "02-03 - NullComparator compare failed." ) ;
            
            // Try compare two object within initialize the nonNullComparator property.
            
            try
            {
                comp2.compare(1, 2) ;
                fail("02-04 - NullComparator compare failed.") ;
            }
            catch( e:Error )
            {
                assertTrue(e is ArgumentError , "02-05 - NullComparator compare failed.") ;
                assertEquals
                (
                    e.message , 
                    "[object ComparableComparator] compare method failed, the o1 or the o2 arguments are not a Comparable objects : 1,2" ,
                    "02-06 - NullComparator compare failed."
                    
                ) ;    
            }
            
            // use the internal ComparableComparator object by default.
            
            var c:ComparableClass = new ComparableClass(1) ;
            
            assertEquals( comp2.compare(c, 2) , -1 , "03-01 - NullComparator compare failed." ) ;
            assertEquals( comp2.compare(2, c) , -1 , "03-02 - NullComparator compare failed." ) ;
            
            // use a custom comparator.
            
            var comp3:NullComparator = new NullComparator( new NumberComparator() , true) ;            
            
            assertNotNull( comp3.nonNullComparator            , "04-01 - NullComparator compare failed.") ;
            assertTrue( comp3.nonNullComparator is Comparator , "04-02 - NullComparator compare failed." ) ;
            assertEquals( comp3.compare(1, 2) , -1            , "04-03 - NullComparator compare failed." ) ;
            assertEquals( comp3.compare(2, 2) ,  0            , "04-02 - NullComparator compare failed." ) ;
            assertEquals( comp3.compare(2, 1) ,  1            , "04-03 - NullComparator compare failed." ) ;            
                        
            
        }
        
    }
}
