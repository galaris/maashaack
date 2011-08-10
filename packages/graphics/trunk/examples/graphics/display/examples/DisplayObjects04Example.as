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
    import graphics.display.DisplayObjects;

    import flash.display.Sprite;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    [SWF(width="500", height="420", frameRate="24", backgroundColor="#666666")]
    
    public class DisplayObjects04Example extends Sprite 
    {
        public function DisplayObjects04Example()
        {
            // bounds
            
            var bounds:Rectangle = new Rectangle( 90, 90 , 320 , 240 ) ;
            
            // background
            
            graphics.beginFill( 0x000000 ) ;
            graphics.drawRect( bounds.x , bounds.y, bounds.width , bounds.height ) ;
            
            // square
            
            sprite = new Sprite() ;
            
            sprite.addEventListener( MouseEvent.MOUSE_DOWN , mouseDown ) ;
            stage.addEventListener( MouseEvent.MOUSE_UP   , mouseUp ) ;
            
            sprite.graphics.beginFill( 0xFF0000 ) ;
            sprite.graphics.drawRect( 0 , 0 , 50 , 50 ) ;
            
            addChild( sprite ) ;
            
            // layout
            
            DisplayObjects.align( sprite , bounds , Align.CENTER ) ;
            
            // stage
            
            stage.scaleMode = StageScaleMode.NO_SCALE ;
        }
        
        public var anchor:Point = new Point() ;
        
        public var angle:uint ;
        
        public var sprite:Sprite ;
        
        protected function mouseDown( e:MouseEvent ):void
        {
            angle = 0 ;
            anchor.x = sprite.mouseX ;
            anchor.y = sprite.mouseY ;
            addEventListener(Event.ENTER_FRAME , enterFrame ) ;
        }
        
        protected function mouseUp( e:MouseEvent ):void
        {
            removeEventListener(Event.ENTER_FRAME , enterFrame ) ;
        }
        
        protected function enterFrame( e:Event ):void
        {
            angle ++ ;
            if ( angle > 360 )
            {
                angle = 360 - angle ;
            }
            DisplayObjects.rotate( sprite , angle , anchor ) ;
        }
    }
}
