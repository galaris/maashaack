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

package system.process 
{
    import flash.display.DisplayObject;
    import flash.display.Loader;
    import flash.display.LoaderInfo;
    import flash.events.IEventDispatcher;
    import flash.system.LoaderContext;
    
    /**
     * This action process launch the load of a Loader object.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.process.Action ;
     * import system.process.ActionLoader ;
     * 
     * import flash.display.Loader ;
     * import flash.net.URLRequest ;
     * 
     * var url:String    = "library/picture.jpg" ;
     * var loader:Loader = new Loader() ;
     * 
     * loader.x = 50 ;
     * loader.y = 50 ;
     * 
     * addChild( loader ) ;
     * 
     * var finish:Function = function( action:Action ):void
     * {
     *     trace( "finish" ) ;
     * }
     * 
     * var start:Function = function( action:Action ):void
     * {
     *     trace( "start" ) ;
     * }
     * 
     * function init( action:Action ):void
     * {
     *     trace( "init : " + action ) ;
     * }
     * 
     * var process:ActionLoader = new ActionLoader( loader ) ;
     * 
     * process.finishIt.connect( finish ) ; 
     * process.init.connect( init ) ;
     * process.startIt.connect( start ) ; 
     * 
     * process.request = new URLRequest( url ) ;
     * 
     * process.run() ;
     * </pre>
     */
    public class ActionLoader extends CoreActionLoader 
    {
        /**
         * Creates a new ActionLoader instance.
         * @param loader The Loader object reference to initialize this process.
         */
        public function ActionLoader( loader:Loader=null )
        {
            super( loader ) ;
        }
        
        /**
         * Indicates the number of bytes that have been loaded thus far during the load operation.
         */
        public override function get bytesLoaded():uint
        {
            return contentLoaderInfo != null ? contentLoaderInfo.bytesLoaded : 0 ;
        }
        
        /**
         * Indicates the total number of bytes in the downloaded data.
         */
        public override function get bytesTotal():uint
        {
            return contentLoaderInfo != null ? contentLoaderInfo.bytesTotal : 0 ;
        }
        
        /**
         * Contains the root display object of the SWF file or image (JPG, PNG, or GIF) file that was loaded by using the load() or loadBytes() methods. 
         */
        public function get content():DisplayObject
        {
            return (_loader != null) ? (_loader as Loader).content : null ;
        } 
        
        /**
         * Returns a LoaderInfo object corresponding to the object being loaded. 
         * LoaderInfo objects are shared between the Loader object and the loaded content object. 
         * The LoaderInfo object supplies loading progress information and statistics about the loaded file. 
         */
        public function get contentLoaderInfo():LoaderInfo
        {
            return (_loader != null) ? (_loader as Loader).contentLoaderInfo : null ;
        }
        
        /**
         * The LoaderContext class provides options for loading SWF files and other media by using the Loader class. 
         * The LoaderContext class is used as the context parameter in the load() and loadBytes() methods of the Loader class.
         */
        public function get context():LoaderContext
        {
            return _context ;
        }
        
        /**
         * @private
         */
        public function set context( context:LoaderContext ):void
        {
            _context = context ;
        }
        
        /**
         * @private
         */
        public override function set loader( loader:IEventDispatcher ):void
        {
            super.loader = loader as Loader ;
        }
        
        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public override function clone():*
        {
            return new ActionLoader(loader as Loader) ;
        }
        
        /**
         * Cancels a load() method operation that is currently in progress for the Loader instance.
         */
        public override function close():void
        {
            if ( _loader != null && _loader is Loader )
            {
                (_loader as Loader).close() ;
            }
            if ( running )
            {
                notifyFinished() ;
            }
        }
        
        /**
         * Register the loader object.
         */
        public override function register( dispatcher:IEventDispatcher ):void
        {
            if ( contentLoaderInfo != null )
            {
                super.register( contentLoaderInfo ) ;
            }
        }
        
        /**
         * Unregister the loader object.
         */
        public override function unregister( dispatcher:IEventDispatcher ):void
        {
            if ( contentLoaderInfo != null )
            {
                super.unregister(contentLoaderInfo) ;
            }
        }
        
        /**
         * This protected method contains the invokation of the load method of the current loader of this process.
         */
        protected override function _run():void
        {
            if ( loader != null && (_loader is Loader) )
            {
                (_loader as Loader).load( request , context ) ;
            }
        }
        
        /**
         * @private
         */
        private var _context:LoaderContext ;
    }
}
