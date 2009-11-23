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
    import graphics.display.DisplayObjects;

    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.display.StageScaleMode;
    import flash.events.KeyboardEvent;
    import flash.geom.Rectangle;

    [SWF(width="500", height="420", frameRate="24", backgroundColor="#666666")]
    
    public class DisplayObjects01_01Example extends Sprite 
    {
        public function DisplayObjects01_01Example()
        {
            // bounds
            
            bounds = new Rectangle( 90, 90 , 320 , 240 ) ;
            
            // background
            
            graphics.beginFill( 0x000000 ) ;
            graphics.drawRect( bounds.x , bounds.y, bounds.width , bounds.height ) ;
            
            // shape
            
            shape = new Shape() ;
            
            shape.graphics.beginFill( 0xFF0000 ) ;
            shape.graphics.drawRect( 0 , 0 , 50 , 50 ) ;
            
            addChild( shape ) ;
            
            // layout
            
            DisplayObjects.align( shape , bounds ) ;
            
            // stage
            
            stage.scaleMode = StageScaleMode.NO_SCALE ;
            
            stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown) ;
        }
        
        public var bounds:Rectangle ;
        
        public var shape:Shape ;
        
        protected function keyDown( e:KeyboardEvent ):void
        {
            var code:uint = e.keyCode ;
            switch( code )
            {
                case ("1").charCodeAt(0) :
                {
                    DisplayObjects.align( shape , bounds, Align.BOTTOM_LEFT ) ;
                    break ;
                }
                case ("2").charCodeAt(0) :
                {
                    DisplayObjects.align( shape , bounds, Align.BOTTOM ) ;
                    break ;
                }
                case ("3").charCodeAt(0) :
                {
                    DisplayObjects.align( shape , bounds, Align.BOTTOM_RIGHT ) ;
                    break ;
                }
                case ("4").charCodeAt(0) :
                {
                    DisplayObjects.align( shape , bounds, Align.CENTER_LEFT ) ;
                    // DisplayObjects.align( shape , bounds, Align.LEFT ) ;
                    break ;
                }
                case ("5").charCodeAt(0) :
                {
                    DisplayObjects.align( shape , bounds, Align.CENTER ) ;
                    break ;
                }
                case ("6").charCodeAt(0) :
                {
                    DisplayObjects.align( shape , bounds, Align.CENTER_RIGHT ) ;
                    // DisplayObjects.align( shape , bounds, Align.RIGHT ) ;
                    break ;
                }
                case ("7").charCodeAt(0) :
                {
                    DisplayObjects.align( shape , bounds, Align.TOP_LEFT ) ;
                    break ;
                }
                case ("8").charCodeAt(0) :
                {
                    DisplayObjects.align( shape , bounds, Align.TOP ) ;
                    break ;
                }
                case ("9").charCodeAt(0) :
                {
                    DisplayObjects.align( shape , bounds, Align.TOP_RIGHT ) ;
                    break ;
                }
            }
        }
    }
}
