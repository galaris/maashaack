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
    import graphics.geom.Metaball;
    import graphics.transitions.FrameLoop;
    
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.filters.BlurFilter;
    import flash.geom.Rectangle;
    
    [SWF(width="340", height="260", frameRate="30", backgroundColor="#666666")]
    
    public class MetaballExample extends Sprite 
    {
        public function MetaballExample()
        {
            // initialize 
            
            area = new Rectangle( 10 , 10 , 320 , 240 ) ;
            
            bitmap = new Bitmap() ;
            
            bitmap.filters = [ new BlurFilter(3,3,1) ] ;
            
            bitmap.x = area.x ;
            bitmap.y = area.y ;
            
            addChild( bitmap ) ;
            
            spot = new Metaball( area.x + area.width / 2 , area.y + area.height / 2 , 60 ) ;
            
            metaballs.push( spot ) ;
            
            render() ;
            
            // stage
            
            stage.scaleMode = StageScaleMode.NO_SCALE ;
            
            // stage.addEventListener( Event.ENTER_FRAME , render ) ;
            
            // frame loop
            
            frame = new FrameLoop() ;
            
            frame.connect( render ) ;
            
            frame.play() ;
        }
        
        public var area:Rectangle ;
        
        public var bitmap:Bitmap ;
        
        public var canvas:BitmapData ;
        
        public var frame:FrameLoop ;
        
        public var metaballs:Vector.<Metaball> = Vector.<Metaball>
        ([
            new Metaball(  20 ,  20 , 10 ) ,
            new Metaball(  70 ,  80 , 30 ) ,
            new Metaball( 250 , 100 , 35 ) ,
            new Metaball( 220 , 130 , 30 ) ,
            new Metaball( 60  , 180 , 20 ) ,
            new Metaball( 90  , 200 , 25 ) 
        ]);
        
        public var maxThreshold:int = 4 ;
        
        public var minThreshold:int = 3 ;
        
        public var spot:Metaball ;
        
        public function render( e:Event = null ):void
        {
            spot.x = bitmap.mouseX ;
            spot.y = bitmap.mouseY ;
            
            if ( canvas )
            {
                canvas.dispose() ;
            }
            
            canvas = new BitmapData( area.width , area.height , false , 0x333333 ) ;
            
            bitmap.bitmapData = canvas ;
            
            canvas.lock() ;
            
            var len:int = metaballs.length ;
            
            _cpt = 0 ;
            
            for( _tx = 0 ; _tx < area.width ; _tx++ ) 
            {
                for( _ty = 0 ; _ty < area.height ; _ty++ ) 
                {
                    _cpt = 0 ;
                    
                    for( _i = 0; _i < len ; _i++ ) 
                    {
                        _cpt += ( metaballs[_i] as Metaball ).calculate( _tx , _ty ) ;
                    }
                    
                    if( _cpt >= minThreshold && _cpt <= maxThreshold) 
                    {
                        canvas.setPixel( _tx , _ty , 0x626262 ) ;
                    }
                }
            }
            
            canvas.unlock() ;
        }
        
        private var _cpt:Number ;
        private var _i:int ;
        private var _tx:int ;
        private var _ty:int ;
    }
}
