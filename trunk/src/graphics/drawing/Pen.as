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
    import graphics.Align;
    import graphics.IFillStyle;
    import graphics.ILineStyle;
    
    import flash.display.Graphics;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.utils.Proxy;
    import flash.utils.flash_proxy;
    
    /**
     * The Pen class use composition to control a Graphics reference and draw custom vector graphic shapes.
     */
    public dynamic class Pen extends Proxy implements IPen 
    {
        /**
         * Creates a new Pen instance.
         * @param graphics The Graphics reference to control with this helper. You can passed-in a Shape or Sprite/MovieClip reference in argument.
         */
        public function Pen( graphics:* = null )
        {
            this.graphics = graphics ;
        }
        
        /**
         * Determinates the align value of the pen.
         */
        public function get align():uint
        {
            return _align ;
        }
        
        /**
          * @private
          */
        public function set align( align:uint ):void 
        {
            _align = Align.validate( align ) ? align : Align.TOP_LEFT ;
        }
        
        /**
         * Specifies the Graphics object belonging to this Shape object, where vector drawing commands can occur. 
         * This attribute is always a Graphics reference but must be defines with a Shape, Sprite, MovieClip or Graphics object.
         */
        public function get graphics():*
        {
            return _graphics ;
        }
        
        /**
         * @private
         */
        public function set graphics( graphics:* ):void
        {
            if ( _graphics != null )
            {
                _graphics.clear() ;
            }
            if ( graphics is Graphics )
            {
                _graphics = graphics ;
            }
            else if ( graphics is Shape )
            {
                _graphics = ( graphics as Shape ).graphics ;
            }
            else if ( graphics is Sprite )
            {
                _graphics = ( graphics as Sprite ).graphics ;
            }
            else
            {
                _graphics = null ;
            }
        }
        
        /**
         * Determinates the fill style object of the pen.
         */
        public function get fill():IFillStyle
        {
            return _fillStyle ;
        }
        
        /**
         * @private
         */
        public function set fill( style:IFillStyle ):void
        {
            _fillStyle = style || null ;
            if ( _fillStyle && _graphics )
            {
                _fillStyle.apply( _graphics ) ;
            }
        }
        
        /**
         * Determinates the line style object of the pen.
         */
        public function get line():ILineStyle
        {
            return _lineStyle ;
        }
        
        /**
         * @private
         */
        public function set line( style:ILineStyle ):void
        {
            _lineStyle = style || null ;
            if ( _lineStyle && _graphics )
            {
                _lineStyle.apply( _graphics ) ;
            }
        }
        
        /**
         * Indicates if the clear() method is invoked at the end of the draw method.
         */
        public var useClear:Boolean = true ;
        
        /**
         * Indicates if the endFill() method is invoked at the end of the draw method.
         */
        public var useEndFill:Boolean = true ;
        
        /**
         * Overrides the behavior of an object property that can be called as a function. 
         * When a method of the object is invoked, this method is called. 
         * While some objects can be called as functions, some object properties can also be called as functions. 
         */
        flash_proxy override function callProperty( methodName:*  , ...rest:Array ):* 
        {
            var res:* = null ;
            if ( _graphics )
            {
                methodName = methodName.toString() ;
                if ( methodName in _graphics )
                {
                    res = _graphics[methodName].apply(_graphics, rest);
                }
            }
            return res ;
        }
        
        /**
         * Defines a shortcut reference to used the <code class="prettyprint">beginBitmapFill</code> method.
         */
        public function BF( ...arguments:Array ):void
        {
            _graphics.beginBitmapFill.apply( _graphics, arguments ) ;
        }
        
        /**
         * Defines a shortcut reference to used the <code class="prettyprint">curveTo</code> method.
         */
        public function C( ...arguments:Array ):void
        {
            _graphics.curveTo.apply( _graphics, arguments ) ;
        }
        
        /**
         * Defines a shortcut reference to used the <code class="prettyprint">clear</code> method.
         */
        public function CL():void
        {
            _graphics.clear() ;
        }
        
        /**
         * Defines a shortcut reference to used the <code class="prettyprint">endFill</code> method.
          */
        public function EF():void
        {
            _graphics.endFill() ;
        }
        
        /**
          * Defines a shortcut reference to used the <code class="prettyprint">beginFill</code> method.
          */
        public function F( ...arguments:Array ):void
        {
            _graphics.beginFill.apply( _graphics, arguments ) ;
        }
        
        /**
         * Defines a shortcut reference to used the <code class="prettyprint">beginGradientFill</code> method.
          */
        public function GF( ...arguments:Array ):void
        {
            _graphics.beginGradientFill.apply( _graphics, arguments ) ;
        }
        
        /**
          * Defines a shortcut reference to used the <code class="prettyprint">lineGradientStyle</code> method.
          */
        public function GS( ...arguments:Array ):void
        {
            _graphics.lineGradientStyle.apply( _graphics, arguments ) ;
        }
        
        /**
         * Defines a shortcut reference to used the <code class="prettyprint">lineTo</code> method.
         */
        public function L( ...arguments:Array ):void
        {
            _graphics.lineTo.apply( _graphics, arguments ) ;
        }
        
        /**
         * Defines a shortcut reference to used the <code class="prettyprint">moveTo</code> method.
         */
        public function M( ...arguments:Array ):void
        {
            _graphics.moveTo.apply( _graphics, arguments ) ;
        }
        
        /**
         * Defines a shortcut reference to used the <code class="prettyprint">lineStyle</code> method.
         */
        public function S( ...arguments:Array ):void
        {
            _graphics.lineStyle.apply( _graphics, arguments ) ;
        }
        
        /**
         * Draws the vector graphic shape.
         */
        public function draw( ...arguments:Array ):void
        {
            if ( useClear ) 
            {
                _graphics.clear() ;
            }
            if ( _lineStyle != null )
            {
                _lineStyle.apply( _graphics ) ;
            }
            if ( _fillStyle != null )
            {
                _fillStyle.apply( _graphics ) ;
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
        public function drawShape():void
        {
            /// override this method
        }
        
        /**
         * @private
         */
        protected var _align:uint = Align.TOP_LEFT ;
        
        /**
         * @private
         */
        private var _fillStyle:IFillStyle ;
        
        /**
         * @private
         */
        protected var _graphics:Graphics ;
        
        /**
         * @private
         */
        private var _lineStyle:ILineStyle ;
    }
}
