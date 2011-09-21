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
    import flash.events.Event;
    import flash.events.EventDispatcher;
    
    /**
     * A process who dispatch events with a specific EventDispatcher object.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * package examples
     * {
     *     import system.process.Action;
     *     import system.process.EventDispatcherTask;
     *     
     *     import flash.display.Sprite;
     *     import flash.events.Event;
     *     import flash.events.EventDispatcher;
     *     
     *     public class EventDispatcherTaskExample extends Sprite
     *     {
     *         public function EventDispatcherTaskExample()
     *         {
     *             var dispatcher:EventDispatcher = new EventDispatcher() ;
     *             var event:Event                = new Event("action") ;
     *             
     *             process.addEventListener( "action" , debug ) ;
     *             
     *             var process:EventDispatcherTask = new EventDispatcherTask( dispatcher , event ) ;
     *             
     *             process.finishIt.connect( finish ) ;
     *             process.start.connect( start ) ;
     *             
     *             process.run() ;
     *         }
     *         
     *         public function debug( e:Event ):void
     *         {
     *             trace( e.type ) ;
     *         }
     *         
     *         public function finish( action:Action ):void
     *         {
     *             trace( "finish" ) ;
     *         }
     *         
     *         public function start( action:Action ):void
     *         {
     *             trace( "start" ) ;
     *         }
     *     }
     * }
     * </pre>
     */
    public class EventDispatcherTask extends Task 
    {
        /**
         * Creates a new EventDispatcherTask instance.
         * @param dispatcher The EventDispatcher reference.
         * @param event The event to dispatch.
         * @param throwable Indicates if the task throw errors.
         */
        public function EventDispatcherTask( dispatcher:EventDispatcher = null , event:* = null , throwable:Boolean = false )
        {
            this.dispatcher = dispatcher ;
            this.event      = event ;
            this.throwable  = throwable ;
        }
        
        /**
         * The EventDispatcher reference.
         */
        public var dispatcher:EventDispatcher ;
        
        /**
         * The event to dispatch in this process.
         */
        public var event:Event ;
        
        /**
         * Switch the verbose mode of the task.
         */
        public var throwable:Boolean ;
        
        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public override function clone():*
        {
            return new EventDispatcherTask( dispatcher , event , throwable ) ;
        }
        
        /**
         * Run the process.
         */
        public override function run( ...arguments:Array ):void 
        {
            notifyStarted() ;
            if ( dispatcher )
            {
                if ( event )
                {
                    dispatcher.dispatchEvent( event ) ;
                }
                else if ( throwable )
                {
                    throw new Error(this + " failed, the event reference not must be null.") ;
                }
            }
            else if ( throwable )
            {
                throw new Error(this + " failed, the dispatcher reference not must be null.") ;
            }
            notifyFinished() ;
        }
    }
}