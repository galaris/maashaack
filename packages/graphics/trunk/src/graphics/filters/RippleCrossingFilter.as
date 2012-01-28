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
    import flash.display.BitmapData;
    import flash.display.Shader;
    import flash.filters.BitmapFilter;
    
    /**
     * Applies a ripple crossing transition effect. 
     * The Shader must be defines with the RippleCrossing pixelbender implementation.
     */
    public class RippleCrossingFilter extends ShaderCustomFilter 
    {
        /**
         * Creates a new RippleCrossingFilter instance.
         * @param init The optional dynamic object to initialize the filter.
         * @param shader The Shader reference of the filter.
         */
        public function RippleCrossingFilter( init:Object = null , shader:Shader = null )
        {
            super( shader || new Shader( new RippleCrossing() ) , init ) ;
        }
        
        /**
         * The amount value of the transition betwen 0 and 1.
         */
        public function get amount():Number
        {
            return shader.data.amount.value[0] ;
        }
        
        /**
         * @private
         */
        public function set amount( value:Number ):void
        {
            shader.data.amount.value[0] = value ;
        }
        
        /**
         * The amplitude of the ripple effect between 0 and 1 (default 0.05)
         */
        public function get amplitude():Number
        {
            return shader.data.amplitude.value[0] ;
        }
        
        /**
         * @private
         */
        public function set amplitude( value:Number ):void
        {
            shader.data.amplitude.value[0] = value ;
        }
        
        /**
         * The center x offset value between 0 and 1 of the effect (default 0.5)
         */
        public function get centerX():Number
        {
            return shader.data.center.value[0] ;
        }
        
        /**
         * @private
         */
        public function set centerX( value:Number ):void
        {
            shader.data.center.value[0] = value ;
        }
        
        /**
         * The center y offset value between 0 and 1 of the effect (default 0.5)
         */
        public function get centerY():Number
        {
            return shader.data.center.value[1] ;
        }
        
        /**
         * @private
         */
        public function set centerY( value:Number ):void
        {
            shader.data.center.value[1] = value ;
        }
        
        /**
         * The frequency of the ripple effect (value between 0.0 and 1.0 and default 0.2).
         */
        public function get frequency():Number
        {
            return shader.data.frequency.value[0] ;
        }
        
        /**
         * @private
         */
        public function set frequency( value:Number ):void
        {
            shader.data.frequency.value[0] = value ;
        }
        
        /**
         * The BitmapData reference who represents the "from" input representation of the interpolation.
         */
        public function get from():BitmapData
        {
            return shader.data.from.input ;
        }
        
        /**
         * @private
         */
        public function set from( bmp:BitmapData ):void
        {
            shader.data.from.input = bmp ;
        }
        
        /**
         * The height of the ripple effect area (default 240 px).
         */
        public function get height():Number
        {
            return shader.data.area.value[1] ;
        }
        
        /**
         * @private
         */
        public function set height( value:Number ):void
        {
            shader.data.area.value[1] = value ;
        }
        
        /**
         * The speed of the ripple effect (value between 0.0 and 1.0 and default 0.1).
         */
        public function get speed():Number
        {
            return shader.data.speed.value[0] ;
        }
        
        /**
         * @private
         */
        public function set speed( value:Number ):void
        {
            shader.data.speed.value[0] = value ;
        }
        
        /**
         * The BitmapData reference who represents the "to" input representation of the interpolation.
         */
        public function get to():BitmapData
        {
            return shader.data.to.input ;
        }
        
        /**
         * @private
         */
        public function set to( bmp:BitmapData ):void
        {
            shader.data.to.input = bmp ;
        }
        
        /**
         * The width of the ripple effect area (default 320 px).
         */
        public function get width():Number
        {
            return shader.data.area.value[0] ;
        }
        
        /**
         * @private
         */
        public function set width( value:Number ):void
        {
            shader.data.area.value[0] = value ;
        }
        
        /**
         * Returns a shallow copy of the object.
         * @return a shallow copy of the object.
         */
        public override function clone():BitmapFilter
        {
            return new RippleCrossingFilter( shader ) ;
        }
    }
}
