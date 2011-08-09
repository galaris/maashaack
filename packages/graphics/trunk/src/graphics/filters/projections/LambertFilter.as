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

package graphics.filters.projections 
{
    import graphics.filters.ShaderCustomFilter;
    
    import flash.display.Shader;
    import flash.filters.BitmapFilter;
    
    /**
     * Apply a lambert azimuthal projection.
     * The Shader must be defines with the Lambert pixelbender implementation.
     */
    public class LambertFilter extends ShaderCustomFilter 
    {
        /**
         * Creates a new LambertFilter instance.
         * @param shader The Shader reference with the Lambert pixel bender filter inside.
         * @param init The optional dynamic object to initialize the filter.
         */
        public function LambertFilter( shader:Shader = null , init:Object = null )
        {
            super( shader || new Shader( new Lambert() ) , init);
        }
        
        /**
         * Specifies an angle, as a degree between 1 and 360, for the field of view of the projection.
         */
        public function get fieldOfView():Number
        {
            return shader.data.fieldOfView.value[0] ;
        }
        
        /**
         * @private
         */
        public function set fieldOfView( value:Number ):void
        {
            shader.data.fieldOfView.value[0] = value ;
        }
        
        /**
         * The distance between the camera and the view located in the z-axis.
         */
        public function get focalLength():Number
        {
            return shader.data.focalLength.value[0] ;
        }
        
        /**
         * @private
         */
        public function set focalLength( value:Number ):void
        {
            shader.data.focalLength.value[0] = value ;
        }
        
        /**
         * The height of the picture to transform.
         */
        public function get height():Number
        {
            return shader.data.aspectRatio.value[1] ;
        }
        
        /**
         * @private
         */
        public function set height( value:Number ):void
        {
            shader.data.aspectRatio.value[1] = value ;
        }
        
        /**
         * The width of the picture to transform.
         */
        public function get width():Number
        {
            return shader.data.aspectRatio.value[0] ;
        }
        
        /**
         * @private
         */
        public function set width( value:Number ):void
        {
            shader.data.aspectRatio.value[0] = value ;
        }
        
        /**
         * Returns a shallow copy of the object.
         * @return a shallow copy of the object.
         */
        public override function clone():BitmapFilter
        {
            return new LambertFilter( shader , { width:width , height:height , focalLength:focalLength , fieldOfView:fieldOfView }) ;
        }
    }
}
