
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
    import graphics.display.ReflectionBitmapData;
    
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    
    [SWF(width="200", height="200", frameRate="24", backgroundColor="#333333")]
    
    /**
     * Example with the pegas.display.ReflectionBitmapData class.
     */
    public dynamic class ReflectionBitmapDataExample extends Sprite 
    {
        public function ReflectionBitmapDataExample()
        {
            //////////
            
            stage.align      = StageAlign.TOP_LEFT ;
            stage.scaleMode  = StageScaleMode.NO_SCALE ;
            
            /////////
            
            var home:BitmapData = new Home(0,0) as BitmapData ;
            var icon:MovieClip  = new Icon() as MovieClip     ;
            
            var reflect1:BitmapData = new ReflectionBitmapData( home , 0.5 , 0xFF , 50 , 0) ; 
            var reflect2:BitmapData = new ReflectionBitmapData( icon , 0.5 , 0xFF , 50 , 0) ;
            
            var bitmap1:Bitmap = new Bitmap( reflect1 ) ;
            var bitmap2:Bitmap = new Bitmap( reflect2 ) ;
            
            bitmap1.x = 25 ;
            bitmap1.y = 50 ;
            
            bitmap2.x = 100 ;
            bitmap2.y = 50 ;
            
            addChild( bitmap1 ) ;
            addChild( bitmap2 ) ;
        }
    }
}
