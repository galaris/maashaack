package flash.errors
{
    /**
     * ActionScript throws a StackOverflowError exception when the stack available to the script is exhausted.
     * ActionScript uses a stack to store information about each method call made in a script,
     * such as the local variables that the method uses.
     * The amount of stack space available varies from system to system.
     * 
     * @langversion ActionScript 3.0
     * @playerversion Flash Player 9
     * @playerversion AIR 1.0
     */
    public dynamic class StackOverflowError extends Error
    {
        prototype.name = "StackOverflowError";
        
        public function StackOverflowError( message:String = "" )
        {
            CFG::dbg{ trace( "new StackOverflowError( " + message + " )" ); }
            super( message );
            this.name = prototype.name;
        }
    }
}