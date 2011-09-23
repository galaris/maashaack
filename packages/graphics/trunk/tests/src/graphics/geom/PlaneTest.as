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

package graphics.geom 
{
    import graphics.Geometry;

    import library.ASTUce.framework.TestCase;
    
    public class PlaneTest extends TestCase 
    {
        public function PlaneTest(name:String = "")
        {
            super( name );
        }
        
        public var p:Plane;
        
        public function setUp():void
        {
            p = new Plane(10, 20, 30, 40) ;
        }
        
        public function tearDown():void
        {
            p = null ;
        }    
        
        public function testConstructor():void
        {   
            assertNotNull( p, "PLANE_00_01 - constructor is null") ;
            assertTrue( p is Plane, "PLANE_00_02 - constructor is an instance of Plane.") ;
        }
        
        public function testInterface():void
        {
            assertTrue( p is Geometry  , "PLANE_01_01 - implements Geometry failed.") ;
        }   
        
        public function testToSource():void
        {
            assertEquals( p.toSource() , "new graphics.geom.Plane(10,20,30,40)", "PLANE_03 - toSource failed : " + p.toSource() ) ;
        }
    
        public function testToString():void
        {
            assertEquals( p.toString() , "[Plane:{10,20,30,40}]", "PLANE_04 - toString failed : " + p.toString() ) ;
        }
    
        public function testA():void
        {
            assertEquals( p.a , 10, "PLANE_05 - a property failed : " + p.a ) ;
        }
    
        public function testB():void
        {
            assertEquals( p.b , 20, "PLANE_06 - b property failed : " + p.b ) ;
        }
        
        public function testC():void
        {
            assertEquals( p.c , 30, "PLANE_07 - c property failed : " + p.c ) ;
        }
        
        public function testD():void
        {
            assertEquals( p.d , 40, "PLANE_08 - d property failed : " + p.d ) ;
        }   
    
        public function testClone():void
        {
            var clone:Plane = p.clone() ;
            clone.a = 100 ;
            clone.b = 200 ;
            clone.c = 300 ;
            clone.d = 400 ;
            assertTrue( clone is Plane , "PLANE_09 - clone method failed, must return a Plane reference." ) ;
            assertFalse( p.a == clone.a, "PLANE_09 - clone property failed, p.a:" + p.a + " must be different of clone.a:" + clone.a ) ;
            assertFalse( p.b == clone.b, "PLANE_09 - clone property failed, p.b:" + p.b + " must be different of clone.b:" + clone.b ) ;
            assertFalse( p.c == clone.c, "PLANE_09 - clone property failed, p.c:" + p.c + " must be different of clone.c:" + clone.c ) ;
            assertFalse( p.d == clone.d, "PLANE_09 - clone property failed, p.d:" + p.d + " must be different of clone.d:" + clone.d ) ;
        }
        
        public function testEquals():void
        {   
            var pe:Plane = new Plane(10, 20, 30, 40) ;
            assertTrue( p.equals(pe) , "PLANE_11 - equals method failed.") ;
        }
    
    }

}
    