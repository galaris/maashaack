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

package system.logging.targets
{
    import system.logging.LoggerLevel;
    import system.process.Cache;
    
    import flash.events.ErrorEvent;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.XMLSocket;
    
    /**
     * Basic implementation to creates socket targets. 
     */
    public class SocketTarget extends LineFormattedTarget
    {
        /**
         * Creates a new SocketTarget instance.
         * @param host The host of the socket connection (default "localhost").
         * @param port The port of the socket connection (default 0).
         * @param auto Indicates if the target is auto connected with the server.
         */
        public function SocketTarget( host:String = "localhost" , port:int = 0 , auto:Boolean = false )
        {
            _host   = host ;
            _port   = port ;
            _socket = new XMLSocket() ;
            _cache  = new Cache( _socket ) ;
            
            _socket.addEventListener( Event.CLOSE                       , _close   ) ;
            _socket.addEventListener( Event.CONNECT                     , _connect ) ;
            _socket.addEventListener( IOErrorEvent.IO_ERROR             , _error   ) ;
            _socket.addEventListener( SecurityErrorEvent.SECURITY_ERROR , _error   ) ;
            
            if ( auto )
            {
                connect() ;
            }
        }
        
        /**
         * Indicates if the target is connected with Socket server.
         */
        public function get connected():Boolean 
        {
            return _socket.connected  ;
        }
        
        /**
         * The host of the socket connection.
         */
        public function get host():String
        {
            return _host ;
        }
        
        /**
         * @private
         */
        public function set host( uri:String ):void
        {
            _host = uri ;
        }
        
        /**
         * The port of the socket connection.
         */
        public function get port():int
        {
            return _port ;
        }
        
        /**
         * @private
         */
        public function set port( port:int ):void
        {
            _port = port ;
        }
        
        /**
         * Closes the target socket connection.
         */
        public function close():void 
        {
            _isConnected = false ;
            _socket.close() ;
        }
        
        /**
         * Connects the target with the socket server.
         */
        public function connect():void
        {
            if (_isConnected) 
            {
                close() ;
            }
            _socket.connect( host, port ) ;
        }
        
        /**
         * Flush the target with all caching messages.
         */
        public function flush():void
        {
            if( _cache.length > 0 )
            {
                _cache.run() ;
            }
        }
        
        /**
         * Descendants of this class should override this method to direct the specified message to the desired output.
         * @param message String containing preprocessed log message which may include time, date, category, etc. based on property settings, such as <code class="prettyprint">includeDate</code>, <code class="prettyprint">includeCategory</code>, etc.
         * @param level the LogEventLevel of the message.
         */
        public override function internalLog( message:* , level:LoggerLevel ):void
        {
            send( message );
        }
        
        /**
         * Send message or bufferize message if the socket is not connected yet.
         */
        public function send( message:* ):void 
        {
            if (_isConnected) 
            {
                _socket.send( message ) ;
            }
            else 
            {
                _cache.enqueueMethod("send" , message ) ;
            }
        }
        
        /**
         * Invoked when the socket close the connection.
         * @private
         */
        protected function _close( e:Event ):void
        {
            _isConnected = false ;
        }
        
        /**
         * Invoked when the socket is connected.
         * @private
         */
        protected function _connect( e:Event ):void 
        {
            _isConnected = true ;
            flush() ;
        }
        
        /**
         * Invoked when the socket notify an error (IOError, SecurityError, etc.).
         * @private
         */
        protected function _error ( e:ErrorEvent ):void 
        {
            _isConnected = false ;
        }
        
        /**
         * @private
         */
        private var _cache:Cache ;
        
        /**
         * @private
         */
        private var _host:String ;
        
        /**
         * @private
         */
        private var _port:int ;
        
        /**
         * The internal value to indicated if the target is connected.
         */
        private var _isConnected:Boolean ;
        
        /**
         * The internal socket reference.
         */
        private var _socket:XMLSocket ;
    }
}