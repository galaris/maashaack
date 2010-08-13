package examples 
{
    import graphics.geom.Metaball;

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
            
            area   = new Rectangle( 10 , 10 , 320 , 240 ) ;
            
            canvas = new BitmapData( area.width , area.height , false, 0x000000) ;
            
            bitmap = new Bitmap( canvas ) ;
            
            bitmap.filters = [ new BlurFilter(5,5,1) ] ;
            
            bitmap.x = area.x ;
            bitmap.y = area.y ;
            
            addChild( bitmap ) ;
            
            spot = new Metaball( area.x + area.width / 2 , area.y + area.height / 2 , 60 ) ;
            
            metaballs.push( spot ) ;
            
            render() ;
            
            // stage
            
            stage.scaleMode = StageScaleMode.NO_SCALE ;
            
            stage.addEventListener( Event.ENTER_FRAME , render ) ;
        }
        
        public var area:Rectangle ;
        
        public var bitmap:Bitmap ;
        
        public var canvas:BitmapData ;
        
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
            
            canvas.fillRect( new Rectangle( 0 , 0 , area.width , area.height ) , 0x000000 ) ;
            //canvas.floodFill(0,0,0);
            
            var len:int    = metaballs.length ;
            var sum:Number = 0;
            
            // Iterate over every pixel on the screen
            
            for( var ty:int = 0 ; ty < area.height ; ty++ ) 
            {
                for(var tx:int = 0; tx < area.width ; tx++) 
                {
                    sum = 0;
                    
                    for(var i:int = 0; i < len ; i++) 
                    {
                        sum += ( metaballs[i] as Metaball ).calculate( tx ,ty ) ;
                    }
                    
                    if( sum >= minThreshold && sum <= maxThreshold) 
                    {
                        canvas.setPixel( tx , ty, 0xFFFFFF ) ;
                    }
                }
            }
        }
    }
}
