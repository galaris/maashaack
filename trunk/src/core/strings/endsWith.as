package core.strings
{
    /**
     * Checks if this string ends with the specified suffix.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import core.strings.endsWith ;
     * 
     * var file:String = "hello.txt";
     * 
     * trace( endsWith( file , "txt" ) ) ; // true
     * </pre>
     * @param source the string reference.
     * @param value the value to find in first in the source.
     * @return true if the value is find in first.
     */
    public function endsWith( source:String , value:String ):Boolean
    {
        return source.lastIndexOf(value) == ( source.length - value.length ) ;
    }
}