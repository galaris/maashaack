package core.strings
{
    /**
     * Checks if this string starts with the specified prefix.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import core.strings.startsWith ;
     * 
     * var file:String = "hello.txt";
     * 
     * trace( startsWith( file , "hello" ) ) ; // true
     * </pre>
     * @param source the string reference.
     * @param value the value to find in first in the source.
     * @return true if the value is find in first.
     */
    public function startsWith( source:String , value:String ):Boolean
    {
        return source.indexOf( value ) == 0 ;
    }
}