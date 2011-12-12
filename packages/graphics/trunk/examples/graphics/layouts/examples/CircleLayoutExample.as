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
    import graphics.Align;
    import graphics.layouts.CircleLayout;
    import graphics.layouts.Layout;
    
    import system.data.Iterator;
    import system.data.iterators.ArrayIterator;
    
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.display.StageScaleMode;
    import flash.events.KeyboardEvent;
    import flash.events.MouseEvent;
    import flash.geom.ColorTransform;
    import flash.geom.Rectangle;
    import flash.ui.Keyboard;
    
    [SWF(width="980", height="760", frameRate="24", backgroundColor="#666666")]
    
    public class CircleLayoutExample extends Sprite 
    {
        public function CircleLayoutExample()
        {
            ///////////
            
            container   = new Sprite() ;
            container.x = 980/2 ;
            container.y = 760/2 ;
            
            addChild( container ) ;
            
            ///////////
            
            var colors:Array = 
            [
                0x7A1D05 , 0xFF0000 , 0xF5532C , 0xECC671 , 0xF3E469 ,
                0xCFE478 , 0x72871B , 0x287968 , 0x1E5184 , 0x0E273F 
            ] ;
            
            var shape:Shape ;
            var ct:ColorTransform ;
            
            var l:uint = colors.length ;
            
            for ( var i:uint = 0 ; i<l ; i++ ) 
            {
                shape = new Shape() ;
                
                shape.graphics.beginFill( 0xFF0000 + i ) ;
                shape.graphics.drawRect(0, 0, 10, 10) ;
                
                ct = new ColorTransform() ;
                ct.color = colors[i] ;
                
                shape.transform.colorTransform = ct ;
                
                container.addChild( shape ) ;
            }
            
            ///////////
            
            layout = new CircleLayout( container ) ;
            
            layout.updater.connect( update ) ;
            
            layout.childAngle       = 0  ;
            layout.childCount       = 10  ;
            layout.radius           = 35  ;
            layout.childOrientation = true ;
            
            layout.align = Align.CENTER ;
            
            layout.run() ;
            
            ///////////
            
            stage.align     = "" ;
            stage.scaleMode = StageScaleMode.NO_SCALE ;
            stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown   ) ;
            stage.addEventListener( MouseEvent.MOUSE_DOWN  , mouseDown ) ;
        }
        
        public var container:Sprite ;
        
        public var layout:CircleLayout ;
        
        public function keyDown( e:KeyboardEvent ):void
        {
            var code:uint = e.keyCode ;
            switch( code )
            {
                case Keyboard.SPACE :
                {
                    //
                    break ;
                }
                case Keyboard.UP :
                {
                    layout.childCount ++ ;
                    layout.radius += 10 ;
                    break ;
                }
                case Keyboard.DOWN :
                {
                    layout.childCount -- ;
                    layout.radius -= 10 ;
                    break ;
                }
                case Keyboard.LEFT :
                {
                    layout.startAngle -= 10 ;
                    break ;
                }
                case Keyboard.RIGHT :
                {
                    layout.startAngle += 10 ;
                    break ;
                }
            }
            layout.run() ;
        }
        
        public function mouseDown( e:MouseEvent ):void
        {
            if ( alignIterator.hasNext() )
            {
                layout.align = alignIterator.next() ;
                layout.run() ;
            }
            if ( !alignIterator.hasNext() )
            {
                alignIterator.reset() ;
            }
        }
        
        protected const aligns:Array = 
        [ 
            Align.TOP_LEFT    , Align.TOP          , Align.TOP_RIGHT ,
            Align.RIGHT       , Align.BOTTOM_RIGHT , Align.BOTTOM    ,
            Align.BOTTOM_LEFT , Align.LEFT         , Align.CENTER 
        ] ;
        
        protected const alignIterator:Iterator = new ArrayIterator( aligns ) ;
        
        /**
         * Invoked when the layout is updated.
         */
        protected function update( layout:Layout ):void
        {
            var bounds:Rectangle = layout.bounds ;
            trace( bounds ) ;
            container.graphics.clear() ;
            container.graphics.beginFill(0x999999,0.1) ;
            container.graphics.drawRect(bounds.x , bounds.y, bounds.width, bounds.height) ;
        }
    }
}
