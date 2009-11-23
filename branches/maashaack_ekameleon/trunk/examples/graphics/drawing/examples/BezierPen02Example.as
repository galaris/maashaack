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
  Nicolas Surian (aka NairuS) <nicolas.surian@gmail.com> 
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
