package utils
{
    import flash.utils.ByteArray;
    
    /**
    * Format a ByteArray to an hexadecimal string, from start to end (or length),
    * adding a `sep` `every` n chars with a maximum line length of `width`
    */
    public function hexformat( bytes:ByteArray, start:uint = 0, end:int = -1,
                               every:uint = 2, sep:String = " ", width:uint = 80, header:String = "" ):String
    {
        if( end == -1 ) { end = bytes.length; }
        
        var stream:String   = "";
        var formated:String = "";
        var hex:String      = "";
        
        var original:uint = bytes.position;
        bytes.position = start;
        while( bytes.position < end )
        {
            hex     = uint( bytes.readUnsignedByte() ).toString( 16 );
            stream += (hex.length>1) ? hex: "0"+hex;
        }
        bytes.position = original;
        
        var len:uint     = stream.length;
        var min:uint     = 0;
        var max:uint     = every;
        var total:uint   = 0;
        var linelen:uint = 0;
        
        while( total < len )
        {
            formated += stream.substr( min, max ) + sep;
            linelen  += max + sep.length;
            
            if( linelen >= width ) { formated += "\n" + header; linelen = 0; }
            
            min   += every;
            total += every;
        }
        
        return formated;
    }
}