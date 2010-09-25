/* -*- c-basic-offset: 4; indent-tabs-mode: nil; tab-width: 4 -*- */
/* vi: set ts=4 sw=4 expandtab: (add to ~/.vimrc: set modeline modelines=5) */
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is [Open Source Virtual Machine.].
 *
 * The Initial Developer of the Original Code is
 * Adobe System Incorporated.
 * Portions created by the Initial Developer are Copyright (C) 2004-2006
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *   Zwetan Kjukov <zwetan@gmail.com>.
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

package avmplus
{
    import C.string.*;
    import C.socket.*;
    import C.errno.*;
    import flash.utils.ByteArray;
    
    public namespace hack;
    
    /**
     * Provides basic sync socket.
     */
    [native(cls="::avmshell::SocketClass", instance="::avmshell::SocketObject", methods="auto")]
    public class Socket
    {
        private var _localAddress:String;
        private var _localPort:int;
        private var _remoteAddress:String;
        private var _remotePort:int;

        private var _connected:Boolean = false;
        private var _bound:Boolean     = false;
        private var _listening:Boolean = false;
        
        public function Socket( family:int = -1, socktype:int = -1, protocol:int = -1 )
        {
            if( (family > -1) &&
                (socktype > -1) &&
                (protocol > -1) )
            {
                _customSocket( family, socktype, protocol );
            }
        }
        
        public native static function get lastError():int;

        
        private native function get lastDataSent():int;
        private native function get receivedBuffer():String;
        private native function get receivedBinary():ByteArray;

        private native function isValid():Boolean;

        private native function _customSocket( family:int, socktype:int, protocol:int ):void;
        private native function _connect( host:String, port:String ):Boolean;
        private native function _close():Boolean;
        private native function _send( data:String, flags:int = 0 ):int;
        private native function _sendBinary( data:ByteArray, flags:int = 0 ):int;
        private native function _receive( flags:int = 0 ):int;
        private native function _receiveBinary( flags:int = 0 ):int;
        private native function _bind( port:int ):Boolean;
        private native function _listen( backlog:int ):Boolean;
        private native function _accept():Socket;


        //status

        public function get valid():Boolean
        {
            return isValid();
        }

        public function get connected():Boolean
        {
            return _connected;
        }

        hack function set connected( value:Boolean ):void
        {
            _connected = value;
        }

        public function get bound():Boolean
        {
            return _bound;
        }

        public function get listening():Boolean
        {
            return _listening;
        }
        

        //options

        private native function get _type():int;

        public function get type():String
        {
            switch( _type )
            {
                case SOCK_RAW:
                return "raw";

                case SOCK_STREAM:
                return "stream";

                case SOCK_DGRAM:
                return "datagram";
            }
        }
        
        public native function get reuseAddress():Boolean;
        public native function set reuseAddress( value:Boolean ):void;

        public native function get broadcast():Boolean;
        public native function set broadcast( value:Boolean ):void;


        //infos

        public function get localPort():int
        {
            return _localPort;
        }

        public function get localAddress():String
        {
            return _localAddress;
        }
        

        public function get remotePort():int
        {
            return _remotePort;
        }

        public function get remoteAddress():String
        {
            return _remoteAddress;
        }



        
        public function connect( host:String, port:int ):void
        {
            if( !_connect( host, String(port) ) )
            {
                throw new Error( strerror( lastError ), lastError );
            }
            else
            {
                _connected = true;
            }
        }

        public function close():void
        {
            if( !connected ) { return; }
            
            if( !_close() )
            {
                //throw new Error( strerror( lastError ), lastError );
                switch( lastError )
                {
                    case 0:
                    //do nothing
                    break;
                    
                    case ENOTCONN:
                    //do nothing
                    break;

                    default:
                    trace( "a problem occured = " + lastError + " : " + strerror( lastError ) );
                }
            }

            _connected = false;
            _bound     = false;
            _listening = false;
        }

        public function send( data:String, flags:int = 0 ):void
        {
            if( !connected ) { return; }
        
            if( _send( data, flags ) == -1 )
            {
                //trace( "We only sent " + lastDataSent + " bytes because of the error!" );
                throw new Error( strerror( lastError ), lastError );
            }

            //trace( "Sent whole data " + data.length + " bytes" );
        }

        public function sendBinary( data:ByteArray, flags:int = 0 ):void
        {
            if( !connected ) { return; }
        
            if( _sendBinary( data, flags ) == -1 )
            {
                //trace( "We only sent " + lastDataSent + " bytes because of the error!" );
                throw new Error( strerror( lastError ), lastError );
            }

            trace( "Sent whole data " + data.length + " bytes" );
        }

        public function sendTo( host:String, port:int, data:String, flags:int = 0 ):void
        {
            connect( host, port );
            
            if( connected )
            {
                send( data, flags );
            }
            else
            {
                trace( "sendTo() could not reach " + host + ":" + port );
            }
        }
        
        public function receive( flags:int = 0 ):String
        {
            if( !connected ) { return; }

            var data:String = "";
            var result:int  = _receive( flags );
            
            data += receivedBuffer;

            if( result == 0 )
            {
                trace( "Connection closed by remote peer." );
                _connected = false;
            }

            return data;
        }
        
        public function receiveBinary( flags:int = 0 ):ByteArray
        {
            if( !connected ) { return; }

            var bytes:ByteArray;
            var result:int  = _receiveBinary( flags );
            
            bytes = receivedBinary;

            if( result == 0 )
            {
                trace( "Connection closed by remote peer." );
                _connected = false;
            }
            
            return bytes;
        }
        
        public function receiveFrom( host:String, port:int, flags:int = 0 ):String
        {
            connect( host, port );

            if( connected )
            {
                return receive( flags );
            }
            else
            {
                trace( "receiveFrom() could not reach " + host + ":" + port );
                return "";
            }
        }

        public function bind( port:uint ):Boolean
        {
            var result:Boolean = _bind( port );

            if( result )
            {
                trace( "bind to port " + port );
                _bound = true;
                _port  = port;
            }

            return result;
        }

        public function listen( backlog:uint = 0 ):Boolean
        {
            var result:Boolean = _listen( backlog );

            if( result )
            {
                _listening = true;
            }

            return result;
        }

        public function accept():Socket
        {
            var s:Socket = _accept();

            if( s )
            {
                this.hack::connected = true;
                s.hack::connected = true;
            }

            return s;
        }

        
    }

}
