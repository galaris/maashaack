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
         * Metallic.
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
         *  Renamed from "Ultra Yellow" in 1990. Fluorescent.
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
         * Renamed from "Ultra Blue" in 1990. Fluorescent.
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
         * Renamed from "Cranberry" in 2000.
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
         * The crayola 'Cadet Blue' color constant.
         */
        public const cadetBlue:RGB = RGB.fromNumber( 0xB0B7C6 ) ;
        
        /**
         * The crayola 'Canary' color constant.
         */
        public const canary:RGB = RGB.fromNumber( 0xFFFF99 ) ;
        
        /**
         * The crayola 'Caribbean Green' color constant.
         */
        public const caribbeanGreen:RGB = RGB.fromNumber( 0x1CD3A2 ) ;
        
        /**
         * The crayola 'Carnation Pink' color constant.
         */
        public const carnationPink:RGB = RGB.fromNumber( 0xFFAACC ) ;
        
        /**
         * The crayola 'Cerise' color constant.
         */
        public const cerise:RGB = RGB.fromNumber( 0xDD4492 ) ;
        
        /**
         * The crayola 'Cerulean' color constant.
         */
        public const cerulean:RGB = RGB.fromNumber( 0x1DACD6 ) ;
        
        /**
         * The crayola 'Chestnut' color constant. 
         * Renamed from "Indian Red" in 1999.
         */
        public const chestnut:RGB = RGB.fromNumber( 0xBC5D58 ) ;
        
        /**
         * The crayola 'Copper' color constant. 
         * Metallic.
         */
        public const copper:RGB = RGB.fromNumber( 0xDD9475 ) ;
        
        /**
         * The crayola 'Cornflower' color constant.
         */
        public const cornflower:RGB = RGB.fromNumber( 0x9ACEEB ) ;
        
        /**
         * The crayola 'Cotton Candy' color constant.
         */
        public const cottonCandy:RGB = RGB.fromNumber( 0xFFBCD9 ) ;
        
        /**
         * The crayola 'Dandelion' color constant.
         */
        public const dandelion:RGB = RGB.fromNumber( 0xFDDB6D ) ;
        
        /**
         * The crayola 'Denim' color constant.
         */
        public const denim:RGB = RGB.fromNumber( 0x2B6CC4 ) ;
        
        /**
         * The crayola 'Desert Sand' color constant.
         */
        public const desertSand:RGB = RGB.fromNumber( 0xEFCDB8 ) ;
        
        /**
         * The crayola 'Eggplant Sand' color constant.
         */
        public const eggplant:RGB = RGB.fromNumber( 0x6E5160 ) ;
        
        /**
         * The crayola 'Electric Lime' color constant. 
         * Fluorescent.
         */
        public const electricLime:RGB = RGB.fromNumber( 0xCEFF1D ) ;
        
        /**
         * The crayola 'Fern' color constant.
         */
        public const fern:RGB = RGB.fromNumber( 0x71BC78 ) ;
        
        /**
         * The crayola 'Forest Green' color constant.
         */
        public const forestGreen:RGB = RGB.fromNumber( 0x6DAE81 ) ;
        
        /**
         * The crayola 'Fuchsia Green' color constant.
         */
        public const fuchsia:RGB = RGB.fromNumber( 0xC364C5 ) ;
        
        /**
         * The crayola 'Fuzzy Wuzzy' color constant.
         */
        public const fuzzyWuzzy:RGB = RGB.fromNumber( 0xCC6666 ) ;
        
        /**
         * The crayola 'Gold' color constant. 
         * Metallic.
         */
        public const gold:RGB = RGB.fromNumber( 0xE7C697 ) ;
        
        /**
         * The crayola 'Goldenrod' color constant.
         */
        public const goldenrod:RGB = RGB.fromNumber( 0xFCD975 ) ;
        
        /**
         * The crayola 'Granny Smith Apple' color constant.
         */
        public const grannySmithApple:RGB = RGB.fromNumber( 0xA8E4A0 ) ;
        
        /**
         * The crayola 'Gray' color constant.
         */
        public const gray:RGB = RGB.fromNumber( 0x95918C ) ;
        
        /**
         * The crayola 'Green' color constant.
         */
        public const green:RGB = RGB.fromNumber( 0x1CAC78 ) ;
        
        /**
         * The crayola 'Green Blue' color constant.
         */
        public const greenBlue:RGB = RGB.fromNumber( 0x1164B4 ) ;
        
        /**
         * The crayola 'Green Yellow' color constant.
         */
        public const greenYellow:RGB = RGB.fromNumber( 0xF0E891 ) ;
        
        /**
         * The crayola 'Hot Magenta' color constant. 
         * Fluorescent.
         */
        public const hotMagenta:RGB = RGB.fromNumber( 0xFF1DCE ) ;
        
        /**
         * The crayola 'Inchworm' color constant.
         */
        public const inchworm:RGB = RGB.fromNumber( 0xB2EC5D ) ;
        
        /**
         * The crayola 'Indigo' color constant.
         */
        public const indigo:RGB = RGB.fromNumber( 0x5D76CB ) ;
        
        /**
         * The crayola 'Jazzberry Jam' color constant.
         */
        public const jazzberryJam:RGB = RGB.fromNumber( 0xCA3767 ) ;
        
        /**
         * The crayola 'Jungle Green' color constant.
         */
        public const jungleGreen:RGB = RGB.fromNumber( 0x3BB08F ) ;
        
        /**
         * The crayola 'Laser Lemon' color constant.
         * Renamed from "Chartreuse" in 1990. Fluorescent.
         */
        public const laserLemon:RGB = RGB.fromNumber( 0xFEFE22 ) ;
        
        /**
         * The crayola 'Lavender' color constant.
         */
        public const lavender:RGB = RGB.fromNumber( 0xFCB4D5 ) ;
        
        /**
         * The crayola 'Lemon Yellow' color constant.
         */
        public const lemonYellow:RGB = RGB.fromNumber( 0xFFF44F ) ;
        
        /**
         * The crayola 'Macaroni and Cheese' color constant.
         */
        public const macaroniAndCheese:RGB = RGB.fromNumber( 0xFFBD88 ) ;
        
        /**
         * The crayola 'Magenta' color constant.
         */
        public const magenta:RGB = RGB.fromNumber( 0xF664AF ) ;
        
        /**
         * The crayola 'Magic Mint' color constant. 
         * Fluorescent.
         */
        public const magicMint:RGB = RGB.fromNumber( 0xAAF0D1 ) ;
        
        /**
         * The crayola 'Mahogany' color constant.
         */
        public const mahogany:RGB = RGB.fromNumber( 0xCD4A4C ) ;
        
        /**
         * The crayola 'Maize' color constant.
         */
        public const maize:RGB = RGB.fromNumber( 0xEDD19C ) ;
        
        /**
         * The crayola 'Manatee' color constant.
         */
        public const manatee:RGB = RGB.fromNumber( 0x979AAA ) ;
        
        /**
         * The crayola 'Mango Tango' color constant.
         */
        public const mangoTango:RGB = RGB.fromNumber( 0xFF8243 ) ;
        
        /**
         * The crayola 'Maroon' color constant.
         */
        public const maroon:RGB = RGB.fromNumber( 0xC8385A ) ;
        
        /**
         * The crayola 'Mauvelous' color constant.
         */
        public const mauvelous:RGB = RGB.fromNumber( 0xEF98AA ) ;
        
        /**
         * The crayola 'Melon' color constant.
         */
        public const melon:RGB = RGB.fromNumber( 0xFDBCB4 ) ;
        
        /**
         * The crayola 'Midnight Blue' color constant. 
         * Renamed from "Prussian Blue" in 1958.
         */
        public const midnightBlue:RGB = RGB.fromNumber( 0x1A4876 ) ;
        
        /**
         * The crayola 'Mountain Meadow' color constant.
         */
        public const mountainMeadow:RGB = RGB.fromNumber( 0x30BA8F ) ;
        
        /**
         * The crayola 'Mulberry' color constant.
         */
        public const mulberry:RGB = RGB.fromNumber( 0xC54B8C ) ;
        
        /**
         * The crayola 'Navy Blue' color constant.
         */
        public const navyBlue:RGB = RGB.fromNumber( 0x1974D2 ) ;
        
        /**
         * The crayola 'Neon Carrot' color constant. 
         * Fluorescent.
         */
        public const neonCarrot:RGB = RGB.fromNumber( 0xFFA343 ) ;
        
        /**
         * @private
         */
        private const _colors:Vector.<ColorSample> = Vector.<ColorSample>
        ([
            new ColorSample( "almond"            , almond            ) , // #001
            new ColorSample( "antiqueBrass"      , antiqueBrass      ) , 
            new ColorSample( "apricot"           , apricot           ) , 
            new ColorSample( "aquamarine"        , aquamarine        ) , 
            new ColorSample( "asparagus"         , asparagus         ) , 
            new ColorSample( "atomicTangerine"   , atomicTangerine   ) , 
            new ColorSample( "bananaMania"       , bananaMania       ) , 
            new ColorSample( "beaver"            , beaver            ) , 
            new ColorSample( "bittersweet"       , bittersweet       ) , 
            new ColorSample( "black"             , black             ) , // #010
            new ColorSample( "blizzardBlue"      , blizzardBlue      ) , 
            new ColorSample( "blue"              , blue              ) , 
            new ColorSample( "blueBell"          , blueBell          ) , 
            new ColorSample( "blueGray"          , blueGray          ) , 
            new ColorSample( "blueGreen"         , blueGreen         ) , 
            new ColorSample( "blueViolet"        , blueViolet        ) , 
            new ColorSample( "blush"             , blush             ) , 
            new ColorSample( "brickRed"          , brickRed          ) , 
            new ColorSample( "brown"             , brown             ) , 
            new ColorSample( "burntOrange"       , burntOrange       ) , // #020
            new ColorSample( "burntSienna"       , burntSienna       ) , 
            new ColorSample( "cadetBlue"         , cadetBlue         ) , 
            new ColorSample( "canary"            , canary            ) , 
            new ColorSample( "caribbeanGreen"    , caribbeanGreen    ) , 
            new ColorSample( "carnationPink"     , carnationPink     ) , 
            new ColorSample( "cerise"            , cerise            ) , 
            new ColorSample( "cerulean"          , cerulean          ) , 
            new ColorSample( "chestnut"          , chestnut          ) , 
            new ColorSample( "copper"            , copper            ) , 
            new ColorSample( "cornflower"        , cornflower        ) , // #030
            new ColorSample( "cottonCandy"       , cottonCandy       ) , 
            new ColorSample( "dandelion"         , dandelion         ) , 
            new ColorSample( "denim"             , denim             ) , 
            new ColorSample( "desertSand"        , desertSand        ) , 
            new ColorSample( "eggplant"          , eggplant          ) , 
            new ColorSample( "electricLime"      , electricLime      ) , 
            new ColorSample( "fern"              , fern              )  ,
            new ColorSample( "forestGreen"       , forestGreen       ) , 
            new ColorSample( "fuchsia"           , fuchsia           ) , 
            new ColorSample( "fuzzyWuzzy"        , fuzzyWuzzy        ) , // #040
            new ColorSample( "gold"              , gold              ) , 
            new ColorSample( "goldenrod"         , goldenrod         ) , 
            new ColorSample( "grannySmithApple"  , grannySmithApple  ) , 
            new ColorSample( "gray"              , gray              ) , 
            new ColorSample( "green"             , green             ) , 
            new ColorSample( "greenBlue"         , greenBlue         ) , 
            new ColorSample( "greenYellow"       , greenYellow       ) , 
            new ColorSample( "hotMagenta"        , hotMagenta        ) , 
            new ColorSample( "inchworm"          , inchworm          ) , 
            new ColorSample( "indigo"            , indigo            ) , // #050
            new ColorSample( "jazzberryJam"      , jazzberryJam      ) , 
            new ColorSample( "jungleGreen"       , jungleGreen       ) , 
            new ColorSample( "laserLemon"        , laserLemon        ) , 
            new ColorSample( "lavender"          , lavender          ) , 
            new ColorSample( "lemonYellow"       , lemonYellow       ) , 
            new ColorSample( "macaroniAndCheese" , macaroniAndCheese ) , 
            new ColorSample( "magenta"           , magenta           ) , 
            new ColorSample( "magicMint"         , magicMint         ) , 
            new ColorSample( "mahogany"          , mahogany          ) , 
            new ColorSample( "maize"             , maize             ) , // #060
            new ColorSample( "manatee"           , manatee           ) , 
            new ColorSample( "mangoTango"        , mangoTango        ) , 
            new ColorSample( "maroon"            , maroon            ) , 
            new ColorSample( "mauvelous"         , mauvelous         ) , 
            new ColorSample( "melon"             , melon             ) , 
            new ColorSample( "midnightBlue"      , midnightBlue      ) , 
            new ColorSample( "mountainMeadow"    , mountainMeadow    ) , 
            new ColorSample( "mulberry"          , mulberry          ) , 
            new ColorSample( "navyBlue"          , navyBlue          ) , 
            new ColorSample( "neonCarrot"        , neonCarrot        )   // #070 
            
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
