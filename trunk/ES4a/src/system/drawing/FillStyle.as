
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

package system.drawing
    {
    import flash.display.Graphics;
    
    /* Class: FillStyle
       Define a FillStyle structure to be used with flash.display.graphics.beginFill
    */
    public class FillStyle
        {
        
        public var color:uint;
        public var alpha:Number;
        
        public function FillStyle( color:uint, alpha:Number = 1.0 )
            {
            this.color = color;
            this.alpha = alpha;
            }
        
        public function applyTo( graphic:Graphics ):void
            {
            graphic.beginFill( this.color,
                               this.alpha );
            }
        
        }
    
    }
