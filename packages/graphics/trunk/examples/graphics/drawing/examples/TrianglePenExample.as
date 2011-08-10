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

package examples 
{
    import graphics.Align;
    import graphics.FillStyle;
    import graphics.LineStyle;
    import graphics.drawing.RectanglePen;
    import graphics.drawing.TrianglePen;
    
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
    
    public class TrianglePenExample extends Sprite 
    {
        public function TrianglePenExample()
        {
            var container:Sprite = new Sprite() ;
            
            container.x = 740/2 ;
            container.y = 200   ;
            
            addChild( container ) ;
            
            ///////////////////////////////
            
            a = new Shape() ;
            b = new Shape() ;
            c = new Shape() ;
            
            var rec:RectanglePen ;
            
            rec = new RectanglePen( a ) ;
            rec.fill  = new FillStyle( 0xFFFFFF ) ;
            rec.draw( 0 , 0 , 5 , 5 , Align.CENTER ) ;
            
            rec = new RectanglePen( b ) ;
            rec.fill  = new FillStyle( 0xFFFFFF ) ;
            rec.draw( 0 , 0 , 5 , 5 , Align.CENTER ) ;
            
            rec = new RectanglePen( c ) ;
            rec.fill  = new FillStyle( 0xFFFFFF ) ;
            rec.draw( 0 , 0 , 5 , 5 , Align.CENTER ) ;
            
            ///////////////////////////////
            
            var canvas:Shape = new Shape() ;
            
            container.addChild( canvas ) ;
            container.addChild( a ) ;
            container.addChild( b ) ;
            container.addChild( c ) ;
            
            pen       = new TrianglePen( canvas.graphics, 200, 200, 90, 90, 0, 0) ;
            pen.fill  = new FillStyle( 0x3F65FC , 0.6 ) ;
            pen.line  = new LineStyle( 2, 0xFFFFFF ) ;
            
            pen.draw() ;
            
            update() ;
            
            stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
        }
        
        public var a:Shape ;
        public var b:Shape ;
        public var c:Shape ;
        
        public var pen:TrianglePen ;
        
        public function keyDown( e:KeyboardEvent ):void
        {
            var code:uint = e.keyCode ;
            switch( code )
            {
                case Keyboard.LEFT :
                {
                    pen.rotation -= 10 ;
                    pen.draw() ;
                    break ;
                }
                case Keyboard.RIGHT :
                {
                    pen.rotation += 10 ;
                    pen.draw() ;
                    break ;
                }
                case Keyboard.UP :
                {
                    pen.angle -= 10 ;
                    pen.draw() ;
                    break ;
                }
                case Keyboard.DOWN :
                {
                    pen.angle += 10 ;
                    pen.draw() ;
                    break ;
                }
            }
            trace( "angle : " + pen.angle + " rotation:" + pen.rotation ) ;
            update() ;
        }
        
        public function update():void
        {
            a.x = pen.a.x ;
            a.y = pen.a.y ;
            
            b.x = pen.b.x ;
            b.y = pen.b.y ; 
            
            c.x = pen.c.x ;
            c.y = pen.c.y ; 
        }
    }
}
