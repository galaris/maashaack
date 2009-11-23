/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package examples 
{
    import graphics.display.PerlinNoise;

    import flash.display.Bitmap;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.filters.DropShadowFilter;
    import flash.filters.GlowFilter;

    [SWF(width="300", height="300", frameRate="24", backgroundColor="#666666")]
    
    /**
     * Example with the pegas.display.PerlinNoise class.
     */
    public class PerlinNoiseExample extends Sprite 
    {
        public function PerlinNoiseExample()
        {
            stage.align     = StageAlign.TOP_LEFT ;
            stage.scaleMode = StageScaleMode.NO_SCALE ;
            
            perlin  = new PerlinNoise( 200 , 200 , true , 0xFFA2FFFF ) ;
            
            //perlin.density   = 100 ;
            //perlin.channels  = BitmapDataChannel.RED | BitmapDataChannel.GREEN | BitmapDataChannel.BLUE ;
            //perlin.greyScale = false ;
            //perlin.octaves   = 10 ;
            //perlin.seed      = 1000 ;
            //perlin.stitch    = true ;
            perlin.fractal   = false ;
            
            var bitmap:Bitmap = new Bitmap( perlin ) ;
            
            bitmap.filters = 
            [
                new GlowFilter( 0xD3E7D3 , 0.4 , 10 , 10 , 2 , 3 , true ) ,
                new DropShadowFilter( 4 , 45 , 0 , 0.4 , 10 , 10 , 1 , 1 ) 
            ] ;
            
            bitmap.x = 50 ;
            bitmap.y = 50 ;
            
            addChild( bitmap ) ;
            
            addEventListener( Event.ENTER_FRAME , refresh ) ;
        }
        
        public var perlin:PerlinNoise ;
        
        public function refresh( e:Event = null ):void
        {
            perlin.move( 24 , -24 ) ;
            perlin.density ++ ;
            if ( perlin.density > 50 )
            {
            	perlin.density = 1 ;
            }
        }
    }
}
