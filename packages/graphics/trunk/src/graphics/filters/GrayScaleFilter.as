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
    import flash.display.Shader;
    import flash.filters.BitmapFilter;

    /**
     * The GrayScaleFilter class applies a gray scale color transformation over a display or a bitmap. This filter use the algorithm from ITU-R Recommendation BT.709.
     * The Shader must be defines with the GrayScale pixelbender implementation.
     * @see http://local.wasp.uwa.edu.au/~pbourke/texture_colour/imageprocess/
     */
    public class GrayScaleFilter extends ShaderCustomFilter 
    {
        /**
         * Creates a new GrayScaleFilter instance.
         * @param shader The Shader reference with the GrayScale pixel bender filter inside.
         * @param init The optional dynamic object to initialize the filter.
         */
        public function GrayScaleFilter( shader:Shader = null , init:Object = null)
        {
            super( shader || new Shader( new GrayScale() ) , init ) ;
        }
        
        /**
         * The scale value of the filter between 0 and 1 (default 1).
         */
        public function get scale():Number
        {
            return shader.data.scale.value[0] ;
        }
        
        /**
         * @private
         */
        public function set scale( value:Number ):void
        {
            shader.data.scale.value[0] = value ;
        }
        
        /**
         * Returns a shallow copy of the object.
         * @return a shallow copy of the object.
         */
        public override function clone():BitmapFilter
        {
            return new GrayScaleFilter( shader ) ;
        }
    }
}
