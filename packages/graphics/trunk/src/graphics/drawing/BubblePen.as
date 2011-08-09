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
    import graphics.geom.Vector2;
    
    import system.hack;
    
    import flash.geom.Rectangle;
    
    /**
     * Draws a bubble shape with a custom alignment, offset, corner radius, arrow and size.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * package examples
     * {
     *     import graphics.Align;
     *     import graphics.FillStyle;
     *     import graphics.LineStyle;
     *     
     *     import graphics.drawing.BubblePen;
     *     
     *     import flash.display.Shape;
     *     import flash.display.Sprite;
     *     import flash.display.StageScaleMode;
     *     import flash.events.KeyboardEvent;
     *     import flash.ui.Keyboard;
     *     
     *     public class ExampleBubblePen extends Sprite
     *     {
     *         public function ExampleBubblePen()
     *         {
     *             /////////
     *             
     *             stage.scaleMode = StageScaleMode.NO_SCALE ;
     *             stage.align = "" ;
     *             
     *             stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
     *             
     *             /////////
     *             
     *             var shape:Shape = new Shape() ;
     *             
     *             shape.x = 740 / 2 ;
     *             shape.y = 420 / 2 ;
     *             
     *             addChild( shape ) ;
     *             
     *             /////////
     *             
     *             pen = new BubblePen( shape , 0 , 0, 200, 150, 14, 14, 14 , 14 ) ;
     *             
     *             pen.arrowHeight = 15 ;
     *             pen.arrowWidth  = 15 ;
     *             pen.arrowMargin = 20 ; // only when a corner radius is 0
     *             
     *             pen.align = Align.TOP_RIGHT ;
     *             pen.fill  = new FillStyle( 0xFF0000 , 0.5 ) ;
     *             pen.line  = new LineStyle( 2, 0xFFFFFF ) ;
     *             
     *             pen.draw() ;
     *         }
     *         
     *         public var pen:BubblePen ;
     *         
     *         public function keyDown( e:KeyboardEvent ):void
     *         {
     *             var code:uint = e.keyCode ;
     *             switch( code )
     *             {
     *                 case Keyboard.LEFT :
     *                 case Keyboard.NUMPAD_6 :
     *                 {
     *                     pen.align = Align.LEFT ;
     *                     break ;
     *                 }
     *                 case Keyboard.RIGHT :
     *                 case Keyboard.NUMPAD_4 :
     *                 {
     *                     pen.align = Align.RIGHT ;
     *                     break ;
     *                 }
     *                 case Keyboard.UP :
     *                 case Keyboard.NUMPAD_2 :
     *                 {
     *                     pen.align = Align.TOP ;
     *                     break ;
     *                 }
     *                 case Keyboard.DOWN :
     *                 case Keyboard.NUMPAD_8 :
     *                 {
     *                     pen.align = Align.BOTTOM ;
     *                     break ;
     *                 }
     *                 case Keyboard.SPACE :
     *                 {
     *                     pen.align = Align.TOP_LEFT ;
     *                     break ;
     *                 }
     *                 case Keyboard.NUMPAD_7 :
     *                 {
     *                     pen.align = Align.BOTTOM_RIGHT ;
     *                     break ;
     *                 }
     *                 case Keyboard.NUMPAD_9 :
     *                 {
     *                     pen.align = Align.BOTTOM_LEFT ;
     *                     break ;
     *                 }
     *                 case Keyboard.NUMPAD_1 :
     *                 {
     *                     pen.align = Align.TOP_RIGHT ;
     *                     break ;
     *                 }
     *                 case Keyboard.NUMPAD_3 :
     *                 {
     *                     pen.align = Align.TOP_LEFT ;
     *                     break ;
     *                 }
     *             }
     *             pen.draw() ;
     *             trace( "rectangle area : " + pen.rectangle ) ;
     *         }
     *     }
     * }
     * </pre>
     */
    public class BubblePen extends RoundedComplexRectanglePen 
    {
        use namespace hack ;
        
        /**
         * Creates a new BubblePen instance.
         * @param graphic The Graphics reference to control with this helper. You can passed-in a Shape or Sprite/MovieClip reference in argument.
         * @param x (optional) The x position of the pen. (default 0)
         * @param y (optional) The y position of the pen. (default 0)
         * @param width (optional) The width of the pen. (default 0)
         * @param height (optional) The height of the pen. (default 0)
         * @param topLeftRadius (optional) The radius of the upper-left corner, in pixels. (default 0)
         * @param topRightRadius (optional) The radius of the upper-right corner, in pixels. (default 0)
         * @param bottomLeftRadius (optional) The radius of the bottom-left corner, in pixels. (default 0)
         * @param bottomRightRadius (optional) The radius of the bottom-right corner, in pixels. (default 0)
         * @param align (optional) The align value of the pen. (default Align.TOP_LEFT)
         */
        public function BubblePen( graphic:*, x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0, topLeftRadius:Number = 0, topRightRadius:Number = 0, bottomRightRadius:Number = 0 , bottomLeftRadius:Number = 0, align:uint = 10)
        {
            super( graphic, x, y, width, height, topLeftRadius, topRightRadius, bottomLeftRadius, bottomRightRadius, align );
        }
        
        /**
         * Determinates the height of the arrow of the bubble.
         */
        public function get arrowHeight():Number 
        { 
            return _arrowHeight ;
        }
        
        /**
         * @private
         */
        public function set arrowHeight(n:Number):void 
        { 
            _arrowHeight = (n>0) ? n : 0 ;
        }
        
        /**
         * Determinates the margin of the arrow of the bubble.
         */
        public function get arrowMargin():Number 
        { 
            return _arrowMargin ;
        }
        
        /**
         * @private
         */
        public function set arrowMargin( n:Number ):void 
        { 
            _arrowMargin = (n>0) ? n : 0 ;
        }
        
        /**
         * Determinates the margin of the arrow of the bubble.
         */
        public function get arrowWidth():Number 
        { 
            return _arrowWidth ;
        }
        
        /**
         * @private
         */
        public function set arrowWidth(n:Number):void 
        { 
            _arrowWidth = (n>0) ? n : 0 ;
        }
        
        /**
         * The Rectangle reference of this pen (use it to defines the rectangle area and not the arrow area of the bubble).
         * This property change when the draw() method is invoked.
         */
        public override function get rectangle():Rectangle 
        {
            return new Rectangle( _min.x, _min.y , width, height ) ;
        }
        
        /**
         * The maximum Vector2 object to defines the bottom right point of the rectangle area in the bubble shape.
         */
        public function get maximum():Vector2 
        {
            return _max.clone() as Vector2 ;
        }
        
        /**
         * The minimum Vector2 object to defines the top left point of the rectangle area in the bubble shape.
         */
        public function get minimum():Vector2 
        {
            return _min.clone() as Vector2 ;
        }
        
        /**
         * This method contains the basic drawing shape algorithm.
         */
        public override function drawShape():void
        {
            if ( _align == Align.CENTER )
            {
                super.drawShape() ;
                return ;
            }
            _x = isNaN(x) ? 0 : x ;
            _y = isNaN(x) ? 0 : y ;
            
            if( align == Align.BOTTOM ) 
            {
                _min.x = -width / 2 ; 
                _min.y = -height - _arrowHeight ; 
            }
            else if ( align == Align.BOTTOM_LEFT )
            {
                _min.x = -1 * ( ( _bottomLeftRadius > 0 ) ? _bottomLeftRadius : _arrowMargin )  ; 
                _min.y = -height - _arrowHeight ; 
            }
            else if ( align == Align.BOTTOM_RIGHT )
            {
                _min.x = -width +  ( ( _bottomRightRadius > 0 ) ? _bottomRightRadius : _arrowMargin ) ; 
                _min.y = -height - _arrowHeight ; 
            }
            else if ( align == Align.LEFT )
            {
                _min.x = _arrowHeight ; 
                _min.y = -height / 2 ; 
            }
            else if ( align == Align.RIGHT )
            {
                _min.x = -width - _arrowHeight ; 
                _min.y = -height / 2 ; 
            }
            else if ( align == Align.TOP )
            {
                _min.x = -width / 2   ; 
                _min.y = _arrowHeight ; 
            }
            else if ( align == Align.TOP_RIGHT )
            {
                _min.x = -width + ( ( _topRightRadius > 0 ) ? _topRightRadius : _arrowMargin ) ; 
                _min.y = _arrowHeight      ;
            }
            else // Align.TOP_LEFT
            {
                _min.x = -1 * ( ( _topLeftRadius > 0 ) ? _topLeftRadius : _arrowMargin ) ; 
                _min.y = _arrowHeight ;
            }
            
            _min.x += _x ;
            _min.y += _y ;
            _max.x  = _min.x + width  ;
            _max.y  = _min.y + height ;
            
            if ( _corner.bl )
            {
                _bl = isNaN( _cornerRadius ) ? _bottomLeftRadius : _cornerRadius ;
                _bl = ( _bl  > Math.min (width, height) / 2 ) ? Math.max( width, height) / 2 : _bl  ;
            }
            else
            {
                _bl = 0 ;
            }
            
            if ( _corner.br )
            {
                _br = isNaN( _cornerRadius ) ? _bottomRightRadius : _cornerRadius ;
                _br = ( _br  > Math.min (width, height) / 2 ) ? Math.max( width, height) / 2 : _br  ;
            }
            else
            {
                _br = 0 ;
            }
            
            if ( _corner.tl )
            {
                _tl = isNaN( _cornerRadius ) ? _topLeftRadius : _cornerRadius ;
                _tl = ( _tl  > Math.min (width, height) / 2 ) ? Math.max( width, height) / 2 : _tl  ;
            }
            else
            {
                _tl = 0 ;
            }
            
            if ( _corner.tr )
            {
                _tr = isNaN( _cornerRadius ) ? _topRightRadius : _cornerRadius ;
                _tr = ( _tr  > Math.min (width, height) / 2 ) ? Math.max( width, height) / 2 : _tr  ;
            }
            else
            {
                _tr = 0 ;
            }
            
            if( align == Align.BOTTOM ) 
            {
                _drawB() ;
            }
            else if ( align == Align.BOTTOM_LEFT )
            {
                _drawBL() ;
            }
            else if ( align == Align.BOTTOM_RIGHT )
            {
                _drawBR() ;
            }
            else if ( align == Align.LEFT )
            {
                _drawL() ;
            }
            else if ( align == Align.RIGHT )
            {
                _drawR() ;
            }
            else if ( align == Align.TOP )
            {
                _drawT() ;
            }
            else if ( align == Align.TOP_RIGHT )
            {
                _drawTR() ;
            }
            else // Align.TOP_LEFT
            {
                _drawTL() ;
            }
        }
        
        /**
         * @private
         */
        private var _angle:Number ;
        
        
        /**
         * @private
         */
        private var _arrowHeight:Number = 20 ;
        
        /**
         * @private
         */
        private var _arrowMargin:Number = 20 ;
        
        /**
         * @private
         */
        private var _arrowWidth:Number = 10 ;
        
        /**
         * @private
         */
        private var _bl:Number ;
        
        /**
         * @private
         */
        private var _br:Number ;
        
        /**
         * @private
         */
        private const _delta:Number = Math.PI/2 ;
        
        /**
         * @private
         */
        private var _max:Vector2 = new Vector2() ;
        
        /**
         * @private
         */
        private var _min:Vector2 = new Vector2() ;
        
        /**
         * @private
         */
        private var _radius:Number ;
        
        /**
         * @private
         */
        private const _theta:Number = Math.PI/4 ;
        
        /**
         * @private
         */
        private var _tl:Number ;
        
        /**
         * @private
         */
        private var _tr:Number ;
        
        /**
         * @private
         */
        private function _curve( x:Number , y:Number ):void 
        {
            _graphics.curveTo
            ( 
                x + ( Math.cos ( _angle + ( _theta / 2 )) * _radius / Math.cos ( _theta / 2 ) ) ,
                y + ( Math.sin ( _angle + ( _theta / 2 )) * _radius / Math.cos( _theta / 2 ) ) ,
                x + ( Math.cos ( _angle + _theta ) * _radius ) ,
                y + ( Math.sin ( _angle + _theta ) * _radius ) 
            ) ;
            _angle += _theta ;
        }
        
        /**
         * @private
         */
        private function _drawCorner( x:Number , y:Number ):void 
        { 
            _curve(x,y) ;
            _curve(x,y) ;
        }
        
        /**
         * @private
         */
        private function _drawB():void 
        {
            _angle = - Math.PI / 2 ;
            
            _radius = _tl ;
            if ( _radius > 0 )
            {
                _graphics.moveTo( _min.x + _radius, _min.y) ;
            }
            else
            {
                _graphics.moveTo( _min.x + _arrowMargin , _min.y ) ;
            }
            
            // ----- TR
            
            _radius = _tr ;
            if ( _radius > 0 )
            {
                _graphics.lineTo( _max.x - _radius , _min.y) ;
                _drawCorner (_max.x - _radius , _min.y + _radius) ;
            }
            else
            {
                _graphics.lineTo( _max.x , _min.y) ;
                _angle += _delta ;
            }
            
            // ----- BR 
            
            _radius = _br ;
            if ( _radius > 0 )
            {
                _graphics.lineTo ( _max.x , _max.y - _radius ) ;  
                _drawCorner (_max.x - _radius, _max.y - _radius) ;
            }
            else
            {
                _graphics.lineTo( _max.x , _max.y) ;
                _angle += _delta ;
            }
            
            // ----- BL
            
            _graphics.lineTo( _max.x - (width/2) + _arrowWidth , _max.y  ) ;
            _graphics.lineTo(_x,_y) ;
            _graphics.lineTo( _max.x - (width/2) , _max.y ) ;
            
            _radius = _bl ;
            if ( _radius > 0 )
            {
                _graphics.lineTo( _min.x  + _radius , _max.y ) ;
                _drawCorner (_min.x + _radius , _max.y - _radius) ;
            }
            else
            {
                _graphics.lineTo( _min.x , _max.y) ;
                _angle += _delta ;
            }
            
            // ----- TL
            
            _radius = _tl ;
            if ( _radius > 0 )
            {
                _graphics.lineTo(_min.x, _min.y + _radius) ;
                _drawCorner(_min.x + _radius, _min.y + _radius) ;
            }
            else
            {
               _graphics.lineTo( _min.x , _min.y ) ;
               _graphics.lineTo(  _min.x + _radius, _min.y ) ;
            }
        }
        
        /**
         * @private
         */
        private function _drawBL():void 
        {
            _angle = - Math.PI / 2 ;
            
            _graphics.moveTo( _min.x , _min.y ) ;
            
            _radius = _tl ;
            if ( _radius > 0 )
            {
                _graphics.moveTo( _min.x + _radius, _min.y) ;
            }
            else
            {
                _graphics.moveTo( _min.x , _min.y ) ;
            }
            
            // ----- TR
            
            _radius = _tr ;
            if ( _radius > 0 )
            {
                _graphics.lineTo( _max.x - _radius , _min.y) ;
                _drawCorner (_max.x - _radius , _min.y + _radius) ;
            }
            else
            {
                _graphics.lineTo( _max.x , _min.y) ;
                _angle += _delta ;
            }
            
            // ----- BR 
            
            _radius = _br ;
            if ( _radius > 0 )
            {
                _graphics.lineTo( _max.x , _max.y - _radius ) ;
                _drawCorner( _max.x - _radius, _max.y - _radius ) ;
            }
            else
            {
                _graphics.lineTo( _max.x , _max.y ) ;
                _angle += _delta ;
            }
            
            // ----- BL
            
            _radius = _bl ;
            if ( _radius > 0 )
            {
                _graphics.lineTo( _min.x + _radius + _arrowWidth , _max.y  ) ;
                _graphics.lineTo(_x,_y) ;
                _graphics.lineTo( _min.x + _radius  , _max.y ) ;
                _drawCorner (_min.x + _radius  , _max.y - _radius) ;
            }
            else
            {
                _graphics.lineTo( _min.x + _arrowMargin + _arrowWidth , _max.y  ) ;
                _graphics.lineTo( 0 , 0 ) ;
                _graphics.lineTo( _min.x + _arrowMargin   , _max.y  ) ;
                _graphics.lineTo( _min.x , _max.y ) ;
                _angle += _delta ;
            }
            
            // ----- TL
            
            _radius = _tl ;
            if ( _radius > 0 )
            {
                _graphics.lineTo(_min.x, _min.y + _radius) ;
                _drawCorner(_min.x + _radius, _min.y + _radius) ;
            }
            else
            {
               _graphics.lineTo( _min.x , _min.y ) ;
               _graphics.lineTo(  _min.x + _radius, _min.y ) ;
            }
        } 
        
        /**
         * @private
         */
        private function _drawBR():void 
        {
            _angle = - Math.PI / 2 ;
            
            _graphics.moveTo( _min.x , _min.y ) ;
            
            _radius = _tl ;
            if ( _radius > 0 )
            {
                _graphics.moveTo( _min.x + _radius, _min.y) ;
            }
            else
            {
                _graphics.moveTo( _min.x , _min.y ) ;
            }
            
            // ----- TR
            
            _radius = _tr ;
            if ( _radius > 0 )
            {
                _graphics.lineTo( _max.x - _radius , _min.y) ;
                _drawCorner (_max.x - _radius , _min.y + _radius) ;
            }
            else
            {
                _graphics.lineTo( _max.x , _min.y) ;
                _angle += _delta ;
            }
            
            // ----- BR 
            
            _radius = _br ;
            if ( _radius > 0 )
            {
                _graphics.lineTo( _max.x , _max.y - _radius - _arrowHeight ) ;
                _drawCorner (_max.x - _radius  , _max.y - _radius) ;
                _graphics.lineTo(_x,_y) ;
                _graphics.lineTo( _max.x - _radius  - _arrowWidth , _max.y) ;
            }
            else
            {
                _graphics.lineTo( _max.x , _max.y ) ;
                _graphics.lineTo( _max.x - _arrowMargin  , _max.y ) ;
                _graphics.lineTo(_x,_y) ;
                _graphics.lineTo( _max.x - _arrowMargin - _arrowWidth , _max.y  ) ;
                _angle += _delta ;
            }
            
            // ----- BL
            
            _radius = _bl ;
            if ( _radius > 0 )
            {
                _graphics.lineTo( _min.x  + _radius , _max.y ) ;
                _drawCorner (_min.x + _radius , _max.y - _radius) ;
            }
            else
            {
                _graphics.lineTo( _min.x , _max.y) ;
                _angle += _delta ;
            }
            
            // ----- TL
            
            _radius = _tl ;
            if ( _radius > 0 )
            {
                _graphics.lineTo(_min.x, _min.y + _radius) ;
                _drawCorner(_min.x + _radius, _min.y + _radius) ;
            }
            else
            {
               _graphics.lineTo( _min.x , _min.y ) ;
               _graphics.lineTo(  _min.x + _radius, _min.y ) ;
            }
        } 
        
        /**
         * @private
         */
        private function _drawL():void 
        {
            _angle = - Math.PI / 2 ;
            
            _radius = _tl ;
            if ( _radius > 0 )
            {
                _graphics.moveTo( _min.x + _radius, _min.y) ;
            }
            else
            {
                _graphics.moveTo( _min.x + _arrowMargin , _min.y ) ;
            }
            
            // ----- TR
            
            _radius = _tr ;
            if ( _radius > 0 )
            {
                _graphics.lineTo( _max.x - _radius , _min.y) ;
                _drawCorner (_max.x - _radius , _min.y + _radius) ;
            }
            else
            {
                _graphics.lineTo( _max.x , _min.y) ;
                _angle += _delta ;
            }
            
            // ----- BR
            
            _radius = _br ;
            if ( _radius > 0 )
            {
                _graphics.lineTo ( _max.x , _max.y - _radius ) ;  
                _drawCorner (_max.x - _radius, _max.y - _radius) ;
            }
            else
            {
                _graphics.lineTo( _max.x , _max.y) ;
                _angle += _delta ;
            }
            
            // ----- BL
            
            _radius = _bl ;
            if ( _radius > 0 )
            {
                _graphics.lineTo( _min.x  + _radius , _max.y ) ;
                _drawCorner (_min.x + _radius , _max.y - _radius) ;
            }
            else
            {
                _graphics.lineTo( _min.x , _max.y) ;
                _angle += _delta ;
            }
            
            // ----- TL
            
            _graphics.lineTo( _min.x, _max.y - (height/2) + _arrowHeight ) ;
            _graphics.lineTo(_x,_y) ;
            _graphics.lineTo( _min.x, _max.y - (height/2) ) ;
            
            _radius = _tl ;
            if ( _radius > 0 )
            {
                _graphics.lineTo(_min.x, _min.y + _radius) ;
                _drawCorner(_min.x + _radius, _min.y + _radius) ;
            }
            else
            {
               _graphics.lineTo( _min.x , _min.y ) ;
               _graphics.lineTo(  _min.x + _radius, _min.y ) ;
            }
        }
        
        private function _drawR():void 
        {
            _angle = - Math.PI / 2 ;
            
            _radius = _tl ;
            if ( _radius > 0 )
            {
                _graphics.moveTo( _min.x + _radius, _min.y) ;
            }
            else
            {
                _graphics.moveTo( _min.x + _arrowMargin , _min.y ) ;
            }
            
            // ----- TR
            
            _radius = _tr ;
            if ( _radius > 0 )
            {
                _graphics.lineTo( _max.x - _radius , _min.y) ;
                _drawCorner (_max.x - _radius , _min.y + _radius) ;
            }
            else
            {
                _graphics.lineTo( _max.x , _min.y) ;
                _angle += _delta ;
            }
            
            // ----- BR 
            
            _graphics.lineTo( _max.x, _max.y - (height/2) ) ;
            _graphics.lineTo(_x,_y) ;
            _graphics.lineTo( _max.x, _max.y - (height/2) + _arrowHeight ) ;
            
            _radius = _br ;
            if ( _radius > 0 )
            {
                _graphics.lineTo ( _max.x , _max.y - _radius ) ;  
                _drawCorner (_max.x - _radius, _max.y - _radius) ;
            }
            else
            {
                _graphics.lineTo( _max.x , _max.y) ;
                _angle += _delta ;
            }
            
            // ----- BL
            
            _radius = _bl ;
            if ( _radius > 0 )
            {
                _graphics.lineTo( _min.x  + _radius , _max.y ) ;
                _drawCorner (_min.x + _radius , _max.y - _radius) ;
            }
            else
            {
                _graphics.lineTo( _min.x , _max.y) ;
                _angle += _delta ;
            }
            
            // ----- TL
                        
            _radius = _tl ;
            if ( _radius > 0 )
            {
                _graphics.lineTo(_min.x, _min.y + _radius) ;
                _drawCorner(_min.x + _radius, _min.y + _radius) ;
            }
            else
            {
               _graphics.lineTo( _min.x , _min.y ) ;
               _graphics.lineTo(  _min.x + _radius, _min.y ) ;
            }
        }
        
        /**
         * @private
         */
        private function _drawT():void 
        {
            _angle = - Math.PI / 2 ;
            
            _radius = _tl ;
            if ( _radius > 0 )
            {
                _graphics.moveTo( _min.x + _radius, _min.y) ;
            }
            else
            {
                _graphics.moveTo( _min.x + _arrowMargin , _min.y ) ;
            }
            
            // ----- TR
            
            _graphics.lineTo( _max.x - (width/2) , _min.y ) ;            
            _graphics.lineTo(_x,_y) ;
            _graphics.lineTo( _max.x - (width/2) + _arrowWidth , _min.y  ) ;
            
            _radius = _tr ;
            if ( _radius > 0 )
            {
                _graphics.lineTo( _max.x - _radius , _min.y) ;
                _drawCorner (_max.x - _radius , _min.y + _radius) ;
            }
            else
            {
                _graphics.lineTo( _max.x , _min.y) ;
                _angle += _delta ;
            }
            
            // ----- BR 
            
            _radius = _br ;
            if ( _radius > 0 )
            {
                _graphics.lineTo ( _max.x , _max.y - _radius ) ;  
                _drawCorner (_max.x - _radius, _max.y - _radius) ;
            }
            else
            {
                _graphics.lineTo( _max.x , _max.y) ;
                _angle += _delta ;
            }
            
            // ----- BL
            
            _radius = _bl ;
            if ( _radius > 0 )
            {
                _graphics.lineTo( _min.x  + _radius , _max.y ) ;
                _drawCorner (_min.x + _radius , _max.y - _radius) ;
            }
            else
            {
                _graphics.lineTo( _min.x , _max.y) ;
                _angle += _delta ;
            }
            
            // ----- TL
            
            _radius = _tl ;
            if ( _radius > 0 )
            {
                _graphics.lineTo(_min.x, _min.y + _radius) ;
                _drawCorner(_min.x + _radius, _min.y + _radius) ;
            }
            else
            {
               _graphics.lineTo( _min.x , _min.y ) ;
               _graphics.lineTo(  _min.x + _radius, _min.y ) ;
            }
        }        
        
        /**
         * @private
         */
        private function _drawTL():void 
        {
            _angle = - Math.PI / 2 ;
            
            _radius = _tl ;
            if ( _radius > 0 )
            {
                _graphics.moveTo( _min.x + _radius, _min.y) ;
                _graphics.lineTo(_x,_y) ;
                _graphics.lineTo (_min.x + _radius + _arrowWidth, _min.y) ;
            }
            else
            {
                _graphics.moveTo( _min.x + _arrowMargin , _min.y ) ;
                _graphics.lineTo(_x,_y) ;
                _graphics.lineTo (_min.x + _arrowMargin + _arrowWidth, _min.y) ;
            }
            
            // ----- TR
            
            _radius = _tr ;
            if ( _radius > 0 )
            {
                _graphics.lineTo( _max.x - _radius , _min.y) ;
                _drawCorner (_max.x - _radius , _min.y + _radius) ;
            }
            else
            {
                _graphics.lineTo( _max.x , _min.y) ;
                _angle += _delta ;
            }
            
            // ----- BR 
            
            _radius = _br ;
            if ( _radius > 0 )
            {
                _graphics.lineTo ( _max.x , _max.y - _radius ) ;  
                _drawCorner (_max.x - _radius, _max.y - _radius) ;
            }
            else
            {
                _graphics.lineTo( _max.x , _max.y) ;
                _angle += _delta ;
            }
            
            // ----- BL
            
            _radius = _bl ;
            if ( _radius > 0 )
            {
                _graphics.lineTo( _min.x  + _radius , _max.y ) ;
                _drawCorner (_min.x + _radius , _max.y - _radius) ;
            }
            else
            {
                _graphics.lineTo( _min.x , _max.y) ;
                _angle += _delta ;
            }
            
            // ----- TL
            
            _radius = _tl ;
            if ( _radius > 0 )
            {
                _graphics.lineTo(_min.x, _min.y + _radius) ;
                _drawCorner(_min.x + _radius, _min.y + _radius) ;
            }
            else
            {
               _graphics.lineTo( _min.x , _min.y ) ;
               _graphics.lineTo(  _min.x + _radius, _min.y ) ;
            }
        }
        
        /**
         * @private
         */
        private function _drawTR():void 
        {
            _angle = - Math.PI / 2 ;
            
            _graphics.moveTo( _min.x , _min.y) ;
            
            _radius = _tl ;
            if ( _radius > 0 )
            {
                _graphics.moveTo( _min.x + _radius, _min.y) ;
            }
            else
            {
                _graphics.moveTo( _min.x , _min.y ) ;
            }
            
            // ----- TR
            
            _radius = _tr ;
            if ( _radius > 0 )
            {
                _graphics.lineTo( _max.x - _radius - _arrowWidth , _min.y) ;
                _graphics.lineTo(_x,_y) ;
                _graphics.lineTo( _max.x - _radius , _min.y) ;
                _drawCorner (_max.x - _radius , _min.y + _radius) ;
            }
            else
            {
                _graphics.lineTo( _max.x - _arrowMargin - _arrowWidth , _min.y) ;
                _graphics.lineTo(_x,_y) ;
                _graphics.lineTo( _max.x - _arrowMargin , _min.y) ;
                _graphics.lineTo( _max.x , _min.y) ;
                _angle += _delta ;
            }
            
            // ----- BR 
            
            _radius = _br ;
            if ( _radius > 0 )
            {
                _graphics.lineTo( _max.x , _max.y  - _radius ) ;
                _drawCorner (_max.x - _radius , _max.y - _radius ) ;
            }
            else
            {
                _graphics.lineTo( _max.x , _max.y) ;
                _angle += _delta ;
            }
            
            // ----- BL
            
            _radius = _bl ;
            if ( _radius > 0 )
            {
                _graphics.lineTo( _min.x  + _radius , _max.y ) ;
                _drawCorner (_min.x + _radius , _max.y - _radius) ;
            }
            else
            {
                _graphics.lineTo( _min.x , _max.y) ;
                _angle += _delta ;
            }
            
            // ----- TL
            
            _radius = _tl ;
            if ( _radius > 0 )
            {
                _graphics.lineTo(_min.x, _min.y + _radius) ;
                _drawCorner(_min.x + _radius, _min.y + _radius) ;
            }
            else
            {
               _graphics.lineTo( _min.x , _min.y ) ;
               _graphics.lineTo(  _min.x + _radius, _min.y ) ;
            }
        }
    }
}
