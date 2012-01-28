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

package graphics.display 
{
    import graphics.drawing.RoundedComplexRectanglePen;
    import graphics.Direction;
    import graphics.Directionable;
    import graphics.Drawable;
    import graphics.Measurable;
    import graphics.drawing.RectanglePen;

    import library.ASTUce.framework.TestCase;

    import flash.display.Sprite;
    
    public class BackgroundTest extends TestCase 
    {
        public function BackgroundTest(name:String = "")
        {
            super( name );
        }
        
        public var background:Background ;
        
        public function setUp():void
        {
            background = new Background() ;
        }
        
        public function tearDown():void
        {
            background = null ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( background ) ;
        }
        
        public function testInheritance():void
        {
            assertTrue( background is MOB ) ;
        }
        
        public function testInterface():void
        {
            assertTrue( background is Directionable , "#1" ) ;
            assertTrue( background is Drawable , "#2" ) ;
            assertTrue( background is Measurable , "#3" ) ;
        }
        
        public function testDirection():void
        {
            assertNull( background.direction , "#1" ) ;
            
            background.direction = Direction.VERTICAL ;
            assertEquals( Direction.VERTICAL , background.direction , "#2" ) ;
            
            background.direction = Direction.HORIZONTAL ;
            assertEquals( Direction.HORIZONTAL , background.direction , "#3" ) ;
            
            background.direction = "unknow" ;
            assertNull( background.direction , "#4" ) ;
            
            background.direction = null ;
            assertNull( background.direction , "#5" ) ;
        }
        
        public function testFullscreen():void
        {
            assertFalse( background.fullscreen , "#1" ) ;
            
            background.fullscreen = true ;
            assertTrue( background.fullscreen , "#2" ) ;
            
            background.fullscreen = false ;
            assertFalse( background.fullscreen , "#3" ) ;
        }
        
        public function testH():void
        {
            assertEquals( 0 , background.h , "#1" ) ;
            
            background.h = 100 ;
            
            assertEquals( 100 , background.h , "#2" ) ;
        }
        
        public function testW():void
        {
            assertEquals( 0 , background.w , "#1" ) ;
            
            background.w = 100 ;
            
            assertEquals( 100 , background.w , "#2" ) ;
        }
        
        public function testPen():void
        {
            assertTrue( background.pen is RectanglePen , "#1" ) ;
            
            var pen:RoundedComplexRectanglePen = new RoundedComplexRectanglePen() ;
            background.pen = pen ;
            assertEquals( pen, background.pen , "#2" ) ;
            
            background.pen = null ;
            assertTrue( background.pen is RectanglePen , "#3" ) ;
        }
        
        public function testScope():void
        {
            assertEquals( background, background.scope , "#1" ) ;
            
            var container:Sprite = new Sprite() ;
            background.scope = container ;
            assertEquals( container, background.scope , "#2" ) ;
            
            background.scope = null ;
            
            assertEquals( background, background.scope , "#3" ) ;
        }
        
        public function testSetSize():void
        {
            background.setSize( 100 , 200 ) ;
            
            assertEquals( 100 , background.w , "#1" ) ;
            assertEquals( 200 , background.h , "#2" ) ;
        }
    }
}
