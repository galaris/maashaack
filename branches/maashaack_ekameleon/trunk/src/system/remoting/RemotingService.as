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

package system.remoting 
{
    import core.reflect.getClassName;
    
    import system.ioc.ObjectScope;
    import system.process.CoreAction;
    import system.process.TimeoutPolicy;
    import system.signals.Signal;
    
    import flash.errors.IllegalOperationError;
    import flash.events.NetStatusEvent;
    import flash.events.TimerEvent;
    import flash.net.ObjectEncoding;
    import flash.net.Responder;
    import flash.net.registerClassAlias;
    import flash.utils.Timer;
    
    /**
     * This class provides a service object to communicate with a remoting gateway server.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * package examples 
     * {
     *     import core.dump;
     *     
     *     import system.remoting.RemotingService;
     *     
     *     import flash.display.Sprite;
     *     
     *     public class RemotingExample extends Sprite 
     *     {
     *         public function RemotingExample()
     *         {
     *             var service:RemotingService = new RemotingService() ;
     *             
     *             service.finishIt.connect( finish ) ;
     *             service.progressIt.connect( progress ) ;
     *             service.startIt.connect( start ) ;
     *             service.timeoutIt.connect( timeout ) ;
     *             
     *             service.error.connect( error  ) ;
     *             service.fault.connect( fault  ) ;
     *             service.result.connect( result ) ;
     *             
     *             service.gatewayUrl  = gatewayUrl ;
     *             service.serviceName = "Test"  ;
     *             service.methodName  = "hello" ;
     *             
     *             service.run( "world" ) ;
     *         }
     *         
     *         public var gatewayUrl:String = 
     *         "http://localhost:8888/maashaack/amfphp/gateway.php" ;
     *         
     *         //////////////// slots
     *         
     *         protected function error( error:* , service:RemotingService ):void
     *         {
     *             trace("error:" + dump(error) ) ;
     *         }
     *         
     *         protected function fault( fault:* , service:RemotingService ):void
     *         {
     *             trace("fault:" + dump(fault) ) ;
     *         }
     *         
     *         protected function finish( service:RemotingService ):void
     *         {
     *             trace( "#finish" ) ;
     *         }
     *           
     *         protected function result( result:* , service:RemotingService ):void
     *         {
     *              trace("result : " + result ) ;
     *         }
     *         
     *         protected function start( service:RemotingService ):void
     *         {
     *             trace( "#start : " + service ) ;
     *         }
     *           
     *         protected function timeout( service:RemotingService ):void
     *         {
     *             trace( "#timeout" ) ;
     *         }
     *         
     *         ////////////////
     *     }
     * }
     * </pre>
     */
    public class RemotingService extends CoreAction
    {
        /**
         * Creates a new RemotingService instance.
         * @param gatewayUrl The url of the gateway of the remoting service.
         * @param serviceName (optional) The name of the service in the server.
         * @param methodName (optional) The method name to invoke in the specific remoting service.
         */
        public function RemotingService( gatewayUrl:String=null , serviceName:String=null , methodName:String=null , params:Array=null )
        {
            this._error        = new Signal() ;
            this._fault        = new Signal() ;
            this._result       = new Signal() ;
            
            this._proxy        = new RemotingServiceProxy( this ) ;
            this._timer        = new Timer( DEFAULT_DELAY, 1 ) ;
            this._responder    = new Responder( _response , _status ) ;
            
            this.gatewayUrl    = gatewayUrl  ;
            this.methodName    = methodName ;
            this.serviceName   = serviceName ;
            this.params        = params ;
            
            this.timeoutPolicy = TimeoutPolicy.LIMIT ;
        }
        
        /**
         * The default delay value before notify the timeout event (25 seconds)
         */
        public static const DEFAULT_DELAY:uint = 25000 ;
        
        /**
         * The string representation value of the level error of the service.
         */
        public static const LEVEL_ERROR:String = "error" ;
        
        /**
         * The internal RemotingConnection reference.
         */
        public function get connection():RemotingConnection 
        {
            return _connection ;
        }
        
        /**
         * Indicates the timeout interval duration (default 12000 ms).
         * <p>Uses the setDelay() method to change this value.</p>
         */
        public function get delay():uint
        {
            return _timer.delay ;
        }
        
        /**
         * This signal emit when the service receive a error message from the server
         */
        public function get error():Signal
        {
            return _error ;
        }
        
        /**
         * This signal emit when the service receive a fault message from the server
         */
        public function get fault():Signal
        {
            return _fault ;
        }
        
        /**
         * Indicates a string containing a dot delimited path from the root of the Flash Remoting Server to the service name. 
         */
        public function get gatewayUrl():String 
        { 
            return _gatewayUrl ;
        }
        
        /**
         * @private
         */
        public function set gatewayUrl( url:String ):void 
        { 
            if ( _connection )
            {
                if ( _connection.hasEventListener( NetStatusEvent.NET_STATUS ) )
                {
                    _connection.removeEventListener( NetStatusEvent.NET_STATUS , _netStatus ) ;
                }
                _connection = null ;
            }
            _gatewayUrl = url ;
            if ( _gatewayUrl != null && _gatewayUrl != "" )
            {
                if ( _scope == ObjectScope.SINGLETON ) 
                {
                    if( !connections.containsConnection( url ) )
                    {
                        connections.addConnection( _gatewayUrl, new RemotingConnection( _gatewayUrl ) ) ;
                    }
                    _connection = connections.getConnection(_gatewayUrl) ;
                }
                else
                {
                    _connection = new RemotingConnection(_gatewayUrl) ;
                }
                if ( _connection )
                {
                    _connection.addEventListener( NetStatusEvent.NET_STATUS , _netStatus ) ;
                }
            } 
        }
        
        /**
         * Defines the <code class="prettyprint">IRemotingService</code> reference of this remoting service.
         */
        public function get listener():IRemotingServiceListener
        {
            return _listener ;
        }
        
        /**
         * @private
         */
        public function set listener( listener:IRemotingServiceListener ):void
        {
            if ( _listener )
            {
                _listener.unregisterService( this ) ;
            }
            _listener = listener ;
            if ( _listener )
            {
                _listener.registerService( this ) ;
            }
        }
        
        /**
         * Indicates the name of the server-side service's method.
         */
        public var methodName:String ; 
        
        /**
         * Defines if the service can lauch multiple simultaneous connections.
         */
        public var multipleSimultaneousAllowed:Boolean ;
        
        /**
         * The object encoding (AMF version) for the internal NetConnection instance.
         */
        public var objectEncoding:uint = ObjectEncoding.AMF3 ;
        
        /**
         * Determinates the Array representation of all arguments to pass in the service method.
         */
        public function get params():Array 
        { 
            return _args ;
        }
        
        /**
         * @private
         */
        public function set params( args:Array ):void 
        { 
            _args = args || [] ;
        }
        
        /**
         * Determinates a RemotingServiceProxy of the current service to use simple methods to run remoting queries.
         */
        public function get proxy():RemotingServiceProxy
        {
            return _proxy ;
        }
        
        /**
         * This signal emit when the service receive a result with success.
         */
        public function get result():Signal
        {
            return _result ;
        }
        
        /**
         * The scope of this object ("prototype" or "singleton")
         * @see system.ioc.ObjectScope
         */
        public function get scope():String
        {
            return _scope ;
        }
        
        /**
         * @private
         */
        public function set scope( value:String ):void
        {
            _scope = value == ObjectScope.PROTOTYPE ? ObjectScope.PROTOTYPE : ObjectScope.SINGLETON ;
            gatewayUrl = _gatewayUrl ; // fix internal connection
        }
        
        /**
         * Indicates the name of the server-side service.
         */
        public var serviceName:String ;
        
        /**
         * Indicates the timeout policy value of this service. Use limit timeout interval.
         * @see TimeoutPolicy
         */
        public function get timeoutPolicy():TimeoutPolicy 
        {
            return _policy ;
        }
        
        /**
         * @private
         */
        public function set timeoutPolicy( policy:TimeoutPolicy ):void 
        {
            _policy = policy ;
            if ( _policy == TimeoutPolicy.LIMIT ) 
            {
                _timer.addEventListener( TimerEvent.TIMER_COMPLETE , _timeout ) ;
            }
            else
            {
                _timer.removeEventListener( TimerEvent.TIMER_COMPLETE , _timeout ) ;
            }
        }
        
        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public override function clone():*
        {
            return new RemotingService( gatewayUrl , serviceName , methodName , params ) ;
        }
        
        /**
         * Preserves the class (type) of an object when the object is encoded in Action Message Format (AMF). 
         * When you encode an object into AMF, this function saves the alias for its class, so that you can recover the class when decoding the object. 
         * If the encoding context did not register an alias for an object's class, the object is encoded as an anonymous object. 
         * Similarly, if the decoding context does not have the same alias registered, an anonymous object is created for the decoded data. 
         * This static method is the same like the flash.net.registerClassAlias singleton method.
         */
        public static function registerClassAlias( aliasName:String , classObject:Class ):void
        {
            flash.net.registerClassAlias( aliasName , classObject ) ;
        }
        
        /**
         * Run the process of the remoting service.
         */
        public override function run(...arguments:Array):void 
        {
            if ( arguments.length > 0 )
            {
                this.params = [].concat( arguments ) ;
            }
            
            if ( _connection == null )
            {
                throw new IllegalOperationError(this + " run failed, you can't run the service with a null internal RemotingConnection reference.") ;
            }
            
            if ( running && multipleSimultaneousAllowed == false )
            {
                notifyProgress() ;
            }
            else 
            {
                notifyStarted() ;
                
                _connection.objectEncoding = objectEncoding ;
                _connection.setCredentials( _authentification ) ;
                
                var params:Array = [ serviceName + "." + methodName , _responder ] ;
                
                if (_args != null && _args.length > 0)
                {
                    params = params.concat( _args ) ;
                }
                
                _timer.start() ;
                
                _connection.call.apply( _connection , params ) ;
            } 
        }
        
        /**
         * Defines a set of credentials to be presented to the server on all subsequent requests.
         * @param authentification The RemotingAuthentification instance to presented to the server.
         * @see RemotingAuthentification
         */
        public function setCredentials( authentification:RemotingAuthentification = null ):void  
        {
            _authentification = authentification ;
        }
        
        /**
         * Set timeout interval duration.
         * @param time the delay value of the timeout event notification.
         * @param useSeconds Indicates if the time value is in seconds <code class="prettyprint">true</code> or milliseconds <code class="prettyprint">false</code>.
         */
        public function setDelay( time:uint , useSeconds:Boolean=false):void 
        {
            if ( useSeconds )
            {
                time = Math.round( time * 1000 ) ;
            }
            _timer.delay = time ;
        }
        
        /**
         * Returns the <code class="prettyprint">String</code> representation of this object.
         * @return the <code class="prettyprint">String</code> representation of this object.
         */
        public function toString():String 
        {
            var txt:String = "[" + getClassName(this) ;
            if ( serviceName && serviceName != "" )
            {
                txt += " serviceName:" + serviceName ;
            }
            if ( methodName && methodName != "" )
            {
                txt  += " methodName:" + methodName ;
            }
            txt += "]" ;
            return txt ;
        }
        
        /**
         * @private
         */
        private var _args:Array ;
        
        /**
         * @private
         */
        private var _authentification:RemotingAuthentification ;
        
        /**
         * @private
         */
        private var _connection:RemotingConnection ;
        
        /**
         * @private
         */
        private var _error:Signal ;
        
        /**
         * @private
         */
        private var _fault:Signal ;
        
        /**
         * @private
         */
        private var _gatewayUrl:String ;
        
        /**
         * @private
         */
        private var _listener:IRemotingServiceListener ;
        
        /**
         * @private
         */
        private var _policy:TimeoutPolicy ;
        
        /**
         * @private
         */
        private var _proxy:RemotingServiceProxy ;
        
        /**
         * @private
         */
        private var _responder:Responder ;
        
        /**
         * @private
         */
        private var _result:Signal ;
        
        /**
         * @private 
         */
        private var _scope:String = ObjectScope.PROTOTYPE ;
        
        /**
         * @private
         */
        private var _timer:Timer ;
        
        /**
         * @private
         */
        private function _netStatus( e:NetStatusEvent ):void
        {
            if( e.info.level == LEVEL_ERROR )
            {
                _timer.stop() ; // stop timeout interval
                _error.emit( e.info , this )  ;
                notifyFinished() ;
            }
        }
        
        /**
         * @private
         */
        private function _response( data:* ):void
        {
            _timer.stop() ; // stop timeout interval
            _result.emit( data , this )  ;
            notifyFinished() ;
        }
        
        /**
         * @private
         */
        private function _status( fault:Object ):void 
        {
            _timer.stop() ; // stop timeout interval
            _fault.emit( fault , this )  ;
            notifyFinished() ;
        }
        
        /**
         * @private
         */
        private function _timeout(e:TimerEvent):void 
        {
            _timer.stop() ;
            notifyTimeOut() ;
            notifyFinished() ;
        }
    }
}