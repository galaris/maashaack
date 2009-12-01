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
    import system.data.Iterator;
    import system.events.ActionEvent;
    import system.process.Stoppable;
    
    /**
     * This <code class="prettyprint">Action</code> object register <code class="prettyprint">Action</code> objects in a batch process.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.events.ActionEvent ;
     * import system.process.BatchProcess ;
     * import system.process.Pause ;
     * 
     * var finish:Function = function( e:ActionEvent ):void
     * {
     *     trace ( e.type ) ;
     * }
     * 
     * var progress:Function = function( e:ActionEvent ):void
     * {
     *     trace ( e.type + " : " + e.context ) ;
     * }
     * 
     * var start:Function = function( e:ActionEvent ):void
     * {
     *     trace ( e.type ) ;
     * }
     * 
     * var batch:BatchProcess = new BatchProcess() ;
     * 
     * batch.addEventListener( ActionEvent.START    , start    ) ;
     * batch.addEventListener( ActionEvent.FINISH   , finish   ) ;
     * batch.addEventListener( ActionEvent.PROGRESS , progress ) ;
     * 
     * batch.addAction( new Pause( 2  , true ) ) ;
     * batch.addAction( new Pause( 10 , true ) ) ;
     * batch.addAction( new Pause( 1  , true ) ) ;
     * batch.addAction( new Pause( 5  , true ) ) ;
     * batch.addAction( new Pause( 7  , true ) ) ;
     * batch.addAction( new Pause( 2  , true ) ) ;
     * 
     * batch.run() ;
     * 
     * // onStarted
     * // onProgress : [Pause duration:1s]
     * // onProgress : [Pause duration:2s]
     * // onProgress : [Pause duration:2s]
     * // onProgress : [Pause duration:5s]
     * // onProgress : [Pause duration:7s]
     * // onProgress : [Pause duration:10s]
     * // onFinished
     * </pre>
     */
    public class BatchProcess extends Task implements Stoppable
    {
        /**
         * Creates a new BatchProcess instance.
         * @param global the flag to use a global event flow or a local event flow.
         * @param channel the name of the global event flow if the <code class="prettyprint">global</code> argument is <code class="prettyprint">true</code>.
         */
        function BatchProcess( global:Boolean = false , channel:String = null ) 
        {
            super( global , channel ) ;
            _batch = new Batch() ;
         }
        
        /**
         * Indicates if all elements in the batch are removed when all the process are finished.
         */
        public var autoClear:Boolean ;
        
        /**
         * Inserts a new Action object in the batch process collection.
         */
        public function addAction( action:Action , useWeakReference:Boolean=false ):Boolean
        {
            if ( action != null )
            {
                action.addEventListener( ActionEvent.FINISH, _onFinished , false, 0 , useWeakReference ) ;
                return _batch.add( action ) ;
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Clear the layout manager.
         */
        public function clear():void
        {
            if ( running && !_batch.isEmpty() )
            {
                var it:Iterator = _batch.iterator() ;
                while(it.hasNext())
                {
                    var action:Action = it.next() ;
                    action.removeEventListener( ActionEvent.FINISH, _onFinished ) ;
                    clearProcess( action ) ;
                }
            }
            _batch.clear() ;
            _cpt = 0 ;
        }
        
        /**
         * Clear the specified process. This method map all Action objects in the batch when the batch is cleared.
         * Overrides this method in a custom BatchProcess implementation. 
         */
        public function clearProcess( action:Action ):void
        {
            // overrides this method
        }
        
        /**
         * Returns a shallow copy of the object.
         * @return a shallow copy of the object.
         */
        public override function clone():*
        {
            var b:BatchProcess = new BatchProcess() ;
            var it:Iterator = _batch.iterator() ;
            while (it.hasNext()) 
            {
                b.addAction( it.next() ) ;
            }
            return b ;
        }
        
        /**
         * Returns the internal Batch reference of this layout manager.
         * @return the internal Batch reference of this layout manager.
         */
        public function getBatch():Batch
        {
            return _batch ;
        }
        
        /**
         * Returns an iterator over the elements in this collection.
         * @return an iterator over the elements in this collection.
         */
        public function iterator():Iterator
        {
            return _batch.iterator() ;
        }        
        
        /**
         * Notify an ActionEvent when the process is in progress.
         */
        public function notifyProgress( action:Action ):void 
        {
            dispatchEvent( new ActionEvent( ActionEvent.PROGRESS, this , null, action ) ) ;
        }
        
        /**
         * Removes an <code class="prettyprint">Action</code> object in the internal batch collection.
         * @return <code class="prettyprint">true</code> if the passed-in action reference is removed in the batch. 
         */
        public function removeAction( action:Action ):Boolean
        {
            if ( _batch.contains( action ) )
            {
                action.removeEventListener( ActionEvent.FINISH, _onFinished ) ;
                _batch.remove( action ) ;
                return true ;
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Runs the process.
         */
        public override function run( ...arguments:Array ):void
        {
            notifyStarted() ;
            if ( size() > 0 )
            {
                _cpt = 0 ;
                _batch.run() ;
            }
            else
            {
                notifyFinished() ;
            }
        }
        
        /**
         * Stops all process in the batch.
         */
        public function stop():void
        {
            _batch.stop() ;
        }
        
        /**
         * Returns the number of Action object in this batch process.
         * @return the number of Action object in this batch process.
         */
        public function size():uint
        {
            return _batch.size() ;
        }
        
        /**
         * The internal batch process of this manager.
         */
        private var _batch:Batch ;
        
        /**
         * Internal count use in the _onFinished method.
         */
        private var _cpt:Number ;
        
        /**
         * Invoked when a tween finish this movement.
         * If all tweens are finished the notifyFinished method is invoked.
         */
        private function _onFinished( e:ActionEvent ):void
        {
            _cpt ++ ;
            notifyProgress( e.target as Action ) ;
            if (_cpt == _batch.size())
            {
                if ( autoClear )
                {
                    clear() ;
                }
                notifyFinished() ;
            }
        }
    }
}