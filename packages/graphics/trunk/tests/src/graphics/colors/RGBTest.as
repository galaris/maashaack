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

package graphics.colors 
{    import buRRRn.ASTUce.framework.TestCase;
    
    import system.Cloneable;
    import system.Equatable;
    import system.Serializable;
    
    public class RGBTest extends TestCase 
    {        public function RGBTest(name:String = "")
        {            super(name);        }
        
        public function testConstructor():void
        {
            var rgb:RGB ;
            
            rgb = new RGB() ;
            assertNotNull( rgb , "01-01 - Constructor failed." ) ;
            assertEquals(rgb.r , 0 , "01-02 Constructor failed with the r parameter.") ;
            assertEquals(rgb.g , 0 , "01-03 Constructor failed with the g parameter.") ;
            assertEquals(rgb.b , 0 , "01-04 Constructor failed with the b parameter.") ;
            
            rgb = new RGB(255,255,255) ;
            assertNotNull( rgb           , "02-01 - Constructor failed." ) ;
            assertEquals(rgb.r , 255 , "02-02 Constructor failed with the r parameter.") ;
            assertEquals(rgb.g , 255 , "02-03 Constructor failed with the g parameter.") ;
            assertEquals(rgb.b , 255 , "02-04 Constructor failed with the b parameter.") ;
        }
        
        public function testInterface():void
        {
            var rgb:RGB = new RGB() ;
            assertTrue( rgb is Cloneable    , "RGB must implements the Cloneable interface.") ;
            assertTrue( rgb is Equatable    , "RGB must implements the Equatable interface.") ;
            assertTrue( rgb is Serializable , "RGB must implements the Serializable interface.") ;
        }
        
        public function testB():void
        {
            var rgb:RGB ;
            
            rgb = new RGB() ;
            assertEquals(rgb.b , 0 , "01 - b property failed.") ;
            
            rgb.b = 2 ;
            assertEquals(rgb.b , 2 , "02 - b property failed.") ;
            
            rgb.b = 255 ;
            assertEquals(rgb.b , 255 , "03 - b property failed.") ;
            
            rgb.b = 1000 ;
            assertEquals(rgb.b , 255 , "04 - b property failed.") ;
        }
        
        public function testG():void
        {
            var rgb:RGB ;
            
            rgb = new RGB() ;
            assertEquals(rgb.g , 0 , "01 - g property failed.") ;
            
            rgb.g = 2 ;
            assertEquals(rgb.g , 2 , "02 - g property failed.") ;
            
            rgb.g = 255 ;
            assertEquals(rgb.g , 255 , "03 - g property failed.") ;
            
            rgb.g = 1000 ;
            assertEquals(rgb.g , 255 , "04 - g property failed.") ;
        }
        
        public function testR():void
        {
            var rgb:RGB ;
            
            rgb = new RGB() ;
            assertEquals(rgb.r , 0 , "01 - r property failed.") ;
            
            rgb.r = 2 ;
            assertEquals(rgb.r , 2 , "02 - r property failed.") ;
            
            rgb.r = 255 ;
            assertEquals(rgb.r , 255 , "03 - r property failed.") ;
            
            rgb.r = 1000 ;
            assertEquals(rgb.r , 255 , "04 - r property failed.") ;
        }
        
        public function testLuminance():void
        {
            var rgb:RGB ;
            
            rgb = new RGB(0,0,0) ;
            assertEquals(0 , rgb.luminance , "#1") ;
            
            rgb = new RGB(255,0,0) ;
            assertEquals( 76.24499999999999 , rgb.luminance , "#2") ;
            
            rgb = new RGB(255,0,0) ;
            rgb.luminance = 0.5 ;
            assertEquals( rgb , new RGB(254,0,0)  , "#2-01") ;
            assertEquals( rgb.luminance  , 75.946  , "#2-02") ;
            
            rgb = new RGB(255,0,0) ;
            rgb.luminance = 255 ;
            assertEquals( rgb , new RGB(76,76,76)  , "#2-03") ;
            
            rgb = new RGB(255,255,255) ;
            assertEquals(255 , rgb.luminance , "#3") ;
        }
        
        public function testClone():void
        {
            var rgb:RGB = new RGB(255,255,255) ;
            var clone:RGB = rgb.clone() as RGB ;
            assertNotNull( clone , "01 - clone() failed." ) ;
            assertEquals(rgb.r , clone.r , "02  - clone() failed.") ;
            assertEquals(rgb.g , clone.g , "03 - clone() failed.") ;
            assertEquals(rgb.b , clone.b , "04 - clone() failed.") ;
        }
        public function testEquals():void
        {
            var rgb1:RGB = new RGB(255,255,255) ;
            var rgb2:RGB = new RGB(255,255,255) ;
            var rgb3:RGB = new RGB(10,255,255) ;
            var rgb4:RGB = new RGB(255,10,255) ;
            var rgb5:RGB = new RGB(255,255,10) ;
            
            assertTrue( rgb1.equals(rgb1) , "01-01  - equals() failed.") ;
            assertTrue( rgb1.equals(rgb2) , "01-02  - equals() failed.") ;
            
            assertFalse( rgb1.equals(null) , "02-01  - equals() failed.") ;
            assertFalse( rgb1.equals(2)    , "02-01  - equals() failed.") ;
            
            assertFalse( rgb1.equals(rgb3) , "03-02  - equals() failed.") ;
            assertFalse( rgb1.equals(rgb4) , "03-02  - equals() failed.") ;
            assertFalse( rgb1.equals(rgb5) , "03-03  - equals() failed.") ;
        }
        
        public function testDifference():void
        {
            var rgb:RGB ;
            
            rgb = new RGB(255,255,255) ;
            rgb.difference();
            assertEquals(rgb.r , 0 , "01-01  - difference() failed.") ;
            assertEquals(rgb.g , 0 , "01-02 - difference() failed.") ;
            assertEquals(rgb.b , 0 , "01-03 - difference() failed.") ;
            
            rgb = new RGB(0,0,0) ;
            rgb.difference();
            assertEquals(rgb.r , 255 , "02-01  - difference() failed.") ;
            assertEquals(rgb.g , 255 , "02-02 - difference() failed.") ;
            assertEquals(rgb.b , 255 , "02-03 - difference() failed.") ;
        }
        
        public function testFromNumber():void 
        {
           var rgb:RGB = new RGB() ;
           
           rgb.fromNumber( 0xEA6F51 ) ;
           assertEquals(rgb.r , 234 , "01-01 - fromNumber() failed.") ;
           assertEquals(rgb.g , 111 , "01-02 - fromNumber() failed.") ;
           assertEquals(rgb.b , 81  , "01-03 - fromNumber() failed.") ;
           
           rgb.fromNumber( 0xFFFFFF ) ;
           assertEquals(rgb.r , 255 , "02-01 - fromNumber() failed.") ;
           assertEquals(rgb.g , 255 , "02-02 - fromNumber() failed.") ;
           assertEquals(rgb.b , 255 , "02-03 - fromNumber() failed.") ;
           
           rgb.fromNumber( 0 ) ;
           assertEquals(rgb.r , 0 , "03-01 - fromNumber() failed.") ;
           assertEquals(rgb.g , 0 , "03-02 - fromNumber() failed.") ;
           assertEquals(rgb.b , 0 , "03-03 - fromNumber() failed.") ;
        } 
        
        public function testFromNumberStatic():void 
        {
           var rgb:RGB = new RGB() ;
           
           rgb = RGB.fromNumber( 0xEA6F51 ) ;
           assertEquals( rgb , new RGB( 234 , 111 , 81 ) , "01 - RGB.fromNumber failed.") ;
            
           rgb = RGB.fromNumber( 0xFFFFFF ) ;
           assertEquals( rgb , new RGB( 255 , 255 , 255 ) , "02 - RGB.fromNumber failed.") ;
           
           rgb = RGB.fromNumber( 0 ) ;
           assertEquals( rgb , new RGB( 0 , 0 , 0 )       , "03 - RGB.fromNumber failed.") ;
        } 
        
        public function testInterpolate():void 
        {
           var rgb1:RGB = new RGB(0,0,0) ;
           var rgb2:RGB = new RGB(255,255,255) ;
           
           var rgb:RGB ;
           
           rgb = rgb1.interpolate( rgb2 , 0 ) ;
           assertEquals(rgb , new RGB(0,0,0) , "01 - interpolate() failed.") ;
           
           rgb = rgb1.interpolate( rgb2 ) ;
           assertEquals(rgb , new RGB(255,255,255) , "02 - interpolate() failed.") ;
           
           rgb = rgb1.interpolate( rgb2 , 0.5 ) ;
           assertEquals(rgb , new RGB(127.5,127.5,127.5) , "03 - interpolate() failed.") ;   
        }
        
        public function testInterpolateToNumber():void 
        {
           var rgb1:RGB = new RGB(0,0,0) ;
           var rgb2:RGB = new RGB(255,255,255) ;
           
           var result:Number ;
           
           result = rgb1.interpolateToNumber( rgb2 , 0 ) ;
           assertEquals(result , 0x000000 , "01 - interpolate() failed.") ;
           
           result = rgb1.interpolateToNumber( rgb2 ) ;
           assertEquals(result , 0xFFFFFF , "02 - interpolate() failed.") ;
           
           result = rgb1.interpolateToNumber( rgb2 , 0.5 ) ;
           assertEquals(result , 0x7F7F7F , "03 - interpolate() failed.") ;   
        }
        
        public function testSet():void
        {
            var rgb:RGB = new RGB() ;
            rgb.set(234,111,81) ;
            assertEquals(rgb.r , 234 , "01 - set() failed.") ;
            assertEquals(rgb.g , 111 , "02 - set() failed.") ;
            assertEquals(rgb.b , 81  , "03 - set() failed.") ;
        }
        
        public function testToHexString():void
        {
            var rgb:RGB = new RGB(234,111,81) ;
            assertEquals(rgb.toHexString()    , "0xEA6F51" , "01 - toHexString() failed.") ;
            assertEquals(rgb.toHexString("#") , "#EA6F51"  , "02 - toHexString() failed.") ;
            assertEquals(rgb.toHexString("")  , "EA6F51"   , "03 - toHexString() failed.") ;
        }
        
        public function testToNumberStatic():void 
        {
           assertEquals( RGB.toNumber(234,111,81)  , 0xEA6F51 , "01 - Colors.RGB2Number failed.") ;
           assertEquals( RGB.toNumber(255,255,255) , 0xFFFFFF , "02 - Colors.RGB2Number failed.") ;
           assertEquals( RGB.toNumber(0,0,0)       , 0x000000 , "03 - Colors.RGB2Number failed.") ;
        }
        
        public function testToObject():void
        {
            var rgb:RGB  = new RGB(234,111,81) ;
            var o:Object = rgb.toObject() ;
            assertEquals( rgb.r , o.r , "01 - toObject() failed.") ;
            assertEquals( rgb.g , o.g , "02 - toObject() failed.") ;
            assertEquals( rgb.b , o.b , "03 - toObject() failed.") ;
        }
        
        public function testToSource():void
        {
            var rgb:RGB = new RGB(234,111,81) ;
            assertEquals( rgb.toSource() , "new graphics.colors.RGB(234,111,81)" , "toSource() failed.") ;
        }
        
        public function testToString():void
        {
            var rgb:RGB = new RGB(234,111,81) ;
            assertEquals( rgb.toString() , "[RGB r:234 g:111 b:81 hex:0xEA6F51]" , "toString() failed.") ;
        }
        
        public function testValueOf():void
        {
            var rgb:RGB = new RGB(234,111,81) ;
            assertEquals( rgb.valueOf() , 0xEA6F51 , "valueOf() failed.") ;
        }
    }}