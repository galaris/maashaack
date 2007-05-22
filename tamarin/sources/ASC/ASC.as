
package
    {
    
    import avmplus.System;
    
    var cmdline = "java -jar asc.jar";
    
    if( System.argv.length > 0 )
        {
        cmdline += " " + System.argv.join( " " );
        }
    
    System.exec( cmdline );
    
    }

