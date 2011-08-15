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

package graphics 
{
    import library.ASTUce.framework.TestCase;
    
    public class AlignTest extends TestCase 
    {
        public function AlignTest(name:String = "")
        {
            super(name);
        }
        
        public function testCENTER():void
        {
            assertEquals( Align.CENTER , 1 , "Align.CENTER constant failed.") ;
        }
        
        public function testCENTER_LEFT():void
        {
            assertEquals( Align.CENTER_LEFT , 3 , "Align.CENTER_LEFT constant failed.") ;
        }
        
        public function testCENTER_RIGHT():void
        {
            assertEquals( Align.CENTER_RIGHT , 5 , "Align.CENTER_RIGHT constant failed.") ;
        }
        
        public function testLEFT():void
        {
            assertEquals( Align.LEFT , 2 , "Align.LEFT constant failed.") ;
        }
        
        public function testRIGHT():void
        {
            assertEquals( Align.RIGHT , 4 , "Align.RIGHT constant failed.") ;
        }
        
        public function testTOP():void
        {
            assertEquals( Align.TOP , 8 , "Align.TOP constant failed.") ;
        }
        
        public function testBOTTOM():void
        {
            assertEquals( Align.BOTTOM , 16 , "Align.BOTTOM constant failed.") ;
        }
        
        public function testREVERSE():void
        {
            assertEquals( Align.REVERSE , 32 , "Align.BOTTOM constant failed.") ;
        }
        
        public function testBOTTOM_LEFT():void
        {
            assertEquals( Align.BOTTOM_LEFT , 18 , "Align.BOTTOM_LEFT constant failed.") ;
        }
        
        public function testBOTTOM_RIGHT():void
        {
            assertEquals( Align.BOTTOM_RIGHT , 20 , "Align.BOTTOM_RIGHT constant failed.") ;
        }
        
        public function testTOP_LEFT():void
        {
            assertEquals( Align.TOP_LEFT , 10 , "Align.TOP_LEFT constant failed.") ;
        }
        
        public function testTOP_RIGHT():void
        {
            assertEquals( Align.TOP_RIGHT , 12 , "Align.TOP_RIGHT constant failed.") ;
        }
        
        public function testLEFT_BOTTOM():void
        {
            assertEquals( Align.LEFT_BOTTOM, 50, "Align.LEFT_BOTTOM constant failed.") ;
        }
        
        public function testRIGHT_BOTTOM():void
        {
            assertEquals( Align.RIGHT_BOTTOM, 52, "Align.RIGHT_BOTTOM constant failed.") ;
        }
        
        public function testLEFT_TOP():void
        {
            assertEquals( Align.LEFT_TOP, 42, "Align.LEFT_TOP constant failed.") ;
        }
        
        public function testRIGHT_TOP():void
        {
            assertEquals( Align.RIGHT_TOP, 44, "Align.RIGHT_TOP constant failed.") ;
        }
        
        public function testToNumberL():void
        {
            assertEquals( Align.toNumber("l") , Align.LEFT , "Align.toNumber('l') failed.") ;
            assertEquals( Align.toNumber("L") , Align.LEFT , "Align.toNumber('L') failed.") ;
        }
        
        public function testToNumberR():void
        {
            assertEquals( Align.toNumber("r") , Align.RIGHT , "Align.toNumber('r') failed.") ;
            assertEquals( Align.toNumber("R") , Align.RIGHT , "Align.toNumber('R') failed.") ;
        }
        
        public function testToNumberT():void
        {
            assertEquals( Align.toNumber("t") , Align.TOP , "Align.toNumber('t') failed.") ;
            assertEquals( Align.toNumber("T") , Align.TOP , "Align.toNumber('T') failed.") ;
        }
        
        public function testToNumberB():void
        {
            assertEquals( Align.toNumber("b") , Align.BOTTOM , "Align.toNumber('b') failed.") ;
            assertEquals( Align.toNumber("B") , Align.BOTTOM , "Align.toNumber('B') failed.") ;
        }
        
        public function testToNumberLT():void
        {
            assertEquals( Align.toNumber("lt") , Align.LEFT_TOP , "Align.toNumber('lt') failed.") ;
            assertEquals( Align.toNumber("LT") , Align.LEFT_TOP , "Align.toNumber('LT') failed.") ;
        }
        
        public function testToNumberRT():void
        {
            assertEquals( Align.toNumber("rt") , Align.RIGHT_TOP , "Align.toNumber('rt') failed.") ;
            assertEquals( Align.toNumber("RT") , Align.RIGHT_TOP , "Align.toNumber('RT') failed.") ;
        }
        
        public function testToNumberLB():void
        {
            assertEquals( Align.toNumber("lb") , Align.LEFT_BOTTOM , "Align.toNumber('lb') failed.") ;
            assertEquals( Align.toNumber("LB") , Align.LEFT_BOTTOM , "Align.toNumber('LB') failed.") ;
        }
        
        public function testToNumberRB():void
        {
            assertEquals( Align.toNumber("rb") , Align.RIGHT_BOTTOM , "Align.toNumber('rb') failed.") ;
            assertEquals( Align.toNumber("RB") , Align.RIGHT_BOTTOM , "Align.toNumber('RB') failed.") ;
        }
        
        public function testToNumberTL():void
        {
            assertEquals( Align.toNumber("tl") , Align.TOP_LEFT , "Align.toNumber('tl') failed.") ;
            assertEquals( Align.toNumber("TL") , Align.TOP_LEFT , "Align.toNumber('TL') failed.") ;
        }
        
        public function testToNumberTR():void
        {
            assertEquals( Align.toNumber("tr") , Align.TOP_RIGHT , "Align.toNumber('tr') failed.") ;
            assertEquals( Align.toNumber("TR") , Align.TOP_RIGHT , "Align.toNumber('TR') failed.") ;
        }
        
        public function testToNumberBL():void
        {
            assertEquals( Align.toNumber("bl") , Align.BOTTOM_LEFT , "Align.toNumber('bl') failed.") ;
            assertEquals( Align.toNumber("BL") , Align.BOTTOM_LEFT , "Align.toNumber('BL') failed.") ;
        }
        
        public function testToNumberBR():void
        {
            assertEquals( Align.toNumber("br") , Align.BOTTOM_RIGHT , "Align.toNumber('br') failed.") ;
            assertEquals( Align.toNumber("BR") , Align.BOTTOM_RIGHT , "Align.toNumber('BR') failed.") ;
        }
        
        public function testToNumberDEFAULT():void
        {
            assertEquals( Align.toNumber(null)     , Align.CENTER , "Align.toNumber(null) failed.") ;
            assertEquals( Align.toNumber("test")   , Align.CENTER , "Align.toNumber('test') failed.") ;
            assertEquals( Align.toNumber("center") , Align.CENTER , "Align.toNumber('center') failed.") ;
        }
        
        public function testToString():void
        {
            assertEquals( Align.toString(Align.LEFT)         , "l"  , "01 - Align.toString(Align.LEFT) failed.") ;
            assertEquals( Align.toString(Align.RIGHT)        , "r"  , "02 - Align.toString(Align.RIGHT) failed.") ;
            assertEquals( Align.toString(Align.BOTTOM)       , "b"  , "03 - Align.toString(Align.BOTTOM) failed.") ;
            assertEquals( Align.toString(Align.BOTTOM_LEFT)  , "bl" , "04 - Align.toString(Align.BOTTOM_LEFT) failed.") ;
            assertEquals( Align.toString(Align.BOTTOM_RIGHT) , "br" , "05 - Align.toString(Align.BOTTOM_RIGHT) failed.") ;
            assertEquals( Align.toString(Align.CENTER_LEFT)  , "cl" , "06 - Align.toString(Align.CENTER_LEFT) failed.") ;
            assertEquals( Align.toString(Align.CENTER_RIGHT) , "cr" , "07 - Align.toString(Align.CENTER_RIGHT) failed.") ;
            assertEquals( Align.toString(Align.TOP)          , "t"  , "08 - Align.toString(Align.TOP) failed.") ;
            assertEquals( Align.toString(Align.TOP_LEFT)     , "tl" , "09 - Align.toString(Align.TOP_LEFT) failed.") ;
            assertEquals( Align.toString(Align.TOP_RIGHT)    , "tr" , "10 - Align.toString(Align.TOP_RIGHT) failed.") ;
            assertEquals( Align.toString(Align.LEFT_TOP)     , "lt" , "11 - Align.toString(Align.LEFT_TOP) failed.") ;
            assertEquals( Align.toString(Align.RIGHT_TOP)    , "rt" , "12 - Align.toString(Align.RIGHT_TOP) failed.") ;
            assertEquals( Align.toString(Align.LEFT_BOTTOM)  , "lb" , "13 - Align.toString(Align.LEFT_BOTTOM) failed.") ;
            assertEquals( Align.toString(Align.RIGHT_BOTTOM) , "rb" , "14 - Align.toString(Align.RIGHT_BOTTOM) failed.") ;
            
            assertEquals( Align.toString(0)            , "" , "15 - Align.toString(0) failed.") ;
            assertEquals( Align.toString(Align.CENTER) , "" , "16 - Align.toString(Align.CENTER) failed.") ;
            assertEquals( Align.toString(100)          , "" , "17 - Align.toString(100) failed.") ; // no valid value
        }
        
        public function testValidate():void
        {
            assertTrue( Align.validate( Align.CENTER       ) , "00 - Align.validate() failed.") ;
            assertTrue( Align.validate( Align.CENTER_LEFT  ) , "01 - Align.validate() failed.") ;
            assertTrue( Align.validate( Align.CENTER_RIGHT ) , "02 - Align.validate() failed.") ;
            assertTrue( Align.validate( Align.LEFT         ) , "03 - Align.validate() failed.") ;
            assertTrue( Align.validate( Align.RIGHT        ) , "04 - Align.validate() failed.") ;
            assertTrue( Align.validate( Align.TOP          ) , "05 - Align.validate() failed.") ;
            assertTrue( Align.validate( Align.BOTTOM       ) , "06 - Align.validate() failed.") ;
            assertTrue( Align.validate( Align.TOP_LEFT     ) , "07 - Align.validate() failed.") ;
            assertTrue( Align.validate( Align.TOP_RIGHT    ) , "08 - Align.validate() failed.") ;
            assertTrue( Align.validate( Align.BOTTOM_LEFT  ) , "09 - Align.validate() failed.") ;
            assertTrue( Align.validate( Align.BOTTOM_RIGHT ) , "10 - Align.validate() failed.") ;
            
            assertFalse( Align.validate( 100 ) , "11 - Align.validate() failed.") ;
        }
    }
}
