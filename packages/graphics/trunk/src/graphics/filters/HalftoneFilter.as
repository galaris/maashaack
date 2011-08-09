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
     * The HalftoneFilter class applies a halftone filter over a picture.
     * The Shader must be defines with the Halftone pixelbender implementation.
     */
    public class HalftoneFilter extends ShaderCustomFilter 
    {
        /**
         * Creates a new HalftoneFilter instance.
         * @param init The optional dynamic object to initialize the filter.
         * @param shader The Shader reference with the Hole pixel bender filter inside.
         */
        public function HalftoneFilter( init:Object = null , shader:Shader = null )
        {
            super( shader || new Shader( new Halftone() ) , init ) ;
        }
        
        /**
         * The angle value of the halftone filter between 0 and 180 degrees (default 0).
         */
        public function get angle():Number
        {
            return shader.data.angle.value[0] ;
        }
        
        /**
         * @private
         */
        public function set angle( value:Number ):void
        {
            shader.data.angle.value[0] = clamp( isNaN(value) ? 0 : value , 0 , 180 ) ;
        }
        
        /**
         * The pitch value of the halftone filter between 0 and 200 pixels (default 5).
         */
        public function get pitch():Number
        {
            return shader.data.pitch.value[0] ;
        }
        
        /**
         * @private
         */
        public function set pitch( value:Number ):void
        {
            shader.data.pitch.value[0] = clamp( isNaN(value) ? 0 : value , 0 , 200 ) ;
        }
        
        /**
         * Indicates if the filter apply a black or white or color effect (default false).
         */
        public function get useColor():Boolean
        {
            return Boolean(shader.data.useColor.value[0]) ;
        }
        
        /**
         * @private
         */
        public function set useColor( b:Boolean ):void
        {
            shader.data.useColor.value[0] = Number( b ) ;
        }
        
        /**
         * Returns a shallow copy of the object.
         * @return a shallow copy of the object.
         */
        public override function clone():BitmapFilter
        {
            return new HalftoneFilter( null , shader ) ;
        }
    }
}
