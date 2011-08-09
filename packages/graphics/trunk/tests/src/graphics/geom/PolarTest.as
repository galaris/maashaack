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
    
    public class PolarTest extends TestCase 
    {
        public function PolarTest(name:String = "")
        {
            super(name);
        }
        
        public var polar:Polar;
        
        public function setUp():void
        {
            polar = new Polar(100, 45) ;
        }
        
        public function tearDown():void
        {
            polar = undefined ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( polar, "01 - constructor failed.") ;
        }
        
        public function testInterface():void
        {
            assertTrue( polar is Geometry  , "implements Geometry failed.") ;
        }
        
        public function testZERO():void
        {
            var polar:Polar = Polar.ZERO ;
            assertEquals( polar.radius , 0 , "ZERO radius failed." ) ;
            assertEquals( polar.angle  , 0 , "ZERO angle  failed." ) ;
        }
        
        public function testToSource():void
        {
            assertEquals( polar.toSource() , "new graphics.geom.Polar(100,45)", "toSource failed." ) ;
        }
        
        public function testToString():void
        {
            assertEquals( polar.toString() , "[Polar radius:100 angle:45]", "toString failed : " + polar.toString() ) ;
        }
        
        public function testRadius():void
        {
            assertEquals( polar.radius , 100 , "radius property failed." ) ;
        }
        
        public function testAngle():void
        {
            assertEquals( polar.angle , 45 , "angle property failed." ) ;
        }
        
        public function testClone():void
        {
            var clone:Polar = polar.clone() as Polar ;
            assertNotNull( clone , "01 - clone method failed.") ;
            assertEquals( clone , polar ,  "02 - clone method failed." ) ;
        }
        
        public function testEmpty():void
        {
            polar.empty() ;
            assertTrue( polar.equals( Polar.ZERO ) , "empty method failed.") ;
        }
        
        public function testEquals():void
        {
            var p:Polar = new Polar(100, 45) ;
            assertTrue( p.equals( polar ) , "equals method failed.") ;
        }
        
        public function testFromObject():void
        {
            var p:Polar = new Polar() ;
            p.fromObject( { angle : 10 , radius : 100 } ) ;
            assertEquals(  10 , p.angle  , "#1" ) ;
            assertEquals( 100 , p.radius , "#2" ) ;
        }
    }
}
