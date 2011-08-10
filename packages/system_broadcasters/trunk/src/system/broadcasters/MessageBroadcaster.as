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

package system.broadcasters 
{
    /**
     * This class provides a Broadcaster to dispatch basic message, this broadcaster use a basic "Observer" implementation (like ASBroadcaster in AS1).
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * package examples 
     * {
     *     import system.events.MessageBroadcaster;
     *     import flash.display.Sprite;
     *     
     *     [SWF(width="740", height="480", frameRate="24", backgroundColor="#666666")]
     *     
     *     public class MessageBroadcasterExample extends Sprite
     *     {
     *         public function MessageBroadcasterExample()
     *         {
     *             var broadcaster:MessageBroadcaster = new MessageBroadcaster() ;
     *             broadcaster.addListener( this ) ;
     *             broadcaster.broadcastMessage( "message" , "hello" , "world" ) ;
     *         }
     *         
     *         public function message( ...arguments:Array ):void
     *         {
     *             trace( "message : " + arguments ) ;
     *         }
     *     }
     * }
     * </pre>
     */
    public class MessageBroadcaster extends InternalBroadcaster
    {
        /**
         * Creates a new MessageBroadcaster instance.
         * @param listeners The Array collection of listeners to register in the dispatcher.
         */
        public function MessageBroadcaster( listeners:Array = null )
        {
            super( listeners ) ;
        }
        
        /**
         * Broadcast the specified message.
         * @return The reference of the Event dispatched by the dispatcher.
         */
        public override function broadcastMessage( message:String , ...rest:Array ):*
        {
            if ( message == null || listeners.length == 0 )
            {
                return false ;
            }
            var o:* ;
            var b:Boolean ;
            var e:BroadcasterEntry ;
            var r:Vector.<BroadcasterEntry> = new Vector.<BroadcasterEntry>() ;
            var v:Vector.<BroadcasterEntry> = listeners.slice() ;
            var l:int = v.length ;
            for ( var i:int ; i<l ; i++ ) 
            {
                e = v[i] as BroadcasterEntry ;
                o = e.listener ;
                if ( o != null && message in o && o[message] is Function )
                {
                    o[message].apply( o , rest ) ;
                    b = true ;
                    if ( e.autoRemove )
                    {
                        r.push( e ) ;
                    }
                }
            }
            if ( r.length > 0 )
            {
                l = r.length ;
                while( --l > -1 )
                {
                    i = listeners.indexOf( r[l] ) ;
                    if ( i > -1 )
                    {
                        listeners.splice( i , 1 ) ;
                    }
                }
            }
            return b ;
        }
    }
}
