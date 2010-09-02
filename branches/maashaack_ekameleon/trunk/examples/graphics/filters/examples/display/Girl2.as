package examples.display
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    
    [Embed(source="Girl2.jpg")]
    
    public class Girl2 extends Bitmap
    {
        public function Girl2(bitmapData:BitmapData = null, pixelSnapping:String = "auto", smoothing:Boolean = false)
        {
            super(bitmapData, pixelSnapping, smoothing);
        }
    }
}
