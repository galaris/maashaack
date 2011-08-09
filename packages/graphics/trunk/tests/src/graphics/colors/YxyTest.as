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
    
    public class YxyTest extends TestCase 
    {
        public function YxyTest(name:String = "")
        {
            super(name);
        }
        
        public function testConstructor():void
        {
            var color:Yxy ;
            
            color = new Yxy() ;
            assertNotNull( color , "01-01 - Constructor failed." ) ;
            assertEquals(color.Y , 0 , "01-02 Constructor failed with the x parameter.") ;
            assertEquals(color.x , 0 , "01-03 Constructor failed with the y parameter.") ;
            assertEquals(color.y , 0 , "01-04 Constructor failed with the z parameter.") ;
        }
        
        public function testInterface():void
        {
            var color:Yxy = new Yxy() ;
            assertTrue( color is ColorSpace , "Yxy must implements the ColorSpace interface.") ;
        }
        
        public function testY():void
        {
            var color:Yxy = new Yxy() ;
            assertEquals(color.Y , 0 , "01 - Y property failed.") ;
            
            color.Y = 2 ;
            assertEquals(color.Y , 2 , "02 - Y property failed.") ;
        }
        
        public function testx():void
        {
            var color:Yxy = new Yxy() ;
            assertEquals(color.x , 0 , "01 - x property failed.") ;
            
            color.x = 2 ;
            assertEquals(color.x , 2 , "02 - x property failed.") ;
        }
        
        public function testy():void
        {
            var color:Yxy = new Yxy() ;
            assertEquals(color.y , 0 , "01 - y property failed.") ;
            
            color.y = 2 ;
            assertEquals(color.y , 2 , "02 - y property failed.") ;
        }
        
        public function testClone():void
        {
            var color:Yxy = new Yxy(50,50,50) ;
            var clone:Yxy = color.clone() as Yxy ;
            assertNotNull( clone , "01 - clone() failed." ) ;
            assertEquals(color.Y , clone.Y , "02  - clone() failed.") ;
            assertEquals(color.x , clone.x , "03 - clone() failed.") ;
            assertEquals(color.y , clone.y , "04 - clone() failed.") ;
        }
        
        public function testEquals():void
        {
            var color1:Yxy = new Yxy(1,1,1) ;
            var color2:Yxy = new Yxy(1,1,1) ;
            var color3:Yxy = new Yxy(3,1,1) ;
            var color4:Yxy = new Yxy(1,3,1) ;
            var color5:Yxy = new Yxy(1,1,3) ;
            
            assertTrue( color1.equals(color1) , "01-01  - equals() failed.") ;
            assertTrue( color1.equals(color2) , "01-02  - equals() failed.") ;
            
            assertFalse( color1.equals(null) , "02-01  - equals() failed.") ;
            assertFalse( color1.equals(2)    , "02-01  - equals() failed.") ;
            
            assertFalse( color1.equals(color3) , "03-02  - equals() failed.") ;
            assertFalse( color1.equals(color4) , "03-02  - equals() failed.") ;
            assertFalse( color1.equals(color5) , "03-03  - equals() failed.") ;
        }
        
        public function testInterpolate():void 
        {
           var color1:Yxy = new Yxy(0,0,0) ;
           var color2:Yxy = new Yxy(1,1,1) ;
           
           var color:Yxy ;
           
           color = color1.interpolate( color2 , 0 ) ;
           assertEquals(color , new Yxy(0,0,0) , "01 - interpolate() failed.") ;
           
           color = color1.interpolate( color2 ) ;
           assertEquals(color , new Yxy(1,1,1) , "02 - interpolate() failed.") ;
           
           color = color1.interpolate( color2 , 0.5 ) ;
           assertEquals(color , new Yxy(0.5,0.5,0.5) , "03 - interpolate() failed.") ;   
        }
        
        public function testSet():void
        {
            var color:Yxy = new Yxy() ;
            color.set(1,1,1) ;
            assertEquals(color.Y , 1 , "01 - set() failed.") ;
            assertEquals(color.x , 1 , "02 - set() failed.") ;
            assertEquals(color.y , 1 , "03 - set() failed.") ;
        }
        
        public function testToObject():void
        {
            var color:Yxy  = new Yxy(1,1,1) ;
            var o:Object = color.toObject() ;
            assertEquals( color.Y , o.Y , "01 - toObject() failed.") ;
            assertEquals( color.x , o.x , "02 - toObject() failed.") ;
            assertEquals( color.y , o.y , "03 - toObject() failed.") ;
        }
        
        public function testToSource():void
        {
            var color:Yxy  = new Yxy(1,1,1) ;
            assertEquals( color.toSource() , "new graphics.colors.Yxy(1,1,1)" , "toSource() failed.") ;
        }
        
        public function testToString():void
        {
            var color:Yxy  = new Yxy(1,1,1) ;
            assertEquals( color.toString() , "[Yxy Y:1 x:1 y:1]" , "toString() failed.") ;
        }
    }
}
