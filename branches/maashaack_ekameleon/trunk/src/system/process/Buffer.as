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
    import system.hack;
    
    // TODO loop + numLoop
    // TODO type : NORMAL / QUEUE
    
    /**
     * Experimental Buffer class to replace Sequencer in the next version of the system.process package.
     */
    public class Buffer extends CoreAction implements Startable, Stoppable
    {
        use namespace hack ;
        
        /**
         * Creates a new Buffer instance.
         * @param length The initial length (number of elements) of the Vector. If this parameter is greater than zero, the specified number of Vector elements are created and populated with the default value appropriate to the base type (null for reference types).
         * @param fixed Whether the buffer length is fixed (true) or can be changed (false). This value can also be set using the fixed property.
         * @param init A dynamic object who contains Action to initialize the buffer.
         */
        public function Buffer( length:uint = 0, fixed:Boolean = false , init:* = null )
        {
            _buffer = new Vector.<Action>( length , fixed ) ;
            if ( init )
            {
                for each( var action:Action in init )
                {
                    addAction( action as Action ) ;
                }
            }
        }
        
        /**
         * Returns the numbers of actions in this buffer.
         * @return the numbers of actions in this buffer.
         */
        public function length():uint
        {
            return _buffer.length ;
        }
        
        /**
         * Insert an action in the buffer.
         * @return <code class="prettyprint">true</code> if the insert is success.
         */
        public function addAction( action:Action ):Boolean 
        {
            if ( action )
            {
                _buffer[_buffer.length] = action ;
                action.finishIt.connect( next ) ;
                return true ;
            }
            return false ;
        }
        
        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public override function clone():*
        {
            return new Buffer( _buffer.length , _buffer.fixed , _buffer ) ;
        }
        
        /**
         * Dispose the buffer and disconnect all actions register in the buffer.
         */
        public function dispose():void
        {
            var len:int = _buffer.length ;
            if ( len > 0 )
            {
                while( --len > -1 )
                {
                    _buffer[len].finishIt.disconnect( next ) ;
                }
            }
        }
        
        /**
         * Indicates if the buffer contains a next action during the process.
         */
        hack function hasNext():Boolean
        {
            return _position < _buffer.length ;
        }
        
        /**
         * Remove a specific action register in the buffer. If the passed-in argument is null all actions register in the buffer are removed. If the buffer is in progress and the current action is the same passed-in action reference the buffer is stopped and the buffer process too.
         * @return <code class="prettyprint">true</code> if the method success.
         */
        public function removeAction( action:Action = null ):Boolean 
        {
            if ( running ) 
            {
                setRunning( false ) ;
                stopCurrent() ;
            }
            if ( _buffer.length > 0 )
            {
                if ( action == null )
                {
                    dispose() ;
                    _buffer.length = 0 ;
                    _current       = null ;
                    if ( !isLocked() ) 
                    {
                        notifyCleared() ;
                    }
                    return true ;
                }
                else
                {
                    var index:int = _buffer.indexOf( action ) ;
                    if ( index > -1 )
                    {
                        action.finishIt.disconnect( next ) ;
                        _buffer.splice( index , 1 ) ;
                        return true ;
                    }
                }
            }
            return false ;
        }
        
        /**
         * Sets the internal buffer.
         * @param length The initial length (number of elements) of the Vector. If this parameter is greater than zero, the specified number of Vector elements are created and populated with the default value appropriate to the base type (null for reference types).
         * @param fixed Whether the buffer length is fixed (true) or can be changed (false). This value can also be set using the fixed property.
         */
        public function setup( length:uint = 0, fixed:Boolean = false ):void
        {
             _buffer = new Vector.<Action>( length , fixed ) ;
        }
        
        /**
         * Resume the buffer.
         */
        public function resume():void 
        {
            if ( _stopped )
            {
                setRunning(true) ;
                _stopped = false ;
                next() ;
            }
            else
            {
                run() ; 
            }
        }
        
        /**
         * Launchs the Sequencer with the first element in the internal Queue of this Sequencer.
         */
        public override function run( ...arguments:Array ):void 
        {
            if ( !running )
            {
                notifyStarted() ;
                _stopped  = false ;
                _position = 0 ;
                next() ;
            }
        }
        
        /**
         * Starts the buffer.
         */
        public function start():void 
        {
            run() ;
        }
        
        /**
         * Stops the buffer. Stop only the current action if is running.
         */
        public function stop():void
        {
            if ( running ) 
            {
                stopCurrent() ;
                setRunning(false) ;
                _stopped = true ;
                if ( !isLocked() )
                {
                    notifyStopped() ;
                }
            }
        }
        
        /**
         * Returns the Array representation of the buffer.
         * @return the Array representation of the buffer.
         */
        public function toArray():Array
        {
            var a:Array = [] ;
            for each( var action:Action in _buffer )
            {
                a[a.length] = action ;
            }
            return a ; 
        }
        
        /**
         * Returns the Vector representation of the buffer.
         * @return the Vector representation of the buffer.
         */
        public function toVector():Vector.<Action>
        {
            return _buffer ; 
        }
        
        /**
         * @private
         */
        hack var _buffer:Vector.<Action> ;
        
        /**
         * @private
         */
        hack var _current:Action ;
        
        /**
         * @private
         */
        hack var _position:int ;
        
        /**
         * @private
         */
        hack var _stopped:Boolean ;
        
        /**
         * Run the next action in the buffer.
         */
        hack function next( ...args:Array ):void 
        {
            if ( _buffer.length > 0 ) 
            {
                if ( hasNext() )
                {
                    _current = _buffer[_position++] as Action ;
                    notifyProgress() ;
                    if ( _current )
                    {
                        _current.run() ;
                    }
                    else
                    {
                        next() ;
                    }
                }
                else
                {
                    notifyFinished() ;
                }
            }
            else 
            {
                notifyFinished() ;
            }
        }
        
        /**
         * Stop the current action in the buffer.
         */
        hack function stopCurrent():void
        {
            if ( _current )
            {
                if ( _current is Stoppable )
                {
                    (_current as Stoppable).stop() ;
                }
                _current = null ;
            } 
        }
    }
}
