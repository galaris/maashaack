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

package graphics.display.patterns 
{
    import graphics.colors.RGBA;
    import graphics.display.Pattern;
    
    import system.hack;
    
    /**
     * This static factory generates standard patterns.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * package examples.patterns 
     * {
     *     import graphics.colors.RGBA;
     *     
     *     import graphics.display.Pattern;
     *     import graphics.display.patterns.StandardPatterns;
     *     import graphics.drawing.RectanglePen;
     *     import graphics.FillBitmapStyle;
     *     
     *     import system.data.Iterator;
     *     import system.data.iterators.ArrayIterator;
     *     
     *     import flash.display.Shape;
     *     import flash.display.Sprite;
     *     import flash.display.StageScaleMode;
     *     import flash.events.Event;
     *     import flash.events.MouseEvent;
     *     
     *     [SWF(width="190", height="190", frameRate="24", backgroundColor="#EEEEEE")]
     *     
     *     public class ExampleStandardPatterns extends Sprite
     *     {
     *         public function ExampleStandardPatterns()
     *         {
     *             ///////////
     *             
     *             stage.scaleMode = StageScaleMode.NO_SCALE ;
     *             
     *             stage.addEventListener( MouseEvent.MOUSE_DOWN , next ) ;
     *             
     *             ///////////
     *             
     *             var shape:Shape = new Shape() ;
     *             
     *             shape.x = 10 ;
     *             shape.y = 10 ;
     *             
     *             addChild(shape) ;
     *             
     *             ///////////
     *             
     *             var pattern:Pattern = StandardPatterns.slantedLineA(0xFFFF0000) ;
     *             
     *             pen = new RectanglePen(shape) ;
     *             pen.fill = new FillBitmapStyle(pattern, null, true) ;
     *             pen.draw(0, 0, 170, 170) ;
     *             
     *             ///////////
     *             
     *             iterator = new ArrayIterator( patterns ) ;
     *         }
     *         
     *         public var iterator:Iterator ;
     *         
     *         public var patterns:Array =
     *         [
     *             StandardPatterns.lattice        ( 0xFF000000 ) ,
     *             StandardPatterns.latticeWide    ( 0xFF000000 ) ,
     *             StandardPatterns.lozenge        ( 0xFF000000 ) ,
     *             StandardPatterns.slantedLineA   ( new RGBA( 255, 0, 0, 1) ) ,
     *             StandardPatterns.slantedLineB   ( new RGBA( 0, 255, 0, 1) ) ,
     *             StandardPatterns.solidBar       ( 0xFF000000 ) ,
     *             StandardPatterns.solidBold      ( 0xFF000000 ) ,
     *             StandardPatterns.solidHorizonal ( 0xFF000000 ) ,
     *             StandardPatterns.spot           ( 0xFF000000 ) ,
     *             StandardPatterns.x              ( 0xFF000000 )
     *         ];
     *         
     *         public var pen:RectanglePen ;
     *         
     *         protected function next( e:Event ):void
     *         {
     *             if ( ! iterator.hasNext() )
     *             {
     *                 iterator.reset() ;
     *             }
     *             (pen.fill as FillBitmapStyle).bitmap = iterator.next() as Pattern;
     *             pen.draw() ;
     *         }
     *     }
     * }
     * </pre>
     */
    public class StandardPatterns 
    {
        use namespace hack ;
        
        /**
         * The lattice pattern.
         * @param rgba The RGBA or rgba Number value (default 0xFF000000)
         */
        public static function lattice( rgba:* = 0xFF000000 ):Pattern
        {
            rgba = rgba2Number(rgba) ;
            return new Pattern
            (
                [
                    [0, 1] ,
                    [1, 1] 
                ]
                ,
                [ 0x00 , rgba ]
            );
        }
        
        /**
         * The lattice wide pattern.
         * @param rgba The RGBA or rgba Number value (default 0xFF000000)
         */
        public static function latticeWide( rgba:* = 0xFF000000 ):Pattern
        {
            rgba = rgba2Number(rgba) ;
            return new Pattern
            (
                [
                    [0, 0, 0, 0, 1] ,
                    [0, 0, 0, 0, 1] ,
                    [0, 0, 0, 0, 1] ,
                    [0, 0, 0, 0, 1] ,
                    [1, 1, 1, 1, 1]
                ]
                ,
                [ 0x00 , rgba ]
            );
        }
        
        /**
         * The lozenge pattern.
         * @param rgba The RGBA or rgba Number value (default 0xFF000000)
         */
        public static function lozenge( rgba:* = 0xFF000000 ):Pattern
        {
            rgba = rgba2Number(rgba) ;
            return new Pattern
            (
                [
                    [0, 0, 1, 0] ,
                    [0, 1, 0, 1] ,
                    [1, 0, 0, 0] ,
                    [0, 1, 0, 1] 
                ]
                ,
                [ 0x00 , rgba ]
            );
        }
        
        /**
         * The slanted line(A) pattern.
         * @param rgba The RGBA or rgba Number value (default 0xFF000000)
         */
        public static function slantedLineA( rgba:* = 0xFF000000 ):Pattern
        {
            rgba = rgba2Number(rgba) ;
            return new Pattern
            (
                [
                    [0, 1, 0] ,
                    [1, 0, 0] ,
                    [0, 0, 1]
                ]
                ,
                [ 0x00 , rgba ]
            );
        }
        
        /**
         * The slanted line(B) pattern.
         * @param rgba The RGBA or rgba Number value (default 0xFF000000)
         */
        public static function slantedLineB( rgba:* = 0xFF000000 ):Pattern
        {
            rgba = rgba2Number(rgba) ;
            return new Pattern
            (
                [
                    [1, 0, 0] ,
                    [0, 1, 0] ,
                    [0, 0, 1]
                ]
                ,
                [ 0x00 , rgba ]
            );
        }
        
        /**
         * The solid bar pattern.
         * @param rgba The RGBA or rgba Number value (default 0xFF000000)
         */
        public static function solidBar( rgba:* = 0xFF000000 ):Pattern
        {
            rgba = rgba2Number(rgba) ;
            return new Pattern
            ( 
                [ 
                    [0, 1] 
                ] 
                , 
                [ 0x00 , rgba ] 
            );
        }
        
        /**
         * The solid bold pattern.
         * @param rgba The RGBA or rgba Number value (default 0xFF000000)
         */
        public static function solidBold( rgba:* = 0xFF000000 ):Pattern
        {
            rgba = rgba2Number(rgba) ;
            return new Pattern
            (
                [
                    [0, 0, 0, 0, 1, 1, 1, 1, 1, 0] ,
                    [0, 0, 0, 1, 1, 1, 1, 1, 0, 0] ,
                    [0, 0, 1, 1, 1, 1, 1, 0, 0, 0] ,
                    [0, 1, 1, 1, 1, 1, 0, 0, 0, 0] ,
                    [1, 1, 1, 1, 1, 0, 0, 0, 0, 0] ,
                    [1, 1, 1, 1, 0, 0, 0, 0, 0, 1] ,
                    [1, 1, 1, 0, 0, 0, 0, 0, 1, 1] ,
                    [1, 1, 0, 0, 0, 0, 0, 1, 1, 1] ,
                    [1, 0, 0, 0, 0, 0, 1, 1, 1, 1] ,
                    [0, 0, 0, 0, 0, 1, 1, 1, 1, 1]
                ]
                ,
                [ 0x00 , rgba ]
            );
        }
        
        /**
         * The solid horizontal pattern.
         * @param rgba The RGBA or rgba Number value (default 0xFF000000)
         */
        public static function solidHorizonal( rgba:* = 0xFF000000 ):Pattern
        {
            rgba = rgba2Number(rgba) ;
            return new Pattern ( [ [0] , [1] ] , [ 0x00 , rgba ] );
        }
        
        /**
         * The spot pattern.
         * @param rgba The RGBA or rgba Number value (default 0xFF000000)
         */
        public static function spot( rgba:* = 0xFF000000 ):Pattern
        {
            rgba = rgba2Number(rgba) ;
            return new Pattern
            (
                [
                    [0, 0, 0, 0] ,
                    [1, 0, 0, 0] ,
                    [0, 0, 0, 0] ,
                    [0, 0, 1, 0]
                ]
                ,
                [ 0x00 , rgba ]
            );
        }
        
        /**
         * The X pattern.
         * @param rgba The RGBA or rgba Number value (default 0xFF000000)
         */
        public static function x( rgba:* = 0xFF000000 ):Pattern
        {
            rgba = rgba2Number(rgba) ;
            return new Pattern
            (
                [
                    [1, 0, 0, 0, 0, 0, 0, 0, 0, 1] ,
                    [0, 1, 0, 0, 0, 0, 0, 0, 1, 0] ,
                    [0, 0, 1, 0, 0, 0, 0, 1, 0, 0] ,
                    [0, 0, 0, 1, 0, 0, 1, 0, 0, 0] ,
                    [0, 0, 0, 0, 1, 1, 0, 0, 0, 0] ,
                    [0, 0, 0, 0, 1, 1, 0, 0, 0, 0] ,
                    [0, 0, 0, 1, 0, 0, 1, 0, 0, 0] ,
                    [0, 0, 1, 0, 0, 0, 0, 1, 0, 0] ,
                    [0, 1, 0, 0, 0, 0, 0, 0, 1, 0] ,
                    [1, 0, 0, 0, 0, 0, 0, 0, 0, 1]
                ]
                ,
                [ 0x00 , rgba ]
            );
        }
        
        /**
         * @private
         */
        hack static function rgba2Number( value:* ):Number
        {
            if ( value is RGBA )
            {
                value = (value as RGBA).valueOf() ;
            }
            else
            {
                value = Number(value) ;
                if ( isNaN(value) )
                {
                    value = 0xFF000000 ;
                }
            }
            return value ;
        }
    }
}
