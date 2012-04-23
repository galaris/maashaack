package examples
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    
    [Embed(source="Joconde.jpg")]
    
    public class Joconde extends Bitmap
    {
        public function Joconde(bitmapData:BitmapData = null, pixelSnapping:String = "auto", smoothing:Boolean = false)
        {
            super(bitmapData, pixelSnapping, smoothing);
        }
    }
}
