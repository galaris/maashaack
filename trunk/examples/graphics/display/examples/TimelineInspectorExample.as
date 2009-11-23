/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package examples 
{
    import graphics.display.TimelineInspector;
    import graphics.events.FrameLabelEvent;
    
    import flash.display.FrameLabel;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.MouseEvent;
    import flash.utils.setTimeout;
    
    /**
     * Example with the graphics.display.TimelineInspector class.
     */
    public dynamic class TimelineInspectorExample extends Sprite 
    {
        public function TimelineInspectorExample()
        {
            // stage
            
            stage.align      = StageAlign.TOP_LEFT ;
            stage.scaleMode  = StageScaleMode.NO_SCALE ;
            
            // target
            
            mc               = getChildByName("mc") as MovieClip ; // MovieClip in the stage of the application
            mc.useHandCursor = true ;
            mc.buttonMode    = true ;
            
            mc.addEventListener( MouseEvent.CLICK , click ) ;
            
            trace("Click the movieclip to start the example.");
            
            // timeline inspector
            
            var inspector:TimelineInspector = new TimelineInspector( mc , true ) ;
            
            // inspector.mode = TimelineInspector.TIMELINE ;
            
            inspector.addEventListener( FrameLabelEvent.FRAME_LABEL, frameLabel ) ; 
        }
        
        public var mc:MovieClip ;
        
        /**
         * Run the test.
         */
        public function click( e:MouseEvent ):void
        {
            mc.play() ;
        }
        
        /**
         * Invoked when a new frame label notify a FrameLabelEvent.
         */
        public function frameLabel( e:FrameLabelEvent ):void
        {
            var frame:FrameLabel = e.frameLabel ;
            trace( "frameLabel :: " + frame.frame + " : " + frame.name ) ;
            switch( frame.name )
            {
                case "finish" :
                {
                    mc.stop() ;
                    break ;
                }
                case "middle" :
                {
                    mc.stop() ;
                    setTimeout(mc.play, 5000) ; // pause 5 seconds
                    break ;
                }
            }
        }
        
    }
}
