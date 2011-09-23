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

    import system.Serializable;

    public class Vector2Test extends TestCase 
    {
        public function Vector2Test(name:String = "")
        {
            super( name );
        }
        
        public var v:Vector2;
        
        public function setUp():void
        {
            v = new Vector2(10, 20) ;
        }
        
        public function tearDown():void
        {
            v = undefined ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( v, "01 - constructor is null") ;
            assertTrue( v is Vector2 , "02 - constructor is an instance of Vector2.") ;
        }
        
        public function testInterface():void
        {
            assertTrue( v is Serializable , "implements Serializable failed.") ;
        }   
        
        public function testDOWN():void
        {
            var v:Vector2 = Vector2.DOWN ;
            assertEquals( v.x ,  0 , "DOWN x failed." ) ;
            assertEquals( v.y , -1 , "DOWN y failed." ) ;
        }
        
        public function testLEFT():void
        {
            var v:Vector2 = Vector2.LEFT ;
            assertEquals( v.x , -1 , "LEFT x failed." ) ;
            assertEquals( v.y ,  0 , "LEFT y failed." ) ;
        }
        
        public function testRIGHT():void
        {
            var v:Vector2 = Vector2.RIGHT ;
            assertEquals( v.x , 1 , "RIGHT x failed." ) ;
            assertEquals( v.y , 0 , "RIGHT y failed." ) ;
        }
        
        public function testUP():void
        {
            var v:Vector2 = Vector2.UP ;
            assertEquals( v.x , 0 , "UP x failed." ) ;
            assertEquals( v.y , 1 , "UP y failed." ) ;
        }
        
        public function testZERO():void
        {
            var v:Vector2 = Vector2.ZERO ;
            assertEquals( v.x , 0 , "ZERO x failed." ) ;
            assertEquals( v.y , 0 , "ZERO y failed." ) ;
        }
        
        public function testToSource():void
        {
            assertEquals( v.toSource() , "new graphics.geom.Vector2(10,20,false)", "toSource failed : " + v.toSource() ) ;
        }
        
        public function testToString():void
        {
            assertEquals( v.toString() , "[Vector2 x:10 y:20]", "toString failed : " + v.toString() ) ;
        }
        
        public function testLength():void
        {
            assertEquals( String(v.length), String(22.360679774997898), "length property failed" ) ;
        }
        
        public function testX():void
        {
            assertEquals( v.x , 10, "x property failed : " + v.x ) ;
        }
        
        public function testY():void
        {
            assertEquals( v.y , 20, "y property failed : " + v.y ) ;
        }
        
        public function testAbs():void
        {
            var vector:Vector2 = new Vector2(-10,-10) ;
            vector.abs() ; 
            assertEquals( vector , new Vector2(10, 10), "abs method failed." ) ;
        }
        
        public function testAbsStatic():void
        {
            var vector:Vector2 = new Vector2(-10,-10) ;
            var abs:Vector2    = Vector2.abs( vector ) ;
            assertEquals( abs , new Vector2(10, 10), "abs static method failed." ) ;
        }
        
        public function testAngle():void
        {
            v.degrees = true ;
            assertEquals( String(v.angle) , String(63.43494882292201), "angle property failed.") ;
        }
        
        public function testAngleBetween():void
        {
            var v1:Vector2 = new Vector2(0,1) ;
            var v2:Vector2 = new Vector2(1,0) ;
            v1.degrees = true ;
            var angle:Number = v1.angleBetween( v2 ) ;
            assertEquals( Math.round(angle), 90, "angleBetween method failed." ) ;
            // TODO test if degrees == false
        }
        
        public function testClone():void
        {
            var clone:Vector2 = v.clone() as Vector2 ;
            
            clone.x = 100 ;
            clone.y = 200 ;
            
            assertTrue( clone is Vector2 , "01 - clone method failed, must return a Vector2 reference." ) ;
            
            assertFalse( v.x == clone.x, "02 - clone property failed, v.x:" + v.x + " must be different of clone.x:" + clone.x ) ;
            assertFalse( v.y == clone.y, "03 - clone property failed, v.y:" + v.y + " must be different of clone.y:" + clone.y ) ;
        }
        
        public function testDirection():void
        {
            var d:Vector2 = v.direction() ;
            var r:Vector2 = new Vector2(0.4472135954999579,0.8944271909999159) ;
            assertEquals( d, r, "direction method failed." ) ;
        }
        
        public function testEquals():void
        {
            var ve:Vector2 = new Vector2(10, 20) ;
            assertTrue( v.equals(ve) , "equals method failed.") ;
        }
        
        public function testCross():void
        {
            var v1:Vector2 = new Vector2(10,20) ;
            var v2:Vector2 = new Vector2(40,60) ;
            assertEquals( v1.cross(v2), -200, "cross method failed.") ;
        }
        
        public function testDistance():void
        {
            var v1:Vector2 = new Vector2(10,20) ;
            var v2:Vector2 = new Vector2(40,60) ;
            assertEquals( Vector2.distance(v1,v2) , 50, "distance method failed.") ;
        }
        
        public function testDot():void
        {
            var v1:Vector2 = new Vector2(10,20) ;
            var v2:Vector2 = new Vector2(40,60) ;
            assertEquals( v1.dot(v2) , 1600, "dot method failed.") ;
        }
        
        public function testIsPerpendicularTo():void
        {
            var p1:Vector2 = new Vector2(0,10) ;
            var p2:Vector2 = new Vector2(10,10) ;
            var p3:Vector2 = new Vector2(10,0) ;
            assertFalse ( p1.isPerpendicularTo(p2) , "01 - isPerpendicularTo method failed." ) ;
            assertTrue  ( p1.isPerpendicularTo(p3) , "02 - isPerpendicularTo method failed." ) ;
        }
        
        public function testInterpolate():void
        {
            var v1:Vector2 = new Vector2(10,10) ;
            var v2:Vector2 = new Vector2(40,40) ;
            var v3:Vector2 = v1.interpolate( v2 , 0 ) ;
            assertEquals( v3, new Vector2(40,40), "01 - interpolate method failed." ) ;
            v3 = v1.interpolate( v2, 1 ) ;
            assertEquals( v3, new Vector2(10,10), "02 - interpolate method failed." ) ;
            v3 = v1.interpolate( v2, 0.5 ) ;
            assertEquals( v3, new Vector2(25,25), "03 - interpolate method failed." ) ;
        }
        
        public function testMax():void
        {
            var p1:Vector2 = new Vector2(10,100) ;
            var p2:Vector2 = new Vector2(100,10) ;
            var p3:Vector2 = p1.max(p2) ;
            assertEquals( p3, new Vector2(100,100), "max method failed : " + p3 ) ;
        }
        
        public function testMiddle():void
        {
            var v1:Vector2 = new Vector2(10,10) ;
            var v2:Vector2 = new Vector2(20,20) ;
            var middle:Vector2 = v1.middle(v2) ;
            assertEquals( middle, new Vector2(15,15), "middle method failed." ) ;
        }
        
        public function testMin():void
        {
            var v1:Vector2 = new Vector2(10,100) ;
            var v2:Vector2 = new Vector2(100,10) ;
            var v3:Vector2 = v1.min(v2) ;
            assertEquals( v3, new Vector2(10,10), "min method failed." ) ;
        }
        
        public function testNegate():void
        {
            var vector:Vector2 = new Vector2(10,20) ;
            vector.negate() ;
            assertEquals( vector, new Vector2(-10,-20), "negate method failed.") ;
        }
        
        public function testNegateStatic():void
        {
            var v1:Vector2 = new Vector2(10,20) ;
            var v2:Vector2 = Vector2.negate( v1 ) ;
            assertEquals( v2, new Vector2(-10,-20), "static negate method failed." ) ;
        }
        
        public function testNormal():void
        {
            var v:Vector2 = new Vector2(10,10) ;
            var n:Vector2 = v.normal() ;
            assertEquals( n, new Vector2(-10,10), "normal method failed." ) ;
        }
        
        public function testNormalize():void
        {
            var vector:Vector2 = new Vector2(0,5) ;
            vector.normalize(1) ;
            assertEquals( vector, new Vector2(0,1), "normalize method failed.") ;
        }
        
        public function testOffset():void
        {
            var vector:Vector2 = new Vector2(10,10) ;
            vector.offset(10,10) ;
            assertEquals( vector, new Vector2(20,20), "offset method failed." ) ;
        }
        
        public function testPolar():void
        {
            var polar:Vector2 = Vector2.polar( 5, Math.atan(3/4) ) ;
            assertEquals( polar, new Vector2(4,3), "polar method failed." ) ;
        }
        
        public function testProjectionLength():void
        {
            var v1:Vector2 = new Vector2(10,10) ;
            var v2:Vector2 = new Vector2(100,200) ;
            var size:Number = v1.projectionLength(v2) ;
            assertEquals( size, 0.06, "projectionLength method failed." ) ;
        }
    }
}