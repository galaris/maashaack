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
    import graphics.FillStyle;
    import graphics.LineStyle;
    import graphics.drawing.BezierPen;
    import graphics.geom.Beziers;
    import graphics.geom.Vector2;

    import flash.display.Shape;
    import flash.display.Sprite;

    public dynamic class BezierPen01Example extends Sprite 
    {
        public function BezierPen01Example()
        {
            var points:Array = [{x:50,y:50},{x:80,y:160},{x:250,y:280},{x:320,y:140}];
            
            var beziers:Array = Beziers.create( points , 0.1 , 0 , true ) ;
            
            trace( beziers ) ;
            
            var canvas:Shape = new Shape() ;
            canvas.x = 25 ;
            canvas.y = 25 ;
            
            var pen:BezierPen = new BezierPen( canvas ) ;
            pen.fill          = new FillStyle( 0xFF0000 , 0.5 ) ;
            pen.line          = new LineStyle( 2, 0xFF0000 , 0.5 ) ;
            
            addChild(canvas) ;
            
            pen.drawPoints( beziers ) ;
            
            var bary:Vector2   = Beziers.getBaryCenter(points) ;
            var sprite:Sprite  = new Barycentre() ; // library asset
            
            addChild(sprite) ;
            
            sprite.x = bary.x ;
            sprite.y = bary.y ;
        }
    }
}
