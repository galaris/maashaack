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
            //
        }
        
        //////////////////
        
        /**
         * The 'aliceBlue' SVG rgb object.
         */
        public const aliceBlue:RGB = RGB.fromNumber( 0xF0F8FF ) ;
        
        /**
         * The 'antiqueWhite' SVG rgb object.
         */
        public const antiqueWhite:RGB = RGB.fromNumber( 0xFAEBD7 ) ;
        
        /**
         * The 'aqua' SVG rgb object.
         */
        public const aqua:RGB = RGB.fromNumber( 0x00FFFF ) ;
        
        /**
         * The 'aquaMarine' SVG rgb object.
         */
        public const aquaMarine:RGB = RGB.fromNumber( 0x7FFFD4 ) ;
        
        /**
         * The 'azure' SVG rgb object.
         */
        public const azure:RGB = RGB.fromNumber( 0xF0FFFF ) ;
        
        /**
         * The 'beige' SVG rgb object.
         */
        public const beige:RGB = RGB.fromNumber( 0xF5F5DC ) ;
        
        /**
         * The 'bisque' SVG rgb object.
         */
        public const bisque:RGB = RGB.fromNumber( 0xFFE4C4 ) ;
        
        /**
         * The 'black' SVG rgb object.
         */
        public const black:RGB = RGB.fromNumber( 0x000000 ) ;
        
        /**
         * The 'blanchedAlmond' SVG rgb object.
         */
        public const blanchedAlmond:RGB = RGB.fromNumber( 0xFFEBCD ) ;
        
        /**
         * The 'blue' SVG rgb object.
         */
        public const blue:RGB = RGB.fromNumber( 0x0000FF ) ;
        
        /**
         * The 'blueViolet' SVG rgb object.
         */
        public const blueViolet:RGB = RGB.fromNumber( 0x8A2BE2 ) ;
        
        /**
         * The 'brown' SVG rgb object.
         */
        public const brown:RGB = RGB.fromNumber( 0xA52A2A ) ;
        
        /**
         * The 'burlyWood' SVG rgb object.
         */
        public const burlyWood:RGB = RGB.fromNumber( 0xDEB887 ) ;
        
        /**
         * The 'cadetBlue' SVG rgb object.
         */
        public const cadetBlue:RGB = RGB.fromNumber( 0x5F9EA0 ) ;
        
        /**
         * The 'chartreuse' SVG rgb object.
         */
        public const chartreuse:RGB = RGB.fromNumber( 0x7FFF00 ) ;
        
        /**
         * The 'chocolate' SVG rgb object.
         */
        public const chocolate:RGB = RGB.fromNumber( 0xD2691E ) ;
        
        /**
         * The 'coral' SVG rgb object.
         */
        public const coral:RGB = RGB.fromNumber( 0xFF7F50 ) ;
        
        /**
         * The 'cornFlowerBlue' SVG rgb object.
         */
        public const cornFlowerBlue:RGB = RGB.fromNumber( 0x6495ED ) ;
        
        /**
         * The 'cornsilk' SVG rgb object.
         */
        public const cornsilk:RGB = RGB.fromNumber( 0xFFF8DC ) ;
        
        /**
         * The 'crimson' SVG rgb object.
         */
        public const crimson:RGB = RGB.fromNumber( 0xDC143C ) ;
        
        /**
         * The 'cyan' SVG rgb object.
         */
        public const cyan:RGB = RGB.fromNumber( 0x00FFFF ) ;
        
        /**
         * The 'darkBlue' SVG rgb object.
         */
        public const darkBlue:RGB = RGB.fromNumber( 0x00008B ) ;
        
        /**
         * The 'darkCyan' SVG rgb object.
         */
        public const darkCyan:RGB = RGB.fromNumber( 0x008B8B ) ;
        
        /**
         * The 'darkGoldenRod' SVG rgb object.
         */
        public const darkGoldenRod:RGB = RGB.fromNumber( 0xB8860B ) ;
        
        /**
         * The 'darkGray' SVG rgb object.
         */
        public const darkGray:RGB = RGB.fromNumber( 0xA9A9A9 ) ;
        
        /**
         * The 'darkGreen' SVG rgb object.
         */
        public const darkGreen:RGB = RGB.fromNumber( 0x006400 ) ;
        
        /**
         * The 'darkGrey' SVG rgb object.
         */
        public const darkGrey:RGB = RGB.fromNumber( 0xA9A9A9 ) ;
        
        /**
         * The 'darkKhaki' SVG rgb object.
         */
        public const darkKhaki:RGB = RGB.fromNumber( 0xBDB76B ) ;
        
        /**
         * The 'darkMagenta' SVG rgb object.
         */
        public const darkMagenta:RGB = RGB.fromNumber( 0x8B008B ) ;
        
        /**
         * The 'darkOliveGreen' SVG rgb object.
         */
        public const darkOliveGreen:RGB = RGB.fromNumber( 0x556B2F ) ;
        
        /**
         * The 'darkOrange' SVG rgb object.
         */
        public const darkOrange:RGB = RGB.fromNumber( 0xFF8C00 ) ;
        
        /**
         * The 'darkOrchid' SVG rgb object.
         */
        public const darkOrchid:RGB = RGB.fromNumber( 0x9932CC ) ;
        
        /**
         * The 'darkRed' SVG rgb object.
         */
        public const darkRed:RGB = RGB.fromNumber( 0x8b0000 ) ;
        
        /**
         * The 'darkSalmon' SVG rgb object.
         */
        public const darkSalmon:RGB = RGB.fromNumber( 0xE9967A ) ;
        
        /**
         * The 'darkSeaGreen' SVG rgb object.
         */
        public const darkSeaGreen:RGB = RGB.fromNumber( 0x8FBC8F ) ;
        
        /**
         * The 'darkSlateBlue' SVG rgb object.
         */
        public const darkSlateBlue:RGB = RGB.fromNumber( 0x483D8B ) ;
        
        /**
         * The 'darkSlateGray' SVG rgb object.
         */
        public const darkSlateGray:RGB = RGB.fromNumber( 0x2F4F4F ) ;
        
        /**
         * The 'darkSlateGrey' SVG rgb object.
         */
        public const darkSlateGrey:RGB = RGB.fromNumber( 0x2F4F4F ) ;
        
        /**
         * The 'darkTurquoise' SVG rgb object.
         */
        public const darkTurquoise:RGB = RGB.fromNumber( 0x00CED1 ) ;
        
        /**
         * The 'darkViolet' SVG rgb object.
         */
        public const darkViolet:RGB = RGB.fromNumber( 0x9400D3 ) ;
        
        /**
         * The 'deepPink' SVG rgb object.
         */
        public const deepPink:RGB = RGB.fromNumber( 0xFF1493 ) ;
        
        /**
         * The 'deepSkyBlue' SVG rgb object.
         */
        public const deepSkyBlue:RGB = RGB.fromNumber( 0x00BFFF ) ;
        
        /**
         * The 'dimGray' SVG rgb object.
         */
        public const dimGray:RGB = RGB.fromNumber( 0x696969 ) ;
        
        /**
         * The 'dimGrey' SVG rgb object.
         */
        public const dimGrey:RGB = RGB.fromNumber( 0x696969 ) ;
        
        /**
         * The 'dodgerBlue' SVG rgb object.
         */
        public const dodgerBlue:RGB = RGB.fromNumber( 0x1E90FF ) ;
        
        /**
         * The 'fireBrick' SVG rgb object.
         */
        public const fireBrick:RGB = RGB.fromNumber( 0xB22222 ) ;
        
        /**
         * The 'floralWhite' SVG rgb object.
         */
        public const floralWhite:RGB = RGB.fromNumber( 0xFFFAF0 ) ;
        
        /**
         * The 'forestGreen' SVG rgb object.
         */
        public const forestGreen:RGB = RGB.fromNumber( 0x228b22 ) ;
        
        /**
         * The 'fuchsia' SVG rgb object.
         */
        public const fuchsia:RGB = RGB.fromNumber( 0xFF00FF ) ;
        
        /**
         * The 'gainsboro' SVG rgb object.
         */
        public const gainsboro:RGB = RGB.fromNumber( 0xDCDCDC ) ;
        
        /**
         * The 'ghostWhite' SVG rgb object.
         */
        public const ghostWhite:RGB = RGB.fromNumber( 0xF8F8FF ) ;
        
        /**
         * The 'gold' SVG rgb object.
         */
        public const gold:RGB = RGB.fromNumber( 0xFFD700 ) ;
        
        /**
         * The 'goldenRod' SVG rgb object.
         */
        public const goldenRod:RGB = RGB.fromNumber( 0xDAA520 ) ;
        
        /**
         * The 'gray' SVG rgb object.
         */
        public const gray:RGB = RGB.fromNumber( 0x808080 ) ;
        
        /**
         * The 'green' SVG rgb object.
         */
        public const green:RGB = RGB.fromNumber( 0x008000 ) ;
        
        /**
         * The 'greenYellow' SVG rgb object.
         */
        public const greenYellow:RGB = RGB.fromNumber( 0xADFF2F ) ;
        
        /**
         * The 'grey' SVG rgb object.
         */
        public const grey:RGB = RGB.fromNumber( 0x808080 ) ;
        
        /**
         * The 'honeyDew' SVG rgb object.
         */
        public const honeyDew:RGB = RGB.fromNumber( 0xF0FFF0 ) ;
        
        /**
         * The 'hotPink' SVG rgb object.
         */
        public const hotPink:RGB = RGB.fromNumber( 0xFF69B4 ) ;
        
        /**
         * The 'indianRed' SVG rgb object.
         */
        public const indianRed:RGB = RGB.fromNumber( 0xCD5C5C ) ;
        
        /**
         * The 'indigo' SVG rgb object.
         */
        public const indigo:RGB = RGB.fromNumber( 0x4B0082 ) ;
        
        /**
         * The 'ivory' SVG rgb object.
         */
        public const ivory:RGB = RGB.fromNumber( 0xFFFFF0 ) ;
        
        /**
         * The 'khaki' SVG rgb object.
         */
        public const khaki:RGB = RGB.fromNumber( 0xF0E68C ) ;
        
        /**
         * The 'lavender' SVG rgb object.
         */
        public const lavender:RGB = RGB.fromNumber( 0xE6E6FA ) ;
        
        /**
         * The 'lavenderBlush' SVG rgb object.
         */
        public const lavenderBlush:RGB = RGB.fromNumber( 0xFFF0F5 ) ;
        
        /**
         * The 'lawnGreen' SVG rgb object.
         */
        public const lawnGreen:RGB = RGB.fromNumber( 0x7CFC00 ) ;
        
        /**
         * The 'lemonChiffon' SVG rgb object.
         */
        public const lemonChiffon:RGB = RGB.fromNumber( 0xFFFACD ) ;
        
        /**
         * The 'lightBlue' SVG rgb object.
         */
        public const lightBlue:RGB = RGB.fromNumber( 0xADD8E6 ) ;
        
        /**
         * The 'lightCoral' SVG rgb object.
         */
        public const lightCoral:RGB = RGB.fromNumber( 0xF08080 ) ;
        
        /**
         * The 'lightCyan' SVG rgb object.
         */
        public const lightCyan:RGB = RGB.fromNumber( 0xE0FFFF ) ;
        
        /**
         * The 'lightGoldenrodYellow' SVG rgb object.
         */
        public const lightGoldenrodYellow:RGB = RGB.fromNumber( 0xFAFAD2 ) ;
        
        /**
         * The 'lightGray' SVG rgb object.
         */
        public const lightGray:RGB = RGB.fromNumber( 0xD3D3D3 ) ;
        
        /**
         * The 'lightGreen' SVG rgb object.
         */
        public const lightGreen:RGB = RGB.fromNumber( 0x90EE90 ) ;
        
        /**
         * The 'lightGrey' SVG rgb object.
         */
        public const lightGrey:RGB = RGB.fromNumber( 0xD3D3D3 ) ;
        
        /**
         * The 'lightPink' SVG rgb object.
         */
        public const lightPink:RGB = RGB.fromNumber( 0xFFB6C1 ) ;
        
        /**
         * The 'lightSalmon' SVG rgb object.
         */
        public const lightSalmon:RGB = RGB.fromNumber( 0xFFA07A ) ;
        
        /**
         * The 'lightSeaGreen' SVG rgb object.
         */
        public const lightSeaGreen:RGB = RGB.fromNumber( 0x20B2AA ) ;
        
        /**
         * The 'lightSkyBlue' SVG rgb object.
         */
        public const lightSkyBlue:RGB = RGB.fromNumber( 0x87CEFA ) ;
        
        /**
         * The 'lightSlateGray' SVG rgb object.
         */
        public const lightSlateGray:RGB = RGB.fromNumber( 0x778899 ) ;
        
        /**
         * The 'lightSlateGrey' SVG rgb object.
         */
        public const lightSlateGrey:RGB = RGB.fromNumber( 0x778899 ) ;
        
        /**
         * The 'lightSteelBlue' SVG rgb object.
         */
        public const lightSteelBlue:RGB = RGB.fromNumber( 0xB0C4DE ) ;
        
        /**
         * The 'lightYellow' SVG rgb object.
         */
        public const lightYellow:RGB = RGB.fromNumber( 0xFFFFE0 ) ;
        
        /**
         * The 'lime' SVG rgb object.
         */
        public const lime:RGB = RGB.fromNumber( 0x00FF00 ) ;
        
        /**
         * The 'limeGreen' SVG rgb object.
         */
        public const limeGreen:RGB = RGB.fromNumber( 0x32CD32 ) ;
        
        /**
         * The 'linen' SVG rgb object.
         */
        public const linen:RGB = RGB.fromNumber( 0xFAF0E6 ) ;
        
        /**
         * The 'magenta' SVG rgb object.
         */
        public const magenta:RGB = RGB.fromNumber( 0xFF00FF ) ;
        
        /**
         * The 'maroon' SVG rgb object.
         */
        public const maroon:RGB = RGB.fromNumber( 0x800000 ) ;
        
        /**
         * The 'mediumAquaMarine' SVG rgb object.
         */
        public const mediumAquaMarine:RGB = RGB.fromNumber( 0x66CDAA ) ;
        
        /**
         * The 'mediumBlue' SVG rgb object.
         */
        public const mediumBlue:RGB = RGB.fromNumber( 0x0000CD ) ;
        
        /**
         * The 'mediumOrchid' SVG rgb object.
         */
        public const mediumOrchid:RGB = RGB.fromNumber( 0xBA55D3 ) ;
        
        /**
         * The 'mediumPurple' SVG rgb object.
         */
        public const mediumPurple:RGB = RGB.fromNumber( 0x9370D8 ) ;
        
        /**
         * The 'mediumSeaGreen' SVG rgb object.
         */
        public const mediumSeaGreen:RGB = RGB.fromNumber( 0x3cb371 ) ;
        
        /**
         * The 'mediumSlateBlue' SVG rgb object.
         */
        public const mediumSlateBlue:RGB = RGB.fromNumber( 0x7B68EE ) ;
        
        /**
         * The 'mediumSpringGreen' SVG rgb object.
         */
        public const mediumSpringGreen:RGB = RGB.fromNumber( 0x00FA9A ) ;
        
        /**
         * The 'mediumTurquoise' SVG rgb object.
         */
        public const mediumTurquoise:RGB = RGB.fromNumber( 0x48D1CC ) ;
        
        /**
         * The 'mediumVioletRed' SVG rgb object.
         */
        public const mediumVioletRed:RGB = RGB.fromNumber( 0xC71585 ) ;
        
        /**
         * The 'midnightBlue' SVG rgb object.
         */
        public const midnightBlue:RGB = RGB.fromNumber( 0x191970 ) ;
        
        /**
         * The 'mintCream' SVG rgb object.
         */
        public const mintCream:RGB = RGB.fromNumber( 0xf5fffa ) ;
        
        /**
         * The 'mistyRose' SVG rgb object.
         */
        public const mistyRose:RGB = RGB.fromNumber( 0xFFE4E1 ) ;
        
        /**
         * The 'Moccasin' SVG rgb object.
         */
        public const moccasin:RGB = RGB.fromNumber( 0xFFE4B5 ) ;
        
        /**
         * The 'navajoWhite' SVG rgb object.
         */
        public const navajoWhite:RGB = RGB.fromNumber( 0xFFDEAD ) ;
        
        /**
         * The 'navy' SVG rgb object.
         */
        public const navy:RGB = RGB.fromNumber( 0x000080 ) ;
        
        /**
         * The 'oldLace' SVG rgb object.
         */
        public const oldLace:RGB = RGB.fromNumber( 0xFDF5E6 ) ;
        
        /**
         * The 'olive' SVG rgb object.
         */
        public const olive:RGB = RGB.fromNumber( 0x808000 ) ;
        
        /**
         * The 'oliveDrab' SVG rgb object.
         */
        public const oliveDrab:RGB = RGB.fromNumber( 0x688E23 ) ;
        
        /**
         * The 'orange' SVG rgb object.
         */
        public const orange:RGB = RGB.fromNumber( 0xFFA500 ) ;
        
        /**
         * The 'orangeRed' SVG rgb object.
         */
        public const orangeRed:RGB = RGB.fromNumber( 0xFF4500 ) ;
        
        /**
         * The 'orchid' SVG rgb object.
         */
        public const orchid:RGB = RGB.fromNumber( 0xDA70D6 ) ;
        
        /**
         * The 'paleGoldenrod' SVG rgb object.
         */
        public const paleGoldenrod:RGB = RGB.fromNumber( 0xEEE8AA ) ;
        
        /**
         * The 'paleGreen' SVG rgb object.
         */
        public const paleGreen:RGB = RGB.fromNumber( 0x98FB98 ) ;
        
        /**
         * The 'paleTurquoise' SVG rgb object.
         */
        public const paleTurquoise:RGB = RGB.fromNumber( 0xAFEEEE ) ;
        
        /**
         * The 'paleVioletRed' SVG rgb object.
         */
        public const paleVioletRed:RGB = RGB.fromNumber( 0xDB7093 ) ;
        
        /**
         * The 'papayaWhip' SVG rgb object.
         */
        public const papayaWhip:RGB = RGB.fromNumber( 0xFFEFD5 ) ;
        
        /**
         * The 'peachPuff' SVG rgb object.
         */
        public const peachPuff:RGB = RGB.fromNumber( 0xFFDAB9 ) ;
        
        /**
         * The 'peru' SVG rgb object.
         */
        public const peru:RGB = RGB.fromNumber( 0xCD853F ) ;
        
        /**
         * The 'pink' SVG rgb object.
         */
        public const pink:RGB = RGB.fromNumber( 0xFFC0CB ) ;
        
        /**
         * The 'plum' SVG rgb object.
         */
        public const plum:RGB = RGB.fromNumber( 0xDDA0DD ) ;
        
        /**
         * The 'powderBlue' SVG rgb object.
         */
        public const powderBlue:RGB = RGB.fromNumber( 0xB0E0E6 ) ;
        
        /**
         * The 'purple' SVG rgb object.
         */
        public const purple:RGB = RGB.fromNumber( 0x800080 ) ;
        
        /**
         * The 'red' SVG rgb object.
         */
        public const red:RGB = RGB.fromNumber( 0xFF0000  ) ;
        
        /**
         * The 'rosyBrown' SVG rgb object.
         */
        public const rosyBrown:RGB = RGB.fromNumber( 0xBC8F8F ) ;
        
        /**
         * The 'royalBlue' SVG rgb object.
         */
        public const royalBlue:RGB = RGB.fromNumber( 0x4169E1 ) ;
        
        /**
         * The 'saddleBrown' SVG rgb object.
         */
        public const saddleBrown:RGB = RGB.fromNumber( 0x8B4513 ) ;
        
        /**
         * The 'salmon' SVG rgb object.
         */
        public const salmon:RGB = RGB.fromNumber( 0xFA8072 ) ;
        
        /**
         * The 'sandyBrown' SVG rgb object.
         */
        public const sandyBrown:RGB = RGB.fromNumber( 0xF4A460 ) ;
        
        /**
         * The 'seaGreen' SVG rgb object.
         */
        public const seaGreen:RGB = RGB.fromNumber( 0x2e8b57 ) ;
        
        /**
         * The 'seaShell' SVG rgb object.
         */
        public const seaShell:RGB = RGB.fromNumber( 0xFFF5EE ) ;
        
        /**
         * The 'sienna' SVG rgb object.
         */
        public const sienna:RGB = RGB.fromNumber( 0xA0522D ) ;
        
        /**
         * The 'silver' SVG rgb object.
         */
        public const silver:RGB = RGB.fromNumber( 0xC0C0C0 ) ;
        
        /**
         * The 'skyBlue' SVG rgb object.
         */
        public const skyBlue:RGB = RGB.fromNumber( 0x87CEEB ) ;
        
        /**
         * The 'slateBlue' SVG rgb object.
         */
        public const slateBlue:RGB = RGB.fromNumber( 0x6A5ACD ) ;
        
        /**
         * The 'slateGray' SVG rgb object.
         */
        public const slateGray:RGB = RGB.fromNumber( 0x708090 ) ;
        
        /**
         * The 'slateGrey' SVG rgb object.
         */
        public const slateGrey:RGB = RGB.fromNumber( 0x708090 ) ;
        
        /**
         * The 'snow' SVG rgb object.
         */
        public const snow:RGB = RGB.fromNumber( 0xFFFAFA ) ;
        
        /**
         * The 'springGreen' SVG rgb object.
         */
        public const springGreen:RGB = RGB.fromNumber( 0x00FF7F ) ;
        
        /**
         * The 'steelBlue' SVG rgb object.
         */
        public const steelBlue:RGB = RGB.fromNumber( 0x4682B4 ) ;
        
        /**
         * The 'tan' SVG rgb object.
         */
        public const tan:RGB = RGB.fromNumber( 0xD2B48C ) ;
        
        /**
         * The 'teal' SVG rgb object.
         */
        public const teal:RGB = RGB.fromNumber( 0x008080 ) ;
        
        /**
         * The 'thistle' SVG rgb object.
         */
        public const thistle:RGB = RGB.fromNumber( 0xD8BFD8 ) ;
        
        /**
         * The 'tomato' SVG rgb object.
         */
        public const tomato:RGB = RGB.fromNumber( 0xFF6347 ) ;
        
        /**
         * The 'turquoise' SVG rgb object.
         */
        public const turquoise:RGB = RGB.fromNumber( 0x40E0D0 ) ;
        
        /**
         * The 'violet' SVG rgb object.
         */
        public const violet:RGB = RGB.fromNumber( 0xEE82EE ) ;
        
        /**
         * The 'wheat' SVG rgb object.
         */
        public const wheat:RGB = RGB.fromNumber( 0xF5DEB3 ) ;
        
        /**
         * The 'white' SVG rgb object.
         */
        public const white:RGB = RGB.fromNumber( 0xFFFFFF ) ;
        
        /**
         * The 'whiteSmoke' SVG rgb object.
         */
        public const whiteSmoke:RGB = RGB.fromNumber( 0xF5F5F5 ) ;
        
        /**
         * The 'yellow' SVG rgb object.
         */
        public const yellow:RGB = RGB.fromNumber( 0xFFFF00 ) ;
        
        /**
         * The 'yellowGreen' SVG rgb object.
         */
        public const yellowGreen:RGB = RGB.fromNumber( 0x9ACD32 ) ;
        
        //////////////////
        
        /**
         * Fills out the supplied rgb collection with the colors from the internal rgb table. 
         * The rgb collection should be sized according to the return results from the length property.
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
         * Retrieves the number of colors in the rgb table.
         */
        public function get length():uint
        {
            return _colors.length ;
        }
        
        /**
         * Returns the list of all rgb names.
         */
        public function get names():Vector.<String>
        {
            var vector:Vector.<String> = new Vector.<String>() ;
            for each( var sample:ColorSample in _colors )
            {
                vector.push( sample.name ) ;
            }
            return vector ;
        }
        
        /**
         * Indicates whether the palette contains an alpha transparent rgb.
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
         * import graphics.colors.palettes.SVGPalette ;
         * 
         * var palette:SVGPalette = new SVGPalette() ;
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
        
        /**
         * @private
         */
        private const _colors:Vector.<ColorSample> = Vector.<ColorSample>
        ([
            new ColorSample( "aliceBlue"            , aliceBlue            ) ,
            new ColorSample( "antiqueWhite"         , antiqueWhite         ) ,
            new ColorSample( "aqua"                 , aqua                 ) ,
            new ColorSample( "aquaMarine"           , aquaMarine           ) ,
            new ColorSample( "azure"                , azure                ) ,
            new ColorSample( "beige"                , beige                ) ,
            new ColorSample( "bisque"               , bisque               ) ,
            new ColorSample( "black"                , black                ) ,
            new ColorSample( "blanchedAlmond"       , blanchedAlmond       ) ,
            new ColorSample( "blue"                 , blue                 ) ,
            new ColorSample( "blueViolet"           , blueViolet           ) ,
            new ColorSample( "brown"                , brown                ) ,
            new ColorSample( "burlyWood"            , burlyWood            ) ,
            new ColorSample( "cadetBlue"            , cadetBlue            ) ,
            new ColorSample( "chartreuse"           , chartreuse           ) ,
            new ColorSample( "chocolate"            , chocolate            ) ,
            new ColorSample( "coral"                , coral                ) ,
            new ColorSample( "cornFlowerBlue"       , cornFlowerBlue       ) ,
            new ColorSample( "cornsilk"             , cornsilk             ) ,
            new ColorSample( "crimson"              , crimson              ) ,
            new ColorSample( "cyan   "              , cyan                 ) ,
            new ColorSample( "darkBlue"             , darkBlue             ) ,
            new ColorSample( "darkCyan"             , darkCyan             ) ,
            new ColorSample( "darkGoldenRod"        , darkGoldenRod        ) ,
            new ColorSample( "darkGray"             , darkGray             ) ,
            new ColorSample( "darkGreen"            , darkGreen            ) ,
            new ColorSample( "darkGrey"             , darkGrey             ) ,
            new ColorSample( "darkKhaki"            , darkKhaki            ) ,
            new ColorSample( "darkMagenta"          , darkMagenta          ) ,
            new ColorSample( "darkOliveGreen"       , darkOliveGreen       ) ,
            new ColorSample( "darkOrange"           , darkOrange           ) ,
            new ColorSample( "darkOrchid"           , darkOrchid           ) ,
            new ColorSample( "darkRed"              , darkRed              ) ,
            new ColorSample( "darkSalmon"           , darkSalmon           ) ,
            new ColorSample( "darkSeaGreen"         , darkSeaGreen         ) ,
            new ColorSample( "darkSlateBlue"        , darkSlateBlue        ) ,
            new ColorSample( "darkSlateGray"        , darkSlateGray        ) ,
            new ColorSample( "darkSlateGrey"        , darkSlateGrey        ) ,
            new ColorSample( "darkTurquoise"        , darkTurquoise        ) ,
            new ColorSample( "darkViolet"           , darkViolet           ) ,
            new ColorSample( "deepPink"             , deepPink             ) ,
            new ColorSample( "deepSkyBlue"          , deepSkyBlue          ) ,
            new ColorSample( "dimGray"              , dimGray              ) ,
            new ColorSample( "dimGrey"              , dimGrey              ) ,
            new ColorSample( "dodgerBlue"           , dodgerBlue           ) ,
            new ColorSample( "fireBrick"            , fireBrick            ) ,
            new ColorSample( "floralWhite"          , floralWhite          ) ,
            new ColorSample( "forestGreen"          , forestGreen          ) ,
            new ColorSample( "fuchsia"              , fuchsia              ) ,
            new ColorSample( "gainsboro"            , gainsboro            ) ,
            new ColorSample( "ghostWhite"           , ghostWhite           ) ,
            new ColorSample( "gold"                 , gold                 ) ,
            new ColorSample( "goldenRod"            , goldenRod            ) ,
            new ColorSample( "gray"                 , gray                 ) ,
            new ColorSample( "green"                , green                ) ,
            new ColorSample( "greenYellow"          , greenYellow          ) ,
            new ColorSample( "grey"                 , grey                 ) ,
            new ColorSample( "honeyDew"             , honeyDew             ) ,
            new ColorSample( "hotPink"              , hotPink              ) ,
            new ColorSample( "indianRed"            , indianRed            ) ,
            new ColorSample( "indigo"               , indigo               ) ,
            new ColorSample( "ivory"                , ivory                ) ,
            new ColorSample( "khaki"                , khaki                ) ,
            new ColorSample( "lavender"             , lavender             ) ,
            new ColorSample( "lavenderBlush"        , lavenderBlush        ) ,
            new ColorSample( "lawnGreen"            , lawnGreen            ) ,
            new ColorSample( "lemonChiffon"         , lemonChiffon         ) ,
            new ColorSample( "lightBlue"            , lightBlue            ) ,
            new ColorSample( "lightCoral"           , lightCoral           ) ,
            new ColorSample( "lightCyan"            , lightCyan            ) ,
            new ColorSample( "lightGoldenrodYellow" , lightGoldenrodYellow ) ,
            new ColorSample( "lightGray"            , lightGray            ) ,
            new ColorSample( "lightGreen"           , lightGreen           ) ,
            new ColorSample( "lightGrey"            , lightGrey            ) ,
            new ColorSample( "lightPink"            , lightPink            ) ,
            new ColorSample( "lightSalmon"          , lightSalmon          ) ,
            new ColorSample( "lightSeaGreen"        , lightSeaGreen        ) ,
            new ColorSample( "lightSkyBlue"         , lightSkyBlue         ) ,
            new ColorSample( "lightSlateGray"       , lightSlateGray       ) ,
            new ColorSample( "lightSlateGrey"       , lightSlateGrey       ) ,
            new ColorSample( "lightSteelBlue"       , lightSteelBlue       ) ,
            new ColorSample( "lightYellow"          , lightYellow          ) ,
            new ColorSample( "lime"                 , lime                 ) ,
            new ColorSample( "limeGreen"            , limeGreen            ) ,
            new ColorSample( "linen"                , linen                ) ,
            new ColorSample( "magenta"              , magenta              ) ,
            new ColorSample( "maroon"               , maroon               ) ,
            new ColorSample( "mediumAquaMarine"     , mediumAquaMarine     ) ,
            new ColorSample( "mediumBlue"           , mediumBlue           ) ,
            new ColorSample( "mediumOrchid"         , mediumOrchid         ) ,
            new ColorSample( "mediumPurple"         , mediumPurple         ) ,
            new ColorSample( "mediumSeaGreen"       , mediumSeaGreen       ) ,
            new ColorSample( "mediumSlateBlue"      , mediumSlateBlue      ) ,
            new ColorSample( "mediumSpringGreen"    , mediumSpringGreen    ) ,
            new ColorSample( "mediumTurquoise"      , mediumTurquoise      ) ,
            new ColorSample( "mediumVioletRed"      , mediumVioletRed      ) ,
            new ColorSample( "midnightBlue"         , midnightBlue         ) ,
            new ColorSample( "mintCream"            , mintCream            ) ,
            new ColorSample( "mistyRose"            , mistyRose            ) ,
            new ColorSample( "moccasin"             , moccasin             ) ,
            new ColorSample( "navajoWhite"          , navajoWhite          ) ,
            new ColorSample( "navy"                 , navy                 ) ,
            new ColorSample( "oldLace"              , oldLace              ) ,
            new ColorSample( "olive"                , olive                ) ,
            new ColorSample( "oliveDrab"            , oliveDrab            ) ,
            new ColorSample( "orange"               , orange               ) ,
            new ColorSample( "orangeRed"            , orangeRed            ) ,
            new ColorSample( "orchid"               , orchid               ) ,
            new ColorSample( "paleGoldenrod"        , paleGoldenrod        ) ,
            new ColorSample( "paleGreen"            , paleGreen            ) ,
            new ColorSample( "paleTurquoise"        , paleTurquoise        ) ,
            new ColorSample( "paleVioletRed"        , paleVioletRed        ) ,
            new ColorSample( "papayaWhip"           , papayaWhip           ) ,
            new ColorSample( "peachPuff"            , peachPuff            ) ,
            new ColorSample( "peru"                 , peru                 ) ,
            new ColorSample( "pink"                 , pink                 ) ,
            new ColorSample( "plum"                 , plum                 ) ,
            new ColorSample( "powderBlue"           , powderBlue           ) ,
            new ColorSample( "purple"               , purple               ) ,
            new ColorSample( "red"                  , red                  ) ,
            new ColorSample( "rosyBrown"            , rosyBrown            ) ,
            new ColorSample( "royalBlue"            , royalBlue            ) ,
            new ColorSample( "saddleBrown"          , saddleBrown          ) ,
            new ColorSample( "salmon"               , salmon               ) ,
            new ColorSample( "sandyBrown"           , sandyBrown           ) ,
            new ColorSample( "seaGreen"             , seaGreen             ) ,
            new ColorSample( "seaShell"             , seaShell             ) ,
            new ColorSample( "sienna"               , sienna               ) ,
            new ColorSample( "silver"               , silver               ) ,
            new ColorSample( "skyBlue"              , skyBlue              ) ,
            new ColorSample( "slateBlue"            , slateBlue            ) ,
            new ColorSample( "slateGray"            , slateGray            ) ,
            new ColorSample( "slateGrey"            , slateGrey            ) ,
            new ColorSample( "snow"                 , snow                 ) ,
            new ColorSample( "springGreen"          , springGreen          ) ,
            new ColorSample( "steelBlue"            , steelBlue            ) ,
            new ColorSample( "tan"                  , tan                  ) ,
            new ColorSample( "teal"                 , teal                 ) ,
            new ColorSample( "thistle"              , thistle              ) ,
            new ColorSample( "tomato"               , tomato               ) ,
            new ColorSample( "turquoise"            , turquoise            ) ,
            new ColorSample( "violet"               , violet               ) ,
            new ColorSample( "wheat"                , wheat                ) ,
            new ColorSample( "white"                , white                ) ,
            new ColorSample( "whiteSmoke"           , whiteSmoke           ) ,
            new ColorSample( "yellow"               , yellow               ) ,
            new ColorSample( "yellowGreen"          , yellowGreen          ) 
        ]);
    }
}