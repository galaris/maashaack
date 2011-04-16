package flash.utils
{
    import avmplus.*;
    
    public function getQualifiedClassName( value:* ):String
    {
        CFG::dbg{ trace( "getQualifiedClassName( " + value + " )" ); }
        return avmplus.getQualifiedClassName( value );
    }
}