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
    import core.dump;
    
    import flash.utils.Dictionary;
    
    /**
     * The basic concrete implementation of the <code class="prettyprint">IRemotingServiceListener</code> interface.
     */
    public class RemotingServiceListener implements IRemotingServiceListener 
    {
        /**
         * Creates a new RemotingServiceListener instance.
         * @param service An optional RemotingService reference or an Array of RemotingService objects to be registered.
         * @param verbose The optional verbose flag to change the mode of this listener.
         */
        public function RemotingServiceListener( service:* = null , verbose:Boolean = true )
        {
            if ( service is RemotingService )
            {
                registerService( service ) ;
            }
            else if ( service is Array )
            {
                var s:RemotingService ;
                var a:Array = service as Array ;
                var l:int   = a.length ;
                while( --l > -1 )
                {
                    s = a[l] as RemotingService ;
                    if ( s )
                    {
                        registerService( s ) ;
                    }
                }
            }
            this.verbose = verbose ;
        }
        
        /**
         * Switch the verbose mode of this listener.
         */
        public var verbose:Boolean ;
        
        /**
         * Invoked when the service notify an error.
         */
        public function error( error:* , service:RemotingService ):void
        {
            if ( verbose )
            {
                logger.error( this + " error:" + dump(error) ) ;
            }
        }
        
        /**
         * Invoked when the service notify a fault.
         */
        public function fault( fault:* , service:RemotingService ):void
        {
            if ( verbose )
            {
                logger.warn( this + " fault:" + dump(fault) ) ;
            }
        }
        
        /**
         * Invoked when the service process is finished.
         */
        public function finish( service:RemotingService ):void
        {
            if ( verbose )
            {
                logger.info( this + " finish:" + service ) ;
            }
        }
        
        /**
         * Registers the specific remoting service.
         * @return True if the service is registered.
         */
        public function registerService( service:RemotingService ):Boolean
        {
            unregisterService( service ) ;
            if ( service && _map[service] == null )
            {
                _map[service] = service ;
                
                service.finishIt.connect( finish ) ;
                service.startIt.connect( start ) ;
                service.timeoutIt.connect( timeout ) ;
                
                service.error.connect( error  ) ;
                service.fault.connect( fault  ) ;
                service.result.connect( result ) ;
                
                return true ;
            }
            else
            {
                return false ; 
            }
        }
        
        /**
         * Invoked when the service notify a success.
         */
        public function result( result:* , service:RemotingService ):void
        {
            if ( verbose )
            {
                logger.debug( this + " result:" + result ) ;
            }
        }
        
        /**
         * Invoked when the service process is started.
         */
        public function start( service:RemotingService ):void
        {
            if ( verbose )
            {
                logger.info( this + " start:" + service ) ;
            }
        }
        
        /**
         * Invoked when the service notify a timeout.
         */
        public function timeout( service:RemotingService ):void
        {
            if ( verbose )
            {
                logger.info( this + " timeout:" + service ) ;
            }
        }
        
        /**
         * Unregister the service register in this listener.
         * @return True if the unregister is success.
         */
        public function unregisterService( service:RemotingService ):Boolean
        {
            if ( _map[service] )
            {
                service.finishIt.disconnect( finish ) ;
                service.startIt.disconnect( start ) ;
                service.timeoutIt.disconnect( timeout ) ;
                
                service.error.disconnect( error  ) ;
                service.fault.disconnect( fault  ) ;
                service.result.disconnect( result ) ;
                
                return delete _map[service] ;
            }
            return false ;
        }
        
        /**
         * The internal map of all services registered in this listener.
         */
        private var _map:Dictionary = new Dictionary(true) ;
    }
}
