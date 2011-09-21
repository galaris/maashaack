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
    import system.data.Iterator;
    import system.data.maps.HashMap;
    
    import flash.display.FrameLabel;
    import flash.display.MovieClip;
    
    /**
     * The TimeLineScript class use composition to register script function over MovieClip timelines.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * package examples 
     * {
     *     import graphics.display.TimelineScript;
     *     
     *     import flash.display.MovieClip;
     *     import flash.display.Sprite;
     *     import flash.display.StageAlign;
     *     import flash.display.StageScaleMode;
     *     import flash.events.KeyboardEvent;
     *     import flash.ui.Keyboard;
     *     import flash.utils.clearTimeout;
     *     import flash.utils.setTimeout;
     *     
     *     public dynamic class TimelineScriptExample extends Sprite 
     *     {
     *         public function TimelineScriptExample()
     *         {
     *             // stage
     *             
     *             stage.align      = StageAlign.TOP_LEFT ;
     *             stage.scaleMode  = StageScaleMode.NO_SCALE ;
     *             
     *             stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
     *             
     *             // MovieClip target
     *             
     *             movieclip = getChildByName("mc") as MovieClip ;
     *             
     *             // timeline script
     *             
     *             timeline = new TimelineScript( movieclip , true ) ;
     *             
     *             timeline.put( "start"   , start ) ;
     *             timeline.put( "middle"  , pause ) ;
     *             timeline.put( "finish"  , finish ) ;
     *         }
     *         
     *         protected var id:uint ;
     *         protected var movieclip:MovieClip ;
     *         protected var timeline:TimelineScript ;
     *         
     *         protected function pause():void
     *         {
     *             trace( "pause" ) ;
     *             movieclip.stop() ;
     *             if ( id )
     *             {
     *                 clearTimeout( id ) ;
     *             }
     *             id = setTimeout( movieclip.play , 4000 ) ; // pause 4 s
     *         }
     *         
     *         protected function finish():void
     *         {
     *             trace( "finish" ) ;
     *             movieclip.stop() ;
     *         }
     *         
     *         protected function keyDown( e:KeyboardEvent ):void
     *         {
     *             var code:uint = e.keyCode ;
     *             switch( code )
     *             {
     *                 case Keyboard.SPACE :
     *                 {
     *                     movieclip.gotoAndPlay(1) ; // start 
     *                     break ;
     *                 }
     *                 case Keyboard.UP :
     *                 {
     *                     timeline.remove( "middle" ) ;
     *                     break ;
     *                 }
     *                 case Keyboard.DOWN :
     *                 {
     *                     timeline.clear() ;
     *                     break ;
     *                 }
     *             }
     *         }
     *         
     *         protected function start():void
     *         {
     *             trace( "start" ) ;
     *         }
     *     }
     * }
     * </pre>
     */
    public class TimelineScript
    {
        /**
         * Creates a new TimelineScript instance.
         * @param target The MovieClip reference of this iterator.
         * @param autoStop This boolean flag indicates if the specified MovieClip target reference is stopped (default true).
         */
        public function TimelineScript( target:MovieClip = null , autoStop:Boolean = true )
        {
            _map          = new HashMap() ;
            this.autoStop = autoStop ;
            this.target   = target   ;
        }
        
        /**
         * This boolean flag indicates if the specified MovieClip target reference is stopped.
         */
        public var autoStop:Boolean ;
        
        /**
         * Specifies whether errors encountered by the object are reported to the application.
         * When enableErrorChecking is <code>true</code> methods are synchronous and can throw errors.
         * When enableErrorChecking is <code>false</code>, the default, the methods are asynchronous and errors are not reported.
         * Enabling error checking reduces parsing performance.
         * You should only enable error checking when debugging.
         */
        public var enableErrorChecking:Boolean;
        
        /**
         * Indicates the target reference of this iterator.
         */
        public function get target():MovieClip
        {
            return _target ;
        }
        
        /**
         * @private
         */
        public function set target( mc:MovieClip ):void
        {
            if( _target )
            {
                clear() ;
            }
            _target = mc ;
            if( _target )
            {
                if ( autoStop )
                {
                    _target.stop() ;
                }
                initialize() ;
            }
        }
        
        /**
         * The verbose mode flag.
         */
        public var verbose:Boolean ;
        
        /**
         * Clear all scripts in the MovieClip target reference.
         */
        public function clear():void
        {
            if ( _cleared )
            {
                return ;
            }
            if ( _target )
            {
                for( var i:uint = 1 ; i<= target.totalFrames ; i++ )
                {
                    _target.addFrameScript( i - 1 , null ) ;
                }
            }
            _map.clear() ;
            _cleared = true ;
        }
        
        /**
         * Indicates if a script is registerd with the specific frame index (label name or frame value).
         * @param index A String label name or an uint frame index value.
         * @return <code>true</code> if the specific index is registered.
         */
        public function contains( index:* ):Boolean
        {
            try
            {
                var num:uint ;
                if ( index is uint )
                {
                    num = index as uint ;
                }
                else if ( index is String )
                {
                    num = resolve( index as String ) ;
                }
                else
                {
                     throw new ArgumentError( "the index argument must be an int or String value.") ;
                }
                return _map.contains( num ) ;
            }
            catch( e:Error )
            {
                warn( this + " contains failed, " + e.message , verbose , enableErrorChecking ) ;
            }
            return false ;
        }
        
        /**
         * Initialize all registered scripts in the target.
         */
        public function initialize():void
        {
            clear() ;
            if ( _cleared )
            {
                _cleared = false ;
            }
            if ( _target && _map.size() > 0 )
            {
                var it:Iterator = _map.iterator() ;
                while( it.hasNext() )
                {
                    _target.addFrameScript( it.key as uint , it.next() as Function ) ;
                }
            }
        }
        
        /**
         * Registers a script function in the frame specified by the label or index value passed-in the first argument of the method.
         * @param index A String label name or an uint frame index value.
         * @param script The Function instruction to register.
         * @return true if the register is success.
         */
        public function put( index:* , script:Function ):Boolean
        {
            try
            {
                var num:uint ;
                if ( index is uint )
                {
                    num = index as uint ;
                }
                else if ( index is String )
                {
                    num = resolve( index as String ) ;
                }
                else
                {
                     throw new ArgumentError( "the index argument must be an int or String value.") ;
                }
                _map.put( num , script ) ;
                if ( _target )
                {
                     _target.addFrameScript( num , script ) ;
                     _cleared = false ;
                }
                return true ;
            }
            catch( e:Error )
            {
                warn( this + " put failed, " + e.message , verbose , enableErrorChecking ) ;
            }
            return false ;
        }
        
        /**
         * Unregisters a script function in the frame specified by the label or index value passed-in argument of the method.
         * @param index A String label name or an uint frame index value.
         */
        public function remove( index:* ):void
        {
            try
            {
                var num:int ;
                if ( index is int )
                {
                    num = index as int ;
                }
                else if ( index is String )
                {
                    num = resolve( index as String ) ;
                }
                else
                {
                     throw new ArgumentError( "the index argument must be an int or String value.") ;
                }
                if ( _map.containsKey( num ) )
                {
                    _map.remove( num ) ;
                    if ( _target )
                    {
                        _target.addFrameScript( num , null ) ;
                    }
                }
            }
            catch( e:Error )
            {
                warn( this + " remove failed, " + e.message , verbose , enableErrorChecking ) ;
            }
        }
        
        /**
         * Find the frame index of the specified passed-in label value in the MovieClip target.
         * @throws ArgumentError if the passed-in label value is null or empty.
         * @throws ArgumentError if the passed-in label value don't exist in the MovieClip.
         */
        public function resolve( label:String = null ):int 
        {
            try
            {
                if ( _target == null )
                {
                    throw new ArgumentError( "the target reference not must be 'null'.") ;
                }
                else if ( label == null || label.length == 0 )
                {
                    throw new ArgumentError( "the label argument not must be 'null' or empty.") ;
                }
                var frame:uint ;
                var currentLabels:Array = _target.currentLabels ;
                for each( var element:FrameLabel in currentLabels )
                {
                    if (element.name == label )
                    {
                        frame = element.frame - 1 ;
                        return frame > 1 ? frame : 1 ;
                    }
                } ;
                throw new ArgumentError( "the frame label '" + label + "' don't exist in the MovieClip target reference." ) ;
            }
            catch( e:Error )
            {
                warn( this + " resolve failed, " + e.message , verbose , enableErrorChecking ) ;
            }
            return -1 ;
        } 
        
        /**
         * @private
         */
        private var _cleared:Boolean ;
        
        /**
         * @private
         */
        private var _target:MovieClip ;
        
        /**
         * @private
         */
        private var _map:HashMap ;
    }
}