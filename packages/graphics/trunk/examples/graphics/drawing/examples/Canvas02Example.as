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
    import graphics.drawing.Canvas;
    import graphics.drawing.CanvasTransform;

    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.geom.Rectangle;

    public class Canvas02Example extends Sprite 
    {
        public function Canvas02Example()
        {
            data = 
            [
                ['S',[2,0xFF0000,100]],
                ['F',[0x000000]],
                ['L',[80,0]],
                ['L',[160,0]],
                ['L',[160,50]],
                ['L',[160,100]],
                ['L',[80,100]],
                ['L',[0,100]],
                ['L',[0,50]],
                ['L',[0,0]], 
                ['EF']
            ] ;
            
            shape = new Shape() ;
            shape.x = 400 ;
            shape.y = 200 ;
            
            addChild(shape) ;
            
            pen = new Canvas( shape , data ) ;
            pen.draw() ;
            
            
            bounds = shape.getBounds(shape) as Rectangle ;
            
            count = 0 ;
            
            stage.addEventListener( Event.ENTER_FRAME , enterFrame );
            
            cpt = 0 ;
            
            stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown );
        }
        
        public var bounds:Rectangle ;
        public var count:Number ;
        public var cpt:uint ;
        public var data:Array ;
        public var pen:Canvas ;
        public var shape:Shape ;
        
        public function enterFrame( e:Event ):void
        {
            count ++;
            var xAmount:Number = Math.sin(count/8)*40 ;
            var yAmount:Number = Math.cos(count/8)*50 ;
            pen.transform = CanvasTransform.createPinch( bounds , xAmount, yAmount) ;
            pen.draw() ;
        }

        public function keyDown( e:KeyboardEvent ):void
        {
            if (cpt++ %2 == 0) 
            {
                pen.linesToCurves() ;
            }
            else
            {
                pen.curvesToLines() ;
            }
        }
    }
}
