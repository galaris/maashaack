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

package graphics.display 
{
    import core.maths.clamp;

    import system.data.OrderedIterator;

    import flash.display.MovieClip;
    import flash.errors.IllegalOperationError;

    /**
     * This iterator control the timeline in a MovieClip target.
     * <p><b>Example :</b>With <b>container</b> a MovieClip reference added in the stage of the application, 
     * this MovieClip contains 10 frames</p>
     * <pre class="prettyprint">
     * import graphics.display.TimelineIterator ;
     * 
     * var it:TimelineIterator = new TimelineIterator( container , 2 ) ;
     * 
     * trace( "timeline current frame : " + it.currentFrame ) ;
     * trace( "timeline total frames  : " + it.totalFrames ) ;
     * 
     * var keyDown:Function = function( e:KeyboardEvent ):void
     * {
     *     var code:uint = e.keyCode ;
     *     switch(code)
     *     {
     *         case Keyboard.LEFT :
     *         {
     *             if ( it.hasPrevious() )
     *             {
     *                 it.previous() ;
     *             }
     *             else
     *             {
     *                 it.last() ;
     *             }
     *             break ;
     *         }
     *         case Keyboard.RIGHT :
     *         {
     *             if ( it.hasNext() )
     *             {
     *                 it.next() ;
     *             }
     *             else
     *             {
     *                 it.reset() ;
     *             }
     *             break ;
     *         }
     *     }
     *     trace( "timeline : " + it.currentFrame + " | " + it.totalFrames + " | frame label : " + it.currentLabel ) ;
     * }
     * 
     * stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
     * </pre>
     */
    public class TimelineIterator implements OrderedIterator  
    {
        /**
         * Creates a new TimelineIterator instance.
         * @param target The MovieClip reference of this iterator.
         * @param framePosition the default framePosition of the specified MovieClip target (default frame 1).
         * @param stepSize (optional) the step between two frames returns by the iterator (default and minimum value is 1).
         * @throws ArgumentError if the <code class="prettyprint">target</code> argument of this constructor is null.
         */
        public function TimelineIterator( target:MovieClip , framePosition:Number = NaN, stepSize:uint = 1 )
        {
            if (target == null)
            {
                throw new ArgumentError( this + " constructor failed, the target argument not must be null.") ;
            }
            _target = target ;
            _step   = Math.max( DEFAULT_STEP , stepSize ) ; 
            if ( !isNaN( framePosition ) )
            {
                seek( framePosition ) ;
            }
        }
        
        /**
         * The minimum and default step value in all the TimelineIterator.
         */
        public static const DEFAULT_STEP:Number = 1 ;
        
        /**
         * The current label in which the playhead is located in the timeline of the MovieClip instance.
         */
        public function get currentLabel():String
        {
            return _target.currentLabel ;
        }
        
        /**
         * The current frame of the iterator.
         */
        public function get currentFrame():int
        {
            return _target.currentFrame ;
        }
        
        /**
         * Returns the step size of this TimelineIterator.
         * @return the step size of this TimelineIterator.
         */
        public function get stepSize():uint
        {
            return _step ;
        }
        
        /**
         * Returns the target reference of this iterator.
         */
        public function get target():MovieClip
        {
            return _target ;
        }
        
        /**
         * The current frame of the iterator.
         */
        public function get totalFrames():Number
        {
            return _target.totalFrames ;
        }
        
        /**
         * Checks to see if there is a previous element that can be iterated to.
         * @return <code class="prettyprint">true</code> if the iterator has more elements.
         */
        public function hasPrevious():Boolean 
        {
            return _target.currentFrame > 1 ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the iteration has more elements.
         * @return <code class="prettyprint">true</code> if the iterator has more elements.
         */
        public function hasNext():Boolean 
        {
            return _target.currentFrame < _target.totalFrames ;
        }
        
        /**
         * Returns the current page number.
         * @return the current page number.
         */
        public function key():*
        {
            return _target.currentFrame ;
        }
        
        /**
         * Seek the key pointer of the iterator over the last frame of the timeline.
         */
        public function last():void 
        {
            _target.gotoAndStop(_target.totalFrames) ;
        }
        
        /**
         * Returns the next Array page of elements or the next element in the Array if the getStepSize() value is 1.
         * @return the next Array page of elements or the next element in the Array if the getStepSize() value is 1.
         */
        public function next():* 
        {
            var k:uint = _target.currentFrame ;
            k += _step ;
            k = (k < _target.totalFrames) ? k : _target.totalFrames ;
            _target.gotoAndStop(k) ;
            return k ;
        }
        
        /**
         * Returns the previous Array page of elements or the previous element in the Array if the getStepSize() value is 1.
         * @return the previous element from the collection.
         */
        public function previous():*
        {
            var k:uint = _target.currentFrame ;
            k -= _step ;
            k = (k > 1) ? k : 1 ;
            _target.gotoAndStop(k) ;
            return k ;
        }
        
        /**
         * Unsupported operation in this iterator.
         * @throws flash.errors.IllegalOperationError the method remove() in this iterator is unsupported. 
         */
        public function remove():*
        {
            throw new IllegalOperationError( this + " remove method is unsupported by this instance.") ;
        }
        
        /**
         * Resets the key pointer of the iterator.
         */
        public function reset():void 
        {
            _target.gotoAndStop(1) ;
        }
        
        /**
         * Seek the key pointer of the iterator.
         */
        public function seek( position:* ):void 
        {
            _target.gotoAndStop( clamp( position, 1, _target.totalFrames )) ;
        }
        
        /**
         * @private
         */
        private var _step:uint ;
        
        /**
         * @private
         */
        private var _target:MovieClip ;
    }
}