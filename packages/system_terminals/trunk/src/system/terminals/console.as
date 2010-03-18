package system.terminals
{
    /**
    * This is the default InteractiveConsole
    * 
    * @example override it with your own implementation
    * <listing version="3.0">
    * <code class="prettyprint">
    * package
    * {
    *     import system.terminals.console;
    *     import com.test.MyConsole; // new to implent InteractiveConsole interface
    *     
    *     public class Test
    *     {
    *         public function Test()
    *         {
    *             system.terminals.console = new MyConsole();
    *         }
    *     }
    * }
    * </code>
    * </listing>
    */
    public var console:InteractiveConsole = new TraceConsole();
}