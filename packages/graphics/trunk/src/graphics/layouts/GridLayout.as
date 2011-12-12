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
    import graphics.Align;
    import graphics.Direction;
    import graphics.DirectionOrder;
    import graphics.Measurable;
    import graphics.Orientation;
    
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    
    /**
     * The Grid layout lays out a container's children in a rectangular grid. The container is divided into equal-sized rectangles, and one child is placed in each rectangle.
     */
    public class GridLayout extends BoxLayout
    {
        /**
         * Creates a new GridLayout instance.
         * @param container The container to layout.
         * @param init An object that contains properties with which to populate the newly layout object. If init is not an object, it is ignored.
         */
        public function GridLayout( container:DisplayObjectContainer = null , init:Object = null )
        {
            super( container , init );
        }
        
        /**
         * Determinates the number of columns in the grid layout if the direction of this layout is Direction.HORIZONTAL.
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
            _columns = value > 1 ? value : 1 ;
        }

        /**
         * Determinates the number of lines in the grid layout if the direction of this layout is Direction.VERTICAL.
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
            _lines = value > 1 ? value : 1 ;
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
            
            if ( _children.length > 0 )
            {
                var entry:LayoutEntry ;
                var child:DisplayObject ;
                
                var i:int ;
                
                const hor:Boolean = _direction == Direction.HORIZONTAL ;
                
                var w:Number = 0 ;
                var h:Number = 0 ;
                var c:Number = hor ? _columns : 0 ;
                var l:Number = hor ? 0        : _lines ; 
                
                for each ( entry in _children ) 
                {
                    child = entry.child ;
                    
                    w = Math.max( child[ (child is Measurable) ? "w" : propWidth  ]  , w ) ;
                    h = Math.max( child[ (child is Measurable) ? "h" : propHeight ] , h ) ;
                    
                    if ( hor ) 
                    {
                        if( i%_columns == 0 ) 
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
                    
                    i++ ;
                }
                
                _bounds.width  += c * ( w  + _horizontalGap ) ;
                _bounds.height += l * ( h  + _verticalGap   ) ;
                
                _bounds.width  -= _horizontalGap ;
                _bounds.height -= _verticalGap ;
                
                _bounds.width  += _padding.horizontal ; 
                _bounds.height += _padding.vertical   ;
                
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
            if ( _children.length > 0 )
            {
                if ( ( _lines > 1 && _direction == Direction.VERTICAL) || ( _columns > 1 && _direction == Direction.HORIZONTAL ) )
                {
                    if ( _order == DirectionOrder.REVERSE )
                    {
                        _children.reverse() ;
                    }
                    
                    const left:Number = _padding.left ;
                    const top:Number  = _padding.top ;
                    const hor:Boolean = _direction == Direction.HORIZONTAL ;
                    
                    var child:DisplayObject ;
                    
                    var i:int ;
                    var c:Number ;
                    var l:Number ;
                    
                    var pw:String ;
                    var ph:String ;
                    
                    for each( var entry:LayoutEntry in _children ) 
                    {
                        child = entry.child ;
                        
                        pw = (child is Measurable) ? "w" : propWidth  ;
                        ph = (child is Measurable) ? "h" : propHeight ;
                        
                        c = hor ? ( i%_columns ) : Math.floor( i/_lines ) ;
                        l = hor ? Math.floor( i/_columns ) : ( i%_lines ) ;
                        
                        entry.tx = left + c * ( child[ pw ] + _horizontalGap ) ;
                        entry.ty = top  + l * ( child[ ph ] + _verticalGap   ) ;
                        
                        if ( isRightToLeft() )
                        {
                            entry.tx *= -1 ;
                            entry.tx += _bounds.width - child[pw] ;
                        }
                        
                        if ( isBottomToTop() )
                        {
                            entry.ty *= -1 ;
                            entry.ty += _bounds.height - child[ph] ;
                        }
                        
                        i++ ;
                    }
                    
                    if ( _order == DirectionOrder.REVERSE )
                    {
                        _children.reverse() ;
                    }
                    
                    arrange() ;
                    
                    _renderer.emit( this ) ;
                }
                else
                {
                    super.render() ;
                }
            }
        }
        
        /**
         * @private
         */
        protected var _columns:int = 1 ; 
        
        /**
         * @private
         */
        protected var _lines:int = 1 ;
        
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
