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
    import graphics.FillStyle;
    import graphics.drawing.PolyLinePen;
    import graphics.geom.Vector2;

    import flash.display.MovieClip;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.Point;

    public class PolyLinePenExample extends Sprite 
    {
        public function PolyLinePenExample()
        {
            stage.align     = "tl" ;
            stage.scaleMode = "noScale" ;
            
            var shape:Shape = new Shape() ;
            
            shape.x = 0 ;
            shape.y = 0 ;
            
            addChild( shape ) ;
            
            var data:Array = 
            [
                new Vector2(10,10), new Vector2(110,10), new Point(110,110), {x:10,y:110}   
            ] ; 
            
            pen      = new PolyLinePen( shape , data ) ;
            pen.fill = new FillStyle( 0xFF0000 ) ;
            pen.draw() ;
            
            // display from stage
            p1 = getChildByName( "p1" ) as MovieClip ;
            p2 = getChildByName( "p2" ) as MovieClip ;
            p3 = getChildByName( "p3" ) as MovieClip ;
            p4 = getChildByName( "p4" ) as MovieClip ;
            
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
        
        public var p1   :MovieClip ;
        public var p2   :MovieClip ;
        public var p3   :MovieClip ;
        public var p4   :MovieClip ;
        public var pen  :PolyLinePen ;
                
        public function enterFrame(e:Event ):void
        {
            pen.draw( [p1,p2,p3,p4] ) ;
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
