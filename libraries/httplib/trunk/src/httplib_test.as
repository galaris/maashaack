
include "httplib.as";

import library.http.StatusCode;

trace( int(StatusCode.shouldContinue) + " - " + StatusCode.shouldContinue );
trace( int(StatusCode.OK) + " - " + StatusCode.OK );
trace( int(StatusCode.notFound) + " - " + StatusCode.notFound );
trace( int(StatusCode.internalServerError) + " - " + StatusCode.internalServerError );
trace( "--" );
trace( "isInformational: " + StatusCode.isInformational( StatusCode.shouldContinue ) );
trace( "isInformational: " + StatusCode.isInformational( StatusCode.switchingProtocols ) );
trace( "isSuccess: " + StatusCode.isSuccess( StatusCode.OK ) );
trace( "isClientError: " + StatusCode.isClientError( StatusCode.notFound ) );
trace( "isServerError: " + StatusCode.isServerError( StatusCode.internalServerError ) );
trace( "" );
trace( "" );

