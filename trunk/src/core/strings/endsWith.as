package core.strings
{
    /**
     * Determines wether the end of a string matches the specified value.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import core.strings.endsWith ;
     * 
     * var file:String = "hello.txt";
     * 
     * trace( endsWith( file , "txt" ) ) ; // true
     * </pre>
     * @example basic usage
     * <listing version="3.0">
     * <code class="prettyprint">
     * trace( endsWith( "hello world", "world" ) ); //true
     * trace( endsWith( "hello world", "hello" ) ); //false
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