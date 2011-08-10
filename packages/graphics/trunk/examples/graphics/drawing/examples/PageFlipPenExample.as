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
    import graphics.Direction;
    import graphics.drawing.PageFlipPen;

    import flash.display.BitmapData;
    import flash.display.MovieClip;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.filters.DropShadowFilter;
    import flash.geom.Point;

    public dynamic class PageFlipPenExample extends Sprite 
    {
        public function PageFlipPenExample()
        {
            stage.align     = "tl" ;
            stage.scaleMode = "noScale" ;
            
            offsetX = 300 ;
            offsetY = 100 ;
            
            shape = new Shape() ;
            
            shape.filters = [ new DropShadowFilter( 20 , 160 , 0x000000 , 0.5 , 10 , 10 , 1 , 3  ) ] ;
            
            shape.x = offsetX ;
            shape.y = offsetY ;
            
            addChildAt( shape , 0 ) ;
            
            page1 = new Girl(0,0) ; // Girl a BitmapData linked in the library of the SWF.
            page2 = new Miss(0,0) ; // Miss a BitmapData linked in the library of the SWF.
            
            pen = new PageFlipPen( shape, page1, page2 ) ;
            
            pen.draw( new Point( 240 , 240 ) , PageFlipPen.BOTTOM_RIGHT , 240, 240, Direction.HORIZONTAL, 1 ) ;
            
            p1 = new Pointer() as MovieClip ; // MovieClip linked in the library of the SWF.
            p1.x = offsetX ;
            p1.y = offsetY ;
            p1.buttonMode    = true ;
            p1.useHandCursor = true ;
            p1.addEventListener( MouseEvent.MOUSE_DOWN , onStartDrag ) ;
            p1.addEventListener( MouseEvent.MOUSE_UP   , onStopDrag  ) ;
            
            p2 = new Pointer() as MovieClip ; // MovieClip linked in the library of the SWF.
            p2.x = 240 + offsetX ;
            p2.y = offsetY  ;
            p2.buttonMode    = true ;
            p2.useHandCursor = true ;
            p2.addEventListener( MouseEvent.MOUSE_DOWN , onStartDrag ) ;
            p2.addEventListener( MouseEvent.MOUSE_UP   , onStopDrag  ) ;
            
            p3 = new Pointer() as MovieClip ; // MovieClip linked in the library of the SWF.
            p3.x = 240 + offsetX ;
            p3.y = 240 + offsetY  ;
            p3.buttonMode    = true ;
            p3.useHandCursor = true ;
            p3.addEventListener( MouseEvent.MOUSE_DOWN , onStartDrag ) ;
            p3.addEventListener( MouseEvent.MOUSE_UP   , onStopDrag  ) ;
            
            p4 = new Pointer() as MovieClip ; // MovieClip linked in the library of the SWF.
            p4.x = offsetX   ;
            p4.y = 240 + offsetY  ;
            p4.buttonMode    = true ;
            p4.useHandCursor = true ;
            p4.addEventListener( MouseEvent.MOUSE_DOWN , onStartDrag ) ;
            p4.addEventListener( MouseEvent.MOUSE_UP   , onStopDrag  ) ;
            
            addChild(p1) ;
            addChild(p2) ;
            addChild(p3) ;
            addChild(p4) ;
        }
        
        public var offsetX:int ;
        public var offsetY:int ;
        public var p1     :* ;
        public var p2     :* ;
        public var p3     :* ;
        public var p4     :* ;
        public var page1  :BitmapData ;
        public var page2  :BitmapData ;
        public var pen    :PageFlipPen ;
        public var shape  :Shape ;
        
        public function enterFrame(e:Event ):void
        {
            switch( e.target )
            {
                case p1 :
                {
                    pen.draw( new Point( p1.x - offsetX , p1.y - offsetY ) ,  PageFlipPen.TOP_LEFT ) ;
                    break ;
                }               
                case p2 :
                {
                    pen.draw( new Point( p2.x - offsetX , p2.y - offsetY ) ,  PageFlipPen.TOP_RIGHT ) ;
                    break ;
                }       
                case p3 :
                {
                    pen.draw( new Point( p3.x - offsetX , p3.y - offsetY ) ,  PageFlipPen.BOTTOM_RIGHT ) ;
                    break ;
                }
                case p4 :
                {
                    pen.draw( new Point( p4.x - offsetX , p4.y - offsetY ) ,  PageFlipPen.BOTTOM_LEFT ) ;
                    break ;
                }       
                
            }
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
