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

package system.process 
{
    import system.Reflection;
    import system.Serializable;
    import system.data.Iterator;
    import system.data.Queue;
    import system.data.queues.LinearQueue;
    import system.data.queues.TypedQueue;
    import system.eden;
    import system.events.ActionEvent;
    import system.hack;
    import system.process.Stoppable;
    
    /**
     * A Sequencer of Action process.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.events.ActionEvent ;
     * import system.process.Sequencer  ;
     * 
     * var handleEvent:Function = function( e:ActionEvent ):void
     * {
     *     trace(e) ;
     * }
     * 
     * var seq:Sequencer = new Sequencer() ;
     * 
     * seq.addEventListener( ActionEvent.START    , handleEvent ) ;
     * seq.addEventListener( ActionEvent.PROGRESS , handleEvent ) ;
     * seq.addEventListener( ActionEvent.FINISH   , handleEvent ) ;
     * 
     * seq.addAction( new Pause( 10 , true ) );
     * seq.addAction( new Pause(  2 , true ) ) ;
     * seq.addAction( new Pause(  5 , true ) ) ;
     * seq.addAction( new Pause( 10 , true ) ) ;
     * seq.run() ;
     * </pre>
     */
    public class Sequencer extends CoreAction implements Serializable, Stoppable
    {
        use namespace hack ;
        
        /**
         * Creates a new Sequencer instance.
         * @param ar An Array of <code class="prettyprint">Action</code> objects.
         * @param global the flag to use a global event flow or a local event flow.
         * @param channel the name of the global event flow if the <code class="prettyprint">global</code> argument is <code class="prettyprint">true</code>.
         * @param queue This optional parameter defines the Queue reference use inside the sequencer, by default the sequencer use a LinearQueue reference.
         */
        public function Sequencer( ar:Array = null , global:Boolean = false , channel:String = null , queue:Queue=null )
        {
            super( global, channel) ;
            setQueue( queue ) ; 
            if ( ar != null )
            {
                var l:int = ar.length ;
                if (l>0) 
                {
                    for ( var i:int = 0 ; i < l ; i++ ) 
                    {
                        if ( ar[i] is Action )
                        {
                            addAction( ar[i] as Action ) ;
                        } 
                    }
                }
            }
        }
        
        /**
         * Indicates the current Action reference in progress.
         */
        public function get current():Action
        {
            return _cur ;
        }
        
        /**
         * Retrieves, but does not remove, the head of this sequencer.
         */
        public function element():* 
        {
            return _queue.element() ;
        }
        
        /**
         * Adds a process(Action) in the Sequencer.
         * @return <code class="prettyprint">true</code> if the method success.
         */
        public function addAction( action:Action , isClone:Boolean = false ):Boolean 
        {
            if ( action == null )
            {
                return false ;
            }
            var a:Action = isClone ? action.clone() : action ;
            var isEnqueue:Boolean = _queue.enqueue(a) ;
            if ( isEnqueue )
            {
                a.addEventListener( ActionEvent.FINISH, run , false, 0 , true ) ;
            }
            return isEnqueue ;
        }
        
        /**
         * Removes all process in the Sequencer.
         */
        public function clear():void 
        {
            if ( running ) 
            {
                if ( _cur != null )
                {
                    _cur.removeEventListener(ActionEvent.FINISH, run) ;
                    if ( _cur is Stoppable )
                    {
                        (_cur as Stoppable).stop() ;
                    }
                    _cur = null ;
                }
                setRunning( false ) ;
            }
            _cur = null ;
            _queue.clear() ;
            if ( !isLocked() ) 
            {
                notifyCleared() ;
            }
        }
        
        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public override function clone():*
        {
            var s:Sequencer = new Sequencer() ;
            var it:Iterator = _queue.iterator() ;
            while ( it.hasNext() ) 
            {
                s.addAction(it.next().clone()) ;
            }
            return s ;
        }
        
        /**
         * Returns the internal Queue reference used in the sequencer. 
         * @return the internal Queue reference used in the sequencer.
         */
        public function getQueue():Queue
        {
            return _internalQueue ;
        } 
        
        /**
         * Launchs the Sequencer with the first element in the internal Queue of this Sequencer.
         */
        public override function run(...arguments:Array):void 
        {
            if ( _queue.size() > 0 ) 
            {
                if ( !running ) 
                {
                    notifyStarted() ;
                }
                else
                {
                    notifyProgress() ;
                }
                _cur = _queue.poll() as Action ;
                if ( _cur != null )
                {
                    _cur.run() ;
                }
                else
                {
                    run() ;
                }
            }
            else 
            {
                notifyProgress() ;
                if ( _cur != null )
                {
                    if ( _cur is Stoppable )
                    {
                        (_cur as Stoppable).stop() ;
                    }
                    _cur.removeEventListener( ActionEvent.FINISH, run ) ;
                    _cur = null ;
                }
                if ( running == true ) 
                {
                    notifyFinished() ;
                }
            }
        }
        
        /**
         * Sets the internal Queue reference used in the sequencer.
         * This queue is protected with a TypedQueue object but you can't use this protector.
         * By default if the queue isn't defines, a LinearQueue is used in the sequencer. 
         * @param q The Queue reference to use in this sequencer.
         */
        public function setQueue( q:Queue ):void
        {
            if ( running )
            {
                stop() ;
            }
            _internalQueue = q || new LinearQueue() ;
            _queue         = new TypedQueue( Action, _internalQueue ) ;
        } 
        
        /**
         * Returns the numbers of process in this Sequencer.
         * @return the numbers of process in this Sequencer.
         */
        public function size():uint
        {
            return _queue.size() ;
        }
        
        /**
         * Starts the Sequencer if is not in progress.
         */
        public function start():void 
        {
            if ( ! running ) 
            {
                run() ;
            }
        }
        
        /**
         * Stops the Sequencer. Stop only the last process if is running.
         */
        public function stop():void
        {
            if ( running ) 
            {
                if ( _cur != null )
                {
                    _cur.removeEventListener(ActionEvent.FINISH, run) ;
                    if ( _cur is Stoppable )
                    {
                        (_cur as Stoppable).stop() ;
                    }
                    _cur = null ;
                }
                setRunning(false) ;
                if ( !isLocked() )
                {
                    notifyStopped() ;
                    notifyFinished() ;
                }
            }
        }
        
        /**
         * Returns the array representation of all process in this Sequencer.
         * @return the array representation of all process in this Sequencer.
         */
        public function toArray():Array 
        {
            return _queue.toArray() ;
        }
        
        /**
         * Returns the source of the specified object passed in argument.
         * @return the source of the specified object passed in argument.
         */
        public function toSource( indent:int = 0 ):String  
        {
            return "new " + Reflection.getClassPath(this) + "(" + eden.serialize(toArray()) + ")" ;
        }
        
        /**
         * @private
         */
        hack var _cur:Action ;
        
        /**
         * @private
         */
        private var _internalQueue:Queue ;
        
        /**
         * @private
         */
        private var _queue:TypedQueue  ;
    }
}