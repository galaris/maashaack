
import system.*;

trace( "hello world" );

//system.config.serializer.prettyPrinting = true;
//system.about( true, true );

import flash.system.Capabilities;

trace( Capabilities.playerType );

import C.stdlib.getenv;

trace( getenv( "HOME" ) );

var obj:* = Capabilities;
var name:String = Reflection.getClassName( obj, true );
var cp:String = Reflection.getClassPath( obj );
trace( "name = " + name );
trace( "class path: " + cp );

import system.eden;

var o:Object = {a:1, b:2}

eden.prettyPrinting = true;

trace( eden.serialize( o ) );


