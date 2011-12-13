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

package graphics.drawing 
{
    /**
     * This pen is the basic tool to draw a dash line.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import flash.display.StageScaleMode ;
     * 
     * import graphics.LineStyle ;
     * 
     * import graphics.drawing.DashLinePen ;
     * 
     * import graphics.geom.Vector2 ;
     * 
     * stage.scaleMode = StageScaleMode.NO_SCALE ;
     * stage.align     = "" ;
     * 
     * var shape:Shape = new Shape() ;
     * 
     * shape.x = 10 ;
     * shape.y = 10 ;
     * 
     * var start:Vector2 = new Vector2(0,0) ;
     * var end:Vector2   = new Vector2(100, 100) ;
     * 
     * var pen:DashLinePen = new DashLinePen( shape , start , end , 4, 6) ;
     * pen.line            = new LineStyle( 2, 0xFFFFFF , 1 , true ) ;
     * pen.draw() ;
     * 
     * addChild( shape ) ;
     * </pre>
     */
    public dynamic class DashLinePen extends LinePen
    {
        /**
         * Creates a new DashLinePen instance.
         * @param graphic The Graphics reference to control with this helper. You can passed-in a Shape or Sprite/MovieClip reference in argument.
         * @param start The vector object to defines the start position of the drawing.
         * @param end The vector object to defines the end position of the drawing.
         * @param length The length of the dashs.
         * @param spacing The spacing between two dashs.
         */
        public function DashLinePen(graphic:*, start:* = null, end:* = null , length:Number = 2 , spacing:Number = 2 )
        {
            super( graphic );
            setPen( start, end, length, spacing ) ;
        }
        
        /**
         * The default length value of the dashs in the line.
         */
        public static var DEFAULT_LENGTH:Number = 2 ;
        
        /**
         * The default spacing value of the dashs in the line.
         */
        public static var DEFAULT_SPACING:Number = 2 ;
        
        /**
         * (read-write) Determinates the length of a dash in the line.
         */
        public function get length():Number 
        {
            return _length ;
        }
        
        /**
         * @private
         */
        public function set length(n:Number):void 
        {
            _length = isNaN(n) ? DEFAULT_LENGTH : n ; 
        }
        
        /**
         * Determinates the spacing value between two dashs in this line.
         */
        public function get spacing():Number 
        {
            return _spacing ;
        }
        
        /**
         * @private
         */
        public function set spacing(n:Number):void 
        {
            _spacing = isNaN( n ) ? DEFAULT_SPACING : n ; 
        }
        
        /**
         * This method contains the basic drawing shape algorithm.
         */
        public override function drawShape():void
        {
            if ( start.equals( end ) )
            {
                return ;
            }
            
            var segl:Number = length + spacing ;
            
            if ( isNaN(segl) )
            {
                segl = 0 ;
            }
            
            var dx:Number     = end.x - start.x ;
            var dy:Number     = end.y - start.y ;
            
            var delta:Number  = Math.sqrt((dx * dx) + (dy * dy));
            var nbSegs:Number = Math.floor(Math.abs(delta / segl)) ;
            
            _radians = Math.atan2 ( dy, dx ) ;
            
            __x = start.x;
            __y = start.y;
            
            dx = Math.cos(_radians)* segl ;
            dy = Math.sin(_radians)* segl ;
            
            for (var i:Number = 0; i < nbSegs; i++) 
            {
                _graphics.moveTo( __x, __y ) ;
                _lineRadiansTo ( _length ) ;
                __x += dx ;
                __y += dy ;
            }
            
            _graphics.moveTo(__x, __y) ; 
            delta = Math.sqrt((end.x - __x)*(end.x - __x)+ (end.y - __y)* (end.y - __y)) ;
            
            if(delta>_length) 
            {
                _lineRadiansTo ( _length ) ;
            }
            else if (delta > 0) 
            {
                _lineRadiansTo ( delta ) ;
            }
            
            _graphics.moveTo(end.x, end.y);
        }
        
        /**
         * Sets the arc options to defined all values to draw the arc shape in the movieclip reference of this pen.
         * @param end (optional) The end vector value (flash.geom.Point or graphics.geom.Vector2)
         * @param start (optional) The start vector value (flash.geom.Point or graphics.geom.Vector2)
         */
        public override function setPen( ...args:Array  ):void 
        {
            super.setPen.call(this, args[0] , args[1] ) ;
            if ( args[2] != null && args[2] is Number )
            {
                length = args[2] ;
            }
            if ( args[3] != null && args[3] is Number )
            {
                spacing = args[3] ;
            }
        }
        
        /**
         * @private
         */
        private var _length:Number = 2 ;
        
        /**
         * @private
         */
        private var _radians:Number ; 
        
        /**
         * @private
         */
        private var _spacing:Number = 2 ;
        
        /**
         * @private
         */
        private var __x:Number ;
        
        /**
         * @private
         */
        private var __y:Number ;
        
        /**
         * @private
         */
        private function _lineRadiansTo( n:Number ):void
        {
            _graphics.lineTo ( __x + Math.cos(_radians) * n ,  __y + Math.sin(_radians) * n ) ;
        }
    }
}
