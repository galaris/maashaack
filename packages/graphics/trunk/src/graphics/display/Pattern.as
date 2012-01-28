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
  Portions created by the Initial Developers are Copyright (C) 2006-2012
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

package graphics.display 
{
    import flash.display.BitmapData;
    import flash.geom.Rectangle;
    
    /**
     * A bitmap pattern defines with a matrix of rgba colors. The rgba colors are often specified in hexadecimal format; for example, 0xFF336699.
     */
    public class Pattern extends BitmapData 
    {
        /**
         * Creates a new Pattern instance.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * package examples
         * {
         *     import graphics.FillBitmapStyle;
         *     import graphics.display.Pattern;
         *     import graphics.drawing.RectanglePen;
         *     
         *     import flash.display.Shape;
         *     import flash.display.Sprite;
         *     import flash.geom.Matrix;
         *     
         *     [SWF(width="780", height="520", frameRate="24", backgroundColor="#FFFFFF")]
         *     
         *     public class ExamplePattern extends Sprite
         *     {
         *         public function ExamplePattern()
         *         {
         *             var shape:Shape = new Shape() ;
         *             
         *             shape.x = 20 ;
         *             shape.y = 20 ;
         *             
         *             addChild( shape ) ;
         *             
         *             var tiles:Array = 
         *             [
         *                 [1, 0, 0, 0] ,
         *                 [0, 0, 0, 0] ,
         *                 [0, 0, 1, 0] ,
         *                 [0, 0, 0, 0]
         *             ];
         *              
         *             var colors:Array = [ 0x00 , 0xFF000000 ] ;
         *             
         *             var pattern:Pattern = new Pattern(tiles, colors) ;
         *             
         *             var pen:RectanglePen = new RectanglePen( shape ) ;
         *             
         *             pen.fill = new FillBitmapStyle( pattern , new Matrix() , true ) ;
         *             
         *             pen.draw( 0, 0 , 150, 150 ) ;
         *         }
         *     }
         * }
         * </pre>
         * @param tiles The Array matrix representation of all pixels of the pattern.
         * @param colors The Array representation of all decimal RGBA colors values used in the tiles object. 
         */
        public function Pattern( tiles:Array , colors:Array )
        {
            var i:int ;
            var j:int ;
            var r:Rectangle = new Rectangle() ;
            var x:int       = tiles[0].length ;
            var y:int       = tiles.length    ;
            super( x , y , true , 0xFF );
            for ( i ; i < x ; i++ )
            {
                for ( j = 0 ; j < y ; j++ )
                {
                    r.x = i ;
                    r.y = j ;
                    r.width = r.height = 1 ;
                    fillRect( r , colors[ tiles[j][i] ] ) ;
                }
            }
        }
    }
}
