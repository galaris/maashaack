
package system
    {
    import system.Version;
    
    /* Function: info
       basic system info
    */
    public function info( verbose:Boolean = false, showConfig:Boolean = false ):void
        {
        var separator:String = "----------------------------------------------------------------";
        var CRLF:String      = "\n";
        var name:String      = "ES4a";
        var fullname:String  = "ECMAScript 4 MaasHaack framework";
        var version:Version  = new Version( 0, 1 );
            version.revision = parseInt( "$Rev$".split( " " )[1] );
        
        var str:String = "";
            if( !verbose && config.verbose )
                {
                verbose = true;
                }
            
            if( verbose ) {
            str += "{sep}{crlf}";
            str += "{name}: {fullname} v{version}{crlf}";
            str += "Host: {host}{isdebug}{crlf}";
            str += "Operating System: {os}{crlf}";
            str += "{sep}";
            } else {
            str += "{name} v{version}"; }
            
            if( showConfig ) {
            str += "{crlf}config:";
            str += "{config}{crlf}";
            str += "{sep}";
            }
            
        Console.writeLine( str,
                           {
                           sep:separator,
                           crlf:CRLF,
                           name:name,
                           fullname:fullname,
                           version:version,
                           host: Environment.host,
                           isdebug: Environment.host.isDebug() ? " (debug)": "",
                           os: Environment.os/*,
                           config: Serializer.serialize( config )*/
                           }
                         );
        }
    
    }

