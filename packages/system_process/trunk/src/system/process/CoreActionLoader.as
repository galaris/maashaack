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

package system.process 
{
    import system.signals.Signal;
    import system.signals.Signaler;
    
    import flash.events.ErrorEvent;
    import flash.events.Event;
    import flash.events.HTTPStatusEvent;
    import flash.events.IEventDispatcher;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.events.SecurityErrorEvent;
    import flash.events.TimerEvent;
    import flash.net.URLRequest;
    import flash.utils.Timer;
    
    /**
     * This core command object run a "loader" object and notify ActionEvent during a load process.
     */
    public class CoreActionLoader extends CoreAction
    {
        /**
         * Creates a new CoreActionLoader instance.
         * @param loader The loader reference.
         */
        public function CoreActionLoader( loader:IEventDispatcher=null )
        {
            _timer             = new Timer(DEFAULT_DELAY, 1) ;
            this.timeoutPolicy = DEFAULT_TIMEOUT_POLICY ;
            this.loader        = loader ;
        }
        
        /**
         * The name of the default cache uri query parameter ("random"). 
         * In the loader request you can set an other parameter name with the property <code>cacheParameterName</code>.
         */
        public static var DEFAULT_CACHE_PARAMETER:String = "random" ;
        
        /**
         * The default value of the delay before the ActionEvent.TIMEOUT event (defines in the constructor of the class).
         */
        public static var DEFAULT_DELAY:uint = 8000 ; // 8 secondes
        
        /**
         * The default TimeoutPolicy value used to set the timeoutPolicy member of all new objects of this class.
         */
        public static var DEFAULT_TIMEOUT_POLICY:TimeoutPolicy = TimeoutPolicy.LIMIT ;
        
        /**
         * Indicates the number of bytes that have been loaded thus far during the load operation.
         */
        public function get bytesLoaded():uint
        {
            return 0 ;
        }
        
        /**
         * Indicates the total number of bytes in the downloaded data.
         */
        public function get bytesTotal():uint
        {
            return 0 ;
        }
        
        /**
         * The cache flag of this resource (default is true).
         */
        public var cache:Boolean ;
        
        /**
         * The name of the uri query parameter when the cache attribute is true. By default the DEFAULT_CACHE_PARAMETER const is used.
         */
        public var cacheParameterName:String ;
        
        /**
         * This signal emit when the notifyComplete method is invoked. 
         */
        public function get complete():Signaler
        {
            return _completeIt ;
        }
        
        /**
         * @private
         */
        public function set complete( signal:Signaler ):void
        {
            _completeIt = signal || new Signal() ;
        }
        
        /**
         * Indicates the timeout interval duration.
         */
        public function get delay():uint
        {
            return _timer.delay ;
        }
        
        /**
         * This signal emit when the notifyError method is invoked. 
         */
        public function get error():Signaler
        {
            return _errorIt ;
        }
        
        /**
         * @private
         */
        public function set error( signal:Signaler ):void
        {
            _errorIt = signal || new Signal() ;
        }
        
        /**
         * This signal emit when the notifyHttpStatus method is invoked. 
         */
        public function get httpStatus():Signaler
        {
            return _httpStatusIt ;
        }
        
        /**
         * @private
         */
        public function set httpStatus( signal:Signaler ):void
        {
            _httpStatusIt = signal || new Signal() ;
        }
        
        /**
         * This signal emit when the notifyInit method is invoked. 
         */
        public function get init():Signaler
        {
            return _initIt ;
        }
        
        /**
         * @private
         */
        public function set init( signal:Signaler ):void
        {
            _initIt = signal || new Signal() ;
        }
        
        /**
         * Indicates the loader object of this process.
         */
        public function get loader():IEventDispatcher
        {
            return _loader ;
        }
        
        /**
         * @private
         */
        public function set loader( loader:IEventDispatcher ):void
        {
            unregister(_loader) ;
            _loader = loader ;
            register(_loader) ;
        }
        
        /**
         * This signal emit when the notifyOpen method is invoked. 
         */
        public function get open():Signaler
        {
            return _openIt ;
        }
        
        /**
         * @private
         */
        public function set open( signal:Signaler ):void
        {
            _openIt = signal || new Signal() ;
        }
        
        
        /**
         * Indicates the URLRequest object who captures all of the information in a single HTTP request.
         */
        public function get request():URLRequest
        {
            return _request ;
        }
        
        /**
         * @private
         */
        public function set request( request:URLRequest ):void
        {
            _request = request ;
        }
        
        /**
         * Indicates the timeout policy of the loader.
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
            if ( policy == TimeoutPolicy.LIMIT ) 
            {
                _policy = TimeoutPolicy.LIMIT ;
                _timer.addEventListener(TimerEvent.TIMER_COMPLETE, _onTimeOut) ;
            }
            else 
            {
                _policy = TimeoutPolicy.INFINITY ;
                _timer.removeEventListener(TimerEvent.TIMER_COMPLETE, _onTimeOut) ;
            }
        }
        
        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public override function clone():*
        {
            return new CoreActionLoader( loader ) ;
        }
        
        /**
         * Cancels a load() method operation that is currently in progress for the Loader instance.
         */
        public function close():void
        {
            notifyFinished() ;
        }
        
        /**
         * Notify when the process is complete.
         */
        public function notifyComplete():void 
        {
            if ( !isLocked() )
            {
                _completeIt.emit( this ) ;
            }
        }
        
        /**
         * Notify when the process failed.
         */
        public function notifyError( error:Object = null ):void 
        {
            if ( !isLocked() )
            {
                _errorIt.emit( error , this ) ;
            }
        }
        
        /**
         * Notify an ActionEvent when the process is finished.
         */
        public override function notifyFinished():void 
        {
            _timer.stop() ;
            super.notifyFinished() ;
        }
        
        /**
         * Notify when the loading process httpstatus is changed..
         */
        public function notifyHttpStatus( status:Object = null ):void 
        {
            if ( !isLocked() )
            {
                _httpStatusIt.emit( status , this ) ;
            }
        }
        
        /**
         * Notify when the process is initialize.
         */
        public function notifyInit():void 
        {
            if ( !isLocked() )
            {
                _initIt.emit( this ) ;
            }
        }
        
        /**
         * Notify when the process is open.
         */
        public function notifyOpen():void 
        {
            if ( !isLocked() )
            {
                _openIt.emit( this ) ;
            }
        }
        
        /**
         * Notify an ActionEvent when the process is started.
         */
        public override function notifyStarted():void
        {
            super.notifyStarted() ;
            _timer.start() ;
        }
        
        /**
         * Register the loader object.
         */
        public function register( dispatcher:IEventDispatcher ):void
        {
            if ( dispatcher != null )
            {
                dispatcher.addEventListener( Event.COMPLETE                    , _complete   , false, 0, true ) ;
                dispatcher.addEventListener( HTTPStatusEvent.HTTP_STATUS       , _httpStatus , false, 0, true ) ;
                dispatcher.addEventListener( Event.INIT                        , _init       , false, 0, true ) ;
                dispatcher.addEventListener( IOErrorEvent.IO_ERROR             , _error      , false, 0, true ) ;
                dispatcher.addEventListener( Event.OPEN                        , _open       , false, 0, true ) ;
                dispatcher.addEventListener( ProgressEvent.PROGRESS            , _progress   , false, 0, true ) ;
                dispatcher.addEventListener( SecurityErrorEvent.SECURITY_ERROR , _error      , false, 0, true ) ;
            }
        }
        
        /**
         * Run the process.
         */
        public override function run( ...arguments:Array ):void 
        {
            notifyStarted() ;
            if ( loader == null )
            {
                notifyError( new ErrorEvent( ErrorEvent.ERROR , false, false, this + " failed the loader reference of this process not must be 'null'.") ) ;
                notifyFinished() ;
            }
            else if ( request == null )
            {
                notifyError( new ErrorEvent( ErrorEvent.ERROR , false, false, this + " failed the request reference of this process not must be 'null'.") ) ;
                notifyFinished() ;
            }
            else
            {
                // FIXME resolveRequest() ; // Problem with the URI class for the moment with the relative uris
                _run() ;
            }
        }
        
        /**
         * Sets the timeout interval duration.
         * @param time The time interval of the timeout limit.
         * @param useSeconds This optional boolean indicates if the time parameter is in seconds or milliseconds.
         */
        public function setDelay( time:uint , useSeconds:Boolean=false):void 
        {
            if (useSeconds) 
            {
                time = Math.round(time * 1000) ;
            }
            _timer.delay = time ;
        }    
        
        /**
         * Unregisters the loader object.
         */
        public function unregister( dispatcher:IEventDispatcher ):void
        {
            if ( dispatcher != null )
            { 
                dispatcher.removeEventListener( Event.COMPLETE                    , _complete   ) ;
                dispatcher.removeEventListener( Event.INIT                        , _init       ) ;
                dispatcher.removeEventListener( HTTPStatusEvent.HTTP_STATUS       , _httpStatus ) ;
                dispatcher.removeEventListener( IOErrorEvent.IO_ERROR             , _error      ) ;
                dispatcher.removeEventListener( Event.OPEN                        , _open       ) ;
                dispatcher.removeEventListener( ProgressEvent.PROGRESS            , _progress   ) ;
                dispatcher.removeEventListener( SecurityErrorEvent.SECURITY_ERROR , _error      ) ;
            }
        }
        
        /**
         * Invoked when the loading is complete.
         */
        protected function _complete( e:Event ):void
        {
            notifyComplete() ;
            notifyFinished() ;
        }
        
        /**
         * Dispatch an ErrorEvent if a call to load() attempts a server problem (IOErrorEvent or SecurityErrorEvent). 
         */
        protected function _error( e:ErrorEvent ):void
        {
            notifyError( e ) ;
            notifyFinished() ;
        }
        
        /**
         * Dispatch HTTPStatusEvent if a call to load() attempts to access data over HTTP and the current Flash Player environment is able to detect and return the status code for the request.
         */
        protected function _httpStatus( e:HTTPStatusEvent ):void
        {
            notifyHttpStatus( e ) ;
        }
        
        /**
         * Invoked when the loading is init.
         */
        protected function _init( e:Event ):void
        {
            notifyInit() ;
        }
        
        /**
         * This protected method contains the invokation of the load method of the current loader of this process.
         */
        protected function _run():void
        {
            //
        }
        
        /**
         * Dispatch Event.OPEN event when the download operation commences following a call to the load() method.
         */
        protected function _open(e:Event):void
        {
            notifyOpen() ;
        }
        
        /**
         * Invoked when the loading is in complete.
         */
        protected function _progress( e:ProgressEvent ):void
        {
            if ( !isLocked() && e )
            {
                _progressIt.emit( e.bytesLoaded , e.bytesTotal, this ) ;
            }
        }
        
        ///////////
        
//        /**
//         * Resolves the request of the loader with the cache query parameter if the cache attribute is true.
//         */
//        protected function resolveRequest():void
//        {
//            if ( _request && _request.url )
//            {
//                var uri:URI = new URI( _request.url ) ; // FIXME bug here with the relative uris !!!!
//                uri.setParameterValue
//                ( 
//                    cacheParameterName || DEFAULT_CACHE_PARAMETER , 
//                    cache ? ( Math.random() * (new Date()).valueOf() ) : undefined 
//                ) ;
//                _request.url = uri.toString() ;
//            }
//        }
        
        ///////////
        
        /**
         * @private
         */
        protected var _completeIt:Signaler = new Signal() ;
        
        /**
         * @private
         */
        protected var _errorIt:Signaler = new Signal() ;
        
        /**
         * @private
         */
        protected var _httpStatusIt:Signaler = new Signal() ;
        
        /**
         * @private
         */
        protected var _initIt:Signaler = new Signal() ;
        
        /**
         * @private
         */
        protected var _loader:* ;
        
        /**
         * The internal URLRequest reference of the loader.
         * @private
         */
        protected var _request:URLRequest ;
        
        /**
         * @private
         */
        protected var _openIt:Signaler = new Signal() ;
        
        /**
         * @private
         */
        private var _policy:TimeoutPolicy ;
        
        /**
         * @private 
         */
        private var _timer:Timer ;
        
        /**
         * @private
         */
        private function _onTimeOut(e:TimerEvent):void
        {
            notifyTimeOut() ;
            close() ;
        }
    }
}
