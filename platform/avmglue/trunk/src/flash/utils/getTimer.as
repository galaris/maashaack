package flash.utils
{
    import avmplus.System;
    
    public var getTimer:Function = function():int
    {
        CFG::dbg{ trace( "getTimer()" ); }
        return System.getTimer();
    }
}