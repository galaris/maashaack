/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :

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
