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

package graphics.layouts 
{
    import core.maths.atan2D;
    import core.maths.degreesToRadians;
    import core.maths.radiansToDegrees;

    import graphics.Align;
    import graphics.Measurable;

    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    
    /**
     * This layout display all the childs elements in a specific DisplayObjectContainer with a circle trigonometric algorithm.
     */
    public class CircleLayout extends LayoutContainer 
    {
        /**
         * Creates a new CircleLayout instance.
         * @param container The container to layout.
         * @param init An object that contains properties with which to populate the newly layout object. If init is not an object, it is ignored.
         */
        public function CircleLayout( container:DisplayObjectContainer = null , init:Object = null )
        {
            super( container , init ) ;
        }
        
        /**
         * Indicates the angle value in degrees of the childs in the container.
         */
        public function get childAngle():Number 
        {
            return _childAngle ; 
        }
        
        /**
         * @private
         */
        public function set childAngle( value:Number ):void 
        {
            _childAngle = isNaN(value) ? 0 : value ;
        }
        
        /**
         * Indicates the number of childs visible in this container (minimal value is 1).
         */
        public function get childCount():Number 
        {
            return _childCount ; 
        }
        
        /**
         * @private
         */
        public function set childCount(n:Number):void 
        {
            _childCount = n > 1 ? n : 1 ;
        }
        
        /**
         * Indicates if the childs of the container use a perpendicular tangente direction.
         * Use the childAngle value to change the angle of the perpendicular childs.
         */
        public function get childOrientation():Boolean 
        {
            return _childOrientation ; 
        }
        
        /**
         * @private
         */
        public function set childOrientation( b:Boolean ):void 
        {
            _childOrientation = b ;
        }
        
        /**
         * Indicates the radius of the circle container.
         */
        public function get radius():Number 
        {
            return _radius ;
        }
        
        /**
         * @private
         */
        public function set radius( n:Number ):void 
        {
            _radius = isNaN(n) ? 0 : n ;
        }
        
        /**
         * Indicates the value of the start angle to display all childs in the container (in degrees).
         */
        public function get startAngle():Number 
        {
            return radiansToDegrees(_startAngle) ;
        }
        
        /**
         * @private
         */
        public function set startAngle(n:Number):void 
        {
            _startAngle = degreesToRadians( isNaN(n) ? 0 : n%360 ) ;
        }
        
        /**
         * Calculates the default sizes and minimum and maximum values. 
         * If the Box layout's direction property is set to Direction.HORIZONTAL, 
         * its measuredWidth property is equal to the sum of default widths of all of the children in the container, plus the thickness of the borders (padding), plus the left and right padding, plus the horizontal gap between each child. The value of the measuredHeight property is the maximum of all the children's default heights, plus room for the borders and padding. 
         * If the Box layout's direction property is set to Direction.VERTICAL, these two values are reversed.
         */
        public override function measure():void
        {
            _bounds.width = _bounds.height = 2 * _radius ;
            if ( _align == Align.BOTTOM ) 
            {
                _bounds.x = -_radius ;
                _bounds.y = -2*_radius ;
            }
            else if ( _align == Align.BOTTOM_LEFT ) 
            {
                _bounds.x = 0 ;
                _bounds.y = -2*_radius ;
            }
            else if (_align == Align.BOTTOM_RIGHT) 
            {
                _bounds.x = -2*_radius ;
                _bounds.y = -2*_radius ;
            }
            else if (_align == Align.LEFT) 
            {
                _bounds.x = 0 ;
                _bounds.y = -_radius ;
            }
            else if (_align ==  Align.RIGHT) 
            {
                _bounds.x = -2*_radius ;
                _bounds.y = -_radius ;
            }
            else if (_align == Align.TOP) 
            {
                _bounds.x = -_radius ;
                _bounds.y = 0 ;
            }
            else if( _align == Align.TOP_LEFT )
            {
                _bounds.x = 0 ;
                _bounds.y = 0 ;
            }
            else if (_align == Align.TOP_RIGHT) 
            {
                _bounds.x = -2*_radius ;
                _bounds.y = 0 ;
            }
            else // Align.CENTER
            {
                _bounds.x = -_radius ;
                _bounds.y = -_radius ;
            }
        }
        
        /**
         * Render the layout, refresh and change the position of all childs in a specific container.
         */
        public override function render():void
        {
            if ( _children.length > 0 )
            {
                var i:int ;
                var child:DisplayObject ;
                for each( var entry:LayoutEntry in _children ) 
                {
                    child    = entry.child ;
                    
                    child.x  = _radius * Math.cos( _startAngle - _pi1 + i * _pi2 / _childCount  ) + _bounds.x + _radius ;
                    child.y  = _radius * Math.sin( _startAngle - _pi1 + i * _pi2 / _childCount  )  ;
                    
                    if( _childOrientation )
                    {
                        child.rotation = atan2D( child.y , child.x ) + _childAngle ;
                    }
                    else
                    {
                        child.rotation = 0 ;
                        child.x -= ( (child is Measurable) ? (child as Measurable).w : child.width  ) * .5 ;
                        child.y -= ( (child is Measurable) ? (child as Measurable).h : child.height ) * .5 ;
                    }
                    
                    child.x += _bounds.x + _radius ;
                    child.y += _bounds.y + _radius ;
                    
                    i++ ;
                }
            }
            _renderer.emit(this) ;
        }
        
        /**
         * This method is invoked when the rendering is finished to finalize the it after the measure invokation.
         */
        public override function update():void
        {
            if ( _children.length > 0 )
            {
                
            }
            _updater.emit(this);
            notifyFinished() ;
        }
        
        /**
         * @private
         */
        protected var _childAngle:Number = 0 ;
        
        /**
         * @private
         */
        protected var _childCount:Number = 10 ;
        
        /**
         * @private
         */
        protected var _childOrientation:Boolean ;
        
        /**
         * @private
         */
        protected var _radius:Number = 100 ;
        
        /**
         * @private
         */
        protected var _startAngle:Number = 0 ;
         
        /**
         * @private
         */
        private const _pi1:Number =  Math.PI / 2 ;
        
        /**
         * @private
         */
        private const _pi2:Number = 2 * Math.PI ;
    }
}
