package avmplus
{
    public var avmglue:String = "0.1.0." + "$Rev$".split( " " )[1];
    
    if( API::REDTAMARIN ) { avmglue += " API"; }
    else if( API::MOCK ) { avmglue += " MOCK"; }
}