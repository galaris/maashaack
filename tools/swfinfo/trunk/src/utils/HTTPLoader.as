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
  
  The Original Code is [swfinfo].
  
  The Initial Developers of the Original Code are
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developers are Copyright (C) 2011
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

package utils
{
    import C.string.strerror;
    
    import avmplus.Socket;
    import avmplus.System;
    
    import core.uri;
    
    import flash.utils.ByteArray;
    
    public class HTTPLoader
    {
        private var _url:String;
        private var _sock:Socket;
        private var _response:ByteArray;
        
        private var _header:String;
        private var _body:ByteArray;
        
        public function HTTPLoader( url:String = "" )
        {
            _url = url;
        }
        
        private function _HTTP_1_1_GET( host:String, port:uint, path:String ):void
        {
            //trace( "host= " + host, ", port= " + port + ", path= " + path );
            Socket.prototype.record = Socket.prototype.recordLogOnly;
            _sock = new Socket();
            _sock.connect( host, port );
            
            if( _sock.valid && _sock.connected )
            {
                var request:String = "";
                request += "GET " + path + " HTTP/1.1\r\n";
                request += "Host: " + host + ":" + port + "\r\n";
                request += "\r\n";
                
                _sock.send( request );
                _response = _sock.receiveBinaryAll();
                _response.position = 0;
                _sock.close();
                _sock = null;
            }
            else
            {
                throw new Error( "Could not connect to host \"" + host + "\" on port " + port + ", reason: " + strerror( Socket.lastError ) );
            }
        }
        
        private function _readLineFrom( data:ByteArray ):String
        {
            if( data.bytesAvailable == 0 ) { return null; }
            
            var start:uint = data.position;
            var bytes:ByteArray = new ByteArray();
            var found:Boolean = false;

            var char:int;
            while( data.bytesAvailable > 0 )
            {
                char = data.readByte();
                bytes.writeByte( char );

                if( char == 10 )
                {
                    found = true;
                    break;
                }
            }

            var line:String = null;
            if( found )
            {
                bytes.position = 0;
                line = bytes.readUTFBytes( bytes.length );
            }
            return line;
        }
        
        public function load( url:String = "" ):void
        {
            if( url != "" ) { _url = url; }
            
            var u:uri = new uri( _url );
            
            if( u.toString() == "" )
            {
                throw new Error( "Malformed URL \"" + url + "\"." );
            }
            
            if( u.scheme != "http" )
            {
                throw new Error( "HTTPLoader only support the HTTP protocol." );
            }
            u.port = 80;
            
            _HTTP_1_1_GET( u.host, u.port, u.path );
            
            _header = "";
            _body   = new ByteArray();
            
            var line:String;
            while( line != "\r\n" )
            {
                line = _readLineFrom( _response );
                _header += line;
            }
            
            _response.readBytes( _body );
            
            var lines:Array = _header.split( "\r\n" );
            if( lines[0].indexOf( "404" ) > -1 )
            {
                throw new Error( "HTTPLoader returned 404." );
            }
        }
        
        public function get header():String { return _header; }
        
        public function get body():ByteArray { return _body; }

    }
}