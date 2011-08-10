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
    import graphics.display.PerlinNoiseBitmapData;
    
    import flash.display.Bitmap;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.filters.DropShadowFilter;
    import flash.filters.GlowFilter;
    
    [SWF(width="300", height="300", frameRate="24", backgroundColor="#666666")]
    
    /**
     * Example with the graphics.display.PerlinNoiseBitmapData class.
     */
    public class PerlinNoiseBitmapDataExample extends Sprite 
    {
        public function PerlinNoiseBitmapDataExample()
        {
            stage.align     = StageAlign.TOP_LEFT ;
            stage.scaleMode = StageScaleMode.NO_SCALE ;
            
            perlin  = new PerlinNoiseBitmapData( 200 , 200 , true , 0xFFA2FFFF ) ;
            
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
        
        public var perlin:PerlinNoiseBitmapData ;
        
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
