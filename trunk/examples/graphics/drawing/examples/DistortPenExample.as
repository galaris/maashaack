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
    import graphics.drawing.DistortPen;

    import flash.display.BitmapData;
    import flash.display.MovieClip;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;

    public dynamic class DistortPenExample extends Sprite 
    {
        public function DistortPenExample()
        {
            stage.align     = "tl" ;
            stage.scaleMode = "noScale" ;

        	var shape:Shape = new Shape() ;
            
            shape.x = 0 ;
            shape.y = 0 ;
            
            addChildAt( shape , 0 ) ;
            
            bmp = new Picture(0,0) ; 
            
            pen = new DistortPen( shape, bmp.width, bmp.height, 4, 4 ) ;
            
            pen.bitmapData = bmp ;
            
            // display from stage
            p1 = getChildByName( "p1" ) as MovieClip ;
            p2 = getChildByName( "p2" ) as MovieClip ;
            p3 = getChildByName( "p3" ) as MovieClip ;
            p4 = getChildByName( "p4" ) as MovieClip ;
            
            pen.draw( p1 , p2 , p3 , p4 ) ;
            
            p1.buttonMode    = true ;
            p1.useHandCursor = true ;
            p1.addEventListener( MouseEvent.MOUSE_DOWN , onStartDrag ) ;
            p1.addEventListener( MouseEvent.MOUSE_UP   , onStopDrag  ) ;
            
            p2.buttonMode    = true ;
            p2.useHandCursor = true ;
            p2.addEventListener( MouseEvent.MOUSE_DOWN , onStartDrag ) ;
            p2.addEventListener( MouseEvent.MOUSE_UP   , onStopDrag  ) ;
            
            p3.buttonMode    = true ;
            p3.useHandCursor = true ;
            p3.addEventListener( MouseEvent.MOUSE_DOWN , onStartDrag ) ;
            p3.addEventListener( MouseEvent.MOUSE_UP   , onStopDrag  ) ;
            
            p4.buttonMode    = true ;
            p4.useHandCursor = true ;
            p4.addEventListener( MouseEvent.MOUSE_DOWN , onStartDrag ) ;
            p4.addEventListener( MouseEvent.MOUSE_UP   , onStopDrag  ) ;
        }
        
        public var bmp:BitmapData ;
        
        public var p1  :MovieClip ;
        public var p2  :MovieClip ;
        public var p3  :MovieClip ;
        public var p4  :MovieClip ;
        public var pen :DistortPen ;
        
        public function enterFrame(e:Event ):void
        {
            pen.draw( p1, p2, p3, p4 ) ;
        }
        
        public function onStartDrag( e:Event ):void
        {
            if ( e.target is MovieClip )
            {
                (e.target as MovieClip).startDrag() ;
                (e.target as MovieClip).addEventListener( Event.ENTER_FRAME , enterFrame ) ; 
            }
        }
        
        public function onStopDrag( e:Event ):void
        {
            if ( e.target is MovieClip )
            {
                (e.target as MovieClip).stopDrag() ;
                (e.target as MovieClip).removeEventListener( Event.ENTER_FRAME , enterFrame ) ;
            }
        }
    }
}