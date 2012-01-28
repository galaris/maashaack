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
  Portions created by the Initial Developers are Copyright (C) 2006-2012
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

package core
{
    /**
     * The core uri class.
     * 
     * note:
     * - no external dependencies
     * - this is a non-validating parser
     *   for ex, we don;t validate a scheme
     * - this is a non-blocking parser,
     *   we don't throw errors
     * 
     */
    public class uri
    {
        private var _source:String = "";
        
        private var _scheme:String   = "" ;
        private var _host:String     = "" ;
        private var _username:String = "" ;
        private var _password:String = "" ;
        private var _port:int        = -1 ;
        private var _path:String     = "" ;
        private var _query:String    = "" ;
        private var _fragment:String = "" ;
        
        private function _parseUnixAbsoluteFilePath( str:String ):void
        {
            this.scheme = "file";
            _port     = -1;
            _fragment = "";
            _query    = "";
            _host     = "";
            _path     = "";
            
            if( str.substr( 0, 2 ) == "//" )
            {
                while( str.charAt( 0 ) == "/" )
                {
                    str = str.substr( 1 );
                }
                
                _path = "/"+str;
            }
            
            if( !_path )
            {
                _path = str;
            }
            
        }
        
        private function _parseWindowsAbsoluteFilePath( str:String ):void
        {
            if( str.length > 2 && str.charAt(2) != "\\" && str.charAt(2) != "/" )
            {
                return;
            }
            
            
            this.scheme = "file";
            _port     = -1;
            _fragment = "";
            _query    = "";
            _host     = "";
            _path     = "/" + str.replace( _r , "/" );
        }
        
        private function _parseWindowsUNC( str:String ):void
        {
            this.scheme = "file";
            _port     = -1;
            _fragment = "";
            _query    = "";
            
            while( str.charAt( 0 ) == "\\" )
            {
                str = str.substr( 1 );
            }
            
            
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
            
            _path = _path.replace( _r , "/" );
        }
        
        private function _parse( str:String ):void
        {
            var pos:int = str.indexOf( ":" );
            
            if( pos < 0 )
            {
                if( str.charAt( 0 ) == "/" )
                {
                    _parseUnixAbsoluteFilePath( str );
                }
                else if( str.substr(0,2) == "\\\\" )
                {
                    _parseWindowsUNC( str );
                }
                
                return;
            }
            else if( pos == 1 )
            {
                _parseWindowsAbsoluteFilePath( str );
                
                return;
            }
            
            var p:RegExp = new RegExp( "^(([^:/?#]+):)?(//([^/?#]*))?([^?#]*)([\?]([^#]*))?(#(.*))?" , null );
            var r:Object = p.exec( str );
            
            //scheme
            if( r[1] && r[2] )
            {
                this.scheme = r[2];
            }
            
            //authority
            if( r[3] )
            {
                var authority:String = r[4];
                var host:String = "";
                
                //userinfo
                if( authority.indexOf( "@" ) > -1 )
                {
                    var userinfos:String = authority.split( "@" )[0];
                    host = authority.split( "@" )[1];
                    
                    if( userinfos.indexOf( ":" ) != -1 )
                    {
                        _username = userinfos.split( ":" )[0];
                        _password = userinfos.split( ":" )[1];
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
                
                //port
                if( host.indexOf( ":" ) > -1 )
                {
                    var port:String = host.split( ":" )[1];
                    var i:int;
                    var c:String;
                    var validPort:Boolean = true;
                    
                    for( i=0; i<port.length; i++ )
                    {
                        c = port.charAt( i );
                        if( !(("0" <= c) && (c <= "9")) )
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
            
            //path
            if( r[5] )
            {
                this.path = r[5];
            }
            
            //query
            if( r[6] )
            {
                _query = r[7];
            }
            
            //fragment
            if( r[8] )
            {
                _fragment = r[9];
            }
        }
        
        /**
         * Creates a new uri instance.
         * @param raw The value expression of the uri.
         */
        public function uri( raw:String )
        {
            _source = raw;
            _parse( raw );
        }
        
        /**
         * Indicates authority value of the uri.
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
         * Determinates the fragment value of the uri.
         */
        public function get fragment():String
        {
            return _fragment;
        }
        
        /**
         * @private
         */
        public function set fragment( value:String ):void
        {
            _fragment = value;
        }
        
        /**
         * Determinates the host value of the uri.
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
         * Determinates the path value of the uri.
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
         * Determinates the port value of the uri.
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
            _port = value;
        }
        
        /**
         * Determinates the scheme value of the uri.
         */
        public function get scheme():String
        {
            return _scheme;
        }
        
        /**
         * @private
         */
        public function set scheme( value:String ):void
        {
            _scheme = value;
        }
        
        /**
         * Determinates the source value of the uri.
         */
        public function get source():String
        {
            return _source;
        }
        
        /**
         * Determinates the user info value of the uri.
         */
        public function get userinfo():String
        {
            if( !_username )
            {
                return "";
            }
            var str:String = "" ;
            str += _username;
            str += ":" + _password;
            return str;
        }
        
        /**
         * Determinates the user info value of the uri.
         */   
        public function get query():String
        {
            return _query;
        }
        
        /**
         * @private
         */ 
        public function set query( value:String ):void
        {
            _query = value;
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
                (scheme == "file") )
            {
                str += "//";
            }
            
            str += path;
            
            if( query )
            {
                str += "?" + query;
            }
            if( fragment )
            {
                str += "#" + fragment;
            }
            return str;
        }
        
        /**
         * Returns the primitive value of the object.
         * @return the primitive value of the object.
         */
        public function valueOf():String
        {
            return toString();
        }
        
        /**
         * @private
         */
        private var _r:RegExp = /\\/g ;
    }
}