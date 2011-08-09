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
    import buRRRn.ASTUce.framework.TestCase;

    public class OrientationTest extends TestCase 
    {
        public function OrientationTest(name:String = "")
        {
            super(name);
        }
        
        public function testBOTTOM_TO_TOP():void
        {
            assertEquals( 4 , Orientation.BOTTOM_TO_TOP ) ;
        }
        
        public function testLEFT_TO_RIGHT():void
        {
            assertEquals( 1 , Orientation.LEFT_TO_RIGHT ) ;
        }
        
        public function testRIGHT_TO_LEFT():void
        {
            assertEquals( 2 , Orientation.RIGHT_TO_LEFT ) ;
        }
        
        public function testTOP_TO_BOTTOM():void
        {
            assertEquals( 8 , Orientation.TOP_TO_BOTTOM ) ;
        }
        
        public function testLEFT_TO_RIGHT_BOTTOM_TO_TOP():void
        {
            assertEquals( 5 , Orientation.LEFT_TO_RIGHT_BOTTOM_TO_TOP ) ;
            assertEquals( Orientation.LEFT_TO_RIGHT | Orientation.BOTTOM_TO_TOP , Orientation.LEFT_TO_RIGHT_BOTTOM_TO_TOP ) ;
        }
        
        public function testLEFT_TO_RIGHT_TOP_TO_BOTTOM():void
        {
            assertEquals( 9 , Orientation.LEFT_TO_RIGHT_TOP_TO_BOTTOM ) ;
            assertEquals( Orientation.LEFT_TO_RIGHT | Orientation.TOP_TO_BOTTOM , Orientation.LEFT_TO_RIGHT_TOP_TO_BOTTOM ) ;
        }
        
        public function testRIGHT_TO_LEFT_BOTTOM_TO_TOP():void
        {
            assertEquals( 6 , Orientation.RIGHT_TO_LEFT_BOTTOM_TO_TOP ) ;
            assertEquals( Orientation.RIGHT_TO_LEFT | Orientation.BOTTOM_TO_TOP , Orientation.RIGHT_TO_LEFT_BOTTOM_TO_TOP ) ;
        }
        
        public function testRIGHT_TO_LEFT_TOP_TO_BOTTOM():void
        {
            assertEquals( 10 , Orientation.RIGHT_TO_LEFT_TOP_TO_BOTTOM ) ;
            assertEquals( Orientation.RIGHT_TO_LEFT | Orientation.TOP_TO_BOTTOM , Orientation.RIGHT_TO_LEFT_TOP_TO_BOTTOM ) ;
        }
        
        
        public function testToString():void
        {
            assertEquals( "btt" , Orientation.toString( Orientation.BOTTOM_TO_TOP ) )  ;
            assertEquals( "ltr" , Orientation.toString( Orientation.LEFT_TO_RIGHT ) )  ;
            assertEquals( "rtl" , Orientation.toString( Orientation.RIGHT_TO_LEFT ) )  ;
            assertEquals( "ttb" , Orientation.toString( Orientation.TOP_TO_BOTTOM ) )  ;
            
            assertEquals( "ltrbtt" , Orientation.toString( Orientation.LEFT_TO_RIGHT_BOTTOM_TO_TOP ) )  ;
            assertEquals( "ltrttb" , Orientation.toString( Orientation.LEFT_TO_RIGHT_TOP_TO_BOTTOM ) )  ;
            assertEquals( "rtlbtt" , Orientation.toString( Orientation.RIGHT_TO_LEFT_BOTTOM_TO_TOP ) )  ;
            assertEquals( "rtlttb" , Orientation.toString( Orientation.RIGHT_TO_LEFT_TOP_TO_BOTTOM ) )  ;
            
            assertEquals( "" , Orientation.toString( 0 ) ) ;
            assertEquals( "" , Orientation.toString( 100 ) ) ;
        }
        
        public function testValidate():void
        {
            assertTrue( Orientation.validate( Orientation.BOTTOM_TO_TOP ) )  ;
            assertTrue( Orientation.validate( Orientation.LEFT_TO_RIGHT ) )  ;            assertTrue( Orientation.validate( Orientation.RIGHT_TO_LEFT ) )  ;            assertTrue( Orientation.validate( Orientation.TOP_TO_BOTTOM ) )  ;
            
            assertTrue( Orientation.validate( Orientation.LEFT_TO_RIGHT_BOTTOM_TO_TOP ) )  ;
            assertTrue( Orientation.validate( Orientation.LEFT_TO_RIGHT_TOP_TO_BOTTOM ) )  ;
            assertTrue( Orientation.validate( Orientation.RIGHT_TO_LEFT_BOTTOM_TO_TOP ) )  ;
            assertTrue( Orientation.validate( Orientation.RIGHT_TO_LEFT_TOP_TO_BOTTOM ) )  ;
            
            assertFalse( Orientation.validate( 0 ) ) ;
            assertFalse( Orientation.validate( 100 ) ) ;
        }
    }
}
