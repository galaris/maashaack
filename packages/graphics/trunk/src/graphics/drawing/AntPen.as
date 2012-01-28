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
    import system.process.Runnable;
    import system.process.Startable;
    import system.process.Stoppable;
    
    import flash.display.BitmapData;
    import flash.events.TimerEvent;
    import flash.geom.Matrix;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.utils.Timer;
    import flash.utils.getTimer;
    
    /**
     * This pen display a marching ants path.
     */
    public class AntPen extends Pen implements Runnable, Startable, Stoppable
    {
        /**
         * Creates a new AntPen instance.
         * @param graphics The Graphics reference to control with this helper. You can passed-in a Shape or Sprite/MovieClip reference in argument.
         */
        public function AntPen( graphics:* = null , colors:Array = null , pattern:Array = null , speed:Number = 32 , steps:uint = 1 , closePath:Boolean = true  )
        {
            super(graphics);
            _timer = new Timer( speed ) ;
            _timer.addEventListener( TimerEvent.TIMER , _timerProgress ) ;
            setup( colors , pattern ) ;
            this.speed     = speed ;
            this.steps     = steps ;
            this.closePath = closePath ;
        }
        
        /**
         * Indicates if the pen close the path when it draw the shape.
         */
        public var closePath:Boolean ;
        
        /**
         * The representation of all points of the path to drawing.
         */
        public var points:Array ;
        
        /**
         * Indicates if the ant effect is in progress.
         */
        public function get running():Boolean
        {
            return _timer.running ;
        }
        
        /**
         * Indicates the speed of the effect.
         */
        public function get speed():Number
        {
            return _timer.delay ;
        }
        
        /**
         * @private
         */
        public function set speed( value:Number ):void
        {
            _timer.delay = value > 10 ? value : 10 ;
        }
        
        /**
         * The steps value of the pen.
         */
        public function get steps():uint
        {
            return _steps ;
        }
        
        /**
         * @private
         */
        public function set steps( value:uint ):void
        {
            _steps = value ;
        }
        
        /**
         * Draws the shape and scale it.
         */
        public override function draw( ...args:Array ):void 
        {
            if ( args.length == 1 && args[0] is Array ) 
            {
                points = args[0] as Array ;
            }
            if ( useClear ) 
            {
                _graphics.clear() ;
            }
            drawShape() ;
            if ( useEndFill )
            {
                _graphics.endFill() ; 
            }
        }
        
        /**
         * This method contains the basic drawing shape algorithm.
         */
        public override function drawShape():void
        {
            _paint( points);
        }
        
        /**
         * Sets the pen with the specified colors and the specific pattern.
         */
        public function setup( colors:Array = null , pattern:Array = null ):void
        {
            var b:Boolean = running ;
            if ( b )
            {
                stop() ;
            }
            if ( colors == null )
            {
                colors = [ 0xFF000000, 0xFFFFFFFF ] ;
            }
            else 
            {
                colors = colors.slice();
            }
            
            if ( pattern == null || pattern.length != colors.length )
            {
                pattern = [ 2 , 2 ] ;
            }
            else 
            {
                pattern = pattern.slice() ;
            }
            
            ///////
            
            _patternLength = 0 ;
            
            if ( _patternBitmap )
            {
                _patternBitmap.dispose() ;
                _patternBitmap = null ;
            }
            
            ///////
            
            var i:int ;
            var j:int ;
            var l:int ;
            var x:Number ;
            
            l = pattern.length ;
            
            for ( i = 0 ; i < l ; i++ )
            {
                _patternLength += pattern[i] ;
            }
            
            _patternBitmap = new BitmapData( _patternLength, 1 , true , 0 ) ;
            
            x = 0 ;
            l = pattern.length ;
            
            for ( i = 0 ; i < l ; i++ )
            {
                for ( j = 0 ; j < pattern[i] ; j++ )
                {
                    _patternBitmap.setPixel32( x++ , 0 , colors[i] );
                }
            }
            
            _copyRect = new Rectangle( 0 , 0 , _patternLength - 1 , 1 ) ;
            
            if ( b )
            {
                start() ;
            }
        }
        
        /**
         * Run the process.
         */
        public function run( ...arguments:Array ):void 
        {
            if ( !_timer.running )
            {
                _timer.start() ;
            }
        }
        
        /**
         * Start the process or the command.
         */
        public function start():void
        {
            if ( !_timer.running )
            {
                _timer.start() ;
            }
        }
        
        /**
         * Stop the process or the command.
         */
        public function stop():void
        {
            if ( _timer.running )
            {
                _timer.stop() ;
            }
        }
        
        /**
         * @private
         */
        private var _copyRect:Rectangle ;
        
        /**
         * @private
         */
        private const _copyPoint:Point = new Point(1,0) ;
        
        /**
         * @private
         */
        private var _lastUpdate:Number;
        
        /**
         * @private
         */
        private var _patternBitmap:BitmapData ;
        
        /**
         * @private
         */
        private var _patternLength:Number ;
        
        /**
         * @private
         */
        private var _steps:uint ;
        
        /**
         * @private
         */
        private var _timer:Timer ;
        
        /**
         * @private
         */
        private function _line(  p1:Point , p2:Point , offset:Number ):Number
        {
            var norm:Point = p2.subtract(p1) ;
            
            var len:int = norm.length;
            
            if ( len == 0 )
            {
                return offset ;
            }
            
            var mx:Number = norm.x / len;
            var my:Number = norm.y / len;
            
            var dx:Number = 0.6* my;
            var dy:Number = -0.6 * mx;
            
            var ox:Number = Math.min(p1.x,p2.x) - mx * offset;
            var oy:Number = Math.min(p1.y,p2.y) - my * offset;
            
            _graphics.moveTo( p1.x + dx, p1.y + dy );
            _graphics.beginBitmapFill( _patternBitmap , new Matrix( mx,my,-my,mx,ox,oy) ) ;
            _graphics.lineTo (p2.x + dx , p2.y + dy ) ;
            _graphics.lineTo (p2.x - dx , p2.y - dy ) ;
            _graphics.lineTo( p1.x - dx, p1.y - dy ) ;
            _graphics.lineTo( p1.x + dx, p1.y + dy ) ;
            
            return ( offset + len) % _patternLength ;
        }
        
        /**
         * @private
         */
        private function _paint( points:Array  ):void
        {
            var offset:Number = 0;
            var n:int = closePath ? points.length : points.length-1 ;
            for ( var i:int = 0; i < n ; i++)
            {
                offset = _line( points[ i % points.length] , points[ (i+1) % points.length ] , offset ) ;
            }
        }
        
        /**
         * @private
         */
        private function _timerProgress( e:TimerEvent ):void
        {
            var s:Number = _steps ;
            do
            {
                var p:uint = _patternBitmap.getPixel32( _patternBitmap.width - 1 , 0 ) ;
                _patternBitmap.copyPixels( _patternBitmap , _copyRect , _copyPoint );
                _patternBitmap.setPixel32( 0 , 0 , p ) ;
            } 
            while ( --s > 0 ) ;
            _lastUpdate = getTimer();
        }
    }
}
