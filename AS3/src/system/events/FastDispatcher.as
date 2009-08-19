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

package system.events 
{
    import system.Cloneable;
    
    import flash.events.Event;
    
    /**
     * This class provides a fast event dispatcher based "Observer" event model (like ASBroadcaster in AS1) but used <code>Event</code> object to dispatch the message to the listeners.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * package examples 
     * {
     *     import system.events.BasicEvent;
     *     import system.events.FastDispatcher;
     *     
     *     import flash.display.Sprite;
     *     import flash.events.Event;
     *     
     *     [SWF(width="740", height="480", frameRate="24", backgroundColor="#666666")]
     *     
     *     public class FastDispatcherExample extends Sprite
     *     {
     *         public function FastDispatcherExample()
     *         {
     *             var dispatcher:FastDispatcher = new FastDispatcher() ;
     *             
     *             dispatcher.addListener( this ) ;
     *             
     *             dispatcher.broadcastMessage( "onCallback" ) ;
     *             dispatcher.dispatch( new BasicEvent( "onCallback" ) ) ;
     *         }
     *         
     *         public function onCallback( e:Event ):void
     *         {
     *             trace( e ) ;
     *         }
     *     }
     * }
     * </pre>
     */
    public class FastDispatcher extends CoreBroadcaster implements Cloneable
    {
        /**
         * Creates a new FastDispatcher instance.
         * @param listeners An optional Array of listeners to register when the dispatcher is initialized.
         */
        public function FastDispatcher( listeners:Array = null )
        {
            super( listeners ) ;
        }
        
        /**
         * Broadcast the specified message.
         * @return The reference of the Event dispatched by the dispatcher.
         */
        public override function broadcastMessage( message:String , ...rest:Array ):*
        {
            if ( message == null && listeners.size() == 0 )
            {
                return null ;
            }
            var e:BasicEvent = new BasicEvent( message , this , rest ) ;
            _propagate( e ) ;
            return e ;
        }
        
        /**
         * Creates and returns a shallow copy of the object.
         * @return A new object that is a shallow copy of this instance.
         */
        public function clone():*
        {
            return new FastDispatcher( listeners.toArray() ) ;
        }
        
        /**
         * Sends an Event Object to each object in the list of listeners.
         * When the Event is received by the listening object, Flash Player attempts to invoke a function of the same name on the Event.type property.
         */
        public function dispatch( e:Event ):void 
        {
            if ( e == null && listeners.size() == 0 )
            {
                return ;
            }
            _propagate( e ) ;
        }
        
        /**
         * @private
         */
        private function _propagate( e:Event ):void
        {
            var o:* ;
            var a:Array  = listeners.toArray() ;
            var l:int    = a.length ;
            var t:String = e.type ;
            for ( var i:int ; i<l ; i++ ) 
            {
                o = a[i] ;
                if ( t in o && o[t] is Function )
                {
                    o[t].call( o , e ) ;
                }
            }
        }
    }
}
