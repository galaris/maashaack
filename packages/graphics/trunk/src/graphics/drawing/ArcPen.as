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
    import core.maths.degreesToRadians;
    import core.maths.fixAngle;

    import graphics.Align;
    import graphics.ArcType;
    import graphics.LineStyle;
    
    /**
     * This pen draw a pie or chord arc shape with a Graphics object.
     */
    public dynamic class ArcPen extends Pen 
    {
        /**
         * Creates a new ArcPen instance.
         * @param graphic The Graphics reference to control with this helper. You can passed-in a Shape or Sprite/MovieClip reference in argument.
         * @param angle (optional) The angle of the arc pen. (default 360)
         * @param radius (optional) The radius value of the arc. (default 100)
         * @param x (optional) The x position of the center of the arc. (default 0)
         * @param y (optional) The y position of the center of the arc. (default 0)
         * @param startAngle (optional) The start angle of the pen. (default 0)
         * @param yRadius (optional) The y radius value of the pen. (default NaN)
         * @param type (optional) The ArcType of the pen. (default ArcType.PIE)
         * @param align (optional) The align value of the pen. (default Align.TOP_LEFT)
         */
        public function ArcPen( graphic:* = null , angle:Number = 360, radius:Number = 100 , x:Number = 0 , y:Number = 0 , startAngle:Number = 0, yRadius:Number = NaN , type:String = "pie", align:uint = 10  )
        {
            super( graphic ) ;
            setPen( angle , radius , x , y , startAngle , yRadius , type , align ) ;
        }
        
        /**
         * Indicates the value of the angle used to draw an arc shape.
         */
        public function get angle():Number 
        {
            return _angle ;
        }
        
        /**
         * @private
         */
        public function set angle(n:Number):void 
        {
            _angle = fixAngle( n ) ;
        }
        
        /**
         * Defines the radius value of the arc shape.
         */
        public var radius:Number;
        
        /**
         * Defines the value of the start angle to draw the arc in the display reference.
         */
        public function get startAngle():Number 
        {
            return _startAngle ;
        }
        
        /**
         * @private
         */
        public function set startAngle( n:Number ):void 
        {
            _startAngle = degreesToRadians(n) ;
        }
        
        /**
         * Defines the type of the arc, can be a chord or a pie arc.
         * @see ArcType
         */
        public function get type():String
        {
            return _type ;
        }
        
        /**
         * @private
         */
        public function set type( type:String ):void
        {
            _type = (type == ArcType.CHORD || type == ArcType.PIE ) ? type : ArcType.NONE ;
        }
        
        /**
         * Defines the x origin position of the arc shape.
         */
        public var x:Number ;
        
        /**
         * Defines the y origin position of the arc shape.
         */
        public var y:Number ;
        
        /**
         * Defines the y origin position of the arc radius.
         */
        public var yRadius:Number ;
        
        /**
         * Draws the shape in the movieclip reference of this pen.
         * @param angle (optional) The angle of the arc pen.
         * @param radius (optional) The radius value of the arc.
         * @param x (optional) The x position of the center of the arc.
         * @param y (optional) The y position of the center of the arc.
         * @param startAngle (optional) The start angle of the pen.
         * @param yRadius (optional) The y radius value of the pen.
         * @param type (optional) The ArcType of the pen.
         * @param align (optional) The align value of the pen.
         */
        public override function draw( ...args:Array ):void 
        {
            if ( args.length > 0 ) 
            {
                setPen.apply( this , args ) ;
            }
            super.draw() ;
        }
        
        /**
         * This method contains the basic drawing shape algorithm.
         */
        public override function drawShape():void
        {
            var nR:Number = isNaN( yRadius ) ? radius : yRadius ;
            var $x:Number = isNaN(x) ? 0 : x ; 
            var $y:Number = isNaN(y) ? 0 : y ;
            switch ( align ) 
            {
                case Align.TOP :
                {
                    $y += nR ;
                    break ;
                }
                case Align.BOTTOM :
                {
                    $y -= nR ;
                    break ;
                }
                case Align.LEFT :
                {
                    $x += radius ;
                    break ;
                }
                case Align.RIGHT :
                {
                    $x -= radius ;
                    break ;
                }
                case Align.TOP_LEFT :
                {
                    $x += radius ;
                    $y = nR ;
                    break ;
                }
                case Align.TOP_RIGHT :
                {
                    $x -= radius ;
                    $y = nR ;
                    break ;
                }
                case Align.BOTTOM_LEFT :
                {
                    $x += radius ;
                    $y -=  nR ;
                    break ;
                }
                case Align.BOTTOM_RIGHT :
                {
                    $x -= radius ;
                    $y -= nR ;
                    break ;
                }
            }
            
            _graphics.moveTo( $x, $y ) ;
            
            var ax:Number ; var ay:Number ; 
            var bx:Number ; var by:Number ; 
            var cx:Number ; var cy:Number ;
            
            var angleMid:Number ;
            
            var a:Number        = - _startAngle  ;
            var segs:Number     = Math.ceil ( Math.abs( _angle ) / 45 ) ;
            var segAngle:Number = _angle / segs ;
            var theta:Number    = - degreesToRadians(segAngle) ;
            
            ax = $x + Math.cos (_startAngle) * radius ;
            ay = $y + Math.sin (-_startAngle) * nR ;
            
            if( segs > 0 ) 
            {
                if (_angle < 360 && _angle > -360 && type == ArcType.PIE) 
                {
                    _graphics.lineTo (ax, ay) ;
                }
                _graphics.moveTo (ax, ay) ;
                for (var i:int = 0 ; i<segs ; i++) 
                {
                    a += theta ;
                    
                    angleMid = a - ( theta / 2 ) ;
                    
                    bx = $x + Math.cos ( a ) * radius ;
                    by = $y + Math.sin ( a ) * nR ;
                    cx = $x + Math.cos( angleMid ) * ( radius / Math.cos ( theta / 2 ) ) ;
                    cy = $y + Math.sin( angleMid ) * ( nR / Math.cos( theta / 2 ) ) ;
                    
                    _graphics.curveTo(cx, cy, bx, by) ;
                }
                if ( type == ArcType.CHORD )
                {
                    _graphics.lineTo(ax, ay) ; // CHORD or other value
                }
                else if ( type == ArcType.PIE )
                {
                    if ( _angle < 360 && _angle > -360 ) 
                    {
                        _graphics.lineTo( $x, $y );
                    }
                }
                else
                {
                    LineStyle.EMPTY.apply( graphics ) ;
                    _graphics.lineTo(ax, ay) ; // CHORD or other value
                }
            }
        }
        
        /**
         * Sets the arc options to defined all values to draw the arc shape in the movieclip reference of this pen.
         * @param angle (optional) The angle of the arc pen.
         * @param radius (optional) The radius value of the arc.
         * @param x (optional) The x position of the center of the arc.
         * @param y (optional) The y position of the center of the arc.
         * @param startAngle (optional) The start angle of the pen.
         * @param yRadius (optional) The y radius value of the pen.
         * @param type (optional) The ArcType of the pen.
         * @param align (optional) The align value of the pen.
         */
        public function setPen( ...args:Array  ):void 
        {
            if ( args[0] != null && args[0] is Number )
            {
                this.angle = isNaN( args[0] ) ? 0 : args[0] ;
            }
            if ( args[1] != null && args[1] is Number )
            {
                this.radius = isNaN( args[1] ) ? 0 : args[1] ;
            }
            if ( args[2] != null && args[2] is Number )
            {
                this.x = isNaN( args[2] ) ? 0 : args[2] ;
            }
            if ( args[3] != null && args[3] is Number )
            {
                this.y = isNaN( args[3] ) ? 0 : args[3] ;
            }
            if ( args[4] != null && args[4] is Number )
            {            
                this.startAngle = isNaN( args[4] ) ? 0 : args[4] ;
            }
            if ( args[5] != null && args[5] is Number )
            {
                this.yRadius = args[5] ;
            }
            if ( args[6] != null &&  args[6] is String )
            {
                this.type = args[6] ;
            }
            
            if ( args[7] != null )
            {
                this.align = args[7] ;
            }
        }
        
        /**
         * @private
         */
        private var _angle:Number ;
        
        /**
         * @private
         */
        private var _startAngle:Number ;
        
        /**
         * @private
         */
        private var _type:String ;
    }
}
