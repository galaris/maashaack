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
  Portions created by the Initial Developers are Copyright (C) 2006-2009
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

package system.data.arrays.mocks 
{
    import system.data.arrays.ArrayFilter;
    
    import flash.events.Event;    

    /**
     * This Mock object listen all events dispatched from an ArrayFilter object.
     */
    public class MockArrayFilterListener 
    {
    
        /**
         * Creates a new MockArrayFilterListener instance.
         * @param af The ArrayFilter of this mock to register.
         */
        public function MockArrayFilterListener( af:ArrayFilter=null )
        {
            if ( af != null )
            {
                register(af) ;
            }    
        }
        
        /**
         * The ArrayFilter object to register and test.
         */
        public var af:ArrayFilter ;
         
        /**
         * Indicates if the Event.CHANGE event is invoked.
         */
        public var changeCalled:Boolean ;
        
        /**
         * Indicates the type of the change event notification.
         */     
        public var changeType:String ;
        
        /**
         * Invoked when the Event.CHANGE event is dispatched.
         */
        public function onChange( e:Event ):void
        {
            changeCalled = true ;
            changeType   = e.type ;
        }
        
        /**
         * Reset the listener.
         */
        public function reset():void
        {
            changeCalled = false ;
            changeType   = null ;
        }
        
        /**
         * Registers all events of the object.
         */
        public function register( af:ArrayFilter ):void
        {
            if ( this.af != null )
            {
                unregister() ;
            }
            this.af = af ;
            this.af.addEventListener( Event.CHANGE , onChange , false , 0 , true ) ;
        }
                
        /**
         * Unregisters all events of the action register in this mock.
         */
        public function unregister():void
        {
            if ( af != null )
            {
                af.removeEventListener( Event.CHANGE , onChange , false ) ;
            }
        }
        
    }

}
