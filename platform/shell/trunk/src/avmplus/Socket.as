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
    
    /**
     * The Socket class
     * Provides methods to create client and server sockets.
     * 
     * @langversion 3.0
     * @playerversion Flash 9
     * @productversion redtamarin 0.3
     * @since 0.3.0
     * 
     * @see http://code.google.com/p/redtamarin/wiki/Socket
     */
    [native(cls="::avmshell::SocketClass", instance="::avmshell::SocketObject", methods="auto")]
    public dynamic class Socket
    {
        /* note:
           in methods like receiveAll()
           we will loop till the result is smaller than the buffer
           if the buffer is 1 byte, we end up with an infinite loop
        */
        static private const _MIN_BUFFER:uint = 2;

        /**
         * The last socket error.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public native static function get lastError():int;

        /**
         * The list of local IP addresses.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function get localAddresses():Array
        {
            var addresses:Array = [];
            var localhost:Array = gethostbyname( "localhost", true );
            var hostname:Array  = gethostbyname( OperatingSystem.hostname, true );

            if( localhost.length > 0 )
            {
                addresses = addresses.concat( localhost );
            }
            
            if( hostname.length > 0 )
            {
                addresses = addresses.concat( hostname );
            }
            
            return addresses;
        }

        /**
         * The maximum backlog queue length supported by the OS for each socket.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function get maxConnectionQueue():uint
        {
            return SOMAXCONN;
        }

        /**
         * The maximum concurrent connections supported by the OS.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public native static function get maxConcurrentConnection():int;

        internal namespace hack_sock;

        private var _logs:Array;
        
        private var _local:String; // ip:port
        private var _peer:String;  // ip:port

        private var _connected:Boolean;
        private var _bound:Boolean;
        private var _listening:Boolean;
        private var _child:Boolean;

        /**
         * The Socket constructor.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public function Socket( family:int = -1, socktype:int = -1, protocol:int = -1 )
        {
            if( (family > -1) && (socktype > -1) && (protocol > -1) )
            {
                _customSocket( family, socktype, protocol );
            }

            _ctor();
        }

        private function _ctor():void
        {
            _logs = [];
            _reset();
            _setNoSigPipe();
            
            this.onConstruct();
        }

        private native function get _type():int;
        
        private native function _getBuffer():ByteArray;
        private native function _setNoSigPipe():void;
        private native function _isValid():Boolean;
        private native function _isReadable( timeout:int = 0 ):int;
        private native function _isWritable( timeout:int = 0 ):int;
        //private native function _isExceptional( timeout:int = 0 ):int; //not used, not working ?
        private native function _customSocket( family:int, socktype:int, protocol:int ):void;
        private native function _connect( host:String, port:String ):Boolean;
        private native function _close():Boolean;
        private native function _send( data:ByteArray, flags:int = 0 ):int;
        private native function _sendTo( host:String, port:String, data:ByteArray, flags:int = 0 ):int;
        private native function _receive( buffer:int, flags:int = 0 ):int;
        private native function _receiveFrom( buffer:int, flags:int = 0 ):int;
        private native function _bind( host:String, port:int ):Boolean;
        private native function _listen( backlog:int ):Boolean;
        private native function _accept():Socket;

        private function _reset():void
        {
            _local = "";
            _peer  = "";
            
            _connected = false;
            _bound     = false;
            _listening = false;
            _child     = false;
        }

        //was: throw new Error( strerror( lastError ), lastError );
        private function _throwSocketError( e:int ):void
        {
            var cerr:Error = new Error( strerror(e), e );
                cerr.name  = "SocketError";

            this.record( cerr.toString() + " (errno="+e+")." );
            throw cerr;
        }

        private function _throwReceiveBufferError():void
        {
            var re:RangeError = new RangeError( "Buffer is too small, need to be minimum " + _MIN_BUFFER + " bytes." );
            this.record( re.toString() );
            throw re;
        }
        
        private function _throwMaxConnectionError():void
        {
            var re:RangeError = new RangeError( "The Operating System only allows " + SOMAXCONN + " maximum listen() backlog queue length for each socket." );
            this.record( re.toString() );
            throw re;
        }

        private function _onConnect():void
        {
            _connected = true;
            
            if( _child )
            {
                _peer  = getsockname( descriptor );
                _local = getpeername( descriptor );            
            }
            else
            {
                _peer  = getpeername( descriptor );
                _local = getsockname( descriptor );
            }
            
            this.onConnect();
        }
        
        //when the other end close the connection
        private function _remoteClose():void
        {
            var addr:String;

            //if we are a child the local/peer is inversed
            if( _child )
            {
                addr = local;
            }
            else
            {
                addr = peer;
            }
            
            this.onDisconnect( "Connection closed by remote peer [" + addr + "]." );
            _localClose();
        }

        private function _localClose():void
        {
            this.onDestruct();
            
            if( !_close() )
            {
                switch( lastError )
                {
                    case 0:
                    //do nothing
                    break;
                    
                    case ENOTCONN:
                    //do nothing
                    break;
                    
                    default:
                    this.record( "another problem occured = " + lastError + " : " + strerror( lastError ) );
                }
            }

            _reset();
        }


        /**
         * The socket descriptor.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public native function get descriptor():int;


        //status
     
        /**
         * Indicates if the socket is valid.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public function get valid():Boolean { return _isValid(); }

        /**
         * Indicates if the socket is ready for reading.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public function get readable():Boolean { return _isReadable( readableTimeout ) > 0; }

        /**
         * Defines the timeout (in seconds) for the readable test.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.2
         */
        public var readableTimeout:uint = 0;

        /**
         * Indicates if the socket is ready for writing.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public function get writable():Boolean { return _isWritable( writableTimeout ) > 0; }

        /**
         * Defines the timeout (in seconds) for the writable test.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.2
         */
        public var writableTimeout:uint = 0;

        //Indicates if the socket has an exceptional condition pending.
        //public function get exceptional():Boolean { return _isExceptional() > 0; }

        //public var exceptionalTimeout:uint = 0;

        /**
         * Indicates if the socket is connected.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public function get connected():Boolean { return _connected; }
        hack_sock function set connected( value:Boolean ):void { _connected = value; }

        /**
         * Indicates if the socket is bound.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public function get bound():Boolean { return _bound; }

        /**
         * Indicates if the socket is listening.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public function get listening():Boolean { return _listening; }
        

        //options

        /**
         * Returns the type of the socket.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
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

                case -1:
                default:
                return "invalid";
            }
        }

        /**
         * Indicates if the socket is blocking or non-blocking.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.2
         */
        public native function get blocking():Boolean;
        public native function set blocking( value:Boolean ):void;

        /**
         * Indicates if the socket address can be reused.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public native function get reuseAddress():Boolean;
        public native function set reuseAddress( value:Boolean ):void;

        /**
         * Indicates if the socket can broadcast.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public native function get broadcast():Boolean;
        public native function set broadcast( value:Boolean ):void;

        /**
         * Defines the timeout (in seconds) for the receive functions.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.2
         */
        public native function get receiveTimeout():int;
        public native function set receiveTimeout( value:int ):void;

        /**
         * Defines the timeout (in seconds) for the send functions.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.2
         */
        public native function get sendTimeout():int;
        public native function set sendTimeout( value:int ):void;

        //infos

        /**
         * Returns the session logs for this socket.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public function get logs():Array { return _logs; }

        /**
         * Local socket address and port.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public function get local():String { return _local; }
        hack_sock function set local( value:String ):void { _local = value; }

        /**
         * Peer socket address and port.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public function get peer():String { return _peer; }
        hack_sock function set peer( value:String ):void { _peer = value; }


        /**
         * Indicates if the socket is a TCP client.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public function isClient():Boolean
        {
            return (type == "stream") && connected;
        }

        /**
         * Indicates if the socket is a TCP server.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public function isServer():Boolean
        {
            return (type == "stream") && bound && listening;
        }
        

        //actions

        /**
         * Connect a socket.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public function connect( host:String, port:uint ):void
        {
            if( !_connect( host, String(port) ) )
            {
                _throwSocketError( lastError );
            }
            
            _onConnect();
        }
        
        //when we create a child socket with accept()
        hack_sock function connectByParent():void
        {
            _ctor();
            _child = true;
            _onConnect();
        }
        
        /**
         * Close a socket.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public function close():void
        {
            if( isClient() || isServer() )
            {
                this.onDisconnect( "Terminated." );
            }
            
            _localClose();
        }

        /**
         * Send a string message on a connected socket.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public function send( data:String, flags:int = 0 ):void
        {
            if( !connected ) { return; }

            var bytes:ByteArray = new ByteArray();
                bytes.writeUTFBytes( data );
                bytes.writeByte(0); //we want null terminated!
                bytes.position = 0;
            
            if( _send( bytes, flags ) == -1 )
            {
                _throwSocketError( lastError );
            }
            
            this.onSend( data.length );
        }

        /**
         * Send a binary message on a connected socket.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public function sendBinary( data:ByteArray, flags:int = 0 ):void
        {
            if( !connected ) { return; }

            data.writeByte(0); //we want null terminated!
            data.position = 0;
            
            if( _send( data, flags ) == -1 )
            {
                _throwSocketError( lastError );
            }
            
            this.onSend( data.length );
        }

        /**
         * Send a string message on a socket.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public function sendTo( host:String, port:int, data:String, flags:int = 0 ):void
        {
            var bytes:ByteArray = new ByteArray();
                bytes.writeUTFBytes( data );
                bytes.writeByte(0); //we want null terminated!
                bytes.position = 0;
            
            if( _sendTo( host, String(port), bytes, flags ) == -1 )
            {
                _throwSocketError( lastError );
            }
            
            _peer  = host + ":" + String(port);
            _local = getsockname( descriptor );
            
            this.onSend( data.length );
        }

        /**
         * Send a binary message on a socket.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public function sendBinaryTo( host:String, port:int, data:ByteArray, flags:int = 0 ):void
        {
            data.writeByte(0); //we want null terminated!
            data.position = 0;
            
            if( _sendTo( host, String(port), data, flags ) == -1 )
            {
                _throwSocketError( lastError );
            }
            
            _peer  = host + ":" + String(port);
            _local = getsockname( descriptor );
            
            this.onSend( data.length );
        }

        /**
         * Receive part of a string message from a connected socket.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public function receive( buffer:uint = 1024, flags:int = 0 ):String
        {
            if( !connected ) { return; }
            
            if( buffer < _MIN_BUFFER ) { _throwReceiveBufferError(); }

            var data:String = "";
            var result:int  = _receive( buffer, flags );
            
            if( result == 0 ) { _remoteClose(); }

            if( result == -1 ) { _throwSocketError( lastError ); }

            var _buffer:ByteArray = _getBuffer();
                _buffer.position = 0;
            data += _buffer.readUTFBytes( result );
            
            this.onReceive( data.length );
            return data;
        }

        /**
         * Receive all of a string message from a connected socket.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public function receiveAll( buffer:uint = 1024, flags:int = 0 ):String
        {
            if( !connected ) { return; }
            
            if( buffer < _MIN_BUFFER ) { _throwReceiveBufferError(); }
            
            var data:String = "";
            var part:String = "";
            var run:Boolean = true;

            /* note:
               a text stream act differently than a binary stream
               
               with a text stream
               receive() think it will always receive data
               so we need to check if the stream is readable
               to stop receiving

               wiht a binary stream
               receive() can not trust the readable as the packet
               can vary in size, but when all data is received, it does receive zero
               so we know when to stop receiving
            */
            do
            {
                part = receive( buffer, flags );
                
                if( (part != "") && (part.length > 0) )
                {
                    data += part;
                }
                else
                {
                    run = false;
                }
                
                /* note:
                   accessing the readable prop here
                   is not very efficient and could generate a
                   "signal EXC_BAD_ACCESS, Could not access memory"

                   so we rever to the "old" way of checking the length of the buffer
                */
                //if( !readable ) { run = false; }
                if( part.length < buffer ) { run = false; }
            }
            while( run )

            this.onReceiveAll( data.length );
            return data;
        }

        /**
         * Receive part of a binary message from a connected socket.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public function receiveBinary( buffer:uint = 1024, flags:int = 0 ):ByteArray
        {
            if( !connected ) { return; }
            
            if( buffer < _MIN_BUFFER ) { _throwReceiveBufferError(); }
            
            var data:ByteArray;
            var result:int  = _receive( buffer, flags );
            
            if( result == 0 ) { _remoteClose(); }

            if( result == -1 ) { _throwSocketError( lastError ); }
            
            data = _getBuffer();
            data.position = 0;
            
            this.onReceive( data.length );
            return data;
        }

        /**
         * Receive all of a binary message from a connected socket.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public function receiveBinaryAll( buffer:uint = 1024, flags:int = 0 ):ByteArray
        {
            if( !connected ) { return; }
            
            if( buffer < _MIN_BUFFER ) { _throwReceiveBufferError(); }
            
            var data:ByteArray = new ByteArray();
            var part:ByteArray;
            var run:Boolean = true;

            do
            {
                part = receiveBinary( buffer, flags );
                
                if( (part != null) && (part.length > 0) )
                {
                    data.writeBytes( part ); //append the bytes
                }
                else
                {
                    run = false; //we received zero
                }
            }
            while( run )

            this.onReceiveAll( data.length );
            return data;
        }

        /**
         * Receive a string message from a socket.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public function receiveFrom( buffer:uint = 512, flags:int = 0 ):String
        {
            var data:String = "";
            var result:int  = _receiveFrom( buffer, flags );

            if( result == 0 ) { _remoteClose(); }

            if( result == -1 ) { _throwSocketError( lastError ); }
            
            var _buffer:ByteArray = _getBuffer();
                _buffer.position = 0;
            data += _buffer.readUTFBytes( result );
            
            _local = getsockname( descriptor );
            
            this.onReceive( data.length );
            return data;
        }

        /**
         * Receive a binary message from a socket.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public function receiveBinaryFrom( buffer:uint = 512, flags:int = 0 ):ByteArray
        {
            var data:ByteArray;
            var result:int  = _receiveFrom( buffer, flags );

            if( result == 0 ) { _remoteClose(); }

            if( result == -1 ) { _throwSocketError( lastError ); }
            
            data = _getBuffer();
            data.position = 0;
            
            _local = getsockname( descriptor );
            
            this.onReceive( data.length );
            return data;
        }

        /**
         * Bind a name to a socket.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public function bind( port:uint, host:String = "" ):Boolean
        {
            if( host == "" ) { host = "127.0.0.1"; }
            
            var result:Boolean = _bind( host, port );

            if( result )
            {
                _bound = true;
                _local = getsockname( descriptor );
                this.onBind( port );
            }

            return result;
        }

        /**
         * Listen for socket connections and limit the queue of incoming connections.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public function listen( backlog:uint = 0 ):Boolean
        {
            if( backlog > SOMAXCONN )
            {
                _throwMaxConnectionError();
            }
            
            var result:Boolean = _listen( backlog );

            if( result )
            {
                _listening = true;
                this.onListen( backlog );
            }

            return result;
        }

        /**
         * Accept a new connection on a socket.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public function accept():Socket
        {
            var s:Socket = _accept();

            if( s && (s.descriptor > 0) )
            {
                s.hack_sock::connectByParent();
            }
            
            this.onAccept( s.descriptor );
            return s;
        }
        

        //poor man events
        public static function _init():void
        {
            prototype.log = function( message:String ):void
            {
                this._logs.push( message );
            }
            
            prototype.output = function( message:String ):void
            {
                trace( message );
            }
            
            prototype.recordLogOnly = function( message:String ):void
            {
                message = "Socket (" + this.descriptor + "): " + message;
                this.log( message );
            }

            prototype.recordOutputOnly = function( message:String ):void
            {
                message = "Socket (" + this.descriptor + "): " + message;
                this.output( message );
            }

            prototype.recordAll = function( message:String ):void
            {
                message = "Socket (" + this.descriptor + "): " + message;
                this.log( message );
                this.output( message );
            }
            
            //default
            prototype.record = prototype.recordAll;
            
            prototype.onConstruct = function():void
            {
                this.record( this.type + " socket created." );
            }

            prototype.onDestruct = function():void
            {
                this.record( this.type + " socket destroyed." );
            }
            
            prototype.onConnect = function():void
            {
                this.record( "[" + this.local + "] connected to [" + this.peer + "]." );
            }

            prototype.onDisconnect = function( message:String = "" ):void
            {
                if( message != "" ) { this.record( message ); }
                if( this.isClient() )
                {
                    this.record( "Disconnected from [" + this.peer + "]." );
                }
                else if( this.isServer() )
                {
                    this.record( "[" + this.local + "] stop listening, unbound and disconnected." );
                }
            }

            prototype.onSend = function( data:Number ):void
            {
                this.record( "Sent " + data + " bytes." );
            }

            prototype.onReceive = function( data:Number ):void
            {
                this.record( "Received " + data + " bytes." );
            }

            prototype.onReceiveAll = function( data:Number ):void
            {
                this.record( "Received all " + data + " bytes." );
            }

            prototype.onBind = function( port:uint ):void
            {
                var info:String = String(port);

                if( this.local != "" ) { info = this.local; }
                
                this.record( "Bound to [" + info + "]." );
            }

            prototype.onListen = function( backlog:uint ):void
            {
                this.record( "[" + this.local + "] listening (backlog=" + backlog + ")." );
            }

            prototype.onAccept = function( id:int ):void
            {
                this.record( "[" + this.local + "] accept connection from [" + id + "]." );
            }

            _dontEnumPrototype( prototype );
        }
        
    }

    // dont create proto functions until after class Function is initialized
    Socket._init()

}
