package utils
{
    import flash.utils.Dictionary;
    
    public function bytesToHumandReadable( bytes:Number,
                                           precision:uint = 2, SI:Boolean = false, force:String = "" ):String
    {
        var unit:Number = SI ? 1000 : 1024;
        
        if( (bytes < unit) && (force == "") ) { return bytes + " B"; }
        
        var kilo:Number  = unit;
        var mega:Number  = kilo  * unit;
        var giga:Number  = mega  * unit;
        var tera:Number  = giga  * unit;
        var peta:Number  = tera  * unit;
        var exa:Number   = peta  * unit;
        var zetta:Number = exa   * unit;
        var yotta:Number = zetta * unit;
        
        var u:String;
        if( (bytes >= 0) && (bytes < kilo) )           { u = "";  }
        else if( (bytes >= kilo)  && (bytes < mega) )  { u = "K"; }
        else if( (bytes >= mega)  && (bytes < giga) )  { u = "M"; }
        else if( (bytes >= giga)  && (bytes < tera) )  { u = "G"; }
        else if( (bytes >= tera)  && (bytes < peta) )  { u = "T"; }
        else if( (bytes >= peta)  && (bytes < exa) )   { u = "P"; }
        else if( (bytes >= exa)   && (bytes < zetta) ) { u = "E"; }
        else if( (bytes >= zetta) && (bytes < yotta) ) { u = "Z"; }
        else if( (bytes >= yotta) )                    { u = "Y"; }
        
        if( force != "" ) { u = force; }
        
        var s:String;
        switch( u )
        {
            case "K": s = Number( bytes / kilo  ).toFixed( precision ).toString(); break;
            case "M": s = Number( bytes / mega  ).toFixed( precision ).toString(); break;
            case "G": s = Number( bytes / giga  ).toFixed( precision ).toString(); break;
            case "T": s = Number( bytes / tera  ).toFixed( precision ).toString(); break;
            case "P": s = Number( bytes / peta  ).toFixed( precision ).toString(); break;
            case "E": s = Number( bytes / exa   ).toFixed( precision ).toString(); break;
            case "Z": s = Number( bytes / zetta ).toFixed( precision ).toString(); break;
            case "Y": s = Number( bytes / yotta ).toFixed( precision ).toString(); break;
            case "":
            default:
            s = bytes + "";
        }
        
        var zeros:String = new Array(precision+1).join("0");
        var parts:Array  = s.split(".")
        
        var hasDot:Boolean = s.indexOf( "." ) > -1;
        if( hasDot && (zeros == parts[1]) ) { s = parts[0]; }
        
        return s + " " + u + (SI ? "i" : "") + "B";
        
        /*
        if( bytes < unit ) { return bytes + " B"; }
        
        var exp:int = int (Math.log(bytes) / Math.log(unit));
        var prefix:String = "KMGTPEZY".charAt( exp-1 ) + (SI ? "" : "i");
        var str:String = Number(bytes / Math.pow( unit, exp )).toFixed( precision ).toString();
        
        var zeros:String = new Array(precision+1).join("0");
        //trace( "zeros = [" + zeros + "]" );
        
        var hasDot:Boolean = str.indexOf( "." ) > -1;
        if( hasDot )
        {
            var tmp:Array   = str.split(".");
            var rest:String = tmp[1];
            
            if( rest == zeros )
            {
                str = tmp[0];
            }
        }
        
        hasDot = str.indexOf( "." ) > -1;
        if( (precision == 0) && hasDot )
        {
            str = str.split(".")[0];
        }
        
        
        return str + " " + prefix + "B";
        */
    }
}