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

package system.process.mocks 
{
    import system.process.Action;
    import system.process.CoreAction;
    
    /**
     * This Mock object listen all signals emitted from a Action object.
     */
    public class MockActionReceiver extends MockTaskReceiver
    {
        /**
         * Creates a new MockActionListener.as instance.
         */
        public function MockActionReceiver(action:Action = null)
        {
            super( action ) ;
        }
        
        public var changeCalled:Boolean ;
        public var clearCalled:Boolean ;
        public var infoCalled:Boolean ;
        public var infoObject:* ;
        public var loopCalled:Boolean ;
        public var pauseCalled:Boolean ;
        public var progressCalled:Boolean ;
        public var resumeCalled:Boolean ;
        public var stopCalled:Boolean ;
        public var timeoutCalled:Boolean ;
        
        public function change( action:Action ):void
        {
            changeCalled = true ;
        }
        
        public function clear( action:Action ):void
        {
            clearCalled = true ;
        }
       
        public function info( action:Action , info:Object ):void
        {
            infoCalled = true ;
            infoObject = info ;
        }
        
        public function loop( action:Action ):void
        {
            loopCalled = true ;
        }
       
        public function pause( action:Action ):void
        {
            pauseCalled = true ;
        }
       
        public function progress( action:Action ):void
        {
            progressCalled = true ;
        }
        
        public function resume( action:Action ):void
        {
            resumeCalled = true ;
        }
        
        public function stop( action:Action ):void
        {
            stopCalled = true ;
        }
        
        public function timeout( action:Action ):void
        {
            timeoutCalled = true ;
        }
        
        /**
         * Registers all signals of the object.
         */
        public override function register( action:Action ):void
        {
            super.register( action ) ;
            var ca:CoreAction = action as CoreAction ;
            if ( ca )
            {
                ca.changeIt.connect( change ) ; 
                ca.clearIt.connect( clear ) ; 
                ca.infoIt.connect( info  ) ;
                ca.loopIt.connect( loop ) ;
                ca.pauseIt.connect( pause ) ; 
                ca.progressIt.connect( progress ) ; 
                ca.resumeIt.connect( resume ) ;
                ca.stopIt.connect( stop ) ; 
                ca.timeoutIt.connect( timeout ) ; 
            }
        }
        
        /**
         * Unregisters all signals of the action register in this mock.
         */
        public override function unregister():void
        {
            var ca:CoreAction = action as CoreAction ;
            if ( ca )
            {
                ca.changeIt.disconnect( change ) ; 
                ca.clearIt.disconnect( clear ) ; 
                ca.infoIt.disconnect( info  ) ;
                ca.loopIt.disconnect( loop ) ;
                ca.pauseIt.disconnect( pause ) ; 
                ca.progressIt.disconnect( progress ) ; 
                ca.resumeIt.disconnect( resume ) ;
                ca.stopIt.disconnect( stop ) ; 
                ca.timeoutIt.disconnect( timeout ) ; 
            }
            super.unregister() ;
        }
    }
}
