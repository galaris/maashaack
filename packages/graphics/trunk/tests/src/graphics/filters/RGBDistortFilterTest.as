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
package graphics.filters 
{
    import library.ASTUce.framework.TestCase;

    import flash.display.Shader;

    public class RGBDistortFilterTest extends TestCase 
    {
        public function RGBDistortFilterTest(name:String = "")
        {
            super(name);
        }
        
        public var filter:RGBDistortFilter ;
        public var shader:Shader ;
        
        public function setUp():void
        {
            shader = new Shader( new RGBDistort() ) ;
            filter = new RGBDistortFilter
            ( 
                shader ,
                { 
                    redDirection   : 1 ,                     greenDirection : 1 ,                     blueDirection  : 1 , 
                    
                    redFrequency   : 1 ,                    greenFrequency : 1 ,                    blueFrequency  : 1 ,
                    
                    redIntensity   : 1 ,                    greenIntensity : 1 ,                    blueIntensity  : 1
                 } 
             ) ;
        }
        
        public function tearDown():void
        {
            filter = null ;
            shader = null ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( filter ) ;
            assertEquals( filter.blueDirection , 1 ) ;
            assertEquals( filter.blueFrequency , 1 ) ;
            assertEquals( filter.blueIntensity , 1 ) ;
        }
        
        public function testDescription():void
        {
            assertEquals( "Distorts all RGB pixels." , filter.description ) ;
        }
        
        public function testName():void
        {
            assertEquals( "RGBDistort" , filter.name ) ; 
        }
        
        public function testNamespace():void
        {
            assertEquals( "graphics.filters" , filter.namespace ) ;
        }
        
        public function testVersion():void
        {
            assertEquals( filter.version , 1 ) ; 
        }
        
        public function testClone():void
        {
            var clone:RGBDistortFilter = filter.clone() as RGBDistortFilter ;
            assertNotNull( clone ) ;
            
            assertEquals( clone.shader , filter.shader ) ;
            
            assertEquals( clone.redDirection   , filter.redDirection ) ;
            assertEquals( clone.greenDirection , filter.greenDirection ) ;
            assertEquals( clone.blueDirection  , filter.blueDirection ) ;
            
            assertEquals( clone.greenFrequency , filter.greenFrequency ) ;
            assertEquals( clone.blueFrequency  , filter.blueFrequency ) ;
            assertEquals( clone.redFrequency   , filter.redFrequency ) ;
            
            assertEquals( clone.redIntensity   , filter.redIntensity ) ;
            assertEquals( clone.greenIntensity , filter.greenIntensity ) ;
            assertEquals( clone.blueIntensity  , filter.blueIntensity ) ;        }
    }
}
