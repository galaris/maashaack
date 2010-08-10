package examples.display 
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    
    [Embed(source="picture.jpg")]
    
    public class Picture extends Bitmap 
    {
        public function Picture(bitmapData:BitmapData = null, pixelSnapping:String = "auto", smoothing:Boolean = false)
        {
            super(bitmapData, pixelSnapping, smoothing);
        }
    }
}
