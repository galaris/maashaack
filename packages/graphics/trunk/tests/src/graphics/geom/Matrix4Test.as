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
    import buRRRn.ASTUce.framework.TestCase;
    
    public class Matrix4Test extends TestCase 
    {
        public function Matrix4Test(name:String = "")
        {
            super( name );
        }
        
        public var m:Matrix4;
        
        public function setUp():void
        {
            m = new Matrix4() ;
        }
        
        public function tearDown():void
        {
            m = undefined ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( m, "MA4_00_01 - constructor is null") ;
            assertTrue( m is Matrix4 , "MA4_00_02 - constructor is an instance of Matrix4.") ;
        }
        
        public function testInterfaces():void
        {
            assertTrue( m is Geometry  , "MA4_01_02 - implements Geometry failed.") ;
        }   
        
        public function testToSource():void
        {
            assertEquals( m.toSource() , "new graphics.geom.Matrix4(1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1)", "MA4_03 - toSource failed : " + m.toSource() ) ;
        }
        
        public function testToString():void
        {
            assertEquals( m.toString() , "[Matrix4:[1,0,0,0],[0,1,0,0],[0,0,1,0],[0,0,0,1]]", "MA4_04 - toString failed : " + m.toString() ) ;
        }
        
        public function testClone():void
        {
            var clone:Matrix4 = m.clone() ;
            assertTrue( clone is Matrix4 , "MA4_05_01 - clone method failed, must return a Matrix4 reference." ) ;
        }
        
        public function testEquals():void
        {
            var ve:Matrix4 = new Matrix4() ;
            assertTrue( m.equals(ve) , "MA4_07 - equals method failed.") ;
        }
        
        public function testN11():void
        {
            assertEquals( m.n11, 1, "MA4_08 - n11 property failed : " + m.n11 ) ;
        }
        
        public function testN12():void
        {
            assertEquals( m.n12, 0, "MA4_09 - n12 property failed : " + m.n12 ) ;
        }
        
        public function testN13():void
        {
            assertEquals( m.n13, 0, "MA4_10 - n13 property failed : " + m.n13 ) ;
        }
    
        public function testN14():void
        {
            assertEquals( m.n14, 0, "MA4_11 - n14 property failed : " + m.n14 ) ;
        }
    
        public function testN21():void
        {
            assertEquals( m.n21, 0, "MA4_08 - n21 property failed : " + m.n21 ) ;
        }
        
        public function testN22():void
        {   
            assertEquals( m.n22, 1, "MA4_09 - n22 property failed : " + m.n22 ) ;
        }
        
        public function testN23():void
        {
            assertEquals( m.n23, 0, "MA4_10 - n23 property failed : " + m.n23 ) ;
        }   
        
        public function testN24():void
        {
            assertEquals( m.n24, 0, "MA4_11 - n24 property failed : " + m.n24 ) ;
        }
        
        public function testN31():void
        {   
            assertEquals( m.n31, 0, "MA4_12 - n31 property failed : " + m.n31 ) ;
        }
        
        public function testN32():void
        {
            assertEquals( m.n32, 0, "MA4_13 - n32 property failed : " + m.n32 ) ;
        }
        
        public function testN33():void
        {
            assertEquals( m.n33, 1, "MA4_14 - n33 property failed : " + m.n33 ) ;
        }
        
        public function testN34():void
        {
            assertEquals( m.n34, 0, "MA4_15 - n34 property failed : " + m.n34 ) ;
        }
        
        public function testN41():void
        {
            assertEquals( m.n41, 0, "MA4_12 - n41 property failed : " + m.n41 ) ;
        }
        
        public function testN42():void
        {   
            assertEquals( m.n42, 0, "MA4_13 - n42 property failed : " + m.n42 ) ;
        }
        
        public function testN43():void
        {
            assertEquals( m.n43, 0, "MA4_14 - n43 property failed : " + m.n43 ) ;
        }
        
        public function testN44():void
        {
            assertEquals( m.n44, 1, "MA4_15 - n44 property failed : " + m.n44 ) ;
        }
    }
}
