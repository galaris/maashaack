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
    import graphics.LineStyle;
    import graphics.drawing.BezierPen;
    import graphics.geom.Vector2;

    import flash.display.DisplayObject;
    import flash.display.Sprite;

    public dynamic class BezierPen02Example extends Sprite 
    {
        public function BezierPen02Example()
        {
            var canvas:Sprite = new Sprite() ;
            canvas.x = 50 ;
            canvas.y = 100 ;
            
            addChild(canvas) ;
            
            var pen:BezierPen = new BezierPen( canvas ) ;
            
            pen.useClear = false ;
            pen.line     = new LineStyle( 2, 0xFF0000 , 1 ) ;
            
            pen.draw( v1, v2 , v3 , v4 ,  5 ) ;
            pen.draw( v4, v5 , v6 , v7 , 10 ) ;
            
            // draw bezier points
            
            var p:DisplayObject ;
            for ( var i:uint = 1 ; i<8 ; i++ )
            {
                p = new BezierPoint() as DisplayObject;
                p.x = this["v"+i].x ;
                p.y = this["v"+i].y ;
                canvas.addChild(p) ;
            }
        }
        
        public var v1:Vector2 = new Vector2(0,0) ;
        public var v2:Vector2 = new Vector2(100,200) ;
        public var v3:Vector2 = new Vector2(200,50) ;
        public var v4:Vector2 = new Vector2(300,0) ;
        public var v5:Vector2 = new Vector2(400 , -50) ;
        public var v6:Vector2 = new Vector2(500 , 100) ;
        public var v7:Vector2 = new Vector2(600,0) ;
    }
}
