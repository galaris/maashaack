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
  Portions created by the Initial Developers are Copyright (C) 2006-2010
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
    import graphics.Direction;

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
         * Calculates the default sizes and minimum and maximum values. 
         * If the Box layout's direction property is set to Direction.HORIZONTAL, 
         * its measuredWidth property is equal to the sum of default widths of all of the children in the container, plus the thickness of the borders (padding), plus the left and right padding, plus the horizontal gap between each child. The value of the measuredHeight property is the maximum of all the children's default heights, plus room for the borders and padding. 
         * If the Box layout's direction property is set to Direction.VERTICAL, these two values are reversed.
         */
        public override function measure():void
        {
            _bounds.setEmpty() ;
            // TODO
        }
        
        /**
         * Render the layout, refresh and change the position of all childs in a specific container.
         */
        public override function render():void
        {
            if ( ( _lines > 1 && direction == Direction.VERTICAL) || ( _columns > 1 && direction == Direction.HORIZONTAL ) )
            {
                if ( _container && _container.numChildren > 0 )
                {
                    // TODO
                }
            }
            else
            {
                super.render() ;
            }
        }
        
        /**
         * This method is invoked when the rendering is finished to finalize the it after the measure invokation.
         */
        public override function update():void
        {
            if ( ( _lines > 1 && direction == Direction.VERTICAL) || ( _columns > 1 && direction == Direction.HORIZONTAL ) )
            {
                if ( _container && _container.numChildren > 0 )
                {
                    // TODO
                }
            }
            else
            {
                super.update() ;
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
    }
}
