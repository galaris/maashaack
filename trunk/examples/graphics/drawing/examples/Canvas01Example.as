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
    import graphics.drawing.Canvas;

    import flash.display.Shape;
    import flash.display.Sprite;

    public class Canvas01Example extends Sprite 
    {
        public function Canvas01Example()
        {
            var shape:Shape = new Shape() ;
            shape.x = 200 ;
            shape.y = 200 ;
            
            addChild(shape) ;
            
            var data:Array = 
            [
                ['S',[2, 0xFFFFFF, 100]] , // lineStyle(2, 0xFFFFFF, 100)
                ['F',[0xFF0000, 100]] , // beginFill(0xFF0000)
                ['M',[0,0]] , // moveTo (0,0)
                ['L',[80,90]] , // lineTo (80,90)
                ['L',[20,90]] , // lineTo (20,90)
                ['L',[20,50]],  // lineTo (20,50)
                ['EF'] // endFill ()
            ] ; 
            
            var pen:Canvas = new Canvas( shape , data) ;
            pen.draw() ;
        }
    }
}
