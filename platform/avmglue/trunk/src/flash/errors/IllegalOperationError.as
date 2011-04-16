package flash.errors
{
    /**
     * The IllegalOperationError exception is thrown when a method is not implemented
     * or the implementation doesn't cover the current usage.
     * 
     * @langversion ActionScript 3.0
     * @playerversion Flash Player 9
     * @playerversion AIR 1.0
     */
    public dynamic class IllegalOperationError extends Error
    {
        prototype.name = "IllegalOperationError";
        
        public function IllegalOperationError( message:String = "" )
        {
            CFG::dbg{ trace( "new IllegalOperationError( " + message + " )" ); }
            super( message );
            this.name = prototype.name;
        }
    }
}