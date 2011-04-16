package flash.utils
{
    import avmplus.*;
    
    public function getQualifiedSuperclassName( value:* ):String
    {
        CFG::dbg{ trace( "getQualifiedSuperclassName( " + value + " )" ); }
        return avmplus.getQualifiedSuperclassName( value );
    }
}