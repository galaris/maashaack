package flash.utils
{
    import avmplus.Domain;
    
    public function getDefinitionByName( name:String ):Object
    {
        return Domain.currentDomain.getClass( name ) as Object;
    }
}