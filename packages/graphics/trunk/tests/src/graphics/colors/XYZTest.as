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
{
    import library.ASTUce.framework.TestCase;
    
    public class XYZTest extends TestCase 
    {
        public function XYZTest(name:String = "")
        {
            super(name);
        }
        
        public function testConstructor():void
        {
            var xyz:XYZ ;
            
            xyz = new XYZ() ;
            assertNotNull( xyz , "01-01 - Constructor failed." ) ;
            assertEquals(xyz.X , 0 , "01-02 Constructor failed with the x parameter.") ;
            assertEquals(xyz.Y , 0 , "01-03 Constructor failed with the y parameter.") ;
            assertEquals(xyz.Z , 0 , "01-04 Constructor failed with the z parameter.") ;
        }
        
        public function testInterface():void
        {
            var xyz:XYZ = new XYZ() ;
            assertTrue( xyz is ColorSpace , "XYZ must implements the ColorSpace interface.") ;
        }
        
        public function testX():void
        {
            var xyz:XYZ = new XYZ() ;
            assertEquals(xyz.X , 0 , "01 - x property failed.") ;
            
            xyz.X = 2 ;
            assertEquals(xyz.X , 2 , "02 - x property failed.") ;
        }
        
        public function testY():void
        {
            var xyz:XYZ = new XYZ() ;
            assertEquals(xyz.Y , 0 , "01 - y property failed.") ;
            
            xyz.Y = 2 ;
            assertEquals(xyz.Y , 2 , "02 - y property failed.") ;
        }
        
        public function testZ():void
        {
            var xyz:XYZ = new XYZ() ;
            assertEquals(xyz.Z , 0 , "01 - z property failed.") ;
            
            xyz.Z = 2 ;
            assertEquals(xyz.Z , 2 , "02 - z property failed.") ;
        }
        
        public function testClone():void
        {
            var xyz:XYZ = new XYZ(50,50,50) ;
            var clone:XYZ = xyz.clone() as XYZ ;
            assertNotNull( clone , "01 - clone() failed." ) ;
            assertEquals(xyz.X , clone.X , "02  - clone() failed.") ;
            assertEquals(xyz.Y , clone.Y , "03 - clone() failed.") ;
            assertEquals(xyz.Z , clone.Z , "04 - clone() failed.") ;
        }
        
        public function testEquals():void
        {
            var xyz1:XYZ = new XYZ(1,1,1) ;
            var xyz2:XYZ = new XYZ(1,1,1) ;
            var xyz3:XYZ = new XYZ(3,1,1) ;
            var xyz4:XYZ = new XYZ(1,3,1) ;
            var xyz5:XYZ = new XYZ(1,1,3) ;
            
            assertTrue( xyz1.equals(xyz1) , "01-01  - equals() failed.") ;
            assertTrue( xyz1.equals(xyz2) , "01-02  - equals() failed.") ;
            
            assertFalse( xyz1.equals(null) , "02-01  - equals() failed.") ;
            assertFalse( xyz1.equals(2)    , "02-01  - equals() failed.") ;
            
            assertFalse( xyz1.equals(xyz3) , "03-02  - equals() failed.") ;
            assertFalse( xyz1.equals(xyz4) , "03-02  - equals() failed.") ;
            assertFalse( xyz1.equals(xyz5) , "03-03  - equals() failed.") ;
        }
        
        public function testInterpolate():void 
        {
           var xyz1:XYZ = new XYZ(0,0,0) ;
           var xyz2:XYZ = new XYZ(1,1,1) ;
           
           var xyz:XYZ ;
           
           xyz = xyz1.interpolate( xyz2 , 0 ) ;
           assertEquals(xyz , new XYZ(0,0,0) , "01 - interpolate() failed.") ;
           
           xyz = xyz1.interpolate( xyz2 ) ;
           assertEquals(xyz , new XYZ(1,1,1) , "02 - interpolate() failed.") ;
           
           xyz = xyz1.interpolate( xyz2 , 0.5 ) ;
           assertEquals(xyz , new XYZ(0.5,0.5,0.5) , "03 - interpolate() failed.") ;   
        }
        
        public function testSet():void
        {
            var xyz:XYZ = new XYZ() ;
            xyz.set(1,1,1) ;
            assertEquals(xyz.X , 1 , "01 - set() failed.") ;
            assertEquals(xyz.Y , 1 , "02 - set() failed.") ;
            assertEquals(xyz.Z , 1 , "03 - set() failed.") ;
        }
        
        public function testToObject():void
        {
            var xyz:XYZ  = new XYZ(1,1,1) ;
            var o:Object = xyz.toObject() ;
            assertEquals( xyz.X , o.X , "01 - toObject() failed.") ;
            assertEquals( xyz.Y , o.Y , "02 - toObject() failed.") ;
            assertEquals( xyz.Z , o.Z , "03 - toObject() failed.") ;
        }
        
        public function testToSource():void
        {
            var xyz:XYZ  = new XYZ(1,1,1) ;
            assertEquals( xyz.toSource() , "new graphics.colors.XYZ(1,1,1)" , "toSource() failed.") ;
        }
        
        public function testToString():void
        {
            var xyz:XYZ  = new XYZ(1,1,1) ;
            assertEquals( xyz.toString() , "[XYZ X:1 Y:1 Z:1]" , "toString() failed.") ;
        }
    }
}
