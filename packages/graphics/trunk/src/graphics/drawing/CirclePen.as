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
  Portions created by the Initial Developers are Copyright (C) 2006-2012
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

package graphics.drawing 
{
    import graphics.Align;
    
    /**
     * This pen is the tool to draw a circle vector shape.
     */
    public dynamic class CirclePen extends Pen 
    {
        /**
         * The Pen class use composition to control a Graphics reference and draw custom vector graphic shapes.
         * @param graphic The Graphics reference to control with this helper. You can passed-in a Shape or Sprite/MovieClip reference in argument.
         * @param x (optional)The x location of the center of the circle relative to the registration point of the parent display object (in pixels).
         * @param y (optional)The y location of the center of the circle relative to the registration point of the parent display object (in pixels).
         * @param radius (optional) The radius of the circle (in pixels). 
         * @param align (optional) The Align value to align the shape.
         */
        public function CirclePen( graphic:* = null , ...arguments:Array )
        {
            super( graphic ) ;
            if ( arguments.length > 1 ) 
            {
                setPen.apply( this, arguments ) ;
            }
        }
        
        /**
         * The radius value of the circle pen.
          */
        public var radius:Number ;
            
        /**
         * The offset x value of the center of the circle.
         */
        public var x:Number ;
        
        /**
          * The offset y value of the center of the circle.
          */
        public var y:Number ;
        
        /**
         * Draws the shape.
         * @param x (optional)The x location of the center of the circle relative to the registration point of the parent display object (in pixels).
         * @param y (optional)The y location of the center of the circle relative to the registration point of the parent display object (in pixels).
         * @param radius (optional) The radius of the circle (in pixels). 
         * @param align (optional) The Align value to align the shape.
         */
        public override function draw( ...arguments:Array ):void
        {
            if ( arguments.length > 0 ) 
            {
                setPen.apply( this, arguments ) ;
            }
            super.draw() ;
        }
            
        /**
         * This method contains the basic drawing shape algorithm.
         */
        public override function drawShape():void
        {
            var $a:uint = align ;
            var $x:Number = x ;
            var $y:Number = y ;
            var $r:Number = radius ;
            if ( $a == Align.CENTER ) 
            {
                // default
            }
            else if ( $a == Align.BOTTOM ) 
            {
                $y -= $r ;
            }
            else if ( $a == Align.BOTTOM_LEFT ) 
            {
                $x += $r ;
                $y -= $r ;
            }
            else if ( $a == Align.BOTTOM_RIGHT) 
            {
                $x -= $r ;
                $y -= $r ;
            }
            else if ( $a == Align.LEFT) 
            {
                $x += $r ;
            }
            else if ( $a ==  Align.RIGHT) 
            {
                $x -= $r ;
            }
            else if ( $a == Align.TOP) 
            {
                $y += $r ;
            }
            else if ( $a == Align.TOP_RIGHT) 
            {
                $x -= $r ;
                $y += $r ;
            }
            else // TOP_LEFT
            {
                $x += $r ;
                $y += $r ;
            }
            _graphics.drawCircle( $x, $y, radius ) ;
        }
        
        /**
         * Sets the pen properties.
         * @param x (optional)The x location of the center of the circle relative to the registration point of the parent display object (in pixels).
         * @param y (optional)The y location of the center of the circle relative to the registration point of the parent display object (in pixels).
         * @param radius (optional) The radius of the circle (in pixels).
         * @param align (optional) The Align value to align the shape.
         */
        public function setPen( ...arguments:Array ):void
        {
            if ( arguments[0] != null && arguments[0] is Number )
            {
                x = isNaN(arguments[0]) ? 0 : arguments[0] ; // x
            }
            if ( arguments[1] != null && arguments[1] is Number )
            {
                y = isNaN(arguments[1]) ? 0 : arguments[1] ; // y
            }
            if ( arguments[2] != null && arguments[2] is Number )
            {
                radius = isNaN(arguments[2]) ? 0 : arguments[2] ; // radius
            }
            if ( arguments.length == 4 && arguments[3] is uint )
            {
                align = arguments[3] as uint ; // align
            }
        }
    }
}
