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

package graphics.display 
{
    import graphics.events.FrameLabelEvent;

    import system.data.maps.HashMap;
    import system.events.CoreEventDispatcher;
    import system.events.Delegate;
    import system.signals.Signal;

    import flash.display.FrameLabel;
    import flash.display.MovieClip;
    import flash.events.Event;

    /**
     * Dispatched when the inspector is in progress.
     * @eventType graphics.events.FrameLabelEvent.FRAME_LABEL
     */
    [Event(name="frameLabel", type="graphics.events.FrameLabelEvent")]
    
    /**
     * The TimelineInspector class use composition to dispatch action events during the MovieClip playing.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * package examples 
     * {
     *     import graphics.display.TimelineInspector;
     *     import graphics.events.FrameLabelEvent;
     *     
     *     import flash.display.FrameLabel;
     *     import flash.display.MovieClip;
     *     import flash.display.Sprite;
     *     import flash.display.StageAlign;
     *     import flash.display.StageScaleMode;
     *     import flash.events.MouseEvent;
     *     import flash.utils.setTimeout;
     *     
     *     public dynamic class TestTimelineInspector extends Sprite
     *     {
     *          public function TestTimelineInspector()
     *          {
     *              // stage
     *              
     *              stage.align      = StageAlign.TOP_LEFT ;
     *              stage.scaleMode  = StageScaleMode.NO_SCALE ;
     *              
     *              // target
     *              
     *              mc               = getChildByName("mc") as MovieClip ; // MovieClip in the stage of the application
     *              mc.useHandCursor = true ;
     *              mc.buttonMode    = true ;
     *              
     *              mc.addEventListener( MouseEvent.CLICK , click ) ;
     *              
     *              trace("Click the movieclip to start the example.") ;
     *              
     *              // timeline inspector
     *              
     *              var inspector:TimelineInspector = new TimelineInspector( mc , true ) ;
     *              inspector.addEventListener( FrameLabelEvent.FRAME_LABEL , frameLabel ) ;
     *              
     *          }
     *          
     *          public var mc:MovieClip ;
     *          
     *          public function click( e:MouseEvent ):void
     *          {
     *              mc.play() ;
     *          }
     *          
     *         public function frameLabel( e:FrameLabelEvent ):void
     *         {
     *             var frame:FrameLabel = e.frameLabel ;
     *             trace( "progress :: " + frame.frame + " : " + frame.name ) ;
     *             switch( frame.name )
     *             {
     *                 case "finish" :
     *                 {
     *                     mc.stop() ;
     *                     break ;
     *                 }
     *                 case "middle" :
     *                 {
     *                     mc.stop() ;
     *                     setTimeout(mc.play, 5000) ; // pause 5 seconds
     *                     break ;
     *                 }
     *             }
     *         }
     *     }
     * }
     * </pre>
     */
    public class TimelineInspector extends CoreEventDispatcher
    {
        /**
         * Creates a new TimelineInspector instance.
         * @param target The MovieClip reference of this iterator.
         * @param autoStop This boolean flag indicates if the specified MovieClip target reference is stopped when the inspector target the MovieClip reference.
         * @throws ArgumentError if the <code class="prettyprint">target</code> argument of this constructor is null.
         */
        public function TimelineInspector( target:MovieClip , autoStop:Boolean = false , mode:String = "injector" )
        {
            if ( target == null )
            {
                throw new ArgumentError( this + " constructor failed, the target argument not must be null.") ;
            }
            _frameLabel = new Signal( [FrameLabel] ) ;
            _map        = new HashMap() ;
            _target     = target ;
            this.mode   = mode ;
            initialize() ;
            if ( autoStop )
            {
                _target.stop() ;
            }
        }
        
        /**
         * The "injector" mode of the inspector.
         */
        public static const INJECTOR:String = "injector" ;
        
        /**
         * The "timeline" mode of the inspector.
         */
        public static const TIMELINE:String = "timeline" ;
        
        /**
         * The signal to indicates if a new frame is inspected with a specific label.
         */
        public function get frameLabel():Signal
        {
            return _frameLabel ;
        }
        
        /**
         * Determinates the mode of the inspector. 
         * <p>When the "injector" mode is defines, the events are dispatched with a set of methods injected in the timeline scripts. </p>
         * <p>When the "timeline" mode is defines, the user can use script in the frames of the MovieClip but the inspector use the Event.ENTER_FRAME event to dispatch the events (CPU usage).</p>
         */
        public function get mode():String
        {
            return _mode ;
        }
        
        /**
         * @private
         */
        public function set mode( value:String ):void
        {
            var b:Boolean = _flag ;
            if ( b )
            {
                dispose() ;
            }
            _mode = value == TIMELINE ? TIMELINE : INJECTOR ;
            if ( b )
            {
                initialize() ;
            }
        }
        
        /**
         * Indicates the target reference of this iterator.
         */
        public function get target():MovieClip
        {
            return _target ;
        }
        
        /**
         * Initialize the inspector.
         */
        public function initialize():void
        {
            var frame:int ;
            var currentLabels:Array = _target.currentLabels ;
            var element:FrameLabel ;
            if ( _mode == TIMELINE )
            {
                _target.addEventListener( Event.ENTER_FRAME, _enterFrame ) ;
                for each( element in currentLabels )
                {
                    _map.put( element.frame , element ) ;
                }
            }
            else
            {
                for each( element in currentLabels )
                {
                    frame = element.frame - 1 ;
                    frame = frame > 1 ? frame : 1 ;
                    _target.addFrameScript( frame , Delegate.create(this, _dispatch, element ) ) ;
                }
            }
            _flag = true ;
        }
        
        /**
         * Unregisters all notifications in the inspector.
         */
        public function dispose():void
        {
            if ( _flag )
            {
                if ( _mode == TIMELINE )
                {
                    _prev = -1  ;
                    _map.clear() ;
                    _target.removeEventListener(Event.ENTER_FRAME, _enterFrame) ;
                }
                else
                {
                    var frame:int ;
                    var currentLabels:Array = _target.currentLabels ;
                    for each( var element:FrameLabel in currentLabels )
                    {
                        frame = element.frame - 1 ;
                        frame = frame > 1 ? frame : 1 ;
                        _target.addFrameScript( frame , null ) ;
                    }
                }
                _flag = false ;
            }
        }
        /**
         * @private
         */
        private var _flag:Boolean ;
        
        /**
         * @private
         */
        private var _frameLabel:Signal ;
        
        /**
         * @private
         */
        private var _map:HashMap ;
        
        /**
         * @private
         */
        private var _mode:String ;
        
        /**
         * @private
         */
        private var _prev:int = -1 ;
        
        /**
         * @private
         */
        private var _target:MovieClip ;
        
        /**
         * @private
         */
        private function _dispatch( frame:FrameLabel ):void
        {
            dispatchEvent( new FrameLabelEvent( FrameLabelEvent.FRAME_LABEL , frame ) ) ;
            _frameLabel.emit( frame ) ;
        }
        
        /**
         * @private
         */
        private function _enterFrame( e:Event ):void
        {
            e.stopImmediatePropagation() ;
            var frame:int = _target.currentFrame;
            if ( _prev != frame && _map.containsKey( frame ) )
            {
                _prev = frame ;
                dispatchEvent( new FrameLabelEvent( FrameLabelEvent.FRAME_LABEL , _map.get( frame ) as FrameLabel ) ) ;
            }
        }
    }
}
