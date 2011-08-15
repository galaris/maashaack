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
    
    public class RayTest extends TestCase 
    {
        public function RayTest(name:String = "")
        {
            super( name );
        }
        
        public var r:Ray;
        
        public function setUp():void
        {
            r = new Ray() ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( r, "constructor is null") ;
        }
        
        public function testInterface():void
        {
            assertTrue( r is Geometry , "implements the Geometry interface failed.") ;
        }   
        
        public function testToSource():void
        {
            assertEquals( r.toSource() , "new graphics.geom.Ray(new graphics.geom.Vector3(0,0,0),new graphics.geom.Vector3(0,0,0))", "toSource failed : " + r.toSource() ) ;
        }
        
        public function testToString():void
        {
            assertEquals( r.toString() , "[Ray:[Vector3 x:0 y:0 z:0]+t*[Vector3 x:0 y:0 z:0]]", "toString failed : " + r.toString() ) ;
        }
        
        public function testP():void
        {
            assertEquals( r.p , new Vector3(), "p property failed : " + r.p ) ;
        }
        
        public function testV():void
        {
            assertEquals( r.v , new Vector3(), "v property failed : " + r.v ) ;
        }
        
        public function testQ():void
        {
            assertEquals( r.q , new Vector3(), "q property failed : " + r.q ) ;
        }
        
        public function testClone():void
        {
            var clone:Ray = r.clone() ;
            assertTrue( clone is Ray , "clone method failed, must return a Ray reference." ) ;
        }
        
        public function testEquals():void
        {
            var re:Ray = new Ray() ;
            assertTrue( r.equals(re) , "equals method failed.") ;
        }
    }
}