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

package graphics.uikit
{
    import graphics.transitions.FrameLoop;
    
    import system.process.Resetable;
    import system.process.Startable;
    import system.process.Stoppable;
    import system.process.Task;
    import system.signals.Signal;
    import system.signals.Signaler;
    
    import flash.utils.getTimer;
    
    public class FPSCounter extends Task implements Resetable, Startable, Stoppable
    {
        /**
         * Creates a new FPSCounter instance.
         */
        public function FPSCounter()
        {
            _loop.connect( __loop__ ) ;
        }
        
        /**
         * Indicates the frame rate of the application.
         */
        public function get fps():uint
        {
            return _fps ;
        }
        
        /**
         * Emits a message when the fps counter is changed.
         */
        public function get changed():Signaler
        {
            return _changed ;
        }
        
        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public override function clone():*
        {
            return new FPSCounter() ;
        }
        
        /**
         * Reset the process.
         */
        public function reset():void 
        {
            _currentFrame = 0 ;
            _fps          = 0 ;
            _startTime    = getTimer() ;
            _loop.play() ;
        }
        
        /**
         * Run the process.
         */
        public override function run( ...arguments:Array ):void 
        {
            if( !running )
            {
                notifyStarted() ;
                reset() ;
                _loop.play() ;
            }
        }
        
        /**
         * Start the process.
         */
        public function start():void
        {
            run() ;
        }
        
        /**
         * Stop the process.
         */
        public function stop():void
        {
            if( running )
            {
                _loop.stop() ;
                notifyFinished() ;
            }
        }
        
        /**
         * @private
         */
        protected const _changed:Signaler = new Signal() ;
        
        /**
         * @private
         */
        protected var _currentFrame:uint ;
        
        /**
         * @private
         */
        protected var _currentTime:Number ;
        
        /**
         * @private
         */
        protected var _fps:uint ;
        
        /**
         * @private
         */
        protected const _loop:FrameLoop = new FrameLoop() ;
        
        /**
         * @private
         */
        protected var _startTime:Number ;
        
        /**
         * @private
         */
        protected function __loop__( ):void
        {
            _currentTime = (getTimer() - _startTime) / 1000 ;
            _currentFrame++ ;
            if ( _currentTime > 1 )
            {
                _fps = Math.floor( (_currentFrame/_currentTime) * 10.0 ) / 10.0 ;
                _startTime    = getTimer() ;
                _currentFrame = 0 ;
                _changed.emit(_fps) ;
            }
        }
    }
}
