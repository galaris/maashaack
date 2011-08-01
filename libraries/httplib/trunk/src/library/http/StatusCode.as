package library.http
{
    /* 
       The Status-Code element is a 3-digit integer result code of the
       attempt to understand and satisfy the request.
       
       see:
       http://www.faqs.org/rfcs/rfc1945.html
       http://www.faqs.org/rfcs/rfc2616.html
       http://www.iana.org/assignments/http-status-codes
    */
    public class StatusCode
    {
        private var _name:String;
        private var _value:int;
        
        public function StatusCode( value:int = 0 , name:String = "" )
        {
            _value = value;
            _name = name;
        }
        
        public function toString():String { return _name; }
        
        public function valueOf():int { return _value; }
        
        private static function _inRange( statuscode:StatusCode, a:int, b:int ):Boolean
        {
            var value:int = statuscode.valueOf();
            if( (value >= a) && (value < b) ) { return true; }
            return false;
        } 
        
        public static function isInformational( statuscode:StatusCode ):Boolean { return _inRange( statuscode, 100, 200 ); }
        public static function isSuccess( statuscode:StatusCode ):Boolean       { return _inRange( statuscode, 200, 300 ); }
        public static function isRedirection( statuscode:StatusCode ):Boolean   { return _inRange( statuscode, 300, 400 ); }
        public static function isClientError( statuscode:StatusCode ):Boolean   { return _inRange( statuscode, 400, 500 ); }
        public static function isServerError( statuscode:StatusCode ):Boolean   { return _inRange( statuscode, 500, 600 ); }
        
        
        public static const shouldContinue:StatusCode               = new StatusCode( 100, "Continue" );
        public static const switchingProtocols:StatusCode           = new StatusCode( 101, "Switching Protocols" );
        public static const processing:StatusCode                   = new StatusCode( 102, "Processing" );
        
        public static const OK:StatusCode                           = new StatusCode( 200, "OK" );
        public static const created:StatusCode                      = new StatusCode( 201, "Created" );
        public static const accepted:StatusCode                     = new StatusCode( 202, "Accepted" );
        public static const nonAuthoritativeInformation:StatusCode  = new StatusCode( 203, "Non-Authoritative Information" );
        public static const noContent:StatusCode                    = new StatusCode( 204, "No Content" );
        public static const resetContent:StatusCode                 = new StatusCode( 205, "Reset Content" );
        public static const partialContent:StatusCode               = new StatusCode( 206, "Partial Content" );
        public static const multiStatus:StatusCode                  = new StatusCode( 207, "Multi-Status" );
        public static const alreadyReported:StatusCode              = new StatusCode( 208, "Already Reported" );
        public static const IMUsed:StatusCode                       = new StatusCode( 226, "IM Used" );
        
        public static const multipleChoices:StatusCode              = new StatusCode( 300, "Multiple Choices" );
        public static const movedPermanently:StatusCode             = new StatusCode( 301, "Moved Permanently" );
        public static const found:StatusCode                        = new StatusCode( 302, "Found" );
        public static const seeOther:StatusCode                     = new StatusCode( 303, "See Other" );
        public static const notModified:StatusCode                  = new StatusCode( 304, "Not Modified" );
        public static const useProxy:StatusCode                     = new StatusCode( 305, "Use Proxy" );
        public static const reserved:StatusCode                     = new StatusCode( 306, "Reserved" );
        public static const temporaryRedirect:StatusCode            = new StatusCode( 307, "Temporary Redirect" );
        
        public static const badRequest:StatusCode                   = new StatusCode( 400, "Bad Request" );
        public static const unauthorized:StatusCode                 = new StatusCode( 401, "Unauthorized" );
        public static const paymentRequired:StatusCode              = new StatusCode( 402, "Payment Required" );
        public static const forbidden:StatusCode                    = new StatusCode( 403, "Forbidden" );
        public static const notFound:StatusCode                     = new StatusCode( 404, "Not Found" );
        public static const methodNotAllowed:StatusCode             = new StatusCode( 405, "Method Not Allowed" );
        public static const notAcceptable:StatusCode                = new StatusCode( 406, "Not Acceptable" );
        public static const proxyAuthenticationRequired:StatusCode  = new StatusCode( 407, "Proxy Authentication Required" );
        public static const requestTimeout:StatusCode               = new StatusCode( 408, "Request Timeout" );
        public static const conflict:StatusCode                     = new StatusCode( 409, "Conflict" );
        public static const gone:StatusCode                         = new StatusCode( 410, "Gone" );
        public static const lengthRequired:StatusCode               = new StatusCode( 411, "Length Required" );
        public static const preconditionFailed:StatusCode           = new StatusCode( 412, "Precondition Failed" );
        public static const requestEntityTooLarge:StatusCode        = new StatusCode( 413, "Request Entity Too Large" );
        public static const requestURITooLong:StatusCode            = new StatusCode( 414, "Request-URI Too Long" );
        public static const unsupportedMediaType:StatusCode         = new StatusCode( 415, "Unsupported Media Type" );
        public static const requestedRangeNotSatisfiable:StatusCode = new StatusCode( 416, "Requested Range Not Satisfiable" );
        public static const expectationFailed:StatusCode            = new StatusCode( 417, "Expectation Failed" );
        public static const unprocessableEntity:StatusCode          = new StatusCode( 422, "Unprocessable Entity" );
        public static const locked:StatusCode                       = new StatusCode( 423, "Locked" );
        public static const failedDependency:StatusCode             = new StatusCode( 424, "Failed Dependency" );
        public static const reservedForWebDAVadvanced:StatusCode    = new StatusCode( 425, "Reserved for WebDAV advanced" );
        public static const upgradeRequired:StatusCode              = new StatusCode( 426, "Upgrade Required" );
        
        public static const internalServerError:StatusCode          = new StatusCode( 500, "Internal Server Error" );
        public static const notImplemented:StatusCode               = new StatusCode( 501, "Not Implemented" );
        public static const badGateway:StatusCode                   = new StatusCode( 502, "Bad Gateway" );
        public static const serviceUnavailable:StatusCode           = new StatusCode( 503, "Service Unavailable" );
        public static const gatewayTimeout:StatusCode               = new StatusCode( 504, "Gateway Timeout" );
        public static const HTTPVersionNotSupported:StatusCode      = new StatusCode( 505, "HTTP Version Not Supported" );
        public static const variantAlsoNegotiates:StatusCode        = new StatusCode( 506, "Variant Also Negotiates" );
        public static const insufficientStorage:StatusCode          = new StatusCode( 507, "Insufficient Storage" );
        public static const loopDetected:StatusCode                 = new StatusCode( 508, "Loop Detected" );
        public static const unassigned:StatusCode                   = new StatusCode( 509, "Unassigned" );
        public static const notExtended:StatusCode                  = new StatusCode( 510, "Not Extended" );
    }
}