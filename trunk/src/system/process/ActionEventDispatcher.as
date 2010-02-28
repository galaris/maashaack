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
  Portions created by the Initial Developers are Copyright (C) 2006-2010
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
    import system.events.BasicEvent;
    
    import flash.events.Event;
    
    /**
     * A process who dispatch events in the global event flow or locally.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * package examples
     * {
     *     import system.events.ActionEvent;
     *     import system.process.ActionEventDispatcher;
     *     
     *     import flash.display.Sprite;
     *     import flash.events.Event;
     *     
     *     [SWF(width="740", height="480", frameRate="24", backgroundColor="#666666")]
     *     
     *     public class ActionEventDispatcherExample extends Sprite
     *     {
     *         public function ActionEventDispatcherExample()
     *         {
     *             var process:ActionEventDispatcher = new ActionEventDispatcher() ;
     *             
     *             process.event = new Event("action") ; // register an Event in the process.
     *             
     *             process.addEventListener( "action" , debug ) ;
     *             
     *             process.addEventListener( ActionEvent.START  , debug ) ;
     *             process.addEventListener( ActionEvent.FINISH , debug ) ;
     *             
     *             process.run() ;
     *         }
     *         
     *         public function debug( e:Event ):void
     *         {
     *             trace(e) ;
     *         }
     *     }
     * }
     * </pre>
     */
    public class ActionEventDispatcher extends Task 
    {
        /**
         * Creates a new ActionEventDispatcher instance.
         * @param event The event to dispatch.
         * @param global the flag to use a global event flow or a local event flow.
         * @param channel the name of the global event flow if the <code class="prettyprint">global</code> argument is <code class="prettyprint">true</code>.
         */
        public function ActionEventDispatcher( event:* = null , global:Boolean = false, channel:String = null)
        {
            super( global, channel ) ;
            this.event = event ;
        }
        
        /**
         * The event to dispatch in this process.
         */
        public function get event():*
        {
            return _event ;
        }
        
        /**
         * The event to dispatch in this process.
         */
        public function set event( e:* ):void
        {
            if ( e is String )
            {
                _event = new BasicEvent( e as String ) ;
            }
            else if ( e is Event )
            {
                _event = e as Event ;
            }
            else
            {
                _event = null ;
            }
        }
        
        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public override function clone():*
        {
            return new ActionEventDispatcher( event , isGlobal() , channel ) ;
        }
        
        /**
         * Run the process.
         */
        public override function run( ...arguments:Array ):void 
        {
            notifyStarted() ;
            if ( _event != null )
            {
                dispatchEvent( _event ) ;
            }
            notifyFinished() ;
        }
        
        /**
         * @private
         */
        private var _event:Event ;
    }
}