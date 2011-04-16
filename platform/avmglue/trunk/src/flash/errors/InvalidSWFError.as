package flash.errors
{
    /**
     * The Flash runtimes throw this exception when they encounter a corrupted SWF file.
     * 
     * @langversion ActionScript 3.0
     * @playerversion Flash Player 9
     * @playerversion AIR 1.0
     */
    public dynamic class InvalidSWFError extends Error
    {
        prototype.name = "InvalidSWFError";
        
        public function InvalidSWFError( message:String = "", id:int = 0 )
        {
            CFG::dbg{ trace( "new InvalidSWFError( " + message + " )" ); }
            super( message, id );
            this.name = prototype.name;
        }
    }
}