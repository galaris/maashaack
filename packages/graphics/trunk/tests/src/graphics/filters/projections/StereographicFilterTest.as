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
package graphics.filters.projections 
{
    import library.ASTUce.framework.TestCase;

    import flash.display.Shader;

    public class StereographicFilterTest extends TestCase 
    {
        public function StereographicFilterTest(name:String = "")
        {
            super(name);
        }
        
        public var filter:StereographicFilter ;
        public var shader:Shader ;
        
        public function setUp():void
        {
            shader = new Shader( new Stereographic() ) ;
            filter = new StereographicFilter( shader ) ;
        }
        
        public function tearDown():void
        {
            filter = null ;
            shader = null ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( filter ) ;
        }
        
        public function testConstructorWithInit():void
        {
            filter = new StereographicFilter( shader  , { height:300, width:150 , fieldOfView:400 , focalLength:500 } ) ;
            assertEquals( 300 , filter.height ) ;
            assertEquals( 150 , filter.width ) ;
            assertEquals( 400 , filter.fieldOfView ) ;
            assertEquals( 500 , filter.focalLength ) ;
        }
        
        public function testHeight():void
        {
            assertEquals( 250 , filter.height ) ;
            
            filter.height = 300 ;
            
            assertEquals( 300 , filter.height ) ;
        }
        
        public function testFieldOfView():void
        {
            assertEquals( 100 , filter.fieldOfView ) ;
            
            filter.fieldOfView = 200 ;
            
            assertEquals( 200 , filter.fieldOfView ) ;
        }
        
        public function testFocalLength():void
        {
            assertEquals( 128 , filter.focalLength ) ;
            
            filter.focalLength = 300 ;
            
            assertEquals( 300 , filter.focalLength ) ;
        }
        
        public function testWidth():void
        {
            assertEquals( 500 , filter.width  ) ;
            
            filter.width = 300 ;
            
            assertEquals( 300 , filter.width ) ;
        }
        
        public function testDescription():void
        {
            assertEquals( "In geometry, the stereographic projection is a particular mapping (function) that projects a sphere onto a plane." , filter.description ) ;
        }
        
        public function testName():void
        {
            assertEquals( "Stereographic" , filter.name ) ; 
        }
        
        public function testNamespace():void
        {
            assertEquals( "graphics.filters.projections" , filter.namespace ) ;
        }
        
        public function testVersion():void
        {
            assertEquals( filter.version , 1 ) ; 
        }
        
        public function testClone():void
        {
            var clone:StereographicFilter ;
            
            clone = filter.clone() as StereographicFilter ;
            
            assertNotNull( clone ) ;
            
            assertEquals( clone.shader , filter.shader ) ;
            assertEquals( 250 , clone.height ) ;
            assertEquals( 100 , clone.fieldOfView ) ;
            assertEquals( 128 , clone.focalLength ) ;
            assertEquals( 500 , clone.width  ) ;
            
            filter = new StereographicFilter( shader  , { height:300, width:150 , fieldOfView:400 , focalLength:500 } ) ;
            clone  = filter.clone() as StereographicFilter ;
            
            assertNotNull( clone ) ;
            
            assertEquals( 300 , clone.height ) ;
            assertEquals( 150 , clone.width ) ;
            assertEquals( 400 , clone.fieldOfView ) ;
            assertEquals( 500 , clone.focalLength ) ;
        }
    }
}
