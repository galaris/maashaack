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
    import system.data.maps.HashMap;

    /**
     * Batchs tasks and notify when all actions are finished.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * package examples
     * {
     *     import system.process.Action;
     *     import system.process.BatchTask;
     *     import system.process.Pause;
     *     
     *     import flash.display.Sprite;
     *     
     *     [SWF(width="740", height="480", frameRate="24", backgroundColor="#666666")]
     *     
     *     public class BatchTaskExample extends Sprite
     *     {
     *         public function BatchTaskExample()
     *         {
     *             batch = new BatchTask() ;
     *             
     *             // batch.mode = BatchTask.TRANSIENT ;
     *             
     *             batch.changeIt.connect( change ) ;
     *             batch.finishIt.connect( finish ) ;
     *             batch.progressIt.connect( progress ) ;
     *             batch.startIt.connect( start ) ;
     *             
     *             batch.addAction( new Pause(  2 , true ) , 0 , true ) ;
     *             batch.addAction( new Pause( 10 , true ) ) ;
     *             batch.addAction( new Pause(  1 , true ) , 0 , true ) ;
     *             batch.addAction( new Pause(  5 , true ) ) ;
     *             batch.addAction( new Pause(  7 , true ) , 0 , true ) ;
     *             batch.addAction( new Pause(  2 , true ) ) ;
     *             
     *             batch.run() ;
     *         }
     *         
     *         public var batch:BatchTask ;
     *         
     *         public function change( action:Action ):void
     *         {
     *             trace( "change :  " + batch.current ) ;
     *         }
     *         
     *         public function finish( action:Action ):void
     *         {
     *             trace( "finish length:" + batch.length ) ;
     *         }
     *         
     *         public function progress( action:Action ):void
     *         {
     *             trace( "progress :  " + batch.current ) ;
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
    public class BatchTask extends TaskGroup 
    {
        /**
         * Creates a new BatchTask instance.
         * @param length The initial length (number of elements) of the Vector. If this parameter is greater than zero, the specified number of Vector elements are created and populated with the default value appropriate to the base type (null for reference types).
         * @param fixed Whether the chain length is fixed (true) or can be changed (false). This value can also be set using the fixed property.
         * @param mode Specifies the mode of the chain. The mode can be "normal" (default), "transient" or "everlasting".
         * @param actions A dynamic object who contains Action references to initialize the chain.
         */
        public function BatchTask(length:uint = 0, fixed:Boolean = false, mode:String = "normal", actions:* = null)
        {
            _currents = new HashMap() ;
            super(length, fixed, mode, actions);
        }
        
        /**
         * Determinates the "everlasting" mode of the batch. In this mode the action register in the batch can't be auto-remove.
         */
        public static const EVERLASTING:String = "everlasting" ;
        
        /**
         * Determinates the "normal" mode of the batch. In this mode the batch has a normal life cycle.
         */
        public static const NORMAL:String = "normal" ;
        
        /**
         * Determinates the "transient" mode of the batch. In this mode all actions are strictly auto-remove in the batch when are invoked.
         */
        public static const TRANSIENT:String = "transient" ;
        
        /**
         * Indicates the current Action reference when the batch is in progress.
         */
        public function get current():Action
        {
            return _current ;
        }
        
        /**
         * @private
         */
        public override function set length( value:uint ):void
        {
            if ( running )
            {
                throw new Error( this + " length property can't be changed, the batch process is in progress." ) ;
            }
            super.length = value ;
        }
        
        /**
         * Insert an action in thechainr.
         * @param priority Determinates the priority level of the action in the chain. 
         * The priority is designated by a signed 32-bit integer. The higher the number, the higher the priority. 
         * All actions with priority n are processed before actions of priority n-1. If two or more actions share the same priority, they are processed in the order in which they were added. The default priority is 0.
         * @param autoRemove Apply a removeAction after the first finish notification.
         * @return <code class="prettyprint">true</code> if the insert is success.
         */
        public override function addAction( action:Action , priority:int = 0 , autoRemove:Boolean = false ):Boolean 
        {
            if ( running )
            {
                throw new Error( this + " addAction failed, the batch process is in progress." ) ;
            }
            return super.addAction( action , priority , autoRemove ) ;
        }
        
        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public override function clone():*
        {
            var clone:BatchTask = new BatchTask( 0 , false, _mode, _actions.length > 0 ? toVector() : null ) ;
            clone.fixed = _actions.fixed ;
            return clone ;
        }
        
        /**
         * Remove a specific action register in the chain and if the passed-in argument is null all actions register in the chain are removed. 
         * If the chain is running the stop() method is called.
         * @return <code class="prettyprint">true</code> if the method success.
         */
        public override function removeAction( action:Action = null ):Boolean 
        {
            if ( running )
            {
                throw new Error( this + " removeAction failed, the batch process is in progress." ) ;
            }
            return super.removeAction( action ) ;
        }
        
        /**
         * Resume the chain.
         */
        public override function resume():void 
        {
            if ( _stopped )
            {
                setRunning(true) ;
                _stopped = false ;
                notifyResumed() ;
                if ( _actions.length > 0 )
                {
                    var a:Action ;
                    var e:ActionEntry ;
                    var l:int = _actions.length ;
                    while( --l > -1 )
                    {
                        e = _actions[l] as ActionEntry ;
                        if ( e )
                        {
                            a = e.action ;
                            if ( a )
                            {
                                if ( a is Resumable )
                                {
                                    (a as Resumable).resume() ;
                                }
                                else
                                {
                                    next(a) ; // finalize the action to clean the batch 
                                }
                            }
                        }
                    }
                }
            }
            else
            {
                run() ; 
            }
        }
        
        /**
         * Launchs the chain process.
         */
        public override function run( ...arguments:Array ):void 
        {
            if ( !running )
            {
                notifyStarted() ;
                _stopped = false ;
                _current  = null ;
                _currents.clear() ;
                if ( _actions.length > 0 )
                {
                    var i:int ;
                    var e:ActionEntry ;
                    var l:int = _actions.length ;
                    for( i ; i<l ; i++ )
                    {
                        e = _actions[i] as ActionEntry ;
                        if ( e && e.action )
                        {
                            _currents.put( e.action , e ) ;
                            e.action.run() ;
                        }
                    }
                }
                else
                {
                    notifyFinished() ;
                }
            }
        }
        
        /**
         * Stops the batch and stop all <code>Stoppable</code> task in the batch.
         */
        public override function stop():void
        {
            if ( running ) 
            {
                if ( _actions.length > 0 )
                {
                    var a:Action ;
                    var e:ActionEntry ;
                    var l:int = _actions.length ;
                    while( --l > -1 )
                    {
                        e = _actions[l] as ActionEntry ;
                        if ( e )
                        {
                            a = e.action ;
                            if ( a && a is Stoppable )
                            {
                                (a as Stoppable).stop() ;
                            }
                        }
                    }
                }
                setRunning(false) ;
                _stopped = true ;
                notifyStopped() ;
            }
        }
        
        /**
         * @private
         */
        protected var _current:Action ;
        
        /**
         * @private
         */
        protected var _currents:HashMap ;
        
        /**
         * Invoked when a task process in the batch is finished.
         */
        protected override function next( action:Action = null ):void 
        {
            if ( action && _currents.containsKey(action) )
            {
                var entry:ActionEntry = _currents.get( action ) ;
                if ( _mode != EVERLASTING )
                {
                    if ( _mode == TRANSIENT || (entry.auto && _mode == NORMAL) )
                    {
                        if ( action )
                        {
                            var e:ActionEntry ;
                            var l:int = _actions.length ;
                            while( --l > -1 )
                            {
                                e = _actions[l] as ActionEntry ;
                                if ( e && e.action == action )
                                {
                                    action.finishIt.disconnect( next ) ;
                                    _actions.splice( l , 1 ) ;
                                    break ;
                                }
                            }
                        }
                    }
                }
                _currents.remove(action) ;
            }
            if ( _current )
            {
                notifyChanged() ;
            }
            _current = action ;
            notifyProgress() ;
            if ( _currents.isEmpty() ) 
            {
                _current = null ;
                notifyFinished() ;
            }
        }
    }
}
