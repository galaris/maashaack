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

package graphics.layouts 
{
    import core.maths.replaceNaN;

    import graphics.Align;
    import graphics.Direction;
    import graphics.DirectionOrder;
    import graphics.Orientation;

    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;

    /**
     * The Grid layout lays out a container's children in a rectangular grid. The container is divided into equal-sized rectangles, and one child is placed in each rectangle.
     * 
     */
    public class GridLayout extends BoxLayout
    {
        /**
         * Creates a new GridLayout instance.
         * @param container The container to layout.
         * @param init An object that contains properties with which to populate the newly layout object. If init is not an object, it is ignored.
         * @param auto This boolean indicates if the layout is auto running or not (default false).
         */
        public function GridLayout( container:DisplayObjectContainer = null , init:Object = null , auto:Boolean = false )
        {
            super(container, init, auto);
        }
        
        /**
         * Determinates the number of columns in the grid layout if the direction of this container is Direction.HORIZONTAL.
         * @see graphics.Direction
         */
        public function get columns():uint 
        {
            return _columns ;
        }
        
        /**
         * @private
         */
        public function set columns( value:uint ):void 
        {
            _columns = value ;
        }

        /**
         * Determinates the number of lines in the matrix layout if the direction of this container is Direction.VERTICAL.
         * @see graphics.Direction
         */
        public function get lines():uint 
        {
            return _lines ;
        }
        
        /**
         * @private
         */
        public function set lines( value:uint ):void 
        {
            _lines = value ;
        }
        
        /**
         * The orientation of the layout.
         * @see graphics.Orientation
         */
        public function get orientation():uint
        {
            return _orientation ;
        }
        
        /**
         * @private
         */
        public function set orientation( value:uint ):void
        {
            _orientation = value ;
        }
        
        /**
         * Calculates the default sizes and minimum and maximum values. 
         * If the Box layout's direction property is set to Direction.HORIZONTAL, 
         * its measuredWidth property is equal to the sum of default widths of all of the children in the container, plus the thickness of the borders (padding), plus the left and right padding, plus the horizontal gap between each child. The value of the measuredHeight property is the maximum of all the children's default heights, plus room for the borders and padding. 
         * If the Box layout's direction property is set to Direction.VERTICAL, these two values are reversed.
         */
        public override function measure():void
        {
            _bounds.setEmpty() ;
            if ( _container && _container.numChildren > 0 )
            {
                var d:DisplayObject ;
                var i:int ;
                
                var isHorizontal:Boolean = direction == Direction.HORIZONTAL ;
                
                var children:Vector.<DisplayObject> = new Vector.<DisplayObject>( l ) ;
                
                var length:int = _container.numChildren ;
                
                for ( i = 0 ; i < length ; i++ ) 
                {
                    children[i] = _container.getChildAt(i) ;
                }
                
                if ( _order == DirectionOrder.REVERSE )
                {
                    children.reverse() ;
                }
                
                var w:Number = 0 ;
                var h:Number = 0 ;
                var c:Number = isHorizontal ? _columns : 0 ;
                var l:Number = isHorizontal ? 0        : _lines ; 
                
                for ( i = 0 ; i<length ; i++ ) 
                {
                    d = children[i] ;
                    w = Math.max( d[propWidth]  , w ) ;
                    h = Math.max( d[propHeight] , h ) ;
                    if ( isHorizontal )
                    {
                        if ( i%_columns == 0 )
                        {
                            l++;
                        } 
                    }
                    else
                    {
                        if ( i%_lines == 0 )
                        {
                            c++ ;
                        } 
                    }
                }
                
                _bounds.width  += c * ( w  + _horizontalGap ) ;
                _bounds.height += l * ( h  + _verticalGap   ) ;
                
                _bounds.width  -= _horizontalGap ;
                _bounds.height -= _verticalGap ;
                
                _bounds.width  += replaceNaN( _padding.horizontal ) ; 
                _bounds.height += replaceNaN( _padding.vertical   ) ;
                
                if (_align == Align.CENTER) 
                {
                    _bounds.x -= _bounds.width  / 2 ;
                    _bounds.y -= _bounds.height / 2 ;
                }
                else if ( _align == Align.BOTTOM ) 
                {
                    _bounds.x -= _bounds.width  / 2 ;
                    _bounds.y -= _bounds.height ;
                }
                else if ( _align == Align.BOTTOM_LEFT ) 
                {
                    _bounds.y -= _bounds.height ;
                }
                else if (_align == Align.BOTTOM_RIGHT) 
                {
                    _bounds.x -= _bounds.width  ;
                    _bounds.y -= _bounds.height ;
                }
                else if (_align == Align.LEFT) 
                {
                    _bounds.y -= _bounds.height / 2 ;
                }
                else if (_align ==  Align.RIGHT) 
                {
                    _bounds.x -= _bounds.width  ;
                    _bounds.y -= _bounds.height / 2 ;
                }
                else if (_align == Align.TOP) 
                {
                    _bounds.x -= _bounds.width / 2 ;
                }
                else if (_align == Align.TOP_RIGHT) 
                {
                    _bounds.x -= _bounds.width ;
                }
                else // TOP_LEFT
                {
                    // nothing
                }
            }
        }
        
        /**
         * Render the layout, refresh and change the position of all childs in a specific container.
         */
        public override function render():void
        {
            if ( _container && _container.numChildren > 0 )
            {
                if ( ( _lines > 1 && direction == Direction.VERTICAL) || ( _columns > 1 && direction == Direction.HORIZONTAL ) )
                {
                    var left:Number = replaceNaN(_padding.left) ;
                    var top:Number  = replaceNaN(_padding.top) ;
                    
                    var d:DisplayObject ;
                    var c:Number ;
                    var i:int ;
                    var l:Number ;
                    
                    var len:int = _container.numChildren ;
                    
                    var isHorizontal:Boolean = direction == Direction.HORIZONTAL ;
                    
                    var children:Vector.<DisplayObject> = new Vector.<DisplayObject>( l ) ;
                    
                    for ( i = 0 ; i < len ; i++ ) 
                    {
                        children[i] = _container.getChildAt(i) ;
                    }
                    
                    if ( _order == DirectionOrder.REVERSE )
                    {
                        children.reverse() ;
                    }
                    
                    for ( i = 0 ; i<len ; i++ ) 
                    {
                        d = children[i] ;
                        c = isHorizontal ? ( i%_columns ) : Math.floor( i/_lines ) ;
                        l = isHorizontal ? Math.floor( i/_columns ) : ( i%_lines ) ;
                        d[propX] = left + c * ( d[propWidth]  + _horizontalGap ) ;
                        d[propY] = top  + l * ( d[propHeight] + _verticalGap   ) ;
                        
                        if ( isRightToLeft() )
                        {
                            d[propX] *= -1 ;
                        }
                        if ( isBottomToTop() )
                        {
                            d[propY] *= -1 ;
                        }
                    }
                }
                else
                {
                    super.render() ;
                }
            }
        }
        
        /**
         * This method is invoked when the rendering is finished to finalize the it after the measure invokation.
         */
        public override function update():void
        {
            super.update() ;
            if ( _container && _container.numChildren > 0 )
            {
                var d:DisplayObject ;
                var i:int ;
                var l:int = _container.numChildren ;
                for ( i = 0  ; i < l ; i++ ) 
                {
                    d = _container.getChildAt(i) ;
                    if( d )
                    {
                        if ( isRightToLeft() )
                        {
                            d[propX] += _bounds.width - d[propWidth] ;
                        }
                        if ( isBottomToTop() )
                        {
                            d[propY] += _bounds.height - d[propHeight] ;
                        }
                    }
                }
            }
        }
        
        /**
         * @private
         */
        protected var _columns:int ; 
        
        /**
         * @private
         */
        protected var _lines:int ;
        
        /**
         * @private
         */
        protected var _orientation:uint ;
        
        /**
         * Indicates if the layout orientation is bottom-to-top.
         */
        protected function isBottomToTop():Boolean
        {
            return _orientation == Orientation.BOTTOM_TO_TOP || _orientation == Orientation.LEFT_TO_RIGHT_BOTTOM_TO_TOP || _orientation == Orientation.RIGHT_TO_LEFT_BOTTOM_TO_TOP ;
        }
        
        /**
         * Indicates if the layout orientation is right-to-left.
         */
        protected function isRightToLeft():Boolean
        {
            return _orientation == Orientation.RIGHT_TO_LEFT || _orientation == Orientation.RIGHT_TO_LEFT_BOTTOM_TO_TOP || _orientation == Orientation.RIGHT_TO_LEFT_TOP_TO_BOTTOM ;
        }
    }
}
