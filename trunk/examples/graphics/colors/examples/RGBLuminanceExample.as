/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is PEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
*/

package examples 
{
    import examples.display.Picture;

    import graphics.colors.RGB;

    import system.numeric.Mathematics;

    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.events.MouseEvent;

    [SWF(width="300", height="300", frameRate="24", backgroundColor="#666666")]
    
    public class RGBLuminanceExample extends Sprite 
    {
        public function RGBLuminanceExample()
        {
            // stage
            
            stage.scaleMode = StageScaleMode.NO_SCALE ;
            stage.addEventListener( MouseEvent.MOUSE_MOVE , update ) ;
            
            // picture
            
            picture.x = 25 ;
            picture.y = 25 ;
            
            addChild( picture ) ;
            
            // pixels
            
            pixels = new Vector.<RGB>() ;
            
            var rgb:RGB ;
            
            var bmp:BitmapData = picture.bitmapData ;
            var width:Number   = bmp.width ;
            var height:Number  = bmp.height ;
            
            for( var i:int = 0 ; i<width ; i++ )
            {
                for ( var j:int = 0  ; j<height ; j++ )
                {
                    rgb = new RGB() ;
                    rgb.fromNumber(bmp.getPixel(i,j) ) ;
                    pixels.push( rgb ) ;
                }
            }
        }
        
        public var picture:Picture = new Picture() ;
        
        public var pixels:Vector.<RGB> ;
        
        public function update( e:Event ):void
        {
            var rgb:RGB ;
            
            var bmp:BitmapData = picture.bitmapData;
            
            var count:uint    = 0 ;
            var width:Number  = bmp.width ;
            var height:Number = bmp.height ;
            
            for( var i:int = 0 ; i<width ; i++ )
            {
                for ( var j:int = 0  ; j<height ; j++ )
                {
                    rgb = pixels[count++].clone() ;
                    rgb.luminance = Mathematics.clamp( Mathematics.map( picture.mouseY , 0 , picture.height , 0 , 255 ) , 0 , 255 ) ;
                    bmp.setPixel(i, j, rgb.valueOf() ) ;
                }
            }
        }
    }
}
