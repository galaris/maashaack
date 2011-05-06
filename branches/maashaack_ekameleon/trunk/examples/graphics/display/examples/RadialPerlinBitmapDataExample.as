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

package examples 
{
    import graphics.FillGradientStyle;
    import graphics.display.RadialPerlinBitmapData;
    import graphics.drawing.CirclePen;

    import flash.display.Bitmap;
    import flash.display.GradientType;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.filters.GlowFilter;
    import flash.geom.Matrix;

    [SWF(width="300", height="300", frameRate="24", backgroundColor="#000000")]
    
    /**
     * Example with the graphics.display.RadialPerlinNoise class.
     */
    public class RadialPerlinBitmapDataExample extends Sprite 
    {
        public function RadialPerlinBitmapDataExample()
        {
            //////////
            
            stage.align     = StageAlign.TOP_LEFT ;
            stage.scaleMode = StageScaleMode.NO_SCALE ;
            
            addEventListener( Event.ENTER_FRAME , refresh ) ;
            
            ////////// background
            
            var background:Shape = new Shape();
            var colors:Array     = [0x006599,0x0099CC];
            var alphas:Array     = [1,0];
            var ratios:Array     = [0,255];
            var matrix:Matrix    = new Matrix() ;
            
            matrix.createGradientBox( 200, 200, 0, 0, 0 );
            
            var pen:CirclePen = new CirclePen( background ) ;
            pen.fill = new FillGradientStyle( GradientType.RADIAL, colors, alphas, ratios, matrix ) ;
            pen.draw( 30, 30, 120 );
            
            addChild( background ) ;
            
            ////////// perlin
            
            perlin = new RadialPerlinBitmapData( 120, 3, Math.random() * 1000, true, 15, false, true );
            perlin.render( _distance , _rotation );
            
            var bitmap:Bitmap = new Bitmap( perlin );
            
            bitmap.x = 30 ;
            bitmap.y = 30 ;
            
            bitmap.filters = [ new GlowFilter(0xFFFFFF, 1, 6, 6, 2, 1, false) ] ;
            
            addChild( bitmap ) ;
        }
        
        public var perlin:RadialPerlinBitmapData ;
        
        private var _distance:Number = 0;
        private var _rotation:Number = 0;
        
        public function refresh( e:Event = null ):void
        {
            _distance += 2;
            _rotation += 4;
            perlin.render( _distance, _rotation ) ;
        }
    }
}
