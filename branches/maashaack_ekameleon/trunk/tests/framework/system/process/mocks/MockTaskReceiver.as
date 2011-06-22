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

    /**
     * This Mock receive all signal emited from a basic Action object.
     */
    public class MockTaskReceiver
    {
        /**
         * Creates a new MockTaskReceiver instance.
         * @param action The Action reference.
         */
        public function MockTaskReceiver( action:Action = null )
        {
            if ( action != null )
            {
                register( action ) ;
            }
        }
        
        /**
         * The Action reference to mock.
         */
        public var action:Action ;
         
        /**
         * Indicates if the ActionEvent.FINISH event is invoked.
         */
        public var finishCalled:Boolean ;
        
        /**
         * Indicates if the Action owner object is running during the process.
         */
        public var isWasRunning:Boolean ;
        
        /**
         * Indicates if the ActionEvent.CALLED event is invoked.
         */
        public var startCalled:Boolean ;
        
        /**
         * Invoked when the ActionEvent.FINISH event is dispatched.
         */
        public function onFinish( action:Action ):void
        {
            finishCalled = true   ;
        }
       
        /**
         * Invoked when the ActionEvent.FINISH event is dispatched.
         */
        public function onStart( action:Action ):void
        {
            startCalled = true ;
            isWasRunning = action.running ;
        }
        
        /**
         * Registers all events of the object.
         */
        public function register( action:Action ):void
        {
            this.action = action ;
            this.action.finishIt.connect( onFinish ) ;
            this.action.startIt.connect( onStart ) ;
        }
        
        /**
         * Unregisters all events of the action register in this mock.
         */
        public function unregister():void
        {
            if ( action )
            {
                action.finishIt.disconnect( onFinish ) ;
                action.startIt.disconnect( onStart ) ;
                action = null ;
            }
        }
    }
}
