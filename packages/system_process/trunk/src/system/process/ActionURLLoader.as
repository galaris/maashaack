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
    import core.maths.clamp;
    
    import flash.events.Event;
    import flash.events.IEventDispatcher;
    import flash.net.URLLoader;
    
    /**
     * This action process launch the load of a URLLoader object.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.events.ActionEvent ;
     * import system.process.ActionURLLoader ;
     * 
     * import system.eden ;
     * 
     * import flash.net.URLLoader ;
     * import flash.net.URLRequest ;
     * 
     * var url:String = "data/config.eden" ;
     * 
     * var loader:URLLoader = new URLLoader() ;
     * 
     * var start:Function = function( action:Action ):void
     * {
     *    trace( "start" ) ;
     * }
     * 
     * var finish:Function = function( e:Event ):void
     * {
     *     trace( "finish" ) ;
     *     
     *     var data:* = eden.deserialize( process.data ) ;
     *     
     *     for (var prop:String in data)
     *     {
     *         trace("  > " + prop + " : " + data[prop]) ;
     *     }
     * }
     * 
     * var process:ActionURLLoader = new ActionURLLoader( loader ) ;
     * 
     * process.startIt.connect( start ) ;
     * process.finishIt.connect( finish ) ;
     * 
     * process.request = new URLRequest( url ) ;
     * 
     * process.run() ;
      * </pre>
     */
    public class ActionURLLoader extends CoreActionLoader
    {
        /**
         * Creates a new ActionURLLoader instance.
         * @param loader The URLLoader object to load.
         */
        public function ActionURLLoader( loader:URLLoader=null )
        {
            super( loader ) ;
        }
        
        /**
         * The range of the max depth value.
         */
        public static var MAX_DEPTH:uint = 100 ;
        
        /**
         * The range of the min depth value.
         */
        public static var MIN_DEPTH:uint = 1 ;
        
        /**
         * The space string use to format the debugs.
         */
        public static var SPACE:String = "   " ;
        
        /**
         * Indicates the number of bytes that have been loaded thus far during the load operation.
         */
        public override function get bytesLoaded():uint
        {
            return (_loader is URLLoader) ? (_loader as URLLoader).bytesLoaded : 0 ;
        }
        
        /**
         * Indicates the total number of bytes in the downloaded data.
         */
        public override function get bytesTotal():uint
        {
            return (_loader is URLLoader) ? (_loader as URLLoader).bytesTotal : 0 ;
        }
        
        /**
         * Indicates the data received from the load operation. 
         */
        public function get data():*
        {
            return (_loader is URLLoader) ? (_loader as URLLoader).data : null ;
        }
        
        /**
         * @private
         */
        public function set data( value:* ):void
        {
            _loader.data = value ;
        }
        
        /**
         * Controls whether the downloaded data is received as 
         *   - text (URLLoaderDataFormat.TEXT),
         *   - raw binary data (URLLoaderDataFormat.BINARY)
         *   - URL-encoded variables (URLLoaderDataFormat.VARIABLES).
         */
        public function get dataFormat():String
        {
            return (_loader is URLLoader) ? (_loader as URLLoader).dataFormat : null ;
        }
        
        /**
         * @private
         */
        public function set dataFormat( value:String ):void
        {
            _loader.dataFormat = value ;
        }
        
        /**
         * Indicated if the console use collapse property or not.
         */
        public var isCollapse:Boolean ;
        
        /**
         * @private
         */
        public override function set loader( loader:IEventDispatcher ):void
        {
            super.loader = loader as URLLoader ;
        }
        
        /**
         * Determinates the max depth to collaspe the structure of an object in the console.
         */
        public function get maxDepth():uint
        {
            return _maxDepth ;
        }
        
        /**
         * @private
         */
        public function set maxDepth( value:uint ):void
        {
            _maxDepth = uint( clamp( value , MIN_DEPTH , MAX_DEPTH ) ) ;
        }
        
        /**
         * Activate or disactivate parsing (Use this with XML, EDEN, JSON...). 
         */
        public function get parsing():Boolean
        {
            return _isParsing ;
        }
        
        /**
         * @private
         */
        public function set parsing( b:Boolean ):void
        {
            _isParsing = b ;
        }
        
        /**
         * Indicates the flag of the verbose mode.
         */
        public var verbose:Boolean ;
        
        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public override function clone():*
        {
            return new ActionURLLoader(loader as URLLoader) ;
        }
        
        /**
         * Cancels a load() method operation that is currently in progress for the Loader instance.
         */
        public override function close():void
        {
            if ( _loader != null && _loader is URLLoader )
            {
                (_loader as URLLoader).close() ;
            }
            if ( running )
            {
                notifyFinished() ;
            }
        }
        
        /**
         * Enumerates the specified object.
         */
        public function enumerate( o:Object ):void
        {
            _enumerate(o) ;
        }
        
        /**
         * Optional log function (override it to customize your logs).
         */
        public function log( message:String ):void
        {
            trace( message ) ;
        }
        
        /**
         * Override this method. Parse your datas when loading is complete.
         */
        public function parse():void
        {
            // override this method.
        }
        
        /**
         * Dispatch an Event.COMPLETE event after all the received data is decoded and placed in the data property. 
         */
        protected override function _complete( e:Event ) : void
        {
            if (_isParsing) 
            {
                this.parse() ;
            }
            if ( verbose )
            {
                enumerate( data ) ;
            }
            super._complete(e) ;
        }
        
        /**
         * This protected method contains the invokation of the load method of the current loader of this process.
         */
        protected override function _run():void
        {
            var l:URLLoader = (_loader as URLLoader) ;
            if ( l != null )
            { 
                l.dataFormat = dataFormat ;
                l.load( request ) ;
            }
        }
        
        /**
         * @private
         */
        private var _isParsing:Boolean ;
        
        /**
         * @private
         */
        private var _maxDepth:uint ;
        
        /**
         * @private
         */
        private function _enumerate( o:Object , depth:uint = 1 ):void
        {
            for ( var prop:String in o ) 
            {
                var value:* = o[prop] ;
                log( _getSpace( depth-1 ) + " + " + prop + " : " + value ) ;
                if ( value is Object && (isCollapse == true) && (depth <= maxDepth) )
                {
                    _enumerate( value , depth + 1 ) ;
                }
            }
        }
        
        /**
         * @private
         */
        private function _getSpace( depth:uint=0 ):String
        {
            var s:String = "" ;
            if ( isNaN(depth) || depth == 0 )
            {
                return "" ;
            }
            while( --depth > -1 )
            {
                s += SPACE ;
            }
            return s ;
        }
    }
}
