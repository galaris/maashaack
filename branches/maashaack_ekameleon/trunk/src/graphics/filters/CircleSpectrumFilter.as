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
     * The CircleSpectrumFilter class maps a color spectrum to a circle area.
     * The Shader must be defines with the CircleSpectrum pixelbender implementation.
     */
    public class CircleSpectrumFilter extends ShaderCustomFilter 
    {
        /**
         * Creates a new CircleSpectrumFilter instance.
         * @param shader The Shader reference with the CircleSpectrum pixel bender filter inside.
         * @param init The optional dynamic object to initialize the filter.
         */
        public function CircleSpectrumFilter( shader:Shader = null , init:Object = null )
        {
            super( shader || new Shader( new CircleSpectrum() ) , init);
        }
        
        /**
         * The center position of the circle (between {0,0} and {2800,2800}, default {100,100}).
         */
        public function get center():Point
        {
            var p:* = shader.data.center.value ;
            return new Point( p[0] , p[1] ) ;
        }
        
        /**
         * @private
         */
        public function set center( p:Point ):void
        {
            shader.data.center.value[0] = p.x ;
            shader.data.center.value[1] = p.y ;
        }
        
        /**
         * The inner radius of the circle (between 0 and 2800 px, default 100 px).
         */
        public function get innerRadius():Number
        {
            return shader.data.innerRadius.value[0] ;
        }
        
        /**
         * @private
         */
        public function set innerRadius( value:Number ):void
        {
            shader.data.innerRadius.value[0] = value ;
        }
        
        /**
         * The outer radius of the circle (between 0 and 2800 px, default 100 px).
         */
        public function get outerRadius():Number
        {
            return shader.data.outerRadius.value[0] ;
        }
        
        /**
         * @private
         */
        public function set outerRadius( value:Number ):void
        {
            shader.data.outerRadius.value[0] = value ;
        }
        
        /**
         * The ratio of the spectrum circle (between 0 and 1, default 1).
         */
        public function get ratio():Number
        {
            return shader.data.ratio.value[0] ;
        }
        
        /**
         * @private
         */
        public function set ratio( value:Number ):void
        {
            shader.data.ratio.value[0] = value ;
        }
        
        /**
         * The ratio of the spectrum circle (between 0 and 360, default 0).
         */
        public function get rotation():Number
        {
            return shader.data.rotation.value[0] ;
        }
        
        /**
         * @private
         */
        public function set rotation( value:Number ):void
        {
            shader.data.rotation.value[0] = value ;
        }
        
        /**
         * Returns a shallow copy of the object.
         * @return a shallow copy of the object.
         */
        public override function clone():BitmapFilter
        {
            return new CircleSpectrumFilter( shader ) ;
        }
    }
}
