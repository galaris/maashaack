
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

package examples.patterns
{
    import graphics.FillBitmapStyle;
    import graphics.colors.RGBA;
    import graphics.display.Pattern;
    import graphics.display.patterns.MangaPatterns;
    import graphics.drawing.RectanglePen;
    
    import system.data.Iterator;
    import system.data.iterators.ArrayIterator;
    
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.events.MouseEvent;
    
    [SWF(width="190", height="190", frameRate="24", backgroundColor="#EEEEEE")]
    
    public class MangaPatternsExample extends Sprite
    {
        public function MangaPatternsExample()
        {
            ///////////
            
            stage.scaleMode = StageScaleMode.NO_SCALE ;
            
            stage.addEventListener( MouseEvent.MOUSE_DOWN , next ) ;
            
            ///////////
            
            var shape:Shape = new Shape() ;
            
            shape.x = 10 ;
            shape.y = 10 ;
            
            addChild( shape ) ;
            
            ///////////
            
            var pattern:Pattern = MangaPatterns.arare( 0xFF666666 ) ;
            
            pen      = new RectanglePen( shape ) ;
            pen.fill = new FillBitmapStyle( pattern, null, true ) ;
            
            pen.draw( 0, 0, 170, 170 ) ;
            
            ///////////
            
            iterator = new ArrayIterator( patterns ) ;
        }
        
        public var iterator:Iterator ;
        
        public var patterns:Array =
        [
            MangaPatterns.arare     ( new RGBA(255, 0, 0, 1) ) ,
            MangaPatterns.furoshiki ( new RGBA(255, 0, 0, 1) ) ,
            MangaPatterns.koishi    ( new RGBA(255, 0, 0, 1) ) ,
            MangaPatterns.kazari    ( new RGBA(255, 0, 0, 1) ) ,
            MangaPatterns.sebiro    ( new RGBA(255, 0, 0, 1) ) ,
            MangaPatterns.shinbun   ( new RGBA(255, 0, 0, 1) ) ,
            MangaPatterns.tenugui   ( new RGBA(255, 0, 0, 1) ) 
        ];
        
        public var pen:RectanglePen ;
        
        protected function next( e:Event ):void
        {
            if ( ! iterator.hasNext() )
            {
                iterator.reset() ;
            }
            (pen.fill as FillBitmapStyle).bitmap = iterator.next() as Pattern;
            pen.draw() ;
        }
    }
}
