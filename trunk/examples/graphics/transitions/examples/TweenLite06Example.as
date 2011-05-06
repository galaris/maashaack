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
{    import graphics.Align;
    import graphics.FillStyle;
    import graphics.LineStyle;
    import graphics.drawing.Pen;
    import graphics.drawing.RectanglePen;
    import graphics.transitions.TweenLite;
    import graphics.transitions.easings.Back;
    import graphics.transitions.easings.Bounce;
    import graphics.transitions.easings.Elastic;
    import graphics.transitions.easings.Expo;

    import system.events.ActionEvent;
    import system.process.Sequencer;

    import flash.display.Shape;
    import flash.display.Sprite;

    public class TweenLite06Example extends Sprite
    {        public function TweenLite06Example()
        {
            /// build and draw the shape
            
            var shape:Shape = new Shape() ;
            var pen:Pen     = new RectanglePen( shape ) ;
            
            pen.fill = new FillStyle(0xFFFFFF) ;
            pen.line = new LineStyle(1,0x999999) ;
            pen.draw(0,0,32,32,Align.CENTER) ;
            
            shape.x = 50 ;
            shape.y = 50 ;
            
            addChild( shape ) ;
            
            // test the TweenLite class with a Sequencer property.
            
            var tween1:TweenLite = new TweenLite( shape , "x", Expo.easeOut    ,  34 , 600 , 1 , true ) ;
            var tween2:TweenLite = new TweenLite( shape , "y", Back.easeOut    ,  30 , 350 , 1 , true ) ;
            var tween3:TweenLite = new TweenLite( shape , "x", Bounce.easeOut  , 600 ,  34 , 1 , true ) ;
            var tween4:TweenLite = new TweenLite( shape , "y", Elastic.easeOut , 200 ,  30 , 1 , true ) ;
            
            var s:Sequencer = new Sequencer() ;
            
            s.addAction(tween1) ;
            s.addAction(tween2) ;
            s.addAction(tween3) ;
            s.addAction(tween4) ;
            
            s.addEventListener( ActionEvent.FINISH , debug ) ;
            s.addEventListener( ActionEvent.START  , debug ) ;
            
            s.run() ;
        }
        
        public function debug( e:ActionEvent ):void
        {
            trace( e.type ) ;
        }
    }}