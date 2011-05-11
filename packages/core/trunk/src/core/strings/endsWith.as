package core.strings
{
    /**
     * Determines wether the end of a string matches the specified value.
     * @example basic usage
     * <listing version="3.0">
     * <code class="prettyprint">
     * import core.strings.endsWith ;
     * 
     * trace( endsWith( "hello world", "world" ) ); //true
     * trace( endsWith( "hello world", "hello" ) ); //false
     * 
     * trace( endsWith( "hello.txt" , "txt" ) ) ; // true
     * </code>
     * </listing>
     * @param source the string reference.
     * @param value the value to find in first in the source.
     * @return true if the value is find in first.
     */
    public const endsWith:Function = function( source:String , value:String ):Boolean
    {
        if( source != null && value == "" )
        {
            return true ;
        }
        if( (source == null) || (value == null) || (source == "") || (source.length < value.length) )
        {
            return false;
        }
        return source.lastIndexOf(value) == ( source.length - value.length ) ;
    };
}