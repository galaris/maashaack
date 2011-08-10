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
    
    public class NumberComparatorTest extends TestCase 
    {
        public function NumberComparatorTest(name:String = "")
        {
            super(name);
        }
        
        public function testConstructor():void
        {
            var c1:NumberComparator = new NumberComparator() ;
            assertNotNull( c1 , "01 - The NumberComparator constructor failed." ) ;
            
            var c2:NumberComparator = new NumberComparator(true, 10) ;
            assertEquals( c2.fractionDigits , 10, "02-01 - The NumberComparator constructor failed." ) ;
            assertTrue(c2.fixed, "02-02 - The NumberComparator constructor failed." ) ;
        }
        
        public function testFractionDigits():void
        {
            var c:NumberComparator = new NumberComparator() ;
            assertEquals(c.fractionDigits, 0, "01 - The NumberComparator fractionDigits failed." ) ;
            
            c.fractionDigits = 10 ; 
            assertEquals(c.fractionDigits, 10, "02 - The NumberComparator fractionDigits failed." ) ;
        }
        
        public function testFixed():void
        {
            var c:NumberComparator = new NumberComparator() ;
            assertFalse(c.fixed, "01 - The NumberComparator fixed failed." ) ;
            
            c.fixed = true ; 
            assertTrue(c.fixed, "01 - The NumberComparator fixed failed." ) ;
        }
        
        public function testCompare():void
        {
            var c:NumberComparator = new NumberComparator() ;

            assertEquals( c.compare(  0   ,  0   ) ,  0 , "01 - The NumberComparator compare method failed." ) ;
            assertEquals( c.compare(  1   ,  1   ) ,  0 , "02 - The NumberComparator compare method failed." ) ;
            assertEquals( c.compare( -1   , -1   ) ,  0 , "03 - The NumberComparator compare method failed." ) ;
            assertEquals( c.compare(  0.1 ,  0.1 ) ,  0 , "04 - The NumberComparator compare method failed." ) ;
            
            assertEquals( c.compare( Number(Math.cos(25)) , 0.9912028118634736 ) ,  0 , "05 - The NumberComparator compare method failed." ) ;
            
            assertEquals( c.compare( 1 , 0 ) ,   1 , "06 - The NumberComparator compare method failed." ) ;
            assertEquals( c.compare( 0 , 1 ) ,  -1 , "07 - The NumberComparator compare method failed." ) ;
        }
        
        public function testCompareArgumentError():void
        {
            var c:NumberComparator = new NumberComparator() ;
            try
            {
                 c.compare( "hello" , 2 ) ;
                 fail( "01-01 - The NumberComparator compare method failed." ) ;
            }
            catch( e:Error )
            {
                assertTrue( e is ArgumentError , "01-02 - The NumberComparator compare method failed." ) ;
                assertEquals( e.message,  "NumberComparator compare(hello,2) failed, the two arguments must be Number objects."  , "01-03 - The NumberComparator compare method failed." ) ;
            }
            
            try
            {
                 c.compare( 1 , "world" ) ;
                 fail( "02-01 - The NumberComparator compare method failed." ) ;
            }
            catch( e:Error )
            {
                assertTrue( e is ArgumentError , "02-02 - The NumberComparator compare method failed." ) ;
                assertEquals( e.message,  "NumberComparator compare(1,world) failed, the two arguments must be Number objects."  , "02-03 - The NumberComparator compare method failed." ) ;
            }
            
            try
            {
                 c.compare( "hello" , "world" ) ;
                 fail( "03-01 - The NumberComparator compare method failed." ) ;
            }
            catch( e:Error )
            {
                assertTrue( e is ArgumentError , "03-02 - The NumberComparator compare method failed." ) ;
                assertEquals( e.message,  "NumberComparator compare(hello,world) failed, the two arguments must be Number objects."  , "03-03 - The NumberComparator compare method failed." ) ;
            } 
            
        } 
        
        public function testCompareWithFixed():void
        {
            var c:NumberComparator = new NumberComparator() ;
            
            c.fixed = true ;
            
            c.fractionDigits = 3 ;
            assertEquals( c.compare(  1.2356   ,  1.2358   ) ,  0 , "01 - The NumberComparator compare method failed." ) ;
            
            c.fractionDigits = 4 ;
            assertEquals( c.compare(  1.2356   ,  1.2358   ) ,  -1 , "01 - The NumberComparator compare method failed." ) ;
        }

        public function testCompareRangeError():void
        {
            var c:NumberComparator = new NumberComparator() ;
            c.fixed = true ;
            c.fractionDigits = 25 ;
            try
            {
                 c.compare( 2.1 , 2.2 ) ;
                 fail( "01 - The NumberComparator compare method failed, must throw a RangeError." ) ;
            }
            catch( e:Error )
            {
                assertTrue( e is RangeError , "02 - The NumberComparator compare method failed, must throw a RangeError." ) ;
            } 
        }
    }
}
