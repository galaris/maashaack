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
    import flash.geom.Point;
    
    /**
     * Applies a ripple blocks effect. 
     * The Shader must be defines with the RippleBlocks pixelbender implementation.
     */
    public class RippleBlocksFilter extends ShaderCustomFilter 
    {
        /**
         * Creates a new RippleBlocksFilter instance.
         * @param shader The Shader reference of the filter.
         * @param init The optional dynamic object to initialize the filter.
         */
        public function RippleBlocksFilter( shader:Shader = null , init:Object = null )
        {
            super( shader || new Shader( new RippleBlocks() ) , init ) ;
        }
        
        /**
         * The amplitude of the filter. You can use too the amplitudeX and amplitudeY properties.
         */
        public function get amplitude():Point
        {
            var p:* = shader.data.amplitude.value ;
            return new Point( p[0] , p[1] ) ;
        }
        
        /**
         * @private
         */
        public function set amplitude( p:Point ):void
        {
            shader.data.amplitude.value[0] = p.x ;
            shader.data.amplitude.value[1] = p.y ;
        }
        
        /**
         * The x component only of the amplitude of the filter.
         */
        public function get amplitudeX():Number
        {
            return shader.data.amplitude.value[0] ;
        }
        
        /**
         * @private
         */
        public function set amplitudeX( value:Number ):void
        {
            shader.data.amplitude.value[0] = value ;
        }
        
        /**
         * The y component only of the amplitude of the filter.
         */
        public function get amplitudeY():Number
        {
            return shader.data.amplitude.value[1] ;
        }
        
        /**
         * @private
         */
        public function set amplitudeY( value:Number ):void
        {
            shader.data.amplitude.value[1] = value ;
        }
        
        /**
         * The phase of the filter. You can use too the phaseX and phaseY properties.
         */
        public function get phase():Point
        {
            var p:* = shader.data.phase.value ;
            return new Point( p[0] , p[1] ) ;
        }
        
        /**
         * @private
         */
        public function set phase( p:Point ):void
        {
            shader.data.phase.value[0] = p.x ;
            shader.data.phase.value[1] = p.y ;
        }
        
        /**
         * The x component only of the phase of the filter.
         */
        public function get phaseX():Number
        {
            return shader.data.phase.value[0] ;
        }
        
        /**
         * @private
         */
        public function set phaseX( value:Number ):void
        {
            shader.data.phase.value[0] = value ;
        }
        
        /**
         * The y component only of the phase of the filter.
         */
        public function get phaseY():Number
        {
            return shader.data.phase.value[1] ;
        }
        
        /**
         * @private
         */
        public function set phaseY( value:Number ):void
        {
            shader.data.phase.value[1] = value ;
        }
        
        /**
         * The wave length value of the filter. You can use too the waveX and waveY properties.
         */
        public function get wave():Point
        {
            var p:* = shader.data.wave.value ;
            return new Point( p[0] , p[1] ) ;
        }
        
        /**
         * @private
         */
        public function set wave( p:Point ):void
        {
            shader.data.wave.value[0] = p.x ;
            shader.data.wave.value[1] = p.y ;
        }
        
        /**
         * The x component only of the wave of the filter.
         */
        public function get waveX():Number
        {
            return shader.data.wave.value[0] ;
        }
        
        /**
         * @private
         */
        public function set waveX( value:Number ):void
        {
            shader.data.wave.value[0] = value ;
        }
        
        /**
         * The y component only of the wave of the filter.
         */
        public function get waveY():Number
        {
            return shader.data.wave.value[1] ;
        }
        
        /**
         * @private
         */
        public function set waveY( value:Number ):void
        {
            shader.data.wave.value[1] = value ;
        }
        
        /**
         * Returns a shallow copy of the object.
         * @return a shallow copy of the object.
         */
        public override function clone():BitmapFilter
        {
            return new RippleBlocksFilter( shader ) ;
        }
    }
}
