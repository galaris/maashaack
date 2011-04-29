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
    
    public class QuaternionTest extends TestCase 
    {
        public function QuaternionTest(name:String = "")
        {
            super( name );
        }
        
        public var q:Quaternion;
        
        public function setUp():void
        {
            q = new Quaternion(10, 20, 30, 40) ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( q, "01 - constructor is null") ;
            assertTrue( q is Quaternion , "02 - constructor is an instance of Quaternion.") ;
        }
        
        public function testInterface():void
        {
            assertTrue( q is Geometry , "Quaternion must implements the Geometry interface.") ;
        }   
        
        public function testX():void
        {
            assertEquals( q.x , 10, "x property failed : " + q.x ) ;
        }
        
        public function testY():void
        {
            assertEquals( q.y , 20, "y property failed : " + q.y ) ;
        }
        
        public function testZ():void
        {
            assertEquals( q.z , 30, "z property failed : " + q.z ) ;
        }
        
        public function testW():void
        {
            assertEquals( q.w , 40, "w property failed : " + q.w ) ;
        }

        public function testAdd():void
        {
            var q1:Quaternion = new Quaternion(10, 20, 30, 40) ;
            var q2:Quaternion = new Quaternion(10, 10, 10, 10) ;
            q1.add(q2) ;
            assertEquals( q1.x , 20 , "01 - add failed with the x value." ) ;
            assertEquals( q1.y , 30 , "02 - add failed with the y value." ) ;
            assertEquals( q1.z , 40 , "03 - add failed with the z value." ) ;
            assertEquals( q1.w , 50 , "04 - add failed with the w value." ) ;
        }
        
        public function testClone():void
        {
            var clone:Quaternion = q.clone() ;
            clone.x = 100 ;
            clone.y = 200 ;
            clone.z = 300 ;
            clone.w = 400 ;
            assertTrue( clone is Quaternion , "01 - clone method failed, must return a Quaternion reference." ) ;
            assertFalse( q.x == clone.x, "02 - clone property failed, q.x:" + q.x + " must be different of clone.x:" + clone.x ) ;
            assertFalse( q.y == clone.y, "03 - clone property failed, q.y:" + q.y + " must be different of clone.x:" + clone.y ) ;
            assertFalse( q.z == clone.z, "04 - clone property failed, q.z:" + q.z + " must be different of clone.z:" + clone.z ) ;
            assertFalse( q.w == clone.w, "05 - clone property failed, q.w:" + q.w + " must be different of clone.w:" + clone.w ) ;
        }
        
        public function testConjugate():void
        {
            var q:Quaternion = new Quaternion(10, 20, 30, 40) ;
            q.conjugate() ;
            assertEquals( q.x , -10 , "01 - conjugate failed with the x value." ) ;
            assertEquals( q.y , -20 , "02 - conjugate failed with the y value." ) ;
            assertEquals( q.z , -30 , "03 - conjugate failed with the z value." ) ;
            assertEquals( q.w ,  40 , "04 - conjugate failed with the w value." ) ;
        }
        
        public function testEquals():void
        {
            var q1:Quaternion = new Quaternion(10, 20, 30, 40) ;
            var q2:Quaternion = new Quaternion(1, 20, 30, 40) ;
            assertTrue( q.equals(q1) , "01 - equals method failed.") ;
            assertFalse( q.equals(q2) , "02 - equals method failed.") ;
        }
        
        public function testExp():void
        {
            var q:Quaternion = new Quaternion(1, 1, 1, 1) ;
            var r:Quaternion = q.exp() ;
            assertEquals( r.x , 0.5698600991825139   , "01 - exp failed with the x value." ) ;
            assertEquals( r.y , 0.5698600991825139   , "02 - exp failed with the y value." ) ;
            assertEquals( r.z , 0.5698600991825139   , "03 - exp failed with the z value." ) ;
            assertEquals( Number(r.w).toPrecision(5) , "-0.16056" , "04 - exp failed with the w value." ) ;
        }
        
        /**
         * Test this method with the tool : http://www.euclideanspace.com/maths/geometry/rotations/conversions/eulerToQuaternion/index.htm
         */
        public function testEuler():void
        {
            var q:Quaternion = new Quaternion();
            
            q.euler( 0, 0 , 0 , true ) ;
            assertEquals( q.toString(), "[Quaternion x:0 y:0 z:0 w:1]" , "01-01 - euler(0,0,0,true) failed.") ;
            assertEquals( q.getEulerAngles(true) , new Vector3(0,0,0) , "01-02 - euler(0,0,0,true) failed" ) ;
            
            q.euler(90,0,0,true) ;
            assertEquals( q.toString(), "[Quaternion x:0 y:0.7071067811865475 z:0 w:0.7071067811865476]" , "02 - euler(90,0,0,true) failed.") ;
            
            q.euler(0,90,0,true) ;
            assertEquals( q.toString(), "[Quaternion x:0 y:0 z:0.7071067811865475 w:0.7071067811865476]" , "03-01 - euler(0,90,0,true) failed.") ;
            q.euler( 0 , Math.PI / 2, 0 ) ;
            assertEquals( q.toString(), "[Quaternion x:0 y:0 z:0.7071067811865475 w:0.7071067811865476]" , "03-02 - euler(0,Math.PI/2,0) failed.") ;
            
            q.euler(0,0,90,true) ;
            assertEquals( q.toString(), "[Quaternion x:0.7071067811865475 y:0 z:0 w:0.7071067811865476]" , "04 - euler(0,0,90,true) failed.") ;
            
            q.euler(90,90,90,true) ;
            assertEquals( q.toString(), "[Quaternion x:0.7071067811865475 y:0.7071067811865475 z:5.551115123125783e-17 w:1.6653345369377348e-16]" , "05 - euler(90,90,90,true) failed.") ;
            
            q.euler(-90,0,0,true) ;
            assertEquals( q.toString(), "[Quaternion x:0 y:-0.7071067811865475 z:0 w:0.7071067811865476]" , "06 - euler(-90,0,0,true) failed.") ;
            
            /// work but approximation problems between PC and MAC.
//            q.euler(40,80,180,true) ;
//            assertEquals( q.toString(), "[Quaternion x:0.7198463103929543 y:0.6040227735550536 z:-0.2620026302293849 w:-0.2198463103929541]" , "07 - euler(40,80,180,true) failed.") ;
        }
        
        public function testGetEulerAngles():void
        {
            var q:Quaternion ;
            var v:Vector3 ;
            
            q = new Quaternion( 0 , 0 , 0 , 1 ) ;
            v = q.getEulerAngles(true) ;
            assertEquals(v, new Vector3(0,0,0) , "01 - getEulerAngles failed : Quaternion( 0 , 0 , 0 , 1 )" ) ;
            
            q = new Quaternion( 0 , 0.7071 , 0 , 0.7071 ) ;
            v = q.getEulerAngles(true) ;
            v.x = Math.round(v.x) ; // fix approximation in the test
            assertEquals(v, new Vector3(90,0,0) , "02 - getEulerAngles failed : Quaternion( 0.7071 , 0 , 0.7071 , 0 )" ) ;
            
            q = new Quaternion( 0.5 , 0.5 , 0.5 , 0.5 ) ;
            v = q.getEulerAngles(true) ;
            assertEquals(v, new Vector3(90,90,0) , "02 - getEulerAngles failed : Quaternion( 0.5 , 0.5 , 0.5 , 0.5 )" ) ;
            
            q = new Quaternion( -0.5 , -0.5 , 0.5 , 0.5 ) ;
            v = q.getEulerAngles(true) ;
            assertEquals(v, new Vector3(-90,90,0) , "03 - getEulerAngles failed : Quaternion( -0.5 , -0.5 , 0.5 , 0.5 )" ) ;
            
            q = new Quaternion( 0 , 1 , 0 , 0 ) ;
            v = q.getEulerAngles(true) ;
            assertEquals(v, new Vector3(180,0,0) , "04 - getEulerAngles failed : Quaternion( 0 , 1 , 0 , 0 )" ) ;
                        
            q = new Quaternion( 0.761 , 0.761 , 0.761 , 1 ) ;
            v = q.getEulerAngles(true) ;
            assertEquals(v, new Vector3(74.54226961530313,90,0) , "05 - getEulerAngles failed : Quaternion( 0.761 , 0.761 , 0.761 , 1 )" ) ;
        }
        
        public function testIdentity():void
        {
            var q:Quaternion = new Quaternion(10, 20, 30, 40) ;
            q.identity() ;
            assertEquals( q.x , 0 , "01 - identity failed with the x value." ) ;
            assertEquals( q.y , 0 , "02 - identity failed with the y value." ) ;
            assertEquals( q.z , 0 , "03 - identity failed with the z value." ) ;
            assertEquals( q.w , 1 , "04 - identity failed with the w value." ) ;
        }
        
        public function testIsIdentity():void
        {
            var q1:Quaternion = new Quaternion(0, 0, 0, 1) ;
            var q2:Quaternion = new Quaternion(10, 20, 30, 40) ;
            assertTrue ( q1.isIdentity() , "01 - isIdentity failed." ) ;
            assertFalse( q2.isIdentity() , "02 - isIdentity failed." ) ;
        }
        
        public function testInvert():void
        {
            var q:Quaternion = new Quaternion(1, 1, 1, 1) ;
            q.invert() ;
            assertEquals( q.x , -0.25 , "01 - invert failed with the x value." ) ;
            assertEquals( q.y , -0.25 , "02 - invert failed with the y value." ) ;
            assertEquals( q.z , -0.25 , "03 - invert failed with the z value." ) ;
            assertEquals( q.w ,  0.25 , "04 - invert failed with the w value." ) ;
        }
        
        public function testLog():void
        {
            var q:Quaternion = new Quaternion(10, 20, 30, 0.25) ;
            var r:Quaternion = q.log() ;
            assertEquals( r.x , 13.613444250345882 , "01 - log failed with the x value." ) ;
            assertEquals( r.y , 27.226888500691764 , "02 - log failed with the y value." ) ;
            assertEquals( r.z , 40.84033275103765  , "03 - log failed with the z value." ) ;
            assertEquals( r.w , 0 , "04 - log failed with the w value." ) ;
        }
        
        public function testMultiply():void
        {
            var q1:Quaternion = new Quaternion(10, 20, 30, 40) ;
            var q2:Quaternion = new Quaternion(2, 2, 2, 2) ;
            
            q1.multiply( q2 ) ;
            
            assertEquals( q1.x ,   80 , "#01" ) ;
            assertEquals( q1.y ,   20 , "#02" ) ;
            assertEquals( q1.z ,  260 , "#03" ) ;
            assertEquals( q1.w , -640 , "#04" ) ;
        }
        
        public function testNormalize():void
        {
            var q:Quaternion = new Quaternion(1, 2, 3, 4) ;
            q.normalize() ;
            assertEquals( q.x , 0.18257418583505536 , "01 - normalize failed with the x value." ) ;
            assertEquals( q.y , 0.3651483716701107  , "02 - normalize failed with the y value." ) ;
            assertEquals( q.z , 0.5477225575051661  , "03 - normalize failed with the z value." ) ;
            assertEquals( q.w , 0.7302967433402214  , "04 - normalize failed with the w value." ) ;
        }
        
        public function testSize():void
        {
            var q:Quaternion = new Quaternion(1, 2, 3, 4) ;
            assertEquals( q.size() , 5.477225575051661 , "size() failed." ) ; // magnitude
        }
        
        public function testSizeSquared():void
        {
            var q:Quaternion = new Quaternion(1, 2, 3, 4) ;
            assertEquals( q.sizeSquared() , 30 , "sizeSquared() failed." ) ;
        }
        
        public function testSubstract():void
        {
            var q1:Quaternion = new Quaternion(10, 20, 30, 40) ;
            var q2:Quaternion = new Quaternion(10, 10, 10, 10) ;
            q1.substract(q2) ;
            assertEquals( q1.x ,  0 , "01 - substract failed with the x value." ) ;
            assertEquals( q1.y , 10 , "02 - substract failed with the y value." ) ;
            assertEquals( q1.z , 20 , "03 - substract failed with the z value." ) ;
            assertEquals( q1.w , 30 , "04 - substract failed with the w value." ) ;
        }
        
        public function testToSource():void
        {
            assertEquals( q.toSource() , "new graphics.geom.Quaternion(10,20,30,40)", "toSource failed : " + q.toSource() ) ;
        }
        
        public function testToObject():void
        {
            var q:Quaternion = new Quaternion(1, 2, 3, 4) ;
            var o:Object     = q.toObject() ;
            assertEquals( o.x , q.x , "01 - toObject failed with the x value." ) ;
            assertEquals( o.y , q.y , "02 - toObject failed with the y value." ) ;
            assertEquals( o.z , q.z , "03 - toObject failed with the z value." ) ;
            assertEquals( o.w , q.w , "04 - toObject failed with the w value." ) ;
        }
        
        public function testToString():void
        {
            assertEquals( q.toString() , "[Quaternion x:10 y:20 z:30 w:40]", "toString failed : " + q.toString() ) ;
        }
        
        public function testUnaryNegation():void
        {
            var q:Quaternion = new Quaternion(10, 20, 30, 40) ;
            q.unaryNegation() ;
            assertEquals( q.x , -10 , "01 - unaryNegation failed with the x value." ) ;
            assertEquals( q.y , -20 , "02 - unaryNegation failed with the y value." ) ;
            assertEquals( q.z , -30 , "03 - unaryNegation failed with the z value." ) ;
            assertEquals( q.w , -40 , "04 - unaryNegation failed with the w value." ) ;
        }
   }
}
