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
     * Collection of all basic SVG HTML colors. http://www.december.com/html/spec/colorsvg.html 
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import graphics.colors.palettes.SVGPalette ;
     * 
     * var palette:SVGPalette = new SVGPalette() ;
     * 
     * trace( "length : " + palette.length ) ;
     * trace( "names  : " + palette.names  ) ;
     * trace( "colors : " + palette.colors ) ;
     * </pre>
     */
    public class SVGPalette implements Palette
    {
        /**
         * Creates a new SVGPalette instance.
         */
        public function SVGPalette()
        {
            
        }
        
        //////////////////
        
        /**
         * The 'aliceBlue' SVG color object.
         */
        public const aliceBlue:RGB = RGB.fromNumber( 0xF0F8FF ) ;
        
        /**
         * The 'antiqueWhite' SVG color object.
         */
        public const antiqueWhite:RGB = RGB.fromNumber( 0xFAEBD7 ) ;
        
        /**
         * The 'aqua' SVG color object.
         */
        public const aqua:RGB = RGB.fromNumber( 0x00FFFF ) ;
        
        /**
         * The 'aquaMarine' SVG color object.
         */
        public const aquaMarine:RGB = RGB.fromNumber( 0x7FFFD4 ) ;
        
        /**
         * The 'azure' SVG color object.
         */
        public const azure:RGB = RGB.fromNumber( 0xF0FFFF ) ;
        
        /**
         * The 'beige' SVG color object.
         */
        public const beige:RGB = RGB.fromNumber( 0xF5F5DC ) ;
        
        /**
         * The 'bisque' SVG color object.
         */
        public const bisque:RGB = RGB.fromNumber( 0xFFE4C4 ) ;
        
        /**
         * The 'black' SVG color object.
         */
        public const black:RGB = RGB.fromNumber( 0x000000 ) ;
        
        /**
         * The 'blanchedAlmond' SVG color object.
         */
        public const blanchedAlmond:RGB = RGB.fromNumber( 0xFFEBCD ) ;
        
        /**
         * The 'blue' SVG color object.
         */
        public const blue:RGB = RGB.fromNumber( 0x0000FF ) ;
        
        /**
         * The 'blueViolet' SVG color object.
         */
        public const blueViolet:RGB = RGB.fromNumber( 0x8A2BE2 ) ;
        
        /**
         * The 'brown' SVG color object.
         */
        public const brown:RGB = RGB.fromNumber( 0xA52A2A ) ;
        
        /**
         * The 'burlyWood' SVG color object.
         */
        public const burlyWood:RGB = RGB.fromNumber( 0xDEB887 ) ;
        
        /**
         * The 'cadetBlue' SVG color object.
         */
        public const cadetBlue:RGB = RGB.fromNumber( 0x5F9EA0 ) ;
        
        /**
         * The 'chartreuse' SVG color object.
         */
        public const chartreuse:RGB = RGB.fromNumber( 0x7FFF00 ) ;
        
        /**
         * The 'chocolate' SVG color object.
         */
        public const chocolate:RGB = RGB.fromNumber( 0xD2691E ) ;
        
        /**
         * The 'coral' SVG color object.
         */
        public const coral:RGB = RGB.fromNumber( 0xFF7F50 ) ;
        
        /**
         * The 'cornFlowerBlue' SVG color object.
         */
        public const cornFlowerBlue:RGB = RGB.fromNumber( 0x6495ED ) ;
        
        /**
         * The 'cornsilk' SVG color object.
         */
        public const cornsilk:RGB = RGB.fromNumber( 0xFFF8DC ) ;
        
        /**
         * The 'crimson' SVG color object.
         */
        public const crimson:RGB = RGB.fromNumber( 0xDC143C ) ;
        
        /**
         * The 'cyan' SVG color object.
         */
        public const cyan:RGB = RGB.fromNumber( 0x00FFFF ) ;
        
        /**
         * The 'darkBlue' SVG color object.
         */
        public const darkBlue:RGB = RGB.fromNumber( 0x00008B ) ;
        
        /**
         * The 'darkCyan' SVG color object.
         */
        public const darkCyan:RGB = RGB.fromNumber( 0x008B8B ) ;
        
        /**
         * The 'darkGoldenRod' SVG color object.
         */
        public const darkGoldenRod:RGB = RGB.fromNumber( 0xB8860B ) ;
        
        /**
         * The 'darkGray' SVG color object.
         */
        public const darkGray:RGB = RGB.fromNumber( 0xA9A9A9 ) ;
        
        /**
         * The 'darkGreen' SVG color object.
         */
        public const darkGreen:RGB = RGB.fromNumber( 0x006400 ) ;
        
        /**
         * The 'darkGrey' SVG color object.
         */
        public const darkGrey:RGB = RGB.fromNumber( 0xA9A9A9 ) ;
        
        /**
         * The 'darkKhaki' SVG color object.
         */
        public const darkKhaki:RGB = RGB.fromNumber( 0xBDB76B ) ;
        
        /**
         * The 'darkMagenta' SVG color object.
         */
        public const darkMagenta:RGB = RGB.fromNumber( 0x8B008B ) ;
        
        /**
         * The 'darkOliveGreen' SVG color object.
         */
        public const darkOliveGreen:RGB = RGB.fromNumber( 0x556B2F ) ;
        
        /**
         * The 'darkOrange' SVG color object.
         */
        public const darkOrange:RGB = RGB.fromNumber( 0xFF8C00 ) ;
        
        /**
         * The 'darkOrchid' SVG color object.
         */
        public const darkOrchid:RGB = RGB.fromNumber( 0x9932CC ) ;
        
        /**
         * The 'darkRed' SVG color object.
         */
        public const darkRed:RGB = RGB.fromNumber( 0x8b0000 ) ;
        
        /**
         * The 'darkSalmon' SVG color object.
         */
        public const darkSalmon:RGB = RGB.fromNumber( 0xE9967A ) ;
        
        /**
         * The 'darkSeaGreen' SVG color object.
         */
        public const darkSeaGreen:RGB = RGB.fromNumber( 0x8FBC8F ) ;
        
        /**
         * The 'darkSlateBlue' SVG color object.
         */
        public const darkSlateBlue:RGB = RGB.fromNumber( 0x483D8B ) ;
        
        /**
         * The 'darkSlateGray' SVG color object.
         */
        public const darkSlateGray:RGB = RGB.fromNumber( 0x2F4F4F ) ;
        
        /**
         * The 'darkSlateGrey' SVG color object.
         */
        public const darkSlateGrey:RGB = RGB.fromNumber( 0x2F4F4F ) ;
        
        /**
         * The 'darkTurquoise' SVG color object.
         */
        public const darkTurquoise:RGB = RGB.fromNumber( 0x00CED1 ) ;
        
        /**
         * The 'darkViolet' SVG color object.
         */
        public const darkViolet:RGB = RGB.fromNumber( 0x9400D3 ) ;
        
        /**
         * The 'deepPink' SVG color object.
         */
        public const deepPink:RGB = RGB.fromNumber( 0xFF1493 ) ;
        
        /**
         * The 'deepSkyBlue' SVG color object.
         */
        public const deepSkyBlue:RGB = RGB.fromNumber( 0x00BFFF ) ;
        
        /**
         * The 'dimGray' SVG color object.
         */
        public const dimGray:RGB = RGB.fromNumber( 0x696969 ) ;
        
        /**
         * The 'dimGrey' SVG color object.
         */
        public const dimGrey:RGB = RGB.fromNumber( 0x696969 ) ;
        
        /**
         * The 'dodgerBlue' SVG color object.
         */
        public const dodgerBlue:RGB = RGB.fromNumber( 0x1E90FF ) ;
        
        /**
         * The 'fireBrick' SVG color object.
         */
        public const fireBrick:RGB = RGB.fromNumber( 0xB22222 ) ;
        
        /**
         * The 'floralWhite' SVG color object.
         */
        public const floralWhite:RGB = RGB.fromNumber( 0xFFFAF0 ) ;
        
        /**
         * The 'forestGreen' SVG color object.
         */
        public const forestGreen:RGB = RGB.fromNumber( 0x228b22 ) ;
        
        /**
         * The 'fuchsia' SVG color object.
         */
        public const fuchsia:RGB = RGB.fromNumber( 0xFF00FF ) ;
        
        /**
         * The 'gainsboro' SVG color object.
         */
        public const gainsboro:RGB = RGB.fromNumber( 0xDCDCDC ) ;
        
        /**
         * The 'ghostWhite' SVG color object.
         */
        public const ghostWhite:RGB = RGB.fromNumber( 0xF8F8FF ) ;
        
        /**
         * The 'gold' SVG color object.
         */
        public const gold:RGB = RGB.fromNumber( 0xFFD700 ) ;
        
        /**
         * The 'goldenRod' SVG color object.
         */
        public const goldenRod:RGB = RGB.fromNumber( 0xDAA520 ) ;
        
        /**
         * The 'gray' SVG color object.
         */
        public const gray:RGB = RGB.fromNumber( 0x808080 ) ;
        
        /**
         * The 'green' SVG color object.
         */
        public const green:RGB = RGB.fromNumber( 0x008000 ) ;
        
        /**
         * The 'greenYellow' SVG color object.
         */
        public const greenYellow:RGB = RGB.fromNumber( 0xADFF2F ) ;
        
        /**
         * The 'grey' SVG color object.
         */
        public const grey:RGB = RGB.fromNumber( 0x808080 ) ;
        
        /**
         * The 'honeyDew' SVG color object.
         */
        public const honeyDew:RGB = RGB.fromNumber( 0xF0FFF0 ) ;
        
        /**
         * The 'hotPink' SVG color object.
         */
        public const hotPink:RGB = RGB.fromNumber( 0xFF69B4 ) ;
        
        /**
         * The 'indianRed' SVG color object.
         */
        public const indianRed:RGB = RGB.fromNumber( 0xCD5C5C ) ;
        
        /**
         * The 'indigo' SVG color object.
         */
        public const indigo:RGB = RGB.fromNumber( 0x4B0082 ) ;
        
        /**
         * The 'ivory' SVG color object.
         */
        public const ivory:RGB = RGB.fromNumber( 0xFFFFF0 ) ;
        
        /**
         * The 'khaki' SVG color object.
         */
        public const khaki:RGB = RGB.fromNumber( 0xF0E68C ) ;
        
        /**
         * The 'lavender' SVG color object.
         */
        public const lavender:RGB = RGB.fromNumber( 0xE6E6FA ) ;
        
        /**
         * The 'lavenderBlush' SVG color object.
         */
        public const lavenderBlush:RGB = RGB.fromNumber( 0xFFF0F5 ) ;
        
        /**
         * The 'lawnGreen' SVG color object.
         */
        public const lawnGreen:RGB = RGB.fromNumber( 0x7CFC00 ) ;
        
        /**
         * The 'lemonChiffon' SVG color object.
         */
        public const lemonChiffon:RGB = RGB.fromNumber( 0xFFFACD ) ;
        
        /**
         * The 'lightBlue' SVG color object.
         */
        public const lightBlue:RGB = RGB.fromNumber( 0xADD8E6 ) ;
        
        /**
         * The 'lightCoral' SVG color object.
         */
        public const lightCoral:RGB = RGB.fromNumber( 0xF08080 ) ;
        
        /**
         * The 'lightCyan' SVG color object.
         */
        public const lightCyan:RGB = RGB.fromNumber( 0xE0FFFF ) ;
        
        /**
         * The 'lightGoldenrodYellow' SVG color object.
         */
        public const lightGoldenrodYellow:RGB = RGB.fromNumber( 0xFAFAD2 ) ;
        
        /**
         * The 'lightGray' SVG color object.
         */
        public const lightGray:RGB = RGB.fromNumber( 0xD3D3D3 ) ;
        
        /**
         * The 'lightGreen' SVG color object.
         */
        public const lightGreen:RGB = RGB.fromNumber( 0x90EE90 ) ;
        
        /**
         * The 'lightGrey' SVG color object.
         */
        public const lightGrey:RGB = RGB.fromNumber( 0xD3D3D3 ) ;
        
        /**
         * The 'lightPink' SVG color object.
         */
        public const lightPink:RGB = RGB.fromNumber( 0xFFB6C1 ) ;
        
        /**
         * The 'lightSalmon' SVG color object.
         */
        public const lightSalmon:RGB = RGB.fromNumber( 0xFFA07A ) ;
        
        /**
         * The 'lightSeaGreen' SVG color object.
         */
        public const lightSeaGreen:RGB = RGB.fromNumber( 0x20B2AA ) ;
        
        /**
         * The 'lightSkyBlue' SVG color object.
         */
        public const lightSkyBlue:RGB = RGB.fromNumber( 0x87CEFA ) ;
        
        /**
         * The 'lightSlateGray' SVG color object.
         */
        public const lightSlateGray:RGB = RGB.fromNumber( 0x778899 ) ;
        
        /**
         * The 'lightSlateGrey' SVG color object.
         */
        public const lightSlateGrey:RGB = RGB.fromNumber( 0x778899 ) ;
        
        /**
         * The 'lightSteelBlue' SVG color object.
         */
        public const lightSteelBlue:RGB = RGB.fromNumber( 0xB0C4DE ) ;
        
        /**
         * The 'lightYellow' SVG color object.
         */
        public const lightYellow:RGB = RGB.fromNumber( 0xFFFFE0 ) ;
        
        /**
         * The 'lime' SVG color object.
         */
        public const lime:RGB = RGB.fromNumber( 0x00FF00 ) ;
        
        /**
         * The 'limeGreen' SVG color object.
         */
        public const limeGreen:RGB = RGB.fromNumber( 0x32CD32 ) ;
        
        /**
         * The 'linen' SVG color object.
         */
        public const linen:RGB = RGB.fromNumber( 0xFAF0E6 ) ;
        
        /**
         * The 'magenta' SVG color object.
         */
        public const magenta:RGB = RGB.fromNumber( 0xFF00FF ) ;
        
        /**
         * The 'maroon' SVG color object.
         */
        public const maroon:RGB = RGB.fromNumber( 0x800000 ) ;
        
        /**
         * The 'mediumAquaMarine' SVG color object.
         */
        public const mediumAquaMarine:RGB = RGB.fromNumber( 0x66CDAA ) ;
        
        /**
         * The 'mediumBlue' SVG color object.
         */
        public const mediumBlue:RGB = RGB.fromNumber( 0x0000CD ) ;
        
        /**
         * The 'mediumOrchid' SVG color object.
         */
        public const mediumOrchid:RGB = RGB.fromNumber( 0xBA55D3 ) ;
        
        /**
         * The 'mediumPurple' SVG color object.
         */
        public const mediumPurple:RGB = RGB.fromNumber( 0x9370D8 ) ;
        
        /**
         * The 'mediumSeaGreen' SVG color object.
         */
        public const mediumSeaGreen:RGB = RGB.fromNumber( 0x3cb371 ) ;
        
        /**
         * The 'mediumSlateBlue' SVG color object.
         */
        public const mediumSlateBlue:RGB = RGB.fromNumber( 0x7B68EE ) ;
        
        /**
         * The 'mediumSpringGreen' SVG color object.
         */
        public const mediumSpringGreen:RGB = RGB.fromNumber( 0x00FA9A ) ;
        
        /**
         * The 'mediumTurquoise' SVG color object.
         */
        public const mediumTurquoise:RGB = RGB.fromNumber( 0x48D1CC ) ;
        
        /**
         * The 'mediumVioletRed' SVG color object.
         */
        public const mediumVioletRed:RGB = RGB.fromNumber( 0xC71585 ) ;
        
        /**
         * The 'midnightBlue' SVG color object.
         */
        public const midnightBlue:RGB = RGB.fromNumber( 0x191970 ) ;
        
        /**
         * The 'mintCream' SVG color object.
         */
        public const mintCream:RGB = RGB.fromNumber( 0xf5fffa ) ;
        
        /**
         * The 'mistyRose' SVG color object.
         */
        public const mistyRose:RGB = RGB.fromNumber( 0xFFE4E1 ) ;
        
        /**
         * The 'Moccasin' SVG color object.
         */
        public const moccasin:RGB = RGB.fromNumber( 0xFFE4B5 ) ;
        
        /**
         * The 'navajoWhite' SVG color object.
         */
        public const navajoWhite:RGB = RGB.fromNumber( 0xFFDEAD ) ;
        
        /**
         * The 'navy' SVG color object.
         */
        public const navy:RGB = RGB.fromNumber( 0x000080 ) ;
        
        /**
         * The 'oldLace' SVG color object.
         */
        public const oldLace:RGB = RGB.fromNumber( 0xFDF5E6 ) ;
        
        /**
         * The 'olive' SVG color object.
         */
        public const olive:RGB = RGB.fromNumber( 0x808000 ) ;
        
        /**
         * The 'oliveDrab' SVG color object.
         */
        public const oliveDrab:RGB = RGB.fromNumber( 0x688E23 ) ;
        
        /**
         * The 'orange' SVG color object.
         */
        public const orange:RGB = RGB.fromNumber( 0xFFA500 ) ;
        
        /**
         * The 'orangeRed' SVG color object.
         */
        public const orangeRed:RGB = RGB.fromNumber( 0xFF4500 ) ;
        
        /**
         * The 'orchid' SVG color object.
         */
        public const orchid:RGB = RGB.fromNumber( 0xDA70D6 ) ;
        
        /**
         * The 'paleGoldenrod' SVG color object.
         */
        public const paleGoldenrod:RGB = RGB.fromNumber( 0xEEE8AA ) ;
        
        /**
         * The 'paleGreen' SVG color object.
         */
        public const paleGreen:RGB = RGB.fromNumber( 0x98FB98 ) ;
        
        /**
         * The 'paleTurquoise' SVG color object.
         */
        public const paleTurquoise:RGB = RGB.fromNumber( 0xAFEEEE ) ;
        
        /**
         * The 'paleVioletRed' SVG color object.
         */
        public const paleVioletRed:RGB = RGB.fromNumber( 0xDB7093 ) ;
        
        /**
         * The 'papayaWhip' SVG color object.
         */
        public const papayaWhip:RGB = RGB.fromNumber( 0xFFEFD5 ) ;
        
        /**
         * The 'peachPuff' SVG color object.
         */
        public const peachPuff:RGB = RGB.fromNumber( 0xFFDAB9 ) ;
        
        /**
         * The 'peru' SVG color object.
         */
        public const peru:RGB = RGB.fromNumber( 0xCD853F ) ;
        
        /**
         * The 'pink' SVG color object.
         */
        public const pink:RGB = RGB.fromNumber( 0xFFC0CB ) ;
        
        /**
         * The 'plum' SVG color object.
         */
        public const plum:RGB = RGB.fromNumber( 0xDDA0DD ) ;
        
        /**
         * The 'powderBlue' SVG color object.
         */
        public const powderBlue:RGB = RGB.fromNumber( 0xB0E0E6 ) ;
        
        /**
         * The 'purple' SVG color object.
         */
        public const purple:RGB = RGB.fromNumber( 0x800080 ) ;
        
        /**
         * The 'red' SVG color object.
         */
        public const red:RGB = RGB.fromNumber( 0xFF0000  ) ;
        
        /**
         * The 'rosyBrown' SVG color object.
         */
        public const rosyBrown:RGB = RGB.fromNumber( 0xBC8F8F ) ;
        
        /**
         * The 'royalBlue' SVG color object.
         */
        public const royalBlue:RGB = RGB.fromNumber( 0x4169E1 ) ;
        
        /**
         * The 'saddleBrown' SVG color object.
         */
        public const saddleBrown:RGB = RGB.fromNumber( 0x8B4513 ) ;
        
        /**
         * The 'salmon' SVG color object.
         */
        public const salmon:RGB = RGB.fromNumber( 0xFA8072 ) ;
        
        /**
         * The 'sandyBrown' SVG color object.
         */
        public const sandyBrown:RGB = RGB.fromNumber( 0xF4A460 ) ;
        
        /**
         * The 'seaGreen' SVG color object.
         */
        public const seaGreen:RGB = RGB.fromNumber( 0x2e8b57 ) ;
        
        /**
         * The 'seaShell' SVG color object.
         */
        public const seaShell:RGB = RGB.fromNumber( 0xFFF5EE ) ;
        
        /**
         * The 'sienna' SVG color object.
         */
        public const sienna:RGB = RGB.fromNumber( 0xA0522D ) ;
        
        /**
         * The 'silver' SVG color object.
         */
        public const silver:RGB = RGB.fromNumber( 0xC0C0C0 ) ;
        
        /**
         * The 'skyBlue' SVG color object.
         */
        public const skyBlue:RGB = RGB.fromNumber( 0x87CEEB ) ;
        
        /**
         * The 'slateBlue' SVG color object.
         */
        public const slateBlue:RGB = RGB.fromNumber( 0x6A5ACD ) ;
        
        /**
         * The 'slateGray' SVG color object.
         */
        public const slateGray:RGB = RGB.fromNumber( 0x708090 ) ;
        
        /**
         * The 'slateGrey' SVG color object.
         */
        public const slateGrey:RGB = RGB.fromNumber( 0x708090 ) ;
        
        /**
         * The 'snow' SVG color object.
         */
        public const snow:RGB = RGB.fromNumber( 0xFFFAFA ) ;
        
        /**
         * The 'springGreen' SVG color object.
         */
        public const springGreen:RGB = RGB.fromNumber( 0x00FF7F ) ;
        
        /**
         * The 'steelBlue' SVG color object.
         */
        public const steelBlue:RGB = RGB.fromNumber( 0x4682B4 ) ;
        
        /**
         * The 'tan' SVG color object.
         */
        public const tan:RGB = RGB.fromNumber( 0xD2B48C ) ;
        
        /**
         * The 'teal' SVG color object.
         */
        public const teal:RGB = RGB.fromNumber( 0x008080 ) ;
        
        /**
         * The 'thistle' SVG color object.
         */
        public const thistle:RGB = RGB.fromNumber( 0xD8BFD8 ) ;
        
        /**
         * The 'tomato' SVG color object.
         */
        public const tomato:RGB = RGB.fromNumber( 0xFF6347 ) ;
        
        /**
         * The 'turquoise' SVG color object.
         */
        public const turquoise:RGB = RGB.fromNumber( 0x40E0D0 ) ;
        
        /**
         * The 'violet' SVG color object.
         */
        public const violet:RGB = RGB.fromNumber( 0xEE82EE ) ;
        
        /**
         * The 'wheat' SVG color object.
         */
        public const wheat:RGB = RGB.fromNumber( 0xF5DEB3 ) ;
        
        /**
         * The 'white' SVG color object.
         */
        public const white:RGB = RGB.fromNumber( 0xFFFFFF ) ;
        
        /**
         * The 'whiteSmoke' SVG color object.
         */
        public const whiteSmoke:RGB = RGB.fromNumber( 0xF5F5F5 ) ;
        
        /**
         * The 'yellow' SVG color object.
         */
        public const yellow:RGB = RGB.fromNumber( 0xFFFF00 ) ;
        
        /**
         * The 'yellowGreen' SVG color object.
         */
        public const yellowGreen:RGB = RGB.fromNumber( 0x9ACD32 ) ;
        
        //////////////////
        
        /**
         * Fills out the supplied color collection with the colors from the internal color table. 
         * The color collection should be sized according to the return results from the length property.
         */
        public function get colors():Vector.<RGB>
        {
            var result:Vector.<RGB> = new Vector.<RGB>() ;
            for each( var color:RGB in _colors )
            {
                result.push( color ) ;
            }
            return result ;
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
            return Vector.<String>
            ([
                "aliceBlue", 
                "antiqueWhite", 
                "aqua", 
                "aquaMarine", 
                "azure", 
                "beige", 
                "bisque", 
                "black", 
                "blanchedAlmond", 
                "blue", 
                "blueViolet", 
                "brown", 
                "burlyWood", 
                "cadetBlue", 
                "chartreuse", 
                "chocolate", 
                "coral", 
                "cornFlowerBlue", 
                "cornsilk", 
                "crimson", 
                "cyan", 
                "darkBlue", 
                "darkCyan", 
                "darkGoldenRod", 
                "darkGray", 
                "darkGreen",
                "darkGrey", 
                "darkKhaki", 
                "darkMagenta", 
                "darkOliveGreen", 
                "darkOrange", 
                "darkOrchid", 
                "darkRed", 
                "darkSalmon", 
                "darkSeaGreen", 
                "darkSlateBlue", 
                "darkSlateGray", 
                "darkSlateGrey", 
                "darkTurquoise", 
                "darkViolet",
                "deepPink", 
                "deepSkyBlue", 
                "dimGray", 
                "dimGrey", 
                "dodgerBlue", 
                "fireBrick", 
                "floralWhite", 
                "forestGreen", 
                "fuchsia", 
                "gainsboro", 
                "ghostWhite", 
                "gold", 
                "goldenRod", 
                "gray", 
                "green", 
                "greenYellow", 
                "grey", 
                "honeyDew", 
                "hotPink", 
                "indianRed", 
                "indigo", 
                "ivory", 
                "khaki", 
                "lavender", 
                "lavenderBlush", 
                "lawnGreen", 
                "lemonChiffon", 
                "lightBlue", 
                "lightCoral", 
                "lightCyan", 
                "lightGoldenrodYellow", 
                "lightGray", 
                "lightGreen", 
                "lightGrey", 
                "lightPink", 
                "lightSalmon", 
                "lightSeaGreen", 
                "lightSkyBlue", 
                "lightSlateGray", 
                "lightSlateGrey",
                "lightSteelBlue", 
                "lightYellow", 
                "lime",
                "limeGreen", 
                "linen", 
                "magenta", 
                "maroon", 
                "mediumAquaMarine", 
                "mediumBlue", 
                "mediumOrchid", 
                "mediumPurple", 
                "mediumSeaGreen", 
                "mediumSlateBlue", 
                "mediumSpringGreen", 
                "mediumTurquoise", 
                "mediumVioletRed", 
                "midnightBlue", 
                "mintCream", 
                "mistyRose", 
                "moccasin", 
                "navajoWhite", 
                "navy", 
                "oldLace", 
                "olive", 
                "oliveDrab", 
                "orange", 
                "orangeRed", 
                "orchid", 
                "paleGoldenrod", 
                "paleGreen", 
                "paleTurquoise", 
                "paleVioletRed", 
                "papayaWhip", 
                "peachPuff", 
                "peru", 
                "pink", 
                "plum", 
                "powderBlue", 
                "purple", 
                "red", 
                "rosyBrown", 
                "royalBlue", 
                "saddleBrown", 
                "salmon", 
                "sandyBrown", 
                "seaGreen", 
                "seaShell", 
                "sienna", 
                "silver", 
                "skyBlue", 
                "slateBlue", 
                "slateGray", 
                "slateGrey", 
                "snow", 
                "springGreen", 
                "steelBlue", 
                "tan", 
                "teal", 
                "thistle", 
                "tomato", 
                "turquoise", 
                "violet", 
                "wheat", 
                "white", 
                "whiteSmoke", 
                "yellow", 
                "yellowGreen"
            ]) ;
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
         */
        public function toArray():Array
        {
            var rgb:RGB ;
            var array:Array = [] ;
            var names:Vector.<String> = this.names ;
            for each( var name:String in names )
            {
                rgb = this[name] as RGB ;
                if( rgb )
                {
                    array.push
                    ({ 
                        name  : name , 
                        value : rgb.valueOf() , 
                        hex   : rgb.toHexString("#") 
                    }) ;
                }
            }
            return array ;
        }
        
        /**
         * @private darkGrey, grey, 
         */
        private const _colors:Vector.<RGB> = Vector.<RGB>
        ([
            aliceBlue, 
            antiqueWhite, 
            aqua, 
            aquaMarine, 
            azure, 
            beige, 
            bisque, 
            black, 
            blanchedAlmond, 
            blue, 
            blueViolet, 
            brown, 
            burlyWood, 
            cadetBlue, 
            chartreuse, 
            chocolate, 
            coral, 
            cornFlowerBlue, 
            cornsilk, 
            crimson, 
            cyan, 
            darkBlue, 
            darkCyan, 
            darkGoldenRod, 
            darkGray, 
            darkGreen,
            darkGrey, 
            darkKhaki, 
            darkMagenta, 
            darkOliveGreen, 
            darkOrange, 
            darkOrchid, 
            darkRed, 
            darkSalmon, 
            darkSeaGreen, 
            darkSlateBlue, 
            darkSlateGray, 
            darkSlateGrey, 
            darkTurquoise, 
            darkViolet,
            deepPink, 
            deepSkyBlue, 
            dimGray, 
            dimGrey, 
            dodgerBlue, 
            fireBrick, 
            floralWhite, 
            forestGreen, 
            fuchsia, 
            gainsboro, 
            ghostWhite, 
            gold, 
            goldenRod, 
            gray, 
            green, 
            greenYellow, 
            grey, 
            honeyDew, 
            hotPink, 
            indianRed, 
            indigo, 
            ivory, 
            khaki, 
            lavender, 
            lavenderBlush, 
            lawnGreen, 
            lemonChiffon, 
            lightBlue, 
            lightCoral, 
            lightCyan, 
            lightGoldenrodYellow, 
            lightGray, 
            lightGreen, 
            lightGrey, 
            lightPink, 
            lightSalmon, 
            lightSeaGreen, 
            lightSkyBlue, 
            lightSlateGray, 
            lightSlateGrey,
            lightSteelBlue, 
            lightYellow, 
            lime,
            limeGreen, 
            linen, 
            magenta, 
            maroon, 
            mediumAquaMarine, 
            mediumBlue, 
            mediumOrchid, 
            mediumPurple, 
            mediumSeaGreen, 
            mediumSlateBlue, 
            mediumSpringGreen, 
            mediumTurquoise, 
            mediumVioletRed, 
            midnightBlue, 
            mintCream, 
            mistyRose, 
            moccasin, 
            navajoWhite, 
            navy, 
            oldLace, 
            olive, 
            oliveDrab, 
            orange, 
            orangeRed, 
            orchid, 
            paleGoldenrod, 
            paleGreen, 
            paleTurquoise, 
            paleVioletRed, 
            papayaWhip, 
            peachPuff, 
            peru, 
            pink, 
            plum, 
            powderBlue, 
            purple, 
            red, 
            rosyBrown, 
            royalBlue, 
            saddleBrown, 
            salmon, 
            sandyBrown, 
            seaGreen, 
            seaShell, 
            sienna, 
            silver, 
            skyBlue, 
            slateBlue, 
            slateGray, 
            slateGrey, 
            snow, 
            springGreen, 
            steelBlue, 
            tan, 
            teal, 
            thistle, 
            tomato, 
            turquoise, 
            violet, 
            wheat, 
            white, 
            whiteSmoke, 
            yellow, 
            yellowGreen
        ]);
    }
}
