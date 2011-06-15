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

package examples 
{
    import graphics.easings.backOut;
    import graphics.easings.bounceOut;
    import graphics.easings.expoOut;
    import graphics.easings.regularOut;
    import graphics.transitions.Tween;
    import graphics.transitions.TweenEntry;

    import system.process.Action;
    import system.process.Chain;

    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    
    public class Tween05Example extends Sprite 
    {        public function Tween05Example()
        {
            stage.scaleMode = "noScale" ;
            stage.addEventListener( KeyboardEvent.KEY_DOWN , run ) ;
            
            var shape:Shape = new Shape() ;
            
            shape.graphics.beginFill(0xFFFFFF) ;
            shape.graphics.lineStyle(1,0x999999) ;
            shape.graphics.drawRect(-16,-16,32,32) ;
            
            shape.x = 50 ;
            shape.y = 50 ;
            
            addChild( shape ) ;
            
            var tween1:Tween = new Tween( shape ) ;
            tween1.duration = 1 ;
            tween1.useSeconds = true ;
            tween1.add( new TweenEntry("x", expoOut, shape.x, 600) ) ;
            tween1.add( new TweenEntry("y", backOut, shape.y, 320) ) ;
            tween1.add( new TweenEntry("rotation", regularOut, 0, 600) ) ;
            
            var tween2:Tween = new Tween( shape ) ;
            tween2.duration = 1 ;
            tween2.useSeconds = true ;
            tween2.add( new TweenEntry("x", expoOut, 600, 325) ) ;
            tween2.add( new TweenEntry("y", expoOut, 320, 40) ) ;
            tween2.add( new TweenEntry("rotation", regularOut, 0, -360 ) ) ;
            
            var tween3:Tween = new Tween( shape ) ;
            tween3.duration = 1 ;
            tween3.useSeconds = true ;
            tween3.add( new TweenEntry("x", expoOut, 325, 30 ) ) ;
            tween3.add( new TweenEntry("y", backOut, 40, 220) ) ;
            
            var tween4:Tween = new Tween( shape ) ;
            tween4.duration = 2 ;
            tween4.useSeconds = true ;
            tween4.add( new TweenEntry("x", bounceOut, 30, 620) ) ;
            tween4.add( new TweenEntry("y", backOut, 220, 30) ) ;
            
            sequencer = new Chain() ;
            
            sequencer.addAction(tween1) ;
            sequencer.addAction(tween2) ;
            sequencer.addAction(tween3) ;
            sequencer.addAction(tween4) ;
            
            sequencer.finishIt.connect( finish   ) ;
            sequencer.progressIt.connect( progress ) ;
            sequencer.startIt.connect( start ) ;
            
            /// run the process
            
            run() ;        }
        
        public var sequencer:Chain ;
        
        /**
         * Run the application.
         */
        public function run( e:Event = null ):void
        {
            sequencer.run() ;
        }
        
        protected function finish( action:Action ):void 
        {
            trace ( "# finish"  ) ;
        }
        
        protected function start( action:Action ):void 
        {
            trace ( "# start" ) ;
        }
        
        protected function progress( action:Action ):void 
        {
            trace ( "# progress"  ) ;
        }
    }
}