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
    import graphics.FillStyle;
    import graphics.LineStyle;
    import graphics.drawing.ArrowPen;
    import graphics.geom.Vector2;

    import flash.display.CapsStyle;
    import flash.display.JointStyle;
    import flash.display.LineScaleMode;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    
    public class ArrowPenExample extends Sprite 
    {
        public function ArrowPenExample()
        {
            shape    = new Sprite() ;
            start    = new Vector2( 740 / 2, 420 / 2) ;
            end      = new Vector2( start.x + 100, start.y + 100) ;
            pen      = new ArrowPen( shape , start , end ) ;
            pen.fill = new FillStyle( 0xFAFA74 ) ;
            pen.line = new LineStyle( 2, 0xFAFA74 , 1 , true, LineScaleMode.NORMAL , CapsStyle.SQUARE, JointStyle.MITER ) ;
            
            pen.setPen( null, null, { headSize:20 , headWidth:8 } ) ;
            
            pen.draw() ;
            
            addChild( shape ) ;
            stage.addEventListener( MouseEvent.MOUSE_MOVE , refresh ) ;
        }
        
        public var shape :Sprite ;
        public var start :Vector2 ;
        public var end   :Vector2 ;
        public var pen   :ArrowPen ;
        
        public function refresh( e:MouseEvent ):void
        {
            pen.end.x = e.localX ;
            pen.end.y = e.localY ;
            pen.draw() ;
        }
    }
}
