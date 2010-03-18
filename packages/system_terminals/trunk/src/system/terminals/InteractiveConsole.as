package system.terminals
{
    
    /**
    * An InteractiveConsole can read/write to an output.
    * 
    * <p>
    * The output can very depending on the context
    * <li>
    * <ul>in Flash IDE or Flex Builder you will only be able to write and not read</ul>
    * <ul>in a GUI output (based on Sprite/MovieClip/TextField/etc.) you will be able to write/read</ul>
    * <ul>with redtamarin you will be able to write and read</ul>
    * </li>
    * </p>
    */
    public interface InteractiveConsole
    {
        /**
        * Returns the last char.
        */
        function read():String;
        
        /**
        * Returns the last line.
        */
        function readLine():String;
        
        /**
        * Appends the message format.
        */
        function write( ...messages ):void;
        
        /**
        * Appends the message format and add a newline character.
        */
        function writeLine( ...messages ):void;
    }
}