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
    import graphics.transitions.CoreTransition;

    import flash.display.MovieClip;

    /**
     * This transition check the frames in the timeline of a specific MovieClip reference and notify a finish and start events between two specific frames.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * package examples 
     * {
     *     import graphics.display.TimelineTransition;
     *     
     *     import system.events.ActionEvent;
     *     
     *     import flash.display.MovieClip;
     *     import flash.display.Sprite;
     *     import flash.display.StageScaleMode;
     *     import flash.events.KeyboardEvent;
     *     import flash.ui.Keyboard;
     *     
     *     public dynamic class TimelineTransition01Example extends Sprite 
     *     {
     *         public function TimelineTransition01Example()
     *         {
     *             // stage
     *             
     *             stage.scaleMode  = StageScaleMode.NO_SCALE ;
     *             
     *             stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
     *             
     *             // MovieClip target with the three frame labels : 
     *             // "start", "middle" and "finish"
     *             
     *             movieclip = getChildByName("mc") as MovieClip ;
     *             
     *             // timeline script
     *             
     *             timeline = new TimelineTransition( movieclip ) ;
     *             
     *             timeline.defaultIndex = 4 ; // by default stop the MovieClip in the frame index 4.
     *             
     *             timeline.finishIt.connect( finish ) ;
     *             timeline.resumeIt.connect( resume ) ;
     *             timeline.startIt.connect( start ) ;
     *         }
     *         
     *         protected var movieclip:MovieClip ;
     *         protected var timeline:TimelineTransition ;
     *         
     *         protected function finish( action:Action ):void
     *         {
     *             trace( "finish" ) ;
     *         }
     *         
     *         protected function keyDown( e:KeyboardEvent ):void
     *         {
     *             var code:uint = e.keyCode ;
     *             switch( code )
     *             {
     *                 case Keyboard.UP :
     *                 {
     *                     timeline.startIndex  = "middle" ;
     *                     timeline.finishIndex = "finish" ;
     *                     timeline.run() ;
     *                     break ;
     *                 }
     *                 case Keyboard.DOWN :
     *                 {
     *                     timeline.startIndex  = "start" ;
     *                     timeline.finishIndex = "middle" ;
     *                     timeline.run() ;
     *                     break ;
     *                 }
     *                 case Keyboard.SPACE :
     *                 {
     *                     timeline.startIndex  = "start" ;
     *                     timeline.finishIndex = "finish" ;
     *                     timeline.run() ;
     *                     break ;
     *                 }
     *                 case Keyboard.LEFT :
     *                 {
     *                     if ( timeline.running )
     *                     { 
     *                         timeline.stop() ;
     *                     }
     *                     else if ( timeline.stopped )
     *                     {
     *                         timeline.resume() ;
     *                     }
     *                     else
     *                     {
     *                         timeline.start() ;
     *                     }
     *                     break ;
     *                 }
     *             }
     *         }
     *         
     *         protected function resume( action:Action ):void
     *         {
     *             trace( "resume" ) ;
     *         }
     *         
     *         protected function start( action:Action ):void
     *         {
     *             trace( "start" ) ;
     *         }
     *     }
     * }
     * </pre>
     */
    public class TimelineTransition extends CoreTransition 
    {
        /**
         * Creates a new TimelineTransition instance.
         * @param target The MovieClip target reference.
         * @param startIndex The start index.
         * @param finishIndex The finish index.
         * @param looping Specifies whether playback of the clip should continue, or loop (default false). 
         * @param numLoop Specifies the number of the times the presentation should loop during playback.
         * @param defaultIndex This index defines the default frame to stop the timeline of the MovieClip target.
         * @param frameScripts The optional Array of frame scripts.
         */
        public function TimelineTransition( target:MovieClip = null , startIndex:* = null , finishIndex:* = null , looping:Boolean = false , numLoop:uint = 0 , defaultIndex:* = 1 , frameScripts:Array = null )
        {
            this.target       = target ;
            this.looping      = looping ;
            this.numLoop      = numLoop ;
            this.defaultIndex = defaultIndex ;
            this.finishIndex  = finishIndex ;
            this.startIndex   = startIndex ;
            this.frameScripts = frameScripts ;
        }
        
        /**
         * Indicates the current countdown loop value.
         */
        public function get currentLoop():uint
        {
            return numLoop - _currentLoop + 1 ;
        }
        
        /**
         * This index defines the default frame to stop the timeline of the MovieClip target.
         */
        public function get defaultIndex():*
        {
            return _defaultIndex ; 
        }
        
        /**
         * @private
         */
        public function set defaultIndex( index:* ):void
        {
            if ( index is int && index > 1 )
            { 
                _defaultIndex = index as uint ;
            }
            else if ( index is String && (index as String).length > 0 )
            {
                _defaultIndex = index as String ;
            }
            else
            {
                _defaultIndex = null ; 
            }
            if ( _target && _defaultIndex != null )
            {
                _target.gotoAndStop( _defaultIndex ) ;
            }
        }
        
        /**
         * Specifies whether errors encountered by the object are reported to the application.
         * When enableErrorChecking is <code>true</code> methods are synchronous and can throw errors.
         * When enableErrorChecking is <code>false</code>, the default, the methods are asynchronous and errors are not reported.
         * Enabling error checking reduces parsing performance.
         * You should only enable error checking when debugging.
         */
        public var enableErrorChecking:Boolean;
        
        /**
         * Indicates the finish index.
         */
        public function get finishIndex():*
        {
            return _finishIndex ; 
        }
        
        /**
         * @private
         */
        public function set finishIndex( index:* ):void
        {
            if ( index is int && index > 1 )
            { 
                _finishIndex = index as uint ;
            }
            else if ( index is String && (index as String).length > 0 )
            {
                _finishIndex = index as String ;
            }
            else
            {
                _finishIndex = null ; 
            }
        }
        
        /**
         * An optional Array of framescripts to add in the MovieClip target during the transition.
         */
        public var frameScripts:Array ;
        
        /**
         * Specifies the number of the times the presentation should loop during playback.
         */
        public var numLoop:uint ;
        
        /**
         * Indicates the start index.
         */
        public function get startIndex():*
        {
            return _startIndex ;
        }
        
        /**
         * @private
         */
        public function set startIndex( index:* ):void
        {
            if ( index is int && index > 1 )
            { 
                _startIndex = index as uint ;
            }
            else if ( index is String && (index as String).length > 0 )
            {
                _startIndex = index as String ;
            }
            else
            {
                _startIndex = 1 ; 
            }
        }
        
        /**
         * Indicates if the process is stopped. You can resume a stopped transition.
         */
        public function get stopped():Boolean
        {
            return _stopped ; 
        }
        
        /**
         * The MovieClip target reference.
         */
        public function get target():MovieClip
        {
            return _target ;
        }
        
        /**
         * @private
         */
        public function set target( target:MovieClip ):void
        {
            if ( _target && _script )
            {
                _script.clear() ;
            }
            _target = target ;
            if ( _target && _defaultIndex != null )
            {
                _target.gotoAndStop( _defaultIndex ) ;
            }
        }
        
        /**
         * Enables the verbose mode of this object.
         */
        public var verbose:Boolean ;
        
        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public override function clone():*
        {
             return new TimelineTransition( _target, _startIndex , _finishIndex, looping, numLoop, _defaultIndex ) ;
        }
        
        /**
         * Restart the process if the process is stopped.
         */
        public override function resume():void
        {
            if ( _stopped && _target )
            {
                _stopped = false ;
                notifyResumed() ;
                _target.play() ;
            }
        }
        
        /**
         * Run the process.
         */
        public override function run( ...arguments:Array ):void 
        {
            if ( running )
            {
                return ; 
            }
            notifyStarted() ;
            _stopped = false ;
            if ( _target )
            {
                if ( _script )
                {
                    _script.clear() ;
                }
                
                _script                     = new TimelineScript( _target ) ;
                _script.enableErrorChecking = enableErrorChecking ;
                _script.verbose             = verbose ;
                
                // fix finish index
                
                if( _finishIndex is String )
                {
                    _finishIndex = _script.resolve( _finishIndex as String ) ;
                }
                if ( _finishIndex != null && _finishIndex > 1  && _finishIndex <= _target.totalFrames )
                {
                    _script.put( _finishIndex , finish ) ;
                }
                else 
                {
                     _script.put( _target.totalFrames , finish ) ;
                }
                
                if( frameScripts && frameScripts.length > 1 )
                {
                    var clone:Array = [].concat( frameScripts ) ;
                    while( clone.length > 0 )
                    {
                        _script.put( clone.shift() , clone.shift() as Function ) ;
                    }
                }
                
                // run the playback
                
                if ( looping )
                {
                    _currentLoop = numLoop ; 
                }
                else
                {
                    _currentLoop = 0 ;
                }
                
                playback() ;
            }
            else
            {
                if ( verbose )
                {
                    warn(this + " run failed, the target reference not must be null." , verbose , enableErrorChecking ) ; 
                }
                notifyFinished() ;
            }
        }
        
        /**
         * Starts the transition.
         */
        public override function start():void
        {
            run() ;
        }
        
        /**
         * Stops the transition.
         */
        public override function stop():void
        {
            if ( running )
            {
                if( _target )
                {
                    _target.stop() ;
                }
                _stopped = true ;
                notifyStopped() ;
            }
        }
        
        /**
         * Invoked when a specific frame is find in the timeline by the timeline inspector.
         */
        protected function finish():void
        {
            if( _target )
            {
                _target.stop() ;
            }
            if ( looping && _currentLoop > 0 )
            {
                notifyLooped() ;
                _currentLoop -- ;
                playback() ;
            }
            else
            { 
                _currentLoop = 0 ;
                notifyFinished() ;
            } 
        }
        
        /**
         * Starts the playback of the target with the specified start index.
         */
        protected function playback():void
        {
            if( _startIndex is String )
            {
                _startIndex = _script.resolve( _startIndex as String ) ;
            }
            if ( _startIndex != null && _startIndex > 1  && _startIndex <= _target.totalFrames )
            {
                _target.gotoAndPlay( _startIndex ) ;
            }
            else 
            {
                 _target.gotoAndPlay( 1 ) ;
            } 
        }
        
        /**
         * @private
         */
        private var _currentLoop:uint ;
        
        /**
         * @private
         */
        private var _defaultIndex:* = 1 ;
        
        /**
         * @private
         */
        private var _finishIndex:* ;
        
        /**
         * @private
         */
        private var _script:TimelineScript ;
        
        /**
         * @private
         */
        private var _stopped:Boolean ;
        
        /**
         * @private
         */
        private var _target:MovieClip ;
        
        /**
         * @private
         */
        private var _startIndex:* = 1 ;
    }
}
