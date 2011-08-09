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

package graphics.filters 
{
    import graphics.colors.RGB;

    import flash.display.Shader;
    import flash.filters.BitmapFilter;

    /**
     * The KnockoutFilter class applies a filter by executing a shader on the object being filtered. 
     * The Shader must be defines with the Knockout pixelbender implementation.
     */
    public class KnockoutFilter extends ShaderCustomFilter 
    {
        /**
         * Creates a new KnockoutFilter instance.
         * @param shader The Shader reference with the Knockout pixel bender filter inside.
         * @param init The optional dynamic object to initialize the filter.
         */
        public function KnockoutFilter( shader:Shader = null , init:Object = null )
        {
            super( shader || new Shader( new Knockout() ) , init );
        }
        
        /**
         * The threshold value of the knockout.
         */
        public function get color():Number
        {
            _rgb.r = shader.data.color.value[0] * 0xFF ;
            _rgb.g = shader.data.color.value[1] * 0xFF ;
            _rgb.b = shader.data.color.value[2] * 0xFF ;
            return _rgb.valueOf() ;
        }
        
        /**
         * @private
         */
        public function set color( value:Number ):void
        {
            _rgb.fromNumber( value ) ;
            shader.data.color.value[0] = _rgb.r / 0xFF ;
            shader.data.color.value[1] = _rgb.g / 0xFF ;
            shader.data.color.value[2] = _rgb.b / 0xFF ;
        }
        
        /**
         * The threshold value of the knockout.
         */
        public function get threshold():Number
        {
            return shader.data.threshold.value[0] ;
        }
        
        /**
         * @private
         */
        public function set threshold( value:Number ):void
        {
            shader.data.threshold.value[0] = value ;
        }
        
        /**
         * Returns a shallow copy of the object.
         * @return a shallow copy of the object.
         */
        public override function clone():BitmapFilter
        {
            return new KnockoutFilter( shader ) ;
        }
        
        /**
         * @private
         */
        private var _rgb:RGB = new RGB() ;
    }
}
