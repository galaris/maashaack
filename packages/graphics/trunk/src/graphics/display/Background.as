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

package graphics.display 
{
    import core.maths.clamp;
    import core.maths.degreesToRadians;

    import graphics.Align;
    import graphics.Direction;
    import graphics.Directionable;
    import graphics.Drawable;
    import graphics.FillGradientStyle;
    import graphics.IFillStyle;
    import graphics.ILineStyle;
    import graphics.Measurable;
    import graphics.drawing.DashRectanglePen;
    import graphics.drawing.RectanglePen;
    import graphics.drawing.RoundedComplexRectanglePen;
    import graphics.layouts.Layout;

    import system.hack;

    import flash.display.DisplayObjectContainer;
    import flash.events.Event;
    import flash.geom.Matrix;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    
    /**
     * This display is used to create a background in your application or in an other display of the application.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import flash.display.GradientType ;
     * import flash.display.StageAlign ;
     * import flash.display.StageScaleMode ;
     * 
     * import graphics.Direction ;
     * import graphics.FillStyle ;
     * import graphics.FillGradientStyle ;
     * import graphics.LineStyle ;
     * 
     * import graphics.display.Background ;
     * 
     * stage.align     = StageAlign.TOP_LEFT ;
     * stage.scaleMode = StageScaleMode.NO_SCALE ;
     * 
     * var area:Background = new Background() ;
     * 
     * area.lock() ; // lock the update method
     * 
     * area.fill = new FillStyle( 0xD97BD0  ) ;
     * area.line = new LineStyle( 2, 0xFFFFFF ) ;
     * 
     * area.w    = 400 ;
     * area.h    = 300 ;
     * 
     * area.unlock() ; // unlock the update method
     * 
     * area.update() ; // force update
     * 
     * addChild( area ) ;
     * 
     * /////////////////////////////////
     * 
     * function keyDown( e:KeyboardEvent ):void
     * {
     *     var code:uint = e.keyCode ;
     *     switch( code )
     *     {
     *         case Keyboard.SPACE :
     *         {
     *             if( area.fullscreen )
     *             {
     *                 area.autoSize   = false ;
     *                 area.fill       = new FillStyle( 0xD97BD0 ) ;
     *                 area.fullscreen = false ;
     *             }
     *             else
     *             {
     *                 area.autoSize         = true ;
     *                 area.gradientRotation = 90 ;
     *                 area.useGradientBox   = true ;
     *                 area.fill             = new FillGradientStyle( GradientType.LINEAR, [0x071E2C,0x81C2ED], [1,1], [0,255] ) ;
     *                 area.fullscreen       = true ;
     *                 area.direction        = null ;
     *             }
     *             break ;
     *         }
     *         case Keyboard.UP :
     *         {
     *             area.autoSize   = true ;
     *             area.fill       = new FillStyle( 0x000000 ) ;
     *             area.fullscreen = true ;
     *             area.direction  = Direction.HORIZONTAL ;
     *             break ;
     *         }
     *         case Keyboard.DOWN :
     *         {
     *             area.autoSize   = true ;
     *             area.fill       = new FillStyle( 0xFFFFFF ) ;
     *             area.fullscreen = true ;
     *             area.direction  = Direction.VERTICAL ;
     *             break ;
     *         }
     *     }
     * }
     * 
     * stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
     * </pre>
     */
    public class Background extends MOB implements Directionable, Drawable, Measurable
    {
        use namespace hack ;
        
        /**
         * Creates a new Background instance.
         * @param init An object that contains properties with which to populate the newly instance. If init is not an object, it is ignored.
         */
        public function Background( init:Object = null )
        {
            ///////////
            
            addEventListener( Event.ADDED_TO_STAGE      , addedToStageResize     , false , 9999 ) ;
            addEventListener( Event.REMOVED_FROM_STAGE  , removedFromStageResize , false , 9999 ) ;
            
            ///////////
            
            if( !_scope )
            {
                _scope = this ;
            }
            
            ///////////
            
            initializePen() ;
            
            ///////////
            
            initialize( init ) ;
            
            ///////////
        }
        
        /**
         * Defines the "dashed" mode of the background border.
         */
        public static const DASHED:String = "dashed" ;
        
        /**
         * Defines the "normal" mode of the background border.
         */
        public static const NORMAL:String = "normal" ;
        
        /**
         * Defines the "rouded" mode of the background border.
         */
        public static const ROUNDED:String = "rounded" ;
        
        /**
         * The alignement of the background.
         * @see graphics.Align
         */
        public function get align():uint
        {
            return _align ;
        }
        
        /**
         * @private
         */
        public function set align( value:uint ):void
        {
            _align = value ;
            update() ;
        }
        
        /**
         * Indicates if the background is resizing when the stage resize event is invoked.
         */
        public function get autoSize():Boolean
        {
            return _autoSize ;
        }
        
        /**
         * @private
         */
        public function set autoSize( b:Boolean ):void
        {
            if( _autoSize == b )
            {
                return ;
            }
            _autoSize = b ;
            if ( stage != null )
            {
                if ( _autoSize )
                {
                    stage.addEventListener( Event.RESIZE , resize ) ;
                    resize() ;
                } 
                else
                {
                    stage.removeEventListener( Event.RESIZE , resize ) ;
                }
            }
        }
        
        /**
         * The border mode of the background : rounded, dashed, normal
         */
        public function get borderMode():String
        {
            return _borderMode ;
        }
        
        /**
         * The border mode of the background : "rounded", "dashed", "normal" (default).
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.display.Background ;
         * 
         * var background:Background = new Background() ;
         * 
         * background.x = 20 ;
         * background.y = 20 ;
         * 
         * background.setSize(500,400) ;
         * 
         * background.borderMode = Background.NORMAL ;
         * 
         * background.borderMode = Background.DASHED ;
         * background.dashLength  = 8 ;
         * background.dashSpacing = 6 ;
         * 
         * background.borderMode = Background.ROUNDED ;
         * background.bottomLeftRadius  = 12 ;
         * background.bottomRightRadius = 12 ;
         * background.topLeftRadius     = 12 ;
         * background.topLeftRadius     = 12 ;
         * background.topRightRadius    = 12 ;
         * background.cornerRadius      = 8  ;
         * </pre>
         */
        public function set borderMode( value:String ):void
        {
            _borderMode = ( _borderModes.indexOf( value ) > -1 ) ? value : ROUNDED ;
            initializePen() ;
            update() ;
        }
        
        /**
         * The radius of the bottom-left corner, in pixels.
         */
        public function get bottomLeftRadius():Number
        {
            return _bottomLeftRadius ;
        }
        
        /**
         * @private
         */
        public function set bottomLeftRadius( value:Number ):void
        {
            _bottomLeftRadius = value > 0 ? value : 0 ;
            update() ;
        }
        
        /**
         * The radius of the bottom-right corner, in pixels.
         */
        public function get bottomRightRadius():Number
        {
            return _bottomRightRadius ;
        }
        
        /**
         * @private
         */
        public function set bottomRightRadius( value:Number ):void
        {
            _bottomRightRadius = value > 0 ? value : 0 ;
            update() ;
        }
        
        /**
         * Defines all corner radius of the background (upper-left, upper-right, bottom-left and bottom-right). 
         */
        public function set cornerRadius( value:Number ):void
        {
            _bottomLeftRadius  = 
            _bottomRightRadius = 
            _topLeftRadius     = 
            _topRightRadius    = value > 0 ? value : 0 ;
            update() ;
        }
        
        /**
         * Determinates the length of a dash in the line. 
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * background.borderMode  = Background.DASHED ;
         * background.dashLength  = 6 ;
         * background.dashSpacing = 6 ;   
         * </pre>
         */
        public function get dashLength():Number 
        {
            return _dashLength ;
        }
        
        /**
         * @private
         */
        public function set dashLength( value:Number):void 
        {
            _dashLength = value > 0 ? value : 0 ;
            update() ;
        }
        
        /**
         * Determinates the spacing value between two dashs in this line. 
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * background.borderMode  = Background.DASHED ;
         * background.dashLength  = 6 ;
         * background.dashSpacing = 6 ;   
         * </pre>
         */
        public function get dashSpacing():Number 
        {
            return _dashSpacing ;
        }
        
        /**
         * @private
         */
        public function set dashSpacing( value:Number ):void 
        {
            _dashSpacing = value > 0 ? value : 0 ;
            update() ;
        }
        
        /**
         * Indicates the direction value of the background when the display is in this "full" mode (default value is null).
         * @see graphics.Direction
         */
        public function get direction():String
        {
            return _direction ;
        }
        
        /**
         * @private
         */
        public function set direction( value:String ):void
        {
            _direction = (value == Direction.VERTICAL || value == Direction.HORIZONTAL ) ? value : null ;
            update() ;
        }
        
        /**
         * Indicates the enabled state of the object.
         */
        public function get enabled():Boolean 
        {
            return _enabled ;
        }
        
        /**
         * @private
         */
        public function set enabled( value:Boolean ):void 
        {
            _enabled = value ;
            if ( _locked > 0 ) 
            {
                return ;
            }
            viewEnabled() ;
        }
        
        /**
         * Determinates the IFillStyle reference of this display.
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
            _fillStyle = style ;
            if( _pen )
            {
                _pen.fill = _fillStyle ;
            }
            update() ;
        }
        
        /**
         * Indicates if the canvas is in the fullscreen mode (use Stage.stageWidth and Stage.stageHeight to resize).
         */
        public function get fullscreen():Boolean
        {
            return _fullscreen ;
        }
        
        /**
         * @private
         */
        public function set fullscreen( b:Boolean ):void
        {
            _fullscreen = b ;
            update() ;
        }
        
        /**
         * The matrix value to draw the gradient fill. This property override the gradientRotation and gradientTranslation properties.
         */
        public var gradientMatrix:Matrix ;
        
        /**
         * The rotation value to draw the gradient fill.
         */
        public var gradientRotation:Number = 0 ;
        
        /**
         * The translation vector to draw the gradient fill.
         */
        public var gradientTranslation:Point ;
        
        /**
         * Determinates the virtual height value of this component.
         */
        public function get h():Number 
        {
            var value:Number = ( _fullscreen && (stage != null) && (_direction != Direction.HORIZONTAL) ) ? stage.stageHeight : _h ;
            return clamp( value , _minHeight, _maxHeight) ;
        }
        
        /**
         * @private
         */
        public function set h( value:Number ):void 
        {
            _h = clamp( value , _minHeight, _maxHeight ) ;
            update() ;
            notifyResized() ;
        }
        
        /**
         * Determinates the layout of this container.
         */
        public function get layout():Layout
        {
            return _layout ;
        }
        
        /**
         * @private
         */
        public function set layout( layout:Layout ):void
        {
            if ( _layout )
            {
                _layout.unlock() ;
                _layout.renderer.disconnect( renderLayout ) ;
                _layout.updater.disconnect( updateLayout ) ;
            }
            _layout = layout ;
            if ( _layout )
            {
                _layout.renderer.connect( renderLayout ) ;
                _layout.updater.connect( updateLayout ) ;
                _layout.container = _scope ;
                if ( isLocked() )
                {
                    _layout.lock() ;
                }
                else
                {
                    _layout.unlock() ;
                }
            }
            update() ;
        }
        
        /**
         * Determinates the <code class="prettyprint">ILineStyle</code> reference of this display.
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
            _lineStyle = style ;
            if( _pen )
            {
                _pen.line = style ;
            }
            update() ;
        }
        
        /**
         * This property defined the maximum height of this display.
         */
        public function get maxHeight():Number
        {
            return _maxHeight ;
        }
        
        /**
         * @private
         */
        public function set maxHeight( value:Number ):void
        {
            _maxHeight = value ;
            if ( _maxHeight < _minHeight )
            {
                _maxHeight = _minHeight ;
            }
            update() ;
        }
        
        /**
         * Defines the maximum width of this display.
         */
        public function get maxWidth():Number
        {
            return _maxWidth ;
        }
        
        /**
         * @private
         */
        public function set maxWidth( value:Number ):void
        {
            _maxWidth = value ;
            if ( _maxWidth < _minWidth )
            {
                _maxWidth = _minWidth ;
            }
            update() ;
        }
        
        /**
         * This property defined the mimimun height of this display (This value is >= 0).
         */
        public function get minHeight():Number
        {
            return _minHeight ;
        }
        
        /**
         * @private
         */
        public function set minHeight( value:Number ):void
        {
            _minHeight = value > 0 ? value : 0 ;
            if ( _minHeight > _maxHeight )
            {
                _minHeight = _maxHeight ;
            }
            update() ;
        }
        
        /**
         * This property defined the mimimun width of this display (This value is >= 0).
         */
        public function get minWidth():Number
        {
            return _minWidth ;
        }
        
        /**
         * @private
         */
        public function set minWidth( value:Number ):void
        {
            _minWidth = value > 0 ? value : 0 ;
            if ( _minWidth > _maxWidth )
            {
                _minWidth = _maxWidth ;
            }
            update() ;
        }
        
        /**
         * The internal RectanglePen reference of this background display to draw inside.
         */
        public function get pen():RectanglePen
        {
            return _pen ;
        }
        
        /**
         * @private
         */
        public function set pen( pen:RectanglePen ):void
        {
            initializePen( pen ) ;
        }
        
        /**
         * Returns the real scope reference of this component.
         * @return the real scope reference of this component.
         */
        public function get scope():DisplayObjectContainer
        {
            return _scope ;
        }
        
        /**
         * The radius of the upper-left corner, in pixels.
         */
        public function get topLeftRadius():Number
        {
            return _topLeftRadius ;
        }
        
        /**
         * @private
         */
        public function set topLeftRadius( value:Number ):void
        {
            _topLeftRadius = value > 0 ? value : 0 ;
            update() ;
        }
        
        /**
         * The radius of the upper-right corner, in pixels. 
         */
        public function get topRightRadius():Number
        {
            return _topRightRadius ;
        }
        
        /**
         * @private
         */
        public function set topRightRadius( value:Number ):void
        {
            _topRightRadius = value > 0 ? value : 0 ;
            update() ;
        }
        
        /**
         * Indicates if the IFillStyle of this display use gradient box matrix (only if the IFillStyle is a FillGradientStyle).
         */
        public var useGradientBox:Boolean ;
        
        /**
         * Determinates the virtual height value of this component.
         */
        public function get w():Number 
        {
            var value:Number = ( _fullscreen && (stage != null) && (_direction != Direction.VERTICAL) ) ? stage.stageWidth : _w ;
            return clamp( value , _minWidth, _maxWidth ) ;
        }
        
        /**
         * @private
         */
        public function set w( value:Number ):void 
        {
            _w = clamp( value , _minWidth, _maxWidth ) ;
            update() ;
            notifyResized() ;
        }
        
        /**
         * Draw the display.
         * @param arguments The optional arguments to draw the background. With the signature : ( w:Number , h:Number, offsetX:Number, offsetY:Number )
         */
        public function draw( ...args:Array ):void
        {
            // align
            
            fixArea() ;
            
            // gradient
            
            if ( _fillStyle is FillGradientStyle )
            {
                var matrix:Matrix ;
                
                if( gradientMatrix )
                {
                    matrix = gradientMatrix ;
                }
                else
                {
                    matrix = new Matrix() ;
                    if( useGradientBox )
                    {
                        matrix.createGradientBox( _real.width, _real.height );
                    }
                    if ( !isNaN(gradientRotation) )
                    {
                        matrix.rotate( degreesToRadians( gradientRotation ) ) ;
                    }
                    if ( gradientTranslation != null )
                    {
                        matrix.translate( gradientTranslation.x , gradientTranslation.y ) ;
                    }
                }
                
                ( _fillStyle as FillGradientStyle ).matrix = matrix ;
            }
            
            // draw
            
            if( _pen )
            {
                if( _pen is RoundedComplexRectanglePen )
                {
                    _pen._topLeftRadius     = _topLeftRadius ;
                    _pen._topRightRadius    = _topRightRadius ;
                    _pen._bottomLeftRadius  = _bottomLeftRadius ;
                    _pen._bottomRightRadius = _topLeftRadius ;
                }
                else if( _pen is DashRectanglePen )
                {
                    _pen.length  = _dashLength  ;
                    _pen.spacing = _dashSpacing ;
                }
                _pen.draw( _real.x , _real.y , _real.width , _real.height ) ;
            }
        }
        
        /**
         * Initialize the canvas.
         * @param init An object that contains properties with which to populate the newly instance. If init is not an object, it is ignored.
         */
        public function initialize( init:Object = null ):void 
        {
            if( init )
            {
                lock() ;
                for( var prop:String in init )
                {
                    this[prop] = init[prop] ;
                }
                unlock() ;
            }
            update() ;
        }
        
        /**
         * Locks the object.
         */
        public override function lock():void 
        {
            super.lock() ;
            if ( _layout )
            {
                _layout.lock() ;
            }
        }
        
        /**
         * Moves the canvas object..
         * @param x The x position of the component.
         * @param y The y position of the component.
         */
        public function move( x:Number=NaN , y:Number=NaN ):void
        {
            if ( !isNaN(x) )
            {
                this.x = x ;
            }
            if ( !isNaN(y) )
            {
                this.y = y ;
            }
        }
        
        /**
         * Notify an event when you resize the component.
         */
        public function notifyResized():void 
        {
            viewResize() ;
            dispatchEvent( new Event( Event.RESIZE ) ) ;
        }
        
        /**
         * Registers the view of this component. The scope view can be the current DisplayObjectContainer or a child inside it.
         */
        public function registerView( scope:DisplayObjectContainer = null ):DisplayObjectContainer
        {
            _scope = ( scope == null || scope == this ) ? this : scope ;
            if ( _layout )
            {
                _layout.container = _scope ;
            }
            return _scope ;
        }
        
        /**
         * Resize and update the background.
         */
        public function resize( e:Event = null ):void
        {
            update() ;
        }
        
        /**
         * Sets the virtual width (w) and height (h) values of the component.
         */
        public function setSize( w:Number, h:Number ):void
        {
            _w = isNaN(w) ? 0 : clamp( w , _minWidth, _maxWidth) ; 
            _h = isNaN(h) ? 0 : clamp( h , _minHeight, _maxHeight) ; 
            update() ;
            notifyResized() ;
        }
        
        /**
         * Unlocks the display.
         */
        public override function unlock():void 
        {
            super.unlock() ;
            if ( _layout )
            {
                _layout.unlock() ;
            }
        }
        
        
        /**
         * Update the display.
         */
        public override function update():void 
        {
            if ( isLocked() ) 
            {
                return ;
            }
            if ( _layout )
            {
                _layout.run() ;
            }
            draw() ;
            viewChanged() ;
            _changed = false ;
        }
        
        /**
         * Unregisters the view of this component.
         */
        public function unregisterView():void
        {
            _scope = this ;
            if ( _layout )
            {
                _layout.container = this ;
            }
        }
        
        //////////
        
        /**
         * Invoked in the constructor to initialize the RectanglePen reference in the background. 
         * Overrides this method to change the pen strategy.
         */
        protected function initializePen( pen:RectanglePen = null ):RectanglePen
        {
            if( pen )
            {
                _pen = pen ;
            }
            else
            {
                if( _borderMode == ROUNDED )
                {
                    _pen = new RoundedComplexRectanglePen( this ) ;
                }
                else if( _borderMode == DASHED )
                {
                    _pen = new DashRectanglePen( this ) ;
                }
                else 
                {
                    _pen = new RectanglePen( this ) ;
                }
            }
            
            _pen.fill = _fillStyle ;
            _pen.line = _lineStyle ;
            
            return _pen ;
        }
        
        //////////
        
        /**
         * This method is invoked after the draw() method in the update() method.
         * Overrides this method.
         */
        protected function viewChanged():void
        {
            // overrides
        }
        
        /**
         * Invoked when the enabled property of the component change.
         * Overrides this method.
         */
        protected function viewEnabled():void 
        {
            // overrides
        }
        
        /**
         * Invoked when the component is resized.
         * Overrides this method.
         */
        protected function viewResize():void 
        {
            // overrides
        }
        
        ////////// layout receivers
        
        /**
         * Receives a message when the layout emit when is rendered.
         */
        protected function renderLayout( layout:Layout = null ):void
        {
            //
        }
        
        /**
         * Receives a message when the layout emit when is updated.
         */
        protected function updateLayout( layout:Layout = null ):void
        {
            //
        }
        
        //////////
        
        /**
         * Invoked when the display is removed from the stage to enable the autoSize mode.
         */
        protected function addedToStageResize( e:Event = null ):void
        {
            if ( stage && _autoSize )
            {
                stage.addEventListener( Event.RESIZE , resize ) ;
                resize() ;
            }
        }
         
        /**
         * Invoked when the display is removed from the stage to disable the autoSize mode.
         */
        protected function removedFromStageResize( e:Event = null ):void
        {
            if ( stage && _autoSize )
            {
                stage.removeEventListener( Event.RESIZE , resize ) ;
            }
        }
        
        //////////
        
        /**
         * @private
         */
        hack var _align:uint = 10 ;
        
        /**
         * @private
         */
        hack var _autoSize:Boolean ;
        
        /**
         * @private
         */
        hack var _borderMode:String = NORMAL ;
        
        /**
         * @private
         */
        hack const _borderModes:Vector.<String> = Vector.<String>([ DASHED , NORMAL , ROUNDED ]) ;
        
        /**
         * @private
         */
        hack var _bottomLeftRadius:Number = 0 ;
        
        /**
         * @private
         */
        hack var _bottomRightRadius:Number = 0 ;
        
        /**
         * @private
         */
        hack var _dashLength:Number = 4 ;
        
        /**
         * @private
         */
        hack var _dashSpacing:Number = 4 ;
        
        /**
         * @private
         */
        hack var _direction:String ;
        
        /**
         * @private
         */
        hack var _enabled:Boolean = true ;
        
        /**
         * @private
         */
        hack var _fillStyle:IFillStyle ;
        
        /**
         * @private
         */
        hack var _h:Number = 0 ;
        
        /**
         * @private
         */
        hack var _fullscreen:Boolean ;
        
        /**
         * @private
         */
        hack var _layout:Layout ;
        
        /**
         * @private
         */
        hack var _lineStyle:ILineStyle ;
        
        /**
         * @private
         */
        hack var _maxHeight:Number ;
        
        /**
         * @private
         */
        hack var _maxWidth:Number ;
        
        /**
         * @private
         */
        hack var _minHeight:Number = 0 ;
        
        /**
         * @private
         */
        hack var _minWidth:Number = 0 ;
        
        /**
         * @private
         */
        hack var _pen:RectanglePen ;
        
        /**
         * @private
         */
        hack const _real:Rectangle = new Rectangle();
        
        /**
         * The scope of the active display list of this container.
         * @private
         */
        hack var _scope:DisplayObjectContainer ;
        
        /**
         * @private
         */
        hack var _topLeftRadius:Number = 0 ;
        
        /**
         * @private
         */
        hack var _topRightRadius:Number = 0 ;
        
        /**
         * @private
         */
        hack var _w:Number = 0 ;
        
        /**
         * Refresh the real area Rectangle of the background with the current alignement.
         */
        hack function fixArea():void
        {
            // initialize
            
            _real.width  = w ;
            _real.height = h ;
            _real.x      = 0 ;
            _real.y      = 0 ;
            
            // update
            
            if( align == Align.BOTTOM ) 
            {
                _real.x -= _real.width / 2 ;
                _real.y -= _real.height ;
            }
            else if ( align == Align.BOTTOM_LEFT )
            {
                _real.y -= _real.height ;
            }
            else if ( align == Align.BOTTOM_RIGHT )
            {
                _real.x -= _real.width ;
                _real.y -= _real.height ;
            }
            else if ( align == Align.CENTER )
            {
                _real.x -= _real.width / 2 ;
                _real.y -= _real.height / 2 ;
            }
            else if ( align == Align.LEFT )
            {
                _real.y -= _real.height / 2 ;
            }
            else if ( align == Align.RIGHT )
            {
                _real.x -= _real.width ;
                _real.y -= _real.height / 2 ;
            }
            else if ( align == Align.TOP )
            {
                _real.x -= _real.width / 2 ;
            }
            else if ( align == Align.TOP_RIGHT )
            {
                _real.x -= _real.width ;
            }
        }
    }
}