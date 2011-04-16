package flash.errors
{
    /**
     * The ScriptTimeoutError exception is thrown when the script timeout interval is reached.
     * The script timeout interval is 15 seconds.
     * 
     * @langversion ActionScript 3.0
     * @playerversion Flash Player 9
     * @playerversion AIR 1.0
     */
    public dynamic class ScriptTimeoutError extends Error
    {
        prototype.name = "ScriptTimeoutError";
        
        public function ScriptTimeoutError( message:String = "" )
        {
            CFG::dbg{ trace( "new ScriptTimeoutError( " + message + " )" ); }
            super( message );
            this.name = prototype.name;
        }
    }
}