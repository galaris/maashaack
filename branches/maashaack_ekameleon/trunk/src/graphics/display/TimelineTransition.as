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

package graphics.display 
{
    import graphics.transitions.CoreTransition;
    
    import flash.display.MovieClip;
    
    /**
     * This transition check the frames in the timeline of a specific MovieClip reference and notify a finish and start events between two specific frames. 
     */
    public class TimelineTransition extends CoreTransition 
    {
        /**
         * Creates a new TimelineTransition instance.
         * @param target The MovieClip target reference.
         * @param startIndex The start index.
         * @param finishIndex The finish index.
         * @param defaultIndex This index defines the default frame to stop the timeline of the MovieClip target.
         */
        public function TimelineTransition( target:MovieClip = null , startIndex:* = null , finishIndex:* = null , defaultIndex:* = 1 )
        {
            this.target       = target ;
            this.defaultIndex = defaultIndex ;
            this.finishIndex  = finishIndex ;
            this.startIndex   = startIndex ;
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
         * Run the process.
         */
        public override function run( ...arguments:Array ):void 
        {
            if ( running )
            {
                return ; 
            }
            notifyStarted() ;
            if ( _target )
            {
                if ( _script )
                {
                    _script.clear() ;
                }
                
                _script         = new TimelineScript( _target ) ;
                _script.verbose = verbose ;
                
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
                
                // fix start index
                
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
            else
            {
                if ( verbose )
                {
                    logger.warn(this + " run failed, the target reference not must be null." ) ; 
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
            notifyFinished() ;
        }
        
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
        private var _target:MovieClip ;
        
        /**
         * @private
         */
        private var _startIndex:* = 1 ;
    }
}
