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

    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.display.StageScaleMode;
    import flash.events.MouseEvent;
    import flash.geom.Point;

    [SWF(width="360", height="280", frameRate="24", backgroundColor="#666666")]
    
    public class DisplayObjects02Example extends Sprite 
    {
        public function DisplayObjects02Example()
        {
            // container
            
            container = new Sprite() ;
            
            container.buttonMode   = true ;
            container.mouseEnabled = true ;
            
            container.x = 20 ;
            container.y = 20 ;
            
            container.graphics.beginFill( 0x000000 ) ;
            container.graphics.drawRect( 0 , 0 , 320 , 240 ) ;
            
            addChild( container ) ;
            
            // shape
            
            shape = new Shape() ;
            
            shape.x = 20 ;
            shape.y = 20 ;
            
            shape.graphics.beginFill( 0xFF0000 ) ;
            shape.graphics.drawRect( 0 , 0 , 50 , 50 ) ;
            
            container.addChild( shape ) ;
            
            // stage
            
            stage.scaleMode = StageScaleMode.NO_SCALE ;
            
            container.addEventListener( MouseEvent.MOUSE_DOWN , down) ;
        }
        
        public var container:Sprite ;
        
        public var shape:Shape ;
        
        protected function down( e:MouseEvent ):void
        {
            var local:Point  = new Point( e.localX , e.localY ) ;
            var change:Point = DisplayObjects.localToLocal( local , shape , container ) ;
            trace( local + " -> " + change ) ;
        }
    }
}
