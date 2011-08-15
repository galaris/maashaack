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
    import library.ASTUce.framework.TestCase;
    
    public class Vector3Test extends TestCase 
    {
        public function Vector3Test(name:String = "")
        {
            super( name );
        }
        
        public var v:Vector3;
        
        public function setUp():void
        {
            v = new Vector3(10, 20, 30) ;
        }
        
        public function tearDown():void
        {
            v = undefined ; 
        }
            
        public function testConstructor():void
        {
            assertNotNull( v, "01 - constructor is null") ;
            assertTrue( v is Vector3 , "02 - constructor is an instance of Vector3.") ;
        }
        
        public function testInterface():void
        {
            assertTrue( v is Geometry , "implements the Geometry interface failed.") ;
        }   
        
        public function testBACKWARD():void
        {
            var v:Vector3 = Vector3.BACKWARD ;
            assertEquals( v.x ,  0 , "BACKWARD x failed." ) ;
            assertEquals( v.y ,  0 , "BACKWARD y failed." ) ;
            assertEquals( v.z , -1 , "BACKWARD z failed." ) ;
        }        
                
        public function testDOWN():void
        {
            var v:Vector3 = Vector3.DOWN ;
            assertEquals( v.x ,  0 , "DOWN x failed." ) ;
            assertEquals( v.y , -1 , "DOWN y failed." ) ;
            assertEquals( v.z ,  0 , "DOWN z failed." ) ;
        }
        
        public function testFORWARD():void
        {
            var v:Vector3 = Vector3.FORWARD ;
            assertEquals( v.x , 0 , "FORWARD x failed." ) ;
            assertEquals( v.y , 0 , "FORWARD y failed." ) ;
            assertEquals( v.z , 1 , "FORWARD z failed." ) ;
        }
        
        public function testLEFT():void
        {
            var v:Vector3 = Vector3.LEFT ;
            assertEquals( v.x , -1 , "LEFT x failed." ) ;
            assertEquals( v.y ,  0 , "LEFT y failed." ) ;
            assertEquals( v.z ,  0 , "LEFT z failed." ) ;
        }
        
        public function testRIGHT():void
        {
            var v:Vector3 = Vector3.RIGHT ;
            assertEquals( v.x , 1 , "RIGHT x failed." ) ;
            assertEquals( v.y , 0 , "RIGHT y failed." ) ;
            assertEquals( v.z , 0 , "RIGHT z failed." ) ;
        }
        
        public function testUP():void
        {
            var v:Vector3 = Vector3.UP ;
            assertEquals( v.x , 0 , "UP x failed." ) ;
            assertEquals( v.y , 1 , "UP y failed." ) ;
            assertEquals( v.z , 0 , "UP z failed." ) ;
        }
        
        public function testZERO():void
        {
            var v:Vector3 = Vector3.ZERO ;
            assertEquals( v.x , 0 , "ZERO x failed." ) ;
            assertEquals( v.y , 0 , "ZERO y failed." ) ;
            assertEquals( v.z , 0 , "ZERO z failed." ) ;
        }
        
        public function testToSource():void
        {
            assertEquals( v.toSource() , "new graphics.geom.Vector3(10,20,30)", "toSource failed : " + v.toSource() ) ;
        }
        
        public function testToString():void
        {
            assertEquals( v.toString() , "[Vector3 x:10 y:20 z:30]", "toString failed : " + v.toString() ) ;
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
        
        public function testClone():void
        {   
            var clone:Vector3 = v.clone() as Vector3;
            assertNotNull( clone , "01 - clone method failed." ) ;
            assertEquals( clone, v , "02 - clone method failed") ;
        }
        
        public function testEquals():void
        {
            var v1:Vector3 = new Vector3(10, 20, 30) ;
            var v2:Vector3 = new Vector3( 0, 20, 30) ;
            var v3:Vector3 = new Vector3(10,  0, 30) ;
            var v4:Vector3 = new Vector3(10, 20,  0) ;
            assertTrue ( v1.equals( v1 ) , "01 - equals method failed.") ;
            assertFalse( v1.equals( v2 ) , "02 - equals method failed.") ;
            assertFalse( v1.equals( v3 ) , "03 - equals method failed.") ;
            assertFalse( v1.equals( v4 ) , "04 - equals method failed.") ;
        }
    }
}
