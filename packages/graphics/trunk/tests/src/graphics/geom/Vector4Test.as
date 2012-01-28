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

package graphics.geom 
{
    import graphics.Geometry;

    import library.ASTUce.framework.TestCase;
    
    public class Vector4Test extends TestCase 
    {
        public function Vector4Test(name:String = "")
        {
            super( name );
        }
        
        public var v:Vector4;
       
        public function setUp():void
        {
            v = new Vector4(10, 20, 30, 40) ;
        }
        
        public function tearDown():void
        {
            v = undefined ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( v, "VECT_00_01 - constructor is null") ;
            assertTrue( v is Vector4 , "VECT_00_02 - constructor is an instance of Vector4.") ;
        }
        
        public function testInterface():void
        {
            assertTrue( v is Geometry , "implements the Geometry interface failed.") ;
        }
        
        public function testToSource():void
        {
            assertEquals( v.toSource() , "new graphics.geom.Vector4(10,20,30,40)", "toSource failed : " + v.toSource() ) ;
        }
        
        public function testToString():void
        {
            assertEquals( v.toString() , "[Vector4 x:10 y:20 z:30 w:40]", "toString failed : " + v.toString() ) ;
        }
        
        public function testX():void
        {
            assertEquals( v.x , 10, "x property failed : " + v.x ) ;
        }
        
        public function testY():void
        {
            assertEquals( v.y , 20, "y property failed : " + v.y ) ;
        }
        
        public function testZ():void
        {
            assertEquals( v.z , 30, "z property failed : " + v.z ) ;
        }
        
        public function testW():void
        {
            assertEquals( v.w , 40, "w property failed : " + v.w ) ;
        }
        
        public function testClone():void
        {
            var clone:Vector4 = v.clone() ;
            clone.x = 100 ;
            clone.y = 200 ;
            clone.z = 300 ;
            clone.w = 400 ;
            assertTrue( clone is Vector4 , "01 - clone method failed, must return a Vector4 reference." ) ;
            assertFalse( v.x == clone.x, "02 - clone property failed, v.x:" + v.x + " must be different of clone.x:" + clone.x ) ;
            assertFalse( v.y == clone.y, "03 - clone property failed, v.y:" + v.y + " must be different of clone.y:" + clone.y ) ;
            assertFalse( v.z == clone.z, "04 - clone property failed, v.z:" + v.z + " must be different of clone.z:" + clone.z ) ;
            assertFalse( v.w == clone.w, "05 - clone property failed, v.w:" + v.w + " must be different of clone.w:" + clone.w ) ;
        }
        
        public function testEquals():void
        {
            var v1:Vector4 = new Vector4(10, 20, 30, 40) ;
            assertTrue( v.equals(v1) , "01 - equals method failed.") ;
        }
    }
}
