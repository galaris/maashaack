/*
  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at
  http://www.mozilla.org/MPL/
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the
  License.
  
  The Original Code is [maashaack framework].
  
  The Initial Developers of the Original Code are
  Zwetan Kjukov <zwetan@gmail.com> and Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developers are Copyright (C) 2006-2011
  the Initial Developers. All Rights Reserved.
  
  Contributor(s):
  
  Alternatively, the contents of this file may be used under the terms of
  either the GNU General Public License Version 2 or later (the "GPL"), or
  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
  in which case the provisions of the GPL or the LGPL are applicable instead
  of those above. If you wish to allow use of your version of this file only
  under the terms of either the GPL or the LGPL, and not to allow others to
  use your version of this file under the terms of the MPL, indicate your
  decision by deleting the provisions above and replace them with the notice
  and other provisions required by the LGPL or the GPL. If you do not delete
  the provisions above, a recipient may use your version of this file under
  the terms of any one of the MPL, the GPL or the LGPL.
*/

package system
{
    import core.strings.endsWith;
    import core.strings.startsWith;
    import core.strings.trimStart;
    
    import system.data.Iterator;
    import system.data.Map;
    import system.data.maps.ArrayMap;
    import system.network.URIScheme;
    
    /**
     * The "Uniform Resource Identifier" class.
     * <p><b>note:</b></p>
     * <p>based on <a href="http://www.ietf.org/rfc/rfc3986.txt">RFC 3986</a></p>
     * <p><b>examples of valid URIs :</b></p>
     * <pre>
     * ftp://ftp.is.co.za/rfc/rfc1808.txt
     * http://www.ietf.org/rfc/rfc2396.txt
     * ldap://[2001:db8::7]/c=GB?objectClass?one
     * mailto:John.Doe&#64;example.com
     * news:comp.infosystems.www.servers.unix
     * tel:+1-816-555-1212
     * telnet://192.0.2.16:80/
     * urn:oasis:names:specification:docbook:dtd:xml:4.1.2
     * </pre>
     */
    public class URI
    {
        /**
         * Creates a new URI instance.
         * @param any An URI object or a String expression to initialize the instance.
         * @param relativeURI The relative URI reference.
         */
        public function URI( any:* , relativeURI:String = "" )
        {
            if( any is String )
            {
                _source = any;
            }
            else if( any is URI )
            {
                _source = (any as URI).source ;
            }
            if( _source )
            {
                _parse( _source ) ;
            }
        }
        
        /**
         * Allows to alter the tring representation of the URI
         * ex:
         * for a raw URI "http://www.domain.com/path/file.html?"
         * after parsing
         * 
         * if greedy render as
         * "http://www.domain.com/path/file.html"
         * 
         * if not greedy render as
         * "http://www.domain.com/path/file.html?"
         */
        public static var greedy:Boolean ;
        
        /**
         * Allows to support deprecated behaviour or not
         * <p>ex: with userinfo</p>
         * <li>if strict, we do not display the password</li>
         * <li>if not strict we display the password</li>
         */
        public static var strict:Boolean = true;
        
        /**
         * Indicates the authority of the URI.
         * syntax:
         * <pre>authority = [ userinfo "&#64;" ] host [ ":" port ]</pre>
         */
        public function get authority():String
        {
            var str:String = "";
            
            if( userinfo )
            {
                str += userinfo + "@";
            }
            
            str += host;
            
            if( (host != "") && (port > -1) )
            {
                str += ":" + port;
            }
            
            return str;
        }
        
        /**
         * Indicates the fragment expression of the URI.
         */
        public function get fragment():String
        {
            return _fragment;
        }
        
        /**
         * Determinaes the host of the URI.
         */
        public function get host():String
        {
            return _host;
        }
        
        /**
         * @private
         */
        public function set host( value:String ):void
        {
            _host = value;
        }
        
        /**
         * Determinates the path of the URI.
         */
        public function get path():String
        {
            return _path;
        }
        
        /**
         * @private
         */
        public function set path( value:String ):void
        {
            _path = value;
        }
        
        /**
         * Determinates the port of the URI.
         */
        public function get port():int
        {
            return _port;
        }
        
        /**
         * @private
         */
        public function set port( value:int ):void
        {
            if( isValidPort( value ) )
            {
                _port = value;
            }
            else
            {
                throw new RangeError( "\""+value+"\" port is out of range" );
            }
        }
        
        /**
         * Determinates the encoded URI query, not including the ?.
         * You can set a query with a string who not including the ? character, ex : "a=1&#38;b=2".
         */
        public function get query():String
        {
            if ( _queryChange )
            {
                _resolveQuery() ;
            }
            return _query ;
        }
        
        /**
         * @private
         */
        public function set query( source:String ):void
        {
            _parseQuery( source ) ;
        }
        
        /**
         * Determinates the scheme of the URI.
         */
        public function get scheme():String
        {
            return _scheme ;
        }
        
        /**
         * @private
         */
        public function set scheme( value:String ):void
        {
            if( isValidScheme( value ) )
            {
                _scheme = value;
            }
            else
            {
                throw new SyntaxError( "\""+value+"\" is not a valid scheme" );
            }
        }
        
        /**
         * Original string source of the URI
         */
        public function get source():String
        {
            return _source ;
        }
        
        /**
         * Indicates the user info expression of the URI.
         */
        public function get userinfo():String
        {
            if( !_username )
            {
                return "";
            }
            var str:String = "" ;
            str += _username;
            if( !strict )
            {
                str += ":" + _password;
            }
            return str;
        }
        
        /**
         * Returns the first value for a given cgi parameter or undefined if the given parameter name does not appear in the query string.
         * @param name The parameter to get values for.
         * @return the first value for a given cgi parameter or undefined if the given parameter name does not appear in the query string.
         */
        public function getParameter( name:String ):*
        {
            return _queries.get( name ) ;
        }
        
        /**
         * Indicates the Map used in the URI to set the parameters of the query.
         */
        public function getQueryMap():Map
        {
            return _queries as Map ;
        }
        
        /**
         * Indicates whether the fragment string has been set.
         */
        public function hasFragment():Boolean
        {
            return _hasFragment;
        }
        
        /**
         * Indicates whether the specified parameter name exist in the query.
         */
        public function hasParameter( name:String ):Boolean
        {
            return _queries.containsKey( name ) ;
        }
        
        /**
         *  Indicates whether the query string has been set.
         */
        public function hasQuery():Boolean
        {
            return _hasQuery ;
        }
        
        /**
         * Indicates if the specified host expression is valid (ipv4 or domain address).
         */
        public static function isValidHost( str:String ):Boolean
        {
            if( isIPv4Address( str ) )
            {
                return true;
            }
            if( isDomainAddress( str ) )
            {
                return true;
            }
            return false;
        }
        
        /**
         * Indicates if the specified port is valid.
         */
        public static function isValidPort( num:int ):Boolean
        {
            if( (num >= 0) && (num <= 0xffff) )
            {
                return true;
            }
            return false;
        }
        
        /**
         * Indicates if the scheme of the uri is valid.
         * <p>RFC: <b>3.1. Scheme</b></p>
         * <p>[...]</p>
         * <pre>
         * Scheme names consist of a sequence of characters beginning with a 
         * letter and followed by any combination of letters, digits, plus
         * ("+"), period ("."), or hyphen ("-").  Although schemes are case-
         * insensitive, the canonical form is lowercase and documents that
         * specify schemes must do so with lowercase letters. An implementation
         * should accept uppercase letters as equivalent to lowercase in scheme
         * names (e.g., allow "HTTP" as well as "http") for the sake of
         * robustness but should only produce lowercase scheme names for consistency.
         * </pre>
         * <pre>scheme = ALPHA *( ALPHA / DIGIT / "+" / "-" / "." )</pre>
         */
        public static function isValidScheme( str:String ):Boolean
        {
            if( (str == null) || (str.length == 0) )
            {
                return false;
            }
            
            if( !Char.isLetter( str, 0 ) )
            {
                return false;
            }
            
            var l:int = str.length;
            
            for( var i:int = 1; i<l; i++ )
            {
                if( !Char.isLetterOrDigit( str, i ) && !Char.isContained( str, i, ".+-" ) )
                {
                    return false;
                }
            }
            
            return true;
        }
        
        /**
         * 
         * syntax:
         *       IPv4address = dec-octet "." dec-octet "." dec-octet "." dec-octet
         * 
         *       dec-octet   = DIGIT                 ; 0-9
         *                   / %x31-39 DIGIT         ; 10-99
         *                   / "1" 2DIGIT            ; 100-199
         *                   / "2" %x30-34 DIGIT     ; 200-249
         *                   / "25" %x30-35          ; 250-255
         */
        public static function isIPv4Address( str:String ):Boolean
        {
            var address:Array = str.split( "." );
            
            if( address.length != 4 )
            {
                return false;
            }
            
            var num:int;
            var block:String;
            var i:int;
            var j:int;
            for( i = 0; i<address.length; i++ )
            {
                block = address[i];
                
                for( j = 0; j<block.length; j++ )
                {
                    if( !Char.isDigit( block, j ) )
                    {
                        return false;
                    }
                }
                
                num = parseInt( block );
                
                if( (num < 0) || (num > 255) )
                {
                    return false;
                }
                
            }
            
            return true;
        }
        
         /**
          * Indicates if the uri is a domain address
          * <p><b>note:</b></p>
          * <p>see: <a href="http://www.ietf.org/rfc/rfc1034.txt">http://www.ietf.org/rfc/rfc1034.txt</a></p>
          * <p>3.5. Preferred name syntax</p>
          * <pre>[...]</pre>
          * <p>The following syntax will result in fewer problems with many 
          * applications that use domain names (e.g., mail, TELNET).</p>
          * <pre>
          * &lt;domain> ::= &lt;subdomain&gt; | " "
          * 
          * &lt;subdomain&gt; ::= &lt;label&gt; | &lt;subdomain&gt; "." &lt;label&gt;
          * 
          * &lt;label&gt; ::= &lt;letter&gt; [ [ &lt;ldh-str&gt; ] &lt;let-dig&gt; ]
          * 
          * &lt;ldh-str&gt; ::= &lt;let-dig-hyp&gt; | &lt;let-dig-hyp&gt; &lt;ldh-str&gt;
          * 
          * &lt;let-dig-hyp&gt; ::= &lt;let-dig&gt; | "-"
          * 
          * &lt;let-dig&gt; ::= &lt;letter&gt; | &lt;digit&gt;
          * 
          * &lt;letter&gt; ::= any one of the 52 alphabetic characters A through Z in upper case and a through z in lower case
          * 
          * &lt;digit&gt; ::= any one of the ten digits 0 through 9
          * 
          * </pre>
          * 
          * <p>Note that while upper and lower case letters are allowed in domain 
          * names, no significance is attached to the case.That is, two names with 
          * the same spelling but different case are to be treated as if identical.</p>
          * 
          * <p>The labels must follow the rules for ARPANET host names.  They must 
          * start with a letter, end with a letter or digit, and have as interior 
          * characters only letters, digits, and hyphen.  There are also some 
          * restrictions on the length.  Labels must be 63 characters or less.</p>
          */
        public static function isDomainAddress( str:String ):Boolean
        {
            if( str.indexOf( "." ) == -1 )
            {
                return false;
            }
            
            var subdomains:Array = str.split( "." );
            
            var i:int;
            var j:int;
            var subdomain:String;
            for( i=0; i<subdomains.length; i++ )
            {
                subdomain = subdomains[i];
                
                if( (subdomain.length == 0) || (subdomain.length > 63) )
                {
                    return false;
                }
                
                if( !Char.isLetter( subdomain, 0 ) ||
                    !Char.isLetterOrDigit( subdomain, subdomain.length-1 ) )
                {
                    return false;
                }
                
                for( j=1; j<subdomain.length-1; j++ )
                {
                    if( !Char.isLetterOrDigit( subdomain, j ) &&
                        !Char.isContained( subdomain, j, "-_" ) )
                    {
                        return false;
                    }
                }
            }
            
            return true;
        }
        
        /**
         * Indicates if the URI is UNC.
         */
        public function isUNC():Boolean
        {
            return _UNC;
        }
        
        /**
         * Removes all the parameters in the query.
         */
        public function removeAllParameters():void
        {
            if ( _queries.size() > 0 )
            {
                _queryChange = true ,
                _queries.clear() ;
            }
        }
        
        /**
         * Removes the named query parameter.
         * @param name The parameter to remove.
         */
        public function removeParameter( name:String ):void
        {
            _queryChange = true ,
            _queries.remove( name ) ;
        }
        
        /**
         * Sets the values of the named query parameters, clearing previous values for that key. Not new values will currently be moved to the end of the query string.
         * @param name The parameter to set.
         * @param value The new value.
         */
        public function setParameterValue( name:String , value:* ):void
        {
            _queryChange = true ;
            if ( value === undefined && _queries.containsKey(name) )
            {
                _queries.remove( name ) ;
            }
            else
            { 
                _queries.put( name , value ) ;
            }
        }
        
        /**
         * Returns the String representation of the object.
         * @return the String representation of the object.
         */
        public function toString():String
        {
            var str:String = "";
            
            if( scheme )
            {
                str += scheme + ":";
            }
            
            if( authority )
            {
                str += "//" + authority;
            }
            
            if( (authority == "") &&
                (scheme == URIScheme.FILE.scheme) )
            {
                str += "//";
            }
            
            str += path;
            
            if( (!greedy && _hasQuery) || query )
            {
                str += "?" + query;
            }
            
            if( (!greedy && _hasFragment) || fragment )
            {
                str += "#" + fragment;
            }
            
            return str;
        }
        
        /**
         * Returns the primitive value of the object.
         * @return the primivite value of the object.
         */
        public function valueOf():String
        {
            return toString();
        }
        
        /////////////////////////////////////////////////
        
//        private var _generalDelimiters:String = ":/?#[]@";
//        private var _opaque:Boolean       ;
//        private var _relative:Boolean     ;
//        private var _reserved:String          = _generalDelimiters+_subDelimiters;
//        private var _subDelimiters:String     = "!$&'()*+,;=";
//        private var _unreserved:String        = "-._~";
        
        private var _backslash:RegExp = /\\/g ;
        private var _fragment:String = "" ;
        private var _hasFragment:Boolean ;
        private var _hasQuery:Boolean ;
        private var _host:String     = "" ;
        private var _username:String = "" ;
        private var _password:String = "" ;
        private var _path:String     = "" ;
        private var _port:int        = -1 ;
        
        /**
         * The Map of all parameters to set the query. We use an ArrayMap to keep the order of the parameters.
         * @private
         */
        private var _queries:ArrayMap = new ArrayMap() ;
        
        /**
         * The full query string without the ? character.
         */
        private var _query:String = "" ;
        
        /**
         * Indicates if the query must change.
         */
        private var _queryChange:Boolean ;
        
        private var _scheme:String   = "" ;
        private var _source:String = "";
        private var _UNC:Boolean          ;
        private var _unixFilePath:Boolean ;
        
        /**
         * @private
         */
        private function _parseUnixAbsoluteFilePath( str:String ):void
        {
            _unixFilePath = true;
            
            this.scheme = URIScheme.FILE.scheme;
            _port     = -1;
            _fragment = "";
            _query    = "";
            _host     = "";
            _path     = "";
            
            if( startsWith( str, "//" ) )
            {
                str = trimStart( str, ["/"] );
                _path = "/"+str;
            }
            
            if( !_path )
            {
                _path = str;
            }
            
        }
        
        /**
         * @private
         */
        private function _parseWindowsAbsoluteFilePath( str:String ):void
        {
            if( str.length > 2 && str.charAt(2) != "\\" && str.charAt(2) != "/" )
            {
                throw new SyntaxError( "Relative file path is not allowed." );
            }
            this.scheme = URIScheme.FILE.scheme;
            _port     = -1 ;
            _fragment = "" ;
            _query    = "" ;
            _host     = "" ;
            _path     = "/"+str.replace( _backslash , "/" );
        }
        
        /**
         * @private
         */
        private function _parseWindowsUNC( str:String ):void
        {
            _UNC = true;
            
            this.scheme = URIScheme.FILE.scheme;
            _port     = -1 ;
            _fragment = "" ;
            _query    = "" ;
            
            str = trimStart( str, ["\\"] );
            var pos:int = str.indexOf( "\\" );
            
            if( pos > 0 )
            {
                _path = str.substring( pos );
                _host = str.substring( 0, pos );
            }
            else
            {
                _host = str;
                _path = "";
            }
            
            _path = _path.replace( _backslash, "/" );
        }
        
        /**
         * @private
         */
        private function _parse( str:String ):void
        {
            var pos:int = str.indexOf( ":" );
            if( pos < 0 )
            {
                if( str.charAt( 0 ) == "/" )
                {
                    _parseUnixAbsoluteFilePath( str );
                }
                else if( Strings.startsWith( str, "\\\\" ) )
                {
                    _parseWindowsUNC( str );
                }
                else
                {
                    throw new SyntaxError( "URI scheme was not recognized, nor input string is not recognized as an absolute file path." );
                }
                
                return;
            }
            else if( pos == 1 )
            {
                if( !Char.isLetter( str, 0 ) )
                {
                    throw new SyntaxError( "URI scheme must start with alphabet character." );
                }
                _parseWindowsAbsoluteFilePath( str );
                return ;
            }
            
            /* from RFC
                 ^(([^:/?#]+):)?(//([^/?#]*))?([^?#]*)(\?([^#]*))?(#(.*))?
            */
            var pattern:RegExp = new RegExp( "^(([^:/?#]+):)?(//([^/?#]*))?([^?#]*)([\?]([^#]*))?(#(.*))?" , null );
            var results:Object = pattern.exec( str ) ;
            
//            trace( "$1: " + results[1] ); //raw scheme
//            trace( "$2: " + results[2] ); //scheme
//            trace( "$3: " + results[3] ); //raw authority
//            trace( "$4: " + results[4] ); //authority
//            trace( "$5: " + results[5] ); //path
//            trace( "$6: " + results[6] ); //raw query
//            trace( "$7: " + results[7] ); //query
//            trace( "$8: " + results[8] ); //raw fragment
//            trace( "$9: " + results[9] ); //fragment
            
            /////// scheme
            
            if( results[1] && results[2] && endsWith( results[1], ":" ) )
            {
                this.scheme = results[2];
            }
//            else
//            {
//                throw new SyntaxError( "URI scheme must end with \":\"" );
//            }
            
            
            /////// authority
            if( results[3] && startsWith( results[3], "//" ) )
            {
                var authority:String = results[4];
                var host:String = "";
                
                //userinfo
                if( authority.indexOf( "@" ) > -1 )
                {
                    var userinfos:String = authority.split( "@" )[0];
                    host = authority.split( "@" )[1];
                    
                    if( userinfos.indexOf( ":" ) != -1 )
                    {
                        _username = userinfos.split( ":" )[0];
                        
                        if( !strict )
                        {
                            _password = userinfos.split( ":" )[1];
                        }
                    }
                    else
                    {
                        _username = userinfos;
                    }
                    
                }
                else
                {
                    host = authority;
                }
                
                /////// port
                if( host.indexOf( ":" ) > -1 )
                {
                    var port:String = host.split( ":" )[1];
                    var i:int;
                    var validPort:Boolean = true;
                    
                    for( i=0; i<port.length; i++ )
                    {
                        if( !Char.isDigit( port, i ) )
                        {
                            validPort = false;
                        }
                    }
                    
                    if( validPort )
                    {
                        host = host.split( ":" )[0];
                        if( port && (port.length > 0) )
                        {
                            this.port = parseInt( port );
                        }
                    }
                    
                }
                
                this.host = host;
            }
//            else
//            {
//                throw new SyntaxError( "URI authority must start with \"//\"" );
//            }
            
            // path
            if( results[5] )
            {
                this.path = results[5];
            }
            
            // query
            if( results[6] && startsWith( results[6], "?" ) )
            {
                _parseQuery( results[7] as String ) ;
            }
            
            // fragment
            
            if( results[8] && startsWith( results[8], "#" ) )
            {
                _fragment = results[9];
                _hasFragment = true;
            }
            
        }
        
        /**
         * @private
         */
        private function _parseQuery( query:String ):void
        {
            _queries.clear() ;
            _queryChange = true  ;
            _hasQuery    = false ;
            if( query && query.length > 0 )
            {
                var p:Array ;
                var q:Array = query.split( "&" ) ;
                for each( var param:String in q )
                {
                    p = param.split( "=" ) ;
                    if ( p.length == 2 )
                    {
                        _queries.put( p[0] as String , p[1] as String ) ;
                    }
                }
                _hasQuery = _queries.size() > 0 ;
            }
            _resolveQuery() ;
        }
        
        /**
         * @private
         */
        private function _resolveQuery():void
        {
            _queryChange = false ;
            _query       = "" ;
            var l:int    = _queries.size() ;
            _hasQuery = l > 0 ;
            if ( _hasQuery )
            {
                var v:* ;
                var k:String ;
                var it:Iterator = _queries.iterator() ;
                while( it.hasNext() )
                {
                    v = it.next() ;
                    k = it.key() ;
                    _query += k + "=" + v ;
                    if ( it.hasNext() )
                    {
                        _query += "&" ;
                    }
                }
            }
        }
    }
}