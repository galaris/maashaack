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
    import core.maths.clamp;

    import flash.display.Shader;
    import flash.filters.BitmapFilter;

    /**
     * The RoundPixelFilter class applies a filter by executing a shader on the object being filtered. 
     * The Shader must be defines with the RoundPixel pixelbender implementation.
     */
    public class RoundPixelFilter extends ShaderCustomFilter
    {
        /**
         * Creates a new RoundPixelFilter instance.
         * @param shader The Shader reference with the RoundPixel pixel bender filter inside.
         * @param init The optional dynamic object to initialize the filter.
         */
        public function RoundPixelFilter( shader:Shader = null , init:Object = null )
        {
            super( shader || new Shader( new RoundPixel() ) , init ) ;
        }
        
        /**
         * Indicates the edge alpha level of the rounded pixels (between 0 and 300).
         */
        public function get edge():Number
        {
            return shader.data.edge.value[0] ;
        }
        
        /**
         * @private
         */
        public function set edge( value:Number ):void
        {
            shader.data.edge.value[0] = clamp( isNaN(value) ? 0 : value , 0 , 300);
        }
        
        /**
         * The space between the centers of the circles (between 1 and 300).
         */
        public function get space():Number
        {
            return shader.data.space.value[0] ;
        }
        
        /**
         * @private
         */
        public function set space( value:Number ):void
        {
            shader.data.space.value[0] = clamp( isNaN( value ) ? 0 : value , 1 , 300) ;
        }
        
        /**
         * The size ratio of the circle pixels (between 0 and 2).
         */
        public function get size():Number
        {
            return shader.data.size.value[0] ;
        }
        
        /**
         * @private
         */
        public function set size( value:Number ):void
        {
            shader.data.size.value[0] = clamp( isNaN(value) ? 0 : value , 0 , 2) ;
        }
        
        /**
         * Returns a shallow copy of the object.
         * @return a shallow copy of the object.
         */
        public override function clone():BitmapFilter
        {
            return new RoundPixelFilter( shader ) ;
        }
    }
}
