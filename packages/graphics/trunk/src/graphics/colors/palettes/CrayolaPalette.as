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
     * var palette:CrayolaPalette = new CrayolaPalette() ;
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
         * The crayola 'Olive Green' color constant. 
         */
        public const oliveGreen:RGB = RGB.fromNumber( 0xBAB86C ) ;
        
        /**
         * The crayola 'Orange' color constant. 
         */
        public const orange:RGB = RGB.fromNumber( 0xFF7538 ) ;
        
        /**
         * The crayola 'Orange Red' color constant. 
         */
        public const orangeRed:RGB = RGB.fromNumber( 0xFF2B2B ) ;
        
        /**
         * The crayola 'Orange Yellow' color constant. 
         */
        public const orangeYellow:RGB = RGB.fromNumber( 0xF8D568 ) ;
        
        /**
         * The crayola 'Orchid Yellow' color constant. 
         */
        public const orchid:RGB = RGB.fromNumber( 0xE6A8D7 ) ;
        
        /**
         * The crayola 'Outer Space' color constant. 
         */
        public const outerSpace:RGB = RGB.fromNumber( 0x414A4C ) ;
        
        /**
         * The crayola 'Outrageous Orange' color constant. 
         * Renamed from "Ultra Orange" in 1990. Fluorescent.
         */
        public const outrageousOrange:RGB = RGB.fromNumber( 0xFF6E4A ) ;
        
        /**
         * The crayola 'Pacific Blue' color constant. 
         */
        public const pacificBlue:RGB = RGB.fromNumber( 0x1CA9C9 ) ;
        
        /**
         * The crayola 'Peach' color constant. 
         * Renamed from "Flesh" in 1962.
         */
        public const peach:RGB = RGB.fromNumber( 0xFFCFAB ) ;
        
        /**
         * The crayola 'Periwinkle' color constant. 
         */
        public const periwinkle:RGB = RGB.fromNumber( 0xC5D0E6 ) ;
        
        /**
         * The crayola 'Piggy Pink' color constant. 
         */
        public const piggyPink:RGB = RGB.fromNumber( 0xFDDDE6 ) ;
        
        /**
         * The crayola 'Pine Green' color constant. 
         */
        public const pineGreen:RGB = RGB.fromNumber( 0x158078 ) ;
        
        /**
         * The crayola 'Pink Flamingo' color constant. 
         */
        public const pinkFlamingo:RGB = RGB.fromNumber( 0xFC74FD8 ) ;
        
        /**
         * The crayola 'Pink Sherbet' color constant. 
         * Renamed from "Brink Pink" in 2000.
         */
        public const pinkSherbet:RGB = RGB.fromNumber( 0xF78FA7 ) ;
        
        /**
         * The crayola 'Plum' color constant. 
         */
        public const plum:RGB = RGB.fromNumber( 0x8E4585 ) ;
        
        /**
         * The crayola 'Purple Heart' color constant. 
         */
        public const purpleHeart:RGB = RGB.fromNumber( 0x7442C8 ) ;
        
        /**
         * The crayola 'Purple Mountain's Majesty' color constant. 
         */
        public const purpleMountainsMajesty:RGB = RGB.fromNumber( 0x9D81BA ) ;
        
        /**
         * The crayola 'Purple Pizzazz' color constant. 
         * Fluorescent.
         */
        public const purplePizzazz:RGB = RGB.fromNumber( 0xFE4EDA ) ;
        
        /**
         * The crayola 'Radical Red' color constant. 
         * Fluorescent.
         */
        public const radicalRed:RGB = RGB.fromNumber( 0xFF496C ) ;
        
        /**
         * The crayola 'Raw Sienna' color constant. 
         */
        public const rawSienna:RGB = RGB.fromNumber( 0xD68A59 ) ;
        
        /**
         * The crayola 'Raw Umber' color constant. 
         */
        public const rawUmber:RGB = RGB.fromNumber( 0x714B23 ) ;
        
        /**
         * The crayola 'Razzle Dazzle Rose' color constant. 
         * Fluorescent. 
         */
        public const razzleDazzleRose:RGB = RGB.fromNumber( 0xFF48D0 ) ;
        
        /**
         * The crayola 'Razzmatazz' color constant. 
         */
        public const razzmatazz:RGB = RGB.fromNumber( 0xE3256B ) ;
        
        /**
         * The crayola 'Red' color constant. 
         */
        public const red:RGB = RGB.fromNumber( 0xEE204D ) ;
        
        /**
         * The crayola 'Red Orange' color constant. 
         */
        public const redOrange:RGB = RGB.fromNumber( 0xFF5349 ) ;
        
        /**
         * The crayola 'Red Violet' color constant. 
         */
        public const redViolet:RGB = RGB.fromNumber( 0xC0448F ) ;
        
        /**
         * The crayola 'Robin's Egg Blue' color constant. 
         */
        public const robinsEggBlue:RGB = RGB.fromNumber( 0x1FCECB ) ;
        
        /**
         * The crayola 'Royal Purple' color constant. 
         */
        public const royalPurple:RGB = RGB.fromNumber( 0x7851A9 ) ;
        
        /**
         * The crayola 'Salmon' color constant. 
         */
        public const salmon:RGB = RGB.fromNumber( 0xFF9BAA ) ;
        
        /**
         * The crayola 'Scarlet' color constant. 
         * Renamed from "Torch Red" in 2000.
         */
        public const scarlet:RGB = RGB.fromNumber( 0xFC2847 ) ;
        
        /**
         * The crayola 'Screamin' Green' color constant. 
         * Renamed from "Ultra Green" in 1990. Fluorescent.
         */
        public const screaminGreen:RGB = RGB.fromNumber( 0x76FF7A ) ;
        
        /**
         * The crayola 'Sea Green' Green' color constant. 
         */
        public const seaGreen:RGB = RGB.fromNumber( 0x9FE2BF ) ;
        
        /**
         * The crayola 'Sepia' Green' color constant. 
         */
        public const sepia:RGB = RGB.fromNumber( 0xA5694F ) ;
        
        /**
         * The crayola 'Shadow' Green' color constant. 
         */
        public const shadow:RGB = RGB.fromNumber( 0x8A795D ) ;
        
        /**
         * The crayola 'Shamrock' Green' color constant. 
         */
        public const shamrock:RGB = RGB.fromNumber( 0x45CEA2 ) ;
        
        /**
         * The crayola 'Shocking Pink' Green' color constant. 
         * Renamed from "Ultra Pink" in 1990. Fluorescent.
         */
        public const shockingPink:RGB = RGB.fromNumber( 0xFB7EFD ) ;
        
        /**
         * The crayola 'Silver' Green' color constant. 
         * Metallic.
         */
        public const silver:RGB = RGB.fromNumber( 0xCDC5C2 ) ;
        
        /**
         * The crayola 'Sky Blue' Green' color constant. 
         */
        public const skyBlue:RGB = RGB.fromNumber( 0x80DAEB ) ;
        
        /**
         * The crayola 'Spring Green' Green' color constant. 
         */
        public const springGreen:RGB = RGB.fromNumber( 0xECEABE ) ;
        
        /**
         * The crayola 'Sunglow' color constant. 
         * Fluorescent. 
         */
        public const sunglow:RGB = RGB.fromNumber( 0xFFCF48 ) ;
        
        /**
         * The crayola 'Sunset Orange' color constant. 
         */
        public const sunsetOrange:RGB = RGB.fromNumber( 0xFD5E53 ) ;
        
        /**
         * The crayola 'Tan' color constant. 
         */
        public const tan:RGB = RGB.fromNumber( 0xFAA76C ) ;
        
        /**
         * The crayola 'Teal Blue' color constant. 
         */
        public const tealBlue:RGB = RGB.fromNumber( 0x18A7B5 ) ;
        
        /**
         * The crayola 'Thistle' color constant. 
         */
        public const thistle:RGB = RGB.fromNumber( 0xEBC7DF ) ;
        
        /**
         * The crayola 'Tickle Me Pink' color constant. 
         */
        public const tickleMePink:RGB = RGB.fromNumber( 0xFC89AC ) ;
        
        /**
         * The crayola 'Timberwolf' color constant. 
         */
        public const timberwolf:RGB = RGB.fromNumber( 0xDBD7D2 ) ;
        
        /**
         * The crayola 'Tropical Rain Forest' color constant. 
         */
        public const tropicalRainForest:RGB = RGB.fromNumber( 0x17806D ) ;
        
        /**
         * The crayola 'Tumbleweed' color constant. 
         */
        public const tumbleweed:RGB = RGB.fromNumber( 0xDEAA88 ) ;
        
        /**
         * The crayola 'Turquoise Blue' color constant. 
         */
        public const turquoiseBlue:RGB = RGB.fromNumber( 0x77DDE7 ) ;
        
        /**
         * The crayola 'Unmellow Yellow' color constant. 
         * Fluorescent.
         */
        public const unmellowYellow:RGB = RGB.fromNumber( 0xFFFF66 ) ;
        
        /**
         * The crayola 'Violet (Purple)' color constant. 
         */
        public const violet:RGB = RGB.fromNumber( 0x926EAE ) ;
        
        /**
         * The crayola 'Violet Blue' color constant. 
         */
        public const violetBlue:RGB = RGB.fromNumber( 0x324AB2 ) ;
        
        /**
         * The crayola 'Violet Red' color constant. 
         */
        public const violetRed:RGB = RGB.fromNumber( 0xF75394 ) ;
        
        /**
         * The crayola 'Vivid Tangerine' color constant. 
         */
        public const vividTangerine:RGB = RGB.fromNumber( 0xFFA089 ) ;
        
        /**
         * The crayola 'Vivid Violet' color constant. 
         */
        public const vividViolet:RGB = RGB.fromNumber( 0x8F509D ) ;
        
        /**
         * The crayola 'White' color constant. 
         */
        public const white:RGB = RGB.fromNumber( 0xFFFFFF ) ;
        
        /**
         * The crayola 'Wild Blue Yonder' color constant. 
         */
        public const wildBlueYonder:RGB = RGB.fromNumber( 0xA2ADD0 ) ;
        
        /**
         * The crayola 'Wild Strawberry' color constant. 
         */
        public const wildStrawberry:RGB = RGB.fromNumber( 0xFF43A4 ) ;
        
        /**
         * The crayola 'Wild Watermelon' color constant. 
         * Renamed from "Ultra Red" in 1990. Fluorescent.
         */
        public const wildWatermelon:RGB = RGB.fromNumber( 0xFC6C85 ) ;
        
        /**
         * The crayola 'Wisteria' color constant. 
         */
        public const wisteria:RGB = RGB.fromNumber( 0xCDA4DE ) ;
        
        /**
         * The crayola 'Yellow' color constant. 
         */
        public const yellow:RGB = RGB.fromNumber( 0xFCE883 ) ;
        
        /**
         * The crayola 'Yellow Green' color constant. 
         */
        public const yellowGreen:RGB = RGB.fromNumber( 0xC5E384 ) ;
        
        /**
         * The crayola 'Yellow Orange' color constant. 
         */
        public const yellowOrange:RGB = RGB.fromNumber( 0xFFAE42 ) ;
        
        /**
         * The crayola 'Grass Green' color constant. 
         */
        public const grassGreen:RGB = RGB.fromNumber( 0x458B00 ) ;
        
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
        
        //////////////////
        
        /**
         * All main Crayola colors based on http://en.wikipedia.org/wiki/List_of_Crayola_crayon_colors.
         * @private
         */
        private const _colors:Vector.<ColorSample> = Vector.<ColorSample>
        ([
            new ColorSample( "Almond"                    , almond                 ) , // #001
            new ColorSample( "Antique Brass"             , antiqueBrass           ) , 
            new ColorSample( "Apricot"                   , apricot                ) , 
            new ColorSample( "Aquamarine"                , aquamarine             ) , 
            new ColorSample( "Asparagus"                 , asparagus              ) , 
            new ColorSample( "Atomic Tangerine"          , atomicTangerine        ) , 
            new ColorSample( "Banana Mania"              , bananaMania            ) , 
            new ColorSample( "Beaver"                    , beaver                 ) , 
            new ColorSample( "Bittersweet"               , bittersweet            ) , 
            new ColorSample( "Black"                     , black                  ) , // #010
            new ColorSample( "Blizzard Blue"             , blizzardBlue           ) , 
            new ColorSample( "Blue"                      , blue                   ) , 
            new ColorSample( "Blue Bell"                 , blueBell               ) , 
            new ColorSample( "Blue Gray"                 , blueGray               ) , 
            new ColorSample( "Blue Green"                , blueGreen              ) , 
            new ColorSample( "Blue Violet"               , blueViolet             ) , 
            new ColorSample( "Blush"                     , blush                  ) , 
            new ColorSample( "Brick Red"                 , brickRed               ) , 
            new ColorSample( "Brown"                     , brown                  ) , 
            new ColorSample( "Burnt Orange"              , burntOrange            ) , // #020
            new ColorSample( "Burnt Sienna"              , burntSienna            ) , 
            new ColorSample( "Cadet Blue"                , cadetBlue              ) , 
            new ColorSample( "Canary"                    , canary                 ) , 
            new ColorSample( "Caribbean Green"           , caribbeanGreen         ) , 
            new ColorSample( "Carnation Pink"            , carnationPink          ) , 
            new ColorSample( "Cerise"                    , cerise                 ) , 
            new ColorSample( "Cerulean"                  , cerulean               ) , 
            new ColorSample( "Chestnut"                  , chestnut               ) , 
            new ColorSample( "Copper"                    , copper                 ) , 
            new ColorSample( "Cornflower"                , cornflower             ) , // #030
            new ColorSample( "Cotton Candy"              , cottonCandy            ) , 
            new ColorSample( "Dandelion"                 , dandelion              ) , 
            new ColorSample( "Denim"                     , denim                  ) , 
            new ColorSample( "Desert Sand"               , desertSand             ) , 
            new ColorSample( "Eggplant"                  , eggplant               ) , 
            new ColorSample( "Electric Lime"             , electricLime           ) , 
            new ColorSample( "Fern"                      , fern                   ) , 
            new ColorSample( "Forest Green"              , forestGreen            ) , 
            new ColorSample( "Fuchsia"                   , fuchsia                ) , 
            new ColorSample( "Fuzzy Wuzzy"               , fuzzyWuzzy             ) , // #040
            new ColorSample( "Gold"                      , gold                   ) , 
            new ColorSample( "Goldenrod"                 , goldenrod              ) , 
            new ColorSample( "Granny Smith Apple"        , grannySmithApple       ) , 
            new ColorSample( "Gray"                      , gray                   ) , 
            new ColorSample( "Green"                     , green                  ) , 
            new ColorSample( "Green Blue"                , greenBlue              ) , 
            new ColorSample( "Green Yellow"              , greenYellow            ) , 
            new ColorSample( "Hot Magenta"               , hotMagenta             ) , 
            new ColorSample( "Inchworm"                  , inchworm               ) , 
            new ColorSample( "Indigo"                    , indigo                 ) , // #050
            new ColorSample( "Jazzberry Jam"             , jazzberryJam           ) , 
            new ColorSample( "Jungle Green"              , jungleGreen            ) , 
            new ColorSample( "Laser Lemon"               , laserLemon             ) , 
            new ColorSample( "Lavender"                  , lavender               ) , 
            new ColorSample( "Lemon Yellow"              , lemonYellow            ) , 
            new ColorSample( "Macaroni And Cheese"       , macaroniAndCheese      ) , 
            new ColorSample( "Magenta"                   , magenta                ) , 
            new ColorSample( "Magic Mint"                , magicMint              ) , 
            new ColorSample( "Mahogany"                  , mahogany               ) , 
            new ColorSample( "Maize"                     , maize                  ) , // #060
            new ColorSample( "Manatee"                   , manatee                ) , 
            new ColorSample( "Mango Tango"               , mangoTango             ) , 
            new ColorSample( "Maroon"                    , maroon                 ) , 
            new ColorSample( "Mauvelous"                 , mauvelous              ) , 
            new ColorSample( "Melon"                     , melon                  ) , 
            new ColorSample( "Midnight Blue"             , midnightBlue           ) , 
            new ColorSample( "Mountain Meadow"           , mountainMeadow         ) , 
            new ColorSample( "Mulberry"                  , mulberry               ) , 
            new ColorSample( "Navy Blue"                 , navyBlue               ) , 
            new ColorSample( "Neon Carrot"               , neonCarrot             ) , // #070 
            new ColorSample( "OliveGreen"                , oliveGreen             ) , 
            new ColorSample( "Orange"                    , orange                 ) , 
            new ColorSample( "Orange Red"                , orangeRed              ) , 
            new ColorSample( "Orange Yellow"             , orangeYellow           ) , 
            new ColorSample( "Orchid"                    , orchid                 ) , 
            new ColorSample( "Outer Space"               , outerSpace             ) , 
            new ColorSample( "Outrageous Orange"         , outrageousOrange       ) , 
            new ColorSample( "pacificBlue"               , pacificBlue            ) , 
            new ColorSample( "peach"                     , peach                  ) , 
            new ColorSample( "periwinkle"                , periwinkle             ) , // #080
            new ColorSample( "piggyPink"                 , piggyPink              ) , 
            new ColorSample( "Pine Green"                , pineGreen              ) , 
            new ColorSample( "Pink Flamingo"             , pinkFlamingo           ) , 
            new ColorSample( "Pink Sherbet"              , pinkSherbet            ) , 
            new ColorSample( "Plum"                      , plum                   ) , 
            new ColorSample( "Purple Heart"              , purpleHeart            ) , 
            new ColorSample( "Purple Mountain's Majesty" , purpleMountainsMajesty ) , 
            new ColorSample( "Purple Pizzazz"            , purplePizzazz          ) , 
            new ColorSample( "Radical Red"               , radicalRed             ) , 
            new ColorSample( "Raw Sienna"                , rawSienna              ) , // #090
            new ColorSample( "Raw Umber"                 , rawUmber               ) , 
            new ColorSample( "Razzle Dazzle Rose"        , razzleDazzleRose       ) , 
            new ColorSample( "Razzmatazz"                , razzmatazz             ) , 
            new ColorSample( "Red"                       , red                    ) , 
            new ColorSample( "Red Orange"                , redOrange              ) , 
            new ColorSample( "Red Violet"                , redViolet              ) , 
            new ColorSample( "Robin's Egg Blue"          , robinsEggBlue          ) , 
            new ColorSample( "Royal Purple"              , royalPurple            ) , 
            new ColorSample( "Salmon"                    , salmon                 ) , 
            new ColorSample( "Scarlet"                   , scarlet                ) , // #100
            new ColorSample( "Screamin' Green"           , screaminGreen          ) , 
            new ColorSample( "Sea Green"                 , seaGreen               ) , 
            new ColorSample( "Sepia"                     , sepia                  ) , 
            new ColorSample( "Shadow"                    , shadow                 ) , 
            new ColorSample( "Shamrock"                  , shamrock               ) , 
            new ColorSample( "Shocking Pink"             , shockingPink           ) , 
            new ColorSample( "Silver"                    , silver                 ) , 
            new ColorSample( "Sky Blue"                  , skyBlue                ) , 
            new ColorSample( "Spring Green"              , springGreen            ) , 
            new ColorSample( "Sunglow"                   , sunglow                ) , // #110
            new ColorSample( "Sunset Orange"             , sunsetOrange           ) , 
            new ColorSample( "Tan"                       , tan                    ) , 
            new ColorSample( "Teal Blue"                 , tealBlue               ) , 
            new ColorSample( "Thistle"                   , thistle                ) , 
            new ColorSample( "Tickle Me Pink"            , tickleMePink           ) , 
            new ColorSample( "Timberwolf"                , timberwolf             ) , 
            new ColorSample( "Tropical Rain Forest"      , tropicalRainForest     ) , 
            new ColorSample( "Tumbleweed"                , tumbleweed             ) , 
            new ColorSample( "Turquoise Blue"            , turquoiseBlue          ) , 
            new ColorSample( "Unmellow Yellow"           , unmellowYellow         ) , // #120
            new ColorSample( "Violet (Purple)"           , violet                 ) , 
            new ColorSample( "Violet Blue"               , violetBlue             ) , 
            new ColorSample( "Violet Red"                , violetRed              ) , 
            new ColorSample( "Vivid Tangerine"           , vividTangerine         ) , 
            new ColorSample( "Vivid Violet"              , vividViolet            ) , 
            new ColorSample( "White"                     , white                  ) , 
            new ColorSample( "Wild Blue Yonder"          , wildBlueYonder         ) , 
            new ColorSample( "Wild Strawberry"           , wildStrawberry         ) , 
            new ColorSample( "Wild Watermelon"           , wildWatermelon         ) , 
            new ColorSample( "Wisteria"                  , wisteria               ) , // #130
            new ColorSample( "Yellow"                    , yellow                 ) , 
            new ColorSample( "Yellow Green"              , yellowGreen            ) , 
            new ColorSample( "Yellow Orange"             , yellowOrange           ) , 
            new ColorSample( "Grass Green"               , grassGreen             ) 
        ]);
    }
}
   