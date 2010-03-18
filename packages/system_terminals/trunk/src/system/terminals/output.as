package system.terminals
{
    /**
    * Text output function.
    * You can replace it with any custom function or method to write to text file,
    * to display in a <code>TextField</code, send to socket, etc.
    * by default it uses the <code>trace()</code> function.
    * 
    * <p>
    * The function signature is the following: <code>function name( message:String ):void</code>.
    * </p>
    * 
    * @example using a custom output method
    * <listing version="3.0">
    * <code class="prettyprint">
    * package
    * {
    *     import system.terminals.output;
    *     
    *     public class Test
    *     {
    *         public function Test()
    *         {
    *             system.terminals.output = myoutput;
    *         }
    *         
    *         public function myoutput( msg:String ):void
    *         {
    *             trace( "[" + msg + "]" );
    *         }
    *     }
    * }
    * </code>
    * </listing>
    * 
    */
    public var output:Function = trace;
}