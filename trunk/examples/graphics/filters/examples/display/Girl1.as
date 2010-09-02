package examples.display
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    
    [Embed(source="Girl1.jpg")]
    
    public class Girl1 extends Bitmap
    {
        public function Girl1(bitmapData:BitmapData = null, pixelSnapping:String = "auto", smoothing:Boolean = false)
        {
            super(bitmapData, pixelSnapping, smoothing);
        }
    }
}
