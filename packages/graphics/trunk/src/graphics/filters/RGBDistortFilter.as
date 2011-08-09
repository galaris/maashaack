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
     * The RGBDistortFilter class applies a filter by executing a shader on the object being filtered. 
     * The Shader must be defines with the RGBDistort pixelbender implementation.
     */
    public class RGBDistortFilter extends ShaderCustomFilter
    {
        /**
         * Creates a new RGBDistorFilter instance.
         * @param shader The Shader reference with the RGBDistort pixel bender filter inside.
         * @param init The optional dynamic object to initialize the filter.
         */
        public function RGBDistortFilter( shader:Shader = null , init:Object = null )
        {
            super( shader || new Shader( new RGBDistort() ) , init ) ;
        }
        
        /**
         * Indicates the direction level of the blue component (between -1 and 1).
         */
        public function get blueDirection():Number
        {
            return shader.data.direction.value[2] ;
        }
        
        /**
         * @private
         */
        public function set blueDirection( value:Number ):void
        {
            shader.data.direction.value[2] = clamp( isNaN(value) ? 0 : value , -1 , 1 );
        }
        
        /**
         * Indicates the frequency level of the blue component (between 0 and 1).
         */
        public function get blueFrequency():Number
        {
            return shader.data.frequency.value[2] ;
        }
        
        /**
         * @private
         */
        public function set blueFrequency( value:Number ):void
        {
            shader.data.frequency.value[2] = clamp( isNaN(value) ? 0 : value , 0 , 1 );
        }
        
        /**
         * Indicates the intensity level of the blue component (between 0 and 1).
         */
        public function get blueIntensity():Number
        {
            return shader.data.intensity.value[2] ;
        }
        
        /**
         * @private
         */
        public function set blueIntensity( value:Number ):void
        {
            shader.data.intensity.value[2] = clamp( isNaN(value) ? 0 : value , 0 , 1 );
        }
        
        /**
         * Indicates the direction level of the green component (between -1 and 1).
         */
        public function get greenDirection():Number
        {
            return shader.data.direction.value[1] ;
        }
        
        /**
         * @private
         */
        public function set greenDirection( value:Number ):void
        {
            shader.data.direction.value[1] = clamp( isNaN(value) ? 0 : value , -1 , 1 );
        }
        
        /**
         * Indicates the frequency level of the green component (between 0 and 1).
         */
        public function get greenFrequency():Number
        {
            return shader.data.frequency.value[1] ;
        }
        
        /**
         * @private
         */
        public function set greenFrequency( value:Number ):void
        {
            shader.data.frequency.value[1] = clamp( isNaN(value) ? 0 : value , 0 , 1 );
        }
        
        /**
         * Indicates the intensity level of the green component (between 0 and 1).
         */
        public function get greenIntensity():Number
        {
            return shader.data.intensity.value[1] ;
        }
        
        /**
         * @private
         */
        public function set greenIntensity( value:Number ):void
        {
            shader.data.intensity.value[1] = clamp( isNaN(value) ? 0 : value , 0 , 1 );
        }
        
        /**
         * Indicates the direction level of the red component (between -1 and 1).
         */
        public function get redDirection():Number
        {
            return shader.data.direction.value[1] ;
        }
        
        /**
         * @private
         */
        public function set redDirection( value:Number ):void
        {
            shader.data.direction.value[0] = clamp( isNaN(value) ? 0 : value , -1 , 1 );
        }
        
        /**
         * Indicates the frequency level of the red component (between 0 and 1).
         */
        public function get redFrequency():Number
        {
            return shader.data.frequency.value[0] ;
        }
        
        /**
         * @private
         */
        public function set redFrequency( value:Number ):void
        {
            shader.data.frequency.value[0] = clamp( isNaN(value) ? 0 : value , 0 , 1 );
        }
        
        /**
         * Indicates the intensity level of the red component (between 0 and 1).
         */
        public function get redIntensity():Number
        {
            return shader.data.intensity.value[0] ;
        }
        
        /**
         * @private
         */
        public function set redIntensity( value:Number ):void
        {
            shader.data.intensity.value[0] = clamp( isNaN(value) ? 0 : value , 0 , 1 );
        }
        
        /**
         * Returns a shallow copy of the object.
         * @return a shallow copy of the object.
         */
        public override function clone():BitmapFilter
        {
            return new RGBDistortFilter( shader ) ;
        }
    }
}
