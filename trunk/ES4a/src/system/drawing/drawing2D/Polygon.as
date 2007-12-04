
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
    import flash.geom.Point;
    
    /* Class: Polygon
       Represents a Polygon shape that can be drawn on the screen.
       
       note:
       this is very basic and can be optimized
    */
    public class Polygon extends VectorShape
        {
        
        private var _points:Array;
        
        public function Polygon( ...points )
            {
            super();
            _points = [];
            setPoints( points );
            }
        
        override protected function draw():void
            {
            graphics.moveTo( _points[0].x, _points[0].y );
            
            for( var i:int=1; i<_points.length; i++ )
                {
                graphics.lineTo( _points[i].x, _points[i].y );
                }
            
            graphics.lineTo( _points[0].x, _points[0].y );
            }
        
        public function setPoints( points:Array ):void
            {
            for( var i:int=0; i<points.length; i++ )
                {
                if( points[i] is Point )
                    {
                    _points.push( points[i] );
                    }
                }
            changed = true;
            }
        
        }
    
    }





