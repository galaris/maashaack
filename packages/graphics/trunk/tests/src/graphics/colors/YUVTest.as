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
{
    import buRRRn.ASTUce.framework.TestCase;
    
    public class YUVTest extends TestCase 
    {
        public function YUVTest(name:String = "")
        {
            super(name);
        }
        
        public function testConstructor():void
        {
            var yuv:YUV ;
            yuv = new YUV() ;
            assertNotNull( yuv , "01-01 - Constructor failed." ) ;
            assertEquals(yuv.y , 0 , "01-02 Constructor failed with the x parameter.") ;
            assertEquals(yuv.u , 0 , "01-03 Constructor failed with the y parameter.") ;
            assertEquals(yuv.v , 0 , "01-04 Constructor failed with the z parameter.") ;
        }
        
        public function testInterface():void
        {
            var yuv:YUV = new YUV() ;
            assertTrue( yuv is ColorSpace , "YUV must implements the ColorSpace interface.") ;
        }
        
        public function testY():void
        {
            var yuv:YUV = new YUV() ;
            assertEquals(yuv.y , 0 , "01 - y property failed.") ;
            
            yuv.y = 2 ;
            assertEquals(yuv.y , 2 , "02 - y property failed.") ;
        }
        
        public function testU():void
        {
            var yuv:YUV = new YUV() ;
            assertEquals(yuv.u , 0 , "01 - u property failed.") ;
            
            yuv.u = 2 ;
            assertEquals(yuv.u , 2 , "02 - u property failed.") ;
        }
        
        public function testV():void
        {
            var yuv:YUV = new YUV() ;
            assertEquals(yuv.v , 0 , "01 - v property failed.") ;
            
            yuv.v = 2 ;
            assertEquals(yuv.v , 2 , "02 - v property failed.") ;
        }
        
        public function testClone():void
        {
            var yuv:YUV = new YUV(50,50,50) ;
            var clone:YUV = yuv.clone() as YUV ;
            assertNotNull( clone , "01 - clone() failed." ) ;
            assertEquals(yuv.y , clone.y , "02  - clone() failed.") ;
            assertEquals(yuv.u , clone.u , "03 - clone() failed.") ;
            assertEquals(yuv.v , clone.v , "04 - clone() failed.") ;
        }
        
        public function testEquals():void
        {
            var yuv1:YUV = new YUV(1,1,1) ;
            var yuv2:YUV = new YUV(1,1,1) ;
            var yuv3:YUV = new YUV(3,1,1) ;
            var yuv4:YUV = new YUV(1,3,1) ;
            var yuv5:YUV = new YUV(1,1,3) ;
            
            assertTrue( yuv1.equals(yuv1) , "01-01  - equals() failed.") ;
            assertTrue( yuv1.equals(yuv2) , "01-02  - equals() failed.") ;
            
            assertFalse( yuv1.equals(null) , "02-01  - equals() failed.") ;
            assertFalse( yuv1.equals(2)    , "02-01  - equals() failed.") ;
            
            assertFalse( yuv1.equals(yuv3) , "03-02  - equals() failed.") ;
            assertFalse( yuv1.equals(yuv4) , "03-02  - equals() failed.") ;
            assertFalse( yuv1.equals(yuv5) , "03-03  - equals() failed.") ;
        }
        
        public function testInterpolate():void 
        {
           var yuv1:YUV = new YUV(0,0,0) ;
           var yuv2:YUV = new YUV(1,1,1) ;
           
           var yuv:YUV ;
           
           yuv = yuv1.interpolate( yuv2 , 0 ) ;
           assertEquals(yuv , new YUV(0,0,0) , "01 - interpolate() failed.") ;
           
           yuv = yuv1.interpolate( yuv2 ) ;
           assertEquals(yuv , new YUV(1,1,1) , "02 - interpolate() failed.") ;
           
           yuv = yuv1.interpolate( yuv2 , 0.5 ) ;
           assertEquals(yuv , new YUV(0.5,0.5,0.5) , "03 - interpolate() failed.") ;   
        }
        
        public function testSet():void
        {
            var yuv:YUV = new YUV() ;
            yuv.set(1,1,1) ;
            assertEquals(yuv.y , 1 , "01 - set() failed.") ;
            assertEquals(yuv.u , 1 , "02 - set() failed.") ;
            assertEquals(yuv.v , 1 , "03 - set() failed.") ;
        }
        
        public function testToObject():void
        {
            var yuv:YUV  = new YUV(1,1,1) ;
            var o:Object = yuv.toObject() ;
            assertEquals( yuv.y , o.y , "01 - toObject() failed.") ;
            assertEquals( yuv.u , o.u , "02 - toObject() failed.") ;
            assertEquals( yuv.v , o.v , "03 - toObject() failed.") ;
        }
        
        public function testToSource():void
        {
            var yuv:YUV  = new YUV(1,1,1) ;
            assertEquals( yuv.toSource() , "new graphics.colors.YUV(1,1,1)" , "toSource() failed.") ;
        }
        
        public function testToString():void
        {
            var yuv:YUV  = new YUV(1,1,1) ;
            assertEquals( yuv.toString() , "[YUV y:1 u:1 v:1]" , "toString() failed.") ;
        }
    }
}
