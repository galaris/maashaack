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
    import graphics.display.DisplayObjects;
    import graphics.geom.AspectRatio;

    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.display.StageScaleMode;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;

    [SWF(width="360", height="280", frameRate="24", backgroundColor="#666666")]
    
    public class DisplayObjects03Example extends Sprite 
    {
        public function DisplayObjects03Example()
        {
            // container
            
            graphics.beginFill( 0x000000 ) ;
            graphics.drawRect( 20 , 20 , 320 , 240 ) ;
            
            // shape
            
            shape = new Shape() ;
            
            shape.x = 20 ;
            shape.y = 20 ;
            
            shape.graphics.beginFill( 0xFF0000 ) ;
            shape.graphics.drawRect( 0 , 0 , 150 , 50 ) ;
            
            addChild( shape ) ;
            
            // stage
            
            stage.scaleMode = StageScaleMode.NO_SCALE ;
            
            stage.addEventListener( KeyboardEvent.KEY_DOWN, down) ;
        }
        
        public var container:Sprite ;
        
        public var shape:Shape ;
        
        protected function down( e:KeyboardEvent ):void
        {
            var code:uint = e.keyCode ;
            switch( code )
            {
                case Keyboard.LEFT :
                {
                    DisplayObjects.resize(shape, 240, 240, new AspectRatio(4,3)) ;
                    break ;
                }
                case Keyboard.RIGHT :
                {
                    DisplayObjects.resize(shape, 340, 100, new AspectRatio(16,9)) ;
                    break ;
                }
                case Keyboard.UP :
                {
                    DisplayObjects.resize(shape, 120, 200, true) ;
                    break ;
                }
                case Keyboard.DOWN :
                {
                    DisplayObjects.resize(shape, 120, 200 ) ;
                    break ;
                }
                case Keyboard.SPACE :
                {
                    DisplayObjects.resize(shape, 150, 50) ;
                    break ;
                }
            }
        }
    }
}
