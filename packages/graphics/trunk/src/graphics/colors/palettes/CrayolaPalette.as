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

package graphics.colors.palettes
{
    import graphics.colors.RGB;
    
    /**
     * Collection of all basic HTML colors.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import graphics.colors.palettes.CrayolaPalette ;
     * 
     * var palette:HTMLPalette = new CrayolaPalette() ;
     * 
     * trace( "length : " + palette.length ) ;
     * trace( "names  : " + palette.names  ) ;
     * trace( "colors : " + palette.colors ) ;
     * </pre>
     */
    public class CrayolaPalette implements Palette
    {
        /**
         * Creates a new CrayolaPalette instance.
         */
        public function CrayolaPalette()
        {
            //
        }
        
        //////////////////
        
        /**
         * The crayola 'Almond' color constant.
         */
        public const almond:RGB = RGB.fromNumber( 0xEFDECD ) ;
        
        /**
         * The crayola 'Antique Brass' color constant.
         */
        public const antiqueBrass:RGB = RGB.fromNumber( 0xCD9575 ) ;
        
        /**
         * The crayola 'Apricot' color constant.
         */
        public const apricot:RGB = RGB.fromNumber( 0xFDD9B5 ) ;
        
        /**
         * The crayola 'Aquamarine' color constant.
         */
        public const aquamarine:RGB = RGB.fromNumber( 0x78DBE2 ) ;
        
        /**
         * The crayola 'Asparagus' color constant.
         */
        public const asparagus:RGB = RGB.fromNumber( 0x87A96B ) ;
        
        /**
         * The crayola 'Atomic Tangerine' color constant.
         */
        public const atomicTangerine:RGB = RGB.fromNumber( 0xFFA474 ) ;
        
        /**
         * The crayola 'Banana Mania' color constant.
         */
        public const bananaMania:RGB = RGB.fromNumber( 0xFAE7B5 ) ;
        
        /**
         * The crayola 'Beaver' color constant.
         */
        public const beaver:RGB = RGB.fromNumber( 0x9F8170 ) ;
        
        /**
         * The crayola 'Bittersweet' color constant.
         */
        public const bittersweet:RGB = RGB.fromNumber( 0xFD7C6E ) ;
        
        /**
         * The crayola 'Black' color constant.
         */
        public const black:RGB = RGB.fromNumber( 0x000000 ) ;
        
        /**
         * The crayola 'Blizzard Blue' color constant.
         */
        public const blizzardBlue:RGB = RGB.fromNumber( 0xACE5EE ) ;
        
        /**
         * The crayola 'Blue' color constant.
         */
        public const blue:RGB = RGB.fromNumber( 0x1F75FE ) ;
        
        /**
         * The crayola 'Blue Bell' color constant.
         */
        public const blueBell:RGB = RGB.fromNumber( 0xA2A2D0 ) ;
        
        /**
         * The crayola 'Blue Gray' color constant.
         */
        public const blueGray:RGB = RGB.fromNumber( 0x6699CC ) ;
        
        /**
         * The crayola 'Blue Green' color constant.
         */
        public const blueGreen:RGB = RGB.fromNumber( 0x0D98BA ) ;
        
        /**
         * The crayola 'Blue Violet' color constant.
         */
        public const blueViolet:RGB = RGB.fromNumber( 0x7366BD ) ;
        
        /**
         * The crayola 'Blush' color constant.
         */
        public const blush:RGB = RGB.fromNumber( 0xDE5D83 ) ;
        
        /**
         * The crayola 'Brick Red' color constant.
         */
        public const brickRed:RGB = RGB.fromNumber( 0xCB4154 ) ;
        
        /**
         * The crayola 'Brown' color constant.
         */
        public const brown:RGB = RGB.fromNumber( 0xCB4674D ) ;
        
        /**
         * The crayola 'Burnt Orange' color constant.
         */
        public const burntOrange:RGB = RGB.fromNumber( 0xFF7F49 ) ;
        
        /**
         * The crayola 'Burnt Sienna' color constant.
         */
        public const burntSienna:RGB = RGB.fromNumber( 0xEA7E5D ) ;
        
        /**
         * @private
         */
        private const _colors:Vector.<ColorSample> = Vector.<ColorSample>
        ([
            new ColorSample( "almond"          , almond          ) , // #001
            new ColorSample( "antiqueBrass"    , antiqueBrass    ) , 
            new ColorSample( "apricot"         , apricot         ) , 
            new ColorSample( "aquamarine"      , aquamarine      ) , 
            new ColorSample( "asparagus"       , asparagus       ) , 
            new ColorSample( "atomicTangerine" , atomicTangerine ) , 
            new ColorSample( "bananaMania"     , bananaMania     ) , 
            new ColorSample( "beaver"          , beaver          ) , 
            new ColorSample( "bittersweet"     , bittersweet     ) , 
            new ColorSample( "black"           , black           ) , // #010
            new ColorSample( "blizzardBlue"    , blizzardBlue    ) , 
            new ColorSample( "blue"            , blue            ) , 
            new ColorSample( "blueBell"        , blueBell        ) , 
            new ColorSample( "blueGray"        , blueGray        ) , 
            new ColorSample( "blueGreen"       , blueGreen       ) , 
            new ColorSample( "blueViolet"      , blueViolet      ) , 
            new ColorSample( "blush"           , blush           ) , 
            new ColorSample( "brickRed"        , brickRed        ) , 
            new ColorSample( "brown"           , brown           ) , 
            new ColorSample( "burntOrange"     , burntOrange     ) , // #020
            new ColorSample( "burntSienna"     , burntSienna     ) 
            // TODO in progress with http://en.wikipedia.org/wiki/List_of_Crayola_crayon_colors
        ]);
        
        //////////////////
        
        /**
         * Fills out the supplied color collection with the colors from the internal color table. 
         * The color collection should be sized according to the return results from the length property.
         */
        public function get colors():Vector.<RGB>
        {
            var vector:Vector.<RGB> = new Vector.<RGB>() ;
            for each( var sample:ColorSample in _colors )
            {
                vector.push( sample.rgb ) ;
            }
            return vector ;
        }
        
        /**
         * Retrieves the number of colors in the color table.
         */
        public function get length():uint
        {
            return _colors.length ;
        }
        
        /**
         * Returns the list of all html color names.
         */
        public function get names():Vector.<String>
        {
            var vector:Vector.<String> = new Vector.<String>() ;
            for each( var item:Object in _colors )
            {
                vector.push( item.name ) ;
            }
            return vector ;
        }
        
        /**
         * Indicates whether the palette contains an alpha transparent color.
         */
        public function hasAlpha():Boolean
        {
            return false ;
        }
        
        /**
         * Returns a generic basic Array of the palette. 
         * All entries in the Array are a basic generic object.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import core.dump ;
         * import graphics.colors.palettes.HTMLPalette ;
         * 
         * var palette:HTMLPalette = new HTMLPalette() ;
         * 
         * trace( "colors : " + dump(palette.toArray() ) ) ;
         * </pre>
         * @return a generic basic Array of the palette. 
         */
        public function toArray():Array
        {
            var array:Array = [] ;
            for each( var sample:ColorSample in _colors )
            {
                array.push( sample.toObject() ) ;
            }
            return array ;
        }
    }
}
