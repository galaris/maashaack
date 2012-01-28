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
    
    public class UVTest extends TestCase 
    {
        public function UVTest(name:String = "")
        {
            super( name );
        }
        
        public var c:UV ;
        
        public function setUp():void
        {
            c = new UV(10, 20) ;
        }
        
        public function tearDown():void
        {
            c = undefined ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( c, "01 - constructor is null") ;
            assertTrue( c is UV , "02 - constructor is an instance of UVCoordinate.") ;
        }
        
        public function testInterface():void
        {
            assertTrue( c is Geometry  , "must implements the Geometry interface.") ;
        }   
        
        public function testToSource():void
        {   
            assertEquals( c.toSource() , "new graphics.geom.UV(10,20)", "toSource failed : " + c.toSource() ) ;
        }
        
        public function testToString():void
        {
            assertEquals( c.toString() , "[UV u:10 v:20]", "toString failed : " + c.toString() ) ;
        }
        
        public function testU():void
        {
            assertEquals( c.u , 10, "u property failed : " + c.u ) ;
        }
        
        public function testV():void
        {
            assertEquals( c.v , 20, "v property failed : " + c.v ) ;
        }
        
        public function testClone():void
        {
            var clone:UV = c.clone() as UV ;
            
            assertNotNull( clone , "01 - clone method failed, must return a UV reference." ) ;
            
            clone.u = 100 ;
            clone.v = 200 ;
            
            assertFalse( c.u == clone.u, "02-01 - clone failed, v.x:" + c.u + " must be different of clone.x:" + clone.u ) ;
            assertFalse( c.v == clone.v, "02-02 - clone failed, v.y:" + c.v + " must be different of clone.x:" + clone.v ) ;
        }
        
        public function testEquals():void
        {
            var uv:UV = new UV(10, 20) ;
            assertTrue( c.equals(uv) , "equals method failed.") ;
        }
    }
}