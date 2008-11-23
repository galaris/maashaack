
//import system.*;

trace( "hello world" );

//system.config.serializer.prettyPrinting = true;
//system.about( true, true );

import flash.system.Capabilities;

trace( Capabilities.playerType );

import C.stdlib.getenv;

trace( getenv( "HOME" ) );

