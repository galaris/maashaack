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
    import graphics.display.TimelineScript;
    
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.MouseEvent;
    import flash.utils.setTimeout;
    
    /**
     * Example with the graphics.display.TimelineScript class.
     */
    public dynamic class TimelineScriptExample extends Sprite 
    {
        public function TimelineScriptExample()
        {
            // stage
            
            stage.align      = StageAlign.TOP_LEFT ;
            stage.scaleMode  = StageScaleMode.NO_SCALE ;
            
            // target
            
            mc               = getChildByName("mc") as MovieClip ;
            mc.useHandCursor = true ;
            mc.buttonMode    = true ;
            
            mc.addEventListener( MouseEvent.CLICK , click ) ;
            
            trace("Click the movieclip to start the example.");
            
            // timeline script
            
            var ts:TimelineScript = new TimelineScript( mc , true ) ;
            
            ts.put( "begin"   , start ) ;
            ts.put( "middle"  , pause ) ;
            ts.put( "finish"  , finish ) ;
            
        }
        
        public var mc:MovieClip ;
        
        public function click( e:MouseEvent ):void
        {
            mc.play() ;
            trace("click") ;
            e.target.removeEventListener( MouseEvent.CLICK , click ) ;
            mc.buttonMode    = false ;
        }
        
        public function start():void
        {
            trace("start") ;
        }
        
        public function pause():void
        {
            trace("pause") ;
            mc.stop() ;
            setTimeout( mc.play , 4000 ) ; // pause 4 s
        }
        
        public function finish():void
        {
            trace("finish") ;
            mc.stop() ;
        }
    }
}
