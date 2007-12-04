
/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [ES4a: ECMAScript 4 MaasHaack framework].
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
*/

package system.drawing.drawing2D
    {
    import flash.errors.IllegalOperationError;
    
    import flash.events.Event;
    
    import flash.display.Shape;
    import flash.display.LineScaleMode;
    import flash.display.JointStyle;
    
    import system.drawing.FillStyle;
    import system.drawing.LineStyle;
    
    /* Class: VectorShape
       Represents a geometric vector shape.
       
       note:
       We don't have abstract class but this class in itself
       shoudl be considered abstract, use the subclasses
       to draw something on the screen.
    */
    public class VectorShape extends Shape
        {
        
        private var _closed:Boolean;
        private var _changed:Boolean;
        
        public var lineStyle:LineStyle = new LineStyle( 1 );
        public var fillStyle:FillStyle = new FillStyle( 0xFFFFFF );
        
        public function VectorShape()
            {
            super();
            _closed  = true;
            _changed = false;
            
            lineStyle.scaleMode = LineScaleMode.NORMAL;
            lineStyle.caps      = null;
            lineStyle.joints    = JointStyle.MITER;
            
            /* note:
               will work from flash player 9.0.28
               see http://www.adobe.com/support/documentation/en/flashplayer/9/releasenotes.html
               "Fixes and improvements in Flash Player 9.0.28.0
               ...
               Addition of ADDED_TO_STAGE and REMOVED_FROM_STAGE events to allow a DisplayObject
               to monitor and know when it can or cannot access its stage property.
               The ADDED_TO_STAGE event is dispatched to a DisplayObject when it
               (or the tree in which it is contained) is added to the stage.
               The REMOVED_FROM_STAGE event is dispatched to a DisplayObject when it
               (or the tree in which it is contained) is removed from the stage.
               ...
               "
            */
            addEventListener( Event.ADDED_TO_STAGE, addedToStageListener );
            addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageListener );
            }
        
        private function _draw():void
            {
            graphics.clear();
            
            /* note:
               If thickness is set to undefined
               graphics will not render the line
               so we test it before applying the rendering
            */
            if( lineStyle.thickness )
                {
                lineStyle.applyTo( graphics );
                }
            
            fillStyle.applyTo( graphics );
            draw();
            graphics.endFill();
            changed = false;
            }
        
        protected function addedToStageListener( event:Event ):void
            {
            stage.addEventListener( Event.RENDER, renderListener );
            if( changed )
                {
                redraw();
                }
            }
        
        protected function removedFromStageListener( event:Event ):void
            {
            stage.removeEventListener( Event.RENDER, renderListener );
            }
        
        protected function renderListener( event:Event ):void
            {
            if( changed )
                {
                _draw();
                }
            }
        
        protected function draw():void
            {
            throw new IllegalOperationError( "draw() method can be invoked only on VectorShape subclasses." );
            }
        
        protected function redraw():void
            {
            if( stage != null )
                {
                stage.invalidate();
                }
            }
        
        public function get changed():Boolean
            {
            return _changed;
            }
        
        public function set changed( value:Boolean ):void
            {
            _changed = value;
            if( value )
                {
                redraw();
                }
            }
        
        public function isClosed():Boolean
            {
            return _closed;
            }
        
        }
    
    }
