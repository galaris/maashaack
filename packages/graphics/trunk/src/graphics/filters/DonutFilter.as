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

package graphics.filters 
{
    import graphics.colors.RGBA;

    import flash.display.Shader;
    import flash.filters.BitmapFilter;

    /**
     * The DonutFilter class applies a pixel transformation over a display or a bitmap and tile it with donut like shapes. 
     * The Shader must be defines with the Donut pixelbender implementation.
     */
    public class DonutFilter extends ShaderCustomFilter 
    {
        /**
         * Creates a new DonutFilter instance.
         * @param shader The Shader reference with the Donut pixel bender filter inside.
         * @param init The optional dynamic object to initialize the filter.
         */
        public function DonutFilter( shader:Shader = null , init:Object = null)
        {
            super( shader || new Shader( new Donut() ) , init ) ;
        }
        
        /**
         * The decimal RGBA color value parameter (ex : 0xFFFF0000 )  
         */
        public function get color():Number
        {
            _color.r = shader.data.color.value[0] ;
            _color.g = shader.data.color.value[1] ;
            _color.b = shader.data.color.value[2] ;
            _color.a = shader.data.color.value[3] ;
            return _color.valueOf() ;
        }
        
        /**
         * @private
         */
        public function set color( value:Number ):void
        {
            _color.fromNumber( value ) ;
            shader.data.count.value[0] = _color.valueOf() ;
        }
        
        /**
         * The number of elements between 0 and 100 (default 5).
         */
        public function get count():Number
        {
            return shader.data.count.value[0] ;
        }
        
        /**
         * @private
         */
        public function set count( value:Number ):void
        {
            shader.data.count.value[0] = value ;
        }
        
        /**
         * The height parameter of the donuts.
         */
        public function get height():Number
        {
            return shader.data.height.value[0] ;
        }
        
        /**
         * @private
         */
        public function set height( value:Number ):void
        {
            shader.data.height.value[0] = value ;
        }
        
        /**
         * The max ratio value between 0 and 1 (default 0.45).
         */
        public function get max():Number
        {
            return shader.data.max.value[0] ;
        }
        
        /**
         * @private
         */
        public function set max( value:Number ):void
        {
            shader.data.max.value[0] = value ;
        }
        
        /**
         * The min ratio value between 0 and 1 (default 0.25).
         */
        public function get min():Number
        {
            return shader.data.min.value[0] ;
        }
        
        /**
         * @private
         */
        public function set min( value:Number ):void
        {
            shader.data.min.value[0] = value ;
        }
        
        /**
         * The width parameter of the donuts.
         */
        public function get width():Number
        {
            return shader.data.width.value[0] ;
        }
        
        /**
         * @private
         */
        public function set width( value:Number ):void
        {
            shader.data.width.value[0] = value ;
        }
        
        /**
         * Returns a shallow copy of the object.
         * @return a shallow copy of the object.
         */
        public override function clone():BitmapFilter
        {
            return new DonutFilter( shader ) ;
        }
        
        /**
         * @private
         */
        private const _color:RGBA = new RGBA() ;
    }
}
