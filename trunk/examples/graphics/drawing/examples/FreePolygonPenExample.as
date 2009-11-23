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
  Nicolas Surian (aka NairuS) <nicolas.surian@gmail.com> 
*/

package examples 
{
    import graphics.FillStyle;
    import graphics.drawing.FreePolygonPen;
    import graphics.geom.Vector2;

    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.display.StageScaleMode;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;

    public class FreePolygonPenExample extends Sprite 
    {
        public function FreePolygonPenExample()
        {
            stage.scaleMode = StageScaleMode.NO_SCALE ;
            stage.align     = "" ;
            
            var shape:Shape = new Shape() ;
            shape.x = 740 / 2 ;
            shape.y = 420 / 2 ;
            
            pen = new FreePolygonPen
            (
                shape       , 
                new Vector2(0,0)     , 
                new Vector2(40,0)    , 
                new Vector2(50,10)   , 
                new Vector2(60,0)    , 
                new Vector2(100,0)   , 
                new Vector2(100,100) , 
                new Vector2(0,100)            
            ) ;
            pen.fill = new FillStyle( 0xFF0000 , 0.6 ) ;
            pen.draw() ;
            
            addChild( shape ) ;
            stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
        }
        
        public var pen:FreePolygonPen ;
        
        public function keyDown( e:KeyboardEvent ):void
        {
            var code:uint = e.keyCode ;
            switch( code )
            {
                case Keyboard.LEFT :
                {
                    pen.draw( new Vector2(-50,-50) , new Vector2(50,-50) , new Vector2(50,50) ,  new Vector2(-50,50)  ) ;
                    break ;
                }
                case Keyboard.RIGHT :
                {
                    var points:Array = [ new Vector2(0,0) , new Vector2(50,100) , new Vector2(-50,100) ] ;
                    pen.draw( points ) ;
                    break ;
                }
                case Keyboard.UP :
                {
                    pen.points = [ new Vector2(0,0) , new Vector2(50,100) , new Vector2(0,150), new Vector2(-50,100) ];
                    pen.draw() ;
                    break ;
                }
            }
        }
    }
}
