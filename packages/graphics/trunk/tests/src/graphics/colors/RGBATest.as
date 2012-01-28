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
  Portions created by the Initial Developers are Copyright (C) 2006-2012
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
{    import library.ASTUce.framework.TestCase;

    public class RGBATest extends TestCase 
    {
        public function RGBATest(name:String = "")
        {            super(name);        }
        
        public function testConstructor():void
        {
            var rgb:RGBA ;
            
            rgb = new RGBA() ;
            assertNotNull( rgb     , "01-01 - Constructor failed." ) ;
            assertEquals(rgb.r , 0 , "01-02 Constructor failed with the r parameter.") ;
            assertEquals(rgb.g , 0 , "01-03 Constructor failed with the g parameter.") ;
            assertEquals(rgb.b , 0 , "01-04 Constructor failed with the b parameter.") ;
            assertEquals(rgb.a , 1 , "01-05 Constructor failed with the a parameter.") ;
            
            rgb = new RGBA(255,255,255,0.5) ;
            assertNotNull( rgb       , "02-01 - Constructor failed." ) ;
            assertEquals(rgb.r , 255 , "02-02 Constructor failed with the r parameter.") ;
            assertEquals(rgb.g , 255 , "02-03 Constructor failed with the g parameter.") ;
            assertEquals(rgb.b , 255 , "02-04 Constructor failed with the b parameter.") ;
            assertEquals(rgb.a , 0.5 , "02-05 Constructor failed with the a parameter.") ;
        }
        
        public function testInterface():void
        {
            var rgb:RGBA = new RGBA() ;
            assertTrue( rgb is ColorSpace , "RGBA must implements the ColorSpace interface.") ;
        }
        
        public function testB():void
        {
            var c:RGBA ;
            
            c = new RGBA() ;
            assertEquals(c.b , 0 , "01 - b property failed.") ;
            
            c.b = 2 ;
            assertEquals(c.b , 2 , "02 - b property failed.") ;
            
            c.b = 255 ;
            assertEquals(c.b , 255 , "03 - b property failed.") ;
            
            c.b = 1000 ;
            assertEquals(c.b , 255 , "04 - b property failed.") ;
        }
        
        public function testG():void
        {
            var c:RGBA ;
            
            c = new RGBA() ;
            assertEquals(c.g , 0 , "01 - g property failed.") ;
            
            c.g = 2 ;
            assertEquals(c.g , 2 , "02 - g property failed.") ;
            
            c.g = 255 ;
            assertEquals(c.g , 255 , "03 - g property failed.") ;
            
            c.g = 1000 ;
            assertEquals(c.g , 255 , "04 - g property failed.") ;
        }
        
        public function testR():void
        {
            var c:RGB ;
            
            c = new RGBA() ;
            assertEquals(c.r , 0 , "01 - r property failed.") ;
            
            c.r = 2 ;
            assertEquals(c.r , 2 , "02 - r property failed.") ;
            
            c.r = 255 ;
            assertEquals(c.r , 255 , "03 - r property failed.") ;
            
            c.r = 1000 ;
            assertEquals(c.r , 255 , "04 - r property failed.") ;
        }
        
        public function testA():void
        {
            var c:RGBA = new RGBA() ;
            
            assertEquals(c.a , 1 , "01 - a property failed.") ;
            
            c.a = 2 ;
            assertEquals(c.a , 1 , "02 - a property failed.") ;
            
            c.a = 0 ;
            assertEquals(c.r , 0 , "03 - a property failed.") ;
            
            c.a = 0.5 ;
            assertEquals(c.a , 0.5 , "04 - a property failed.") ;
            
            c.a = 1 ;
            assertEquals(c.a , 1 , "05 - a property failed.") ;
        }
        
        public function testOffset():void
        {
            var c:RGBA = new RGBA() ;
            c.offset = 127.5 ;
            assertEquals(c.a , 0.5 , "a property failed.") ;
        }
        
        public function testPercent():void
        {
            var c:RGBA = new RGBA() ;
            c.percent = 50 ;
            assertEquals(c.a , 0.5 , "a property failed.") ;
        }
        
        public function testClone():void
        {
            var c:RGBA = new RGBA(255,255,255,0.5) ;
            var clone:RGBA = c.clone() as RGBA ;
            assertNotNull( clone       , "01 - clone() failed." ) ;
            assertEquals(c.r , clone.r , "02  - clone() failed.") ;
            assertEquals(c.g , clone.g , "03 - clone() failed.") ;
            assertEquals(c.b , clone.b , "04 - clone() failed.") ;
            assertEquals(c.a , clone.a , "05 - clone() failed.") ;
        }
        
        public function testDifference():void
        {
            var rgb:RGBA ;
            
            rgb = new RGBA(255,255,255,0) ;
            rgb.difference();
            assertEquals(rgb.r , 0 , "01-01  - difference() failed.") ;
            assertEquals(rgb.g , 0 , "01-02 - difference() failed.") ;
            assertEquals(rgb.b , 0 , "01-03 - difference() failed.") ;
            assertEquals(rgb.a , 1 , "01-04 - difference() failed.") ;
            
            rgb = new RGBA(0,0,0,1) ;
            rgb.difference();
            assertEquals(rgb.r , 255 , "02-01  - difference() failed.") ;
            assertEquals(rgb.g , 255 , "02-02 - difference() failed.") ;
            assertEquals(rgb.b , 255 , "02-03 - difference() failed.") ;
            assertEquals(rgb.a ,   0 , "02-04 - difference() failed.") ;
        }
        
        public function testEquals():void
        {
            var rgba1:RGBA = new RGBA(255,255,255,0.5) ;
            var rgba2:RGBA = new RGBA(255,255,255,0.5) ;
            var rgba3:RGBA = new RGBA(10,255,255,0.5) ;
            var rgba4:RGBA = new RGBA(255,10,255,0.5) ;
            var rgba5:RGBA = new RGBA(255,255,10,0.5) ;
            var rgba6:RGBA = new RGBA(255,255,255,0.8) ;
            
            assertTrue( rgba1.equals(rgba1) , "01-01  - equals() failed.") ;
            assertTrue( rgba1.equals(rgba2) , "01-02  - equals() failed.") ;
            
            assertFalse( rgba1.equals(null) , "02-01  - equals() failed.") ;
            assertFalse( rgba1.equals(2)    , "02-01  - equals() failed.") ;
            
            assertFalse( rgba1.equals(rgba3) , "03-02  - equals() failed.") ;
            assertFalse( rgba1.equals(rgba4) , "03-02  - equals() failed.") ;
            assertFalse( rgba1.equals(rgba5) , "03-03  - equals() failed.") ;
            assertFalse( rgba1.equals(rgba6) , "03-04  - equals() failed.") ;
        }
        
        public function testFromNumber():void 
        {
           var rgb:RGBA = new RGBA() ;
           
           rgb.fromNumber( 0xFFEA6F51 ) ;
           assertEquals(rgb.r , 234 , "01-01 - fromNumber() failed.") ;
           assertEquals(rgb.g , 111 , "01-02 - fromNumber() failed.") ;
           assertEquals(rgb.b , 81  , "01-03 - fromNumber() failed.") ;
           assertEquals(rgb.a , 1   , "01-04 - fromNumber() failed.") ;
           
           rgb.fromNumber( 0x00FFFFFF ) ;
           assertEquals(rgb.r , 255 , "02-01 - fromNumber() failed.") ;
           assertEquals(rgb.g , 255 , "02-02 - fromNumber() failed.") ;
           assertEquals(rgb.b , 255 , "02-03 - fromNumber() failed.") ;
           assertEquals(rgb.a , 0   , "01-04 - fromNumber() failed.") ;
           
           rgb.fromNumber( 0x99AAAAAA ) ;
           assertEquals(rgb.r , 170 , "03-01 - fromNumber() failed.") ;
           assertEquals(rgb.g , 170 , "03-02 - fromNumber() failed.") ;
           assertEquals(rgb.b , 170 , "03-03 - fromNumber() failed.") ;
           assertEquals(rgb.a , 0.6 , "03-04 - fromNumber() failed.") ;
           
           rgb.fromNumber( 0 ) ;
           assertEquals(rgb.r , 0 , "04-01 - fromNumber() failed.") ;
           assertEquals(rgb.g , 0 , "04-02 - fromNumber() failed.") ;
           assertEquals(rgb.b , 0 , "04-03 - fromNumber() failed.") ;
           assertEquals(rgb.a , 0 , "04-04 - fromNumber() failed.") ;
        } 
        
        public function testFromNumberStatic():void 
        {
           var rgb:RGBA = new RGBA() ;
           
           rgb = RGBA.fromNumber( 0xFFEA6F51 ) ;
           assertEquals(  rgb , new RGBA( 234 , 111 , 81 , 1 ) , "01 - RGBA.fromNumber failed.") ;
            
           rgb = RGBA.fromNumber( 0xFFFFFFFF ) ;
           assertEquals(  rgb , new RGBA( 255 , 255 , 255 , 1 ) , "02 - RGBA.fromNumber failed.") ;
           
           rgb = RGBA.fromNumber( 0 ) ;
           assertEquals(  rgb , new RGBA( 0 , 0 , 0 , 0 ) , "03 - RGBA.fromNumber failed.") ;
        } 
        
        public function testInterpolate():void 
        {
           var rgb:RGBA ;
           var rgb1:RGBA = new RGBA(0,0,0,0) ;
           var rgb2:RGBA = new RGBA(255,255,255,1) ;
           
           rgb = rgb1.interpolate( rgb2 , 0 ) as RGBA  ;
           assertEquals(rgb , new RGBA(0,0,0,0) , "01 - interpolate() failed.") ;
           
           rgb = rgb1.interpolate( rgb2 ) as RGBA ;
           assertEquals(rgb , new RGBA(255,255,255,1) , "02 - interpolate() failed.") ;
           
           rgb = rgb1.interpolate( rgb2 , 0.5 ) as RGBA ;
           assertEquals(rgb , new RGBA(127.5,127.5,127.5,0.5) , "03 - interpolate() failed.") ;   
        }
        
        public function testSet():void
        {
            var rgb:RGBA = new RGBA() ;
            rgb.set(234,111,81,0.6) ;
            assertEquals(rgb.r , 234 , "01-01 - set() failed.") ;
            assertEquals(rgb.g , 111 , "01-02 - set() failed.") ;
            assertEquals(rgb.b , 81  , "01-03 - set() failed.") ;
            assertEquals(rgb.a , 0.6 , "01-04 - set() failed.") ;
        }
        
        public function testToHexString():void
        {
            var rgb:RGBA = new RGBA(170,170,170,0.6) ;
            assertEquals(rgb.toHexString()    , "0x99AAAAAA" , "01 - toHexString() failed.") ;
            assertEquals(rgb.toHexString("#") , "#99AAAAAA"  , "02 - toHexString() failed.") ;
            assertEquals(rgb.toHexString("")  , "99AAAAAA"   , "03 - toHexString() failed.") ;
        }
        
        public function testToNumberStatic():void 
        {
           assertEquals( RGBA.toNumber(170,170,170,0.6), 0x99AAAAAA , "01 - Colors.RGBA2Number failed.") ;
           assertEquals( RGBA.toNumber(255,255,255,1)  , 0xFFFFFFFF , "02 - Colors.RGBA2Number failed.") ;
           assertEquals( RGBA.toNumber(0,0,0,0)        , 0x00000000 , "03 - Colors.RGBA2Number failed.") ;
        }
        
        public function testToObject():void
        {
            var rgb:RGBA  = new RGBA(234,111,81,0.5) ;
            var o:Object = rgb.toObject() ;
            assertEquals( rgb.r , o.r , "01 - toObject() failed.") ;
            assertEquals( rgb.g , o.g , "02 - toObject() failed.") ;
            assertEquals( rgb.b , o.b , "03 - toObject() failed.") ;
            assertEquals( rgb.a , o.a , "04 - toObject() failed.") ;
        }
        
        public function testToSource():void
        {
            var rgb:RGBA = new RGBA(234,111,81,0.5) ;
            assertEquals( rgb.toSource() , "new graphics.colors.RGBA(234,111,81,0.5)" , "toSource() failed.") ;
        }
        
        public function testToString():void
        {
            var rgb:RGBA = new RGBA(170,170,170,0.6) ;
            assertEquals( rgb.toString() , "[RGBA r:170 g:170 b:170 a:0.6 hex:0x99AAAAAA]" , "toString() failed.") ;
        }
        
        public function testValueOf():void
        {
            var rgb:RGB = new RGBA(170,170,170,0.6) ;
            assertEquals( rgb.valueOf() , 0x99AAAAAA , "valueOf() failed.") ;
        }
    }}