
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
    
    /* Class: Rectangle
       Represents a Rectangle shape that can be drawn on the screen.
    */
    public class RoundedRectangle extends VectorShape
        {
        
        protected var w:Number;
        protected var h:Number;
        protected var ellipse:Number;
        
        public function RoundedRectangle( width:Number, height:Number, corner:Number = 10 )
            {
            super();
            setSize( width, height );
            setCornerSize( corner );
            }
        
        override protected function draw():void
            {
            //graphics.drawRect( 0, 0, w, h );
            graphics.drawRoundRect( 0, 0, w, h, ellipse, ellipse );
            }
        
        public function setSize( w:Number, h:Number ):void
            {
            this.w  = w;
            this.h  = h;
            changed = true;
            }
        
        public function setCornerSize( size:Number ):void
            {
            this.ellipse = size;
            changed      = true;
            }
        
        }
    
    }





