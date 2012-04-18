package examples
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    
    [Embed(source="Girl.jpg")]
    
    public class Girl extends Bitmap
    {
        public function Girl(bitmapData:BitmapData = null, pixelSnapping:String = "auto", smoothing:Boolean = false)
        {
            super(bitmapData, pixelSnapping, smoothing);
        }
    }
}
