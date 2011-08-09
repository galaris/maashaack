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
    import flash.display.Graphics;
    
    /**
     * The Canvas pen is used to draw a complex shape with differents points in a data model.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import graphics.drawing.Canvas ;
     * 
     * var shape:Shape = new Shape() ;
     * shape.x = 200 ;
     * shape.y = 200 ;
     * 
     * addChild(shape) ;
     * 
     * var data:Array =
     * [
     *     ['S',[2, 0xFFFFFF, 100]] , // lineStyle(2, 0xFFFFFF, 100)
     *     ['F',[0xFF0000, 100]] , // beginFill(0xFF0000)
     *     ['M',[0,0]] , // moveTo (0,0)
     *     ['L',[80,90]] , // lineTo (80,90)
     *     ['L',[20,90]] , // lineTo (20,90)
     *     ['L',[20,50]],  // lineTo (20,50)
     *     ['EF'] // endFill ()
     * ] ;
     * 
     * var pen:Canvas = new Canvas( shape.graphics , data) ;
     * pen.draw() ;
     * </pre>
     */
    public dynamic class Canvas extends Pen 
    {
        /**
         * Creates a new Canvas instance.
         * @param graphic The Graphics reference to control with this helper. You can passed-in a Shape or Sprite/MovieClip reference in argument.
         * @param data An Array to fill of x/y points the model of the canvas.
         */
        public function Canvas( graphic:* , data:Array = null )
        {
            super( graphic );
            this.data = data ;
        }
        
        /**
         * Determinates the array representation of the model of this canvas.
         */
        public function get data():Array 
        {
            return _data ;
        }
        
        /**
         * @private
         */
        public function set data( ar:Array ):void 
        {
            _data = ar || [] ;
        }

        /**
         * Apply a transform method in this Canvas. Uses the <code class="prettyprint">CanvasTransform</code> tool class and this static methods.
         * @param transform the method effect used to transform the shape.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.drawing.Canvas ;
         * import graphics.drawing.CanvasTransform ;
         * 
         * var data:Array = 
         * [
         *     ['S',[2,0xFF0000,100]],
         *     ['F',[0x000000]],
         *     ['L',[80,0]],
         *     ['L',[160,0]],
         *     ['L',[160,50]],
         *     ['L',[160,100]],
         *     ['L',[80,100]],
         *     ['L',[0,100]],
         *     ['L',[0,50]],
         *     ['L',[0,0]],
         *     ['EF']
         * ] ;
         *  
         * this.createEmptyMovieClip("canvas_mc", 1) ;
         * canvas_mc._x = 400 ;
         * canvas_mc._y = 200 ;
         * 
         * var c:Canvas = new Canvas(canvas_mc, data) ;
         * trace (c + " : " + c.size()) ;
         * c.draw() ;
         * 
         * var bounds = canvas_mc.getBounds(canvas_mc);
         * 
         * var count:Number = 0;
         * onEnterFrame = function()
         * {
         *     count ++;
         *     var b = bounds ;
         *     var xAmount = Math.sin(count/8)*40 ;
         *     var yAmount = Math.cos(count/8)*50 ;
         *     var transform:Function = CanvasTransform.createPinch(b.xMin, b.yMin, b.xMax, b.yMax, xAmount, yAmount) ;
         *     c.setTransform( transform ) ;
         *     c.clear();
         *     c.draw() ;
         *     
         *     var speedX = (_xmouse - canvas_mc._x ) * 0.2 ;
         *     var speedY = (_ymouse - canvas_mc._y ) * 0.2 ;
         *     canvas_mc._x += speedX ;
         *     canvas_mc._y += speedY ;
         *     
         *     updateAfterEvent() ;
         * }
         * 
         * var cpt:Number = 0 ;
         * this.onKeyDown = function ()
         * {
         *     (cpt++ %2 == 0) ? c.linesToCurves() : c.curvesToLines() ;
         * }
         * Key.addListener(this) ;
         * </pre>
         * @see CanvasTransform.
         */
        public function get transform():Function
        {
            return _transform ;
        }
        
        public function set transform( transform:Function ):void 
        {    
            _transform = transform ;
        }

        /**
         * Defines a shortcut reference to used the <code class="prettyprint">curveTo</code> method.
         */
        public override function C( ...arguments:Array ):void
        {
            if ( _transform == null )
            {
                super.C.apply(this, arguments) ;
            }
            else
            {
                var cp:Object = (transform as Function)( arguments[0], arguments[1] );
                var ap:Object = (transform as Function)( arguments[2], arguments[3] ) ;
                _graphics.curveTo( cp.x , cp.y , ap.x , ap.y );
            }
        }
        
        /**
         * Defines a shortcut reference to used the <code class="prettyprint">lineTo</code> method.
         */
        public override function L( ...arguments:Array ):void
        {
            if ( _transform == null )
            {
                super.L.apply(this, arguments) ;
            }
            else
            {
                var p:Object = (transform as Function)( arguments[0], arguments[1] );
                graphics.lineTo( p.x ,p.y ) ;
            }
        }
        
        /**
         * Defines a shortcut reference to used the <code class="prettyprint">moveTo</code> method.
         */
        public override function M( ...arguments:Array ):void
        {
            if ( _transform == null )
            {
                super.M.apply(this, arguments) ;
            }
            else
            {
                var p:Object = (transform as Function)( arguments[0], arguments[1] );
                _graphics.moveTo(p.x,p.y);
            }
        }

        /**
         * Converts the curves in the model to lines.
         */
        public function curvesToLines():void 
        {
            var d:Array = _data ;
            var e:Array ;
            var value:Array ;
            var l:int = d.length ;
            while (--l > -1) 
            {
                e = d[l];
                value = e[1];
                if( e[0] == "C" )
                {
                    d[l] = ["L",[value[2],value[3]]];
                }
            }
        }
        
        /**
         * Draws the shape.
         * @param data The array representation of all items of the canvas to draw the shape.
         */
        public override function draw( ...arguments:Array ):void
        {
            if ( arguments.length > 0 ) 
            {
                data = arguments[0] ;
            }
            super.draw() ;
        }
        
        /**
         * This method contains the basic drawing shape algorithm.
         */
        public override function drawShape():void
        {
            Canvas.process( graphics , this ) ;
        }

        /**
         * Converts the lines in the model to curves.
         */
        public function linesToCurves():void 
        {
            var i:int = 0 ;
            var key:String ;
            var value:Array ;
            var e:Array ;
            var d:Array = _data ;
            var len:int = d.length;
            var ax:Number = 0 ;
            var ay:Number = 0 ;
            while ( i<len ) 
            {
                e = d[i] ;
                key = e[0] ;
                value = e[1] ;
                if( key == "L" )
                {
                    d[i] = ["C", [(ax+value[0])/2 , (ay+value[1])/2 , value[0], value[1]]] ;
                    ax = value[0] ;
                    ay = value[1] ;
                } 
                else if ( key == "C" )
                {
                    ax = value[2] ;
                    ay = value[3] ;
                }
                else if ( key == "M" )
                {
                    ax = value[0] ;
                    ay = value[1] ;
                }
                i++ ;
            }
        }
        
        /**
         * This static method launch the process to draw in a specified movieclip target the canvas defined with the (@code draw} argument.
         * @param graphics the Graphics reference.
         * @param draw the <code class="prettyprint">Canvas</code> reference used to draw in the <code class="prettyprint">target</code> reference.
         * @throws NullPointerError The Canvas process failed with a 'null' or 'undefined' graphics reference in argument.") ;
         */
        public static function process( graphics:Graphics , pen:Canvas ):void 
        {
            if ( graphics == null )
            {
                throw new ArgumentError( "Canvas process failed with a 'null' or 'undefined' graphics reference in argument.") ;    
            }
            var d:Array = pen.data ;
            var len:Number = pen.size() ;
            if ( len > 0 ) 
            {
                var c:Array ;
                var i:int = 0 ;
                while (i < len) 
                {
                    c = d[i++] ;
                    pen[ c[0] ].apply( pen[ c[0] ] , c[1] ) ;
                }
            }
        }
        
        /**
         * Returns the number of elements in the model.
         * @return the number of elements in the model.
         */
        public function size():Number 
        {
            return _data.length ;
        }
        
        /**
         * @private
         */
        private var _data:Array = [] ;
        
        /**
         * @private
         */
        private var _transform:Function ;
    }
}
