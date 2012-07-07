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
     * import graphics.colors.palettes.HTMLPalette ;
     * 
     * var palette:HTMLPalette = new HTMLPalette() ;
     * 
     * trace( "length : " + palette.length ) ;
     * trace( "names  : " + palette.names  ) ;
     * trace( "colors : " + palette.colors ) ;
     * </pre>
     */
    public class HTMLPalette implements Palette
    {
        /**
         * Creates a new HTMLPalette instance.
         */
        public function HTMLPalette()
        {
            
        }
        //////////////////
        
        /**
         * The html 'aqua' color constant.
         */
        public const aqua:RGB = RGB.fromNumber(0x00FFFF) ;
        
        /**
         * The html 'black' color constant.
         */
        public const black:RGB = RGB.fromNumber(0x000000) ;
        
        /**
         * The html 'blue' color constant.
         */
        public const blue:RGB = RGB.fromNumber(0x0000FF) ;
        
        /**
         * The html 'fuchsia' color constant.
         */
        public const fuchsia:RGB = RGB.fromNumber(0xFF00FF) ;
        
        /**
         * The html 'gray' color constant.
         */
        public const gray:RGB = RGB.fromNumber(0x808080) ;
        
        /**
         * The html 'green' color constant.
         */
        public const green:RGB = RGB.fromNumber(0x008000) ;
        
        /**
         * The html 'lime' color constant.
         */
        public const lime:RGB = RGB.fromNumber(0x00FF00) ;
        
        /**
         * The html 'olive' color constant.
         */
        public const olive:RGB = RGB.fromNumber(0x808000) ;
        
        /**
         * The html 'maroon' color constant.
         */
        public const maroon:RGB = RGB.fromNumber(0x800000) ;
        
        /**
         * The html 'navy' color constant.
         */
        public const navy:RGB = RGB.fromNumber(0x000080) ;
        
        /**
         * The html 'purple' color constant.
         */
        public const purple:RGB = RGB.fromNumber(0x800080) ;
        
        /**
         * The html 'red' color constant.
         */
        public const red:RGB = RGB.fromNumber(0xFF0000) ;
        
        /**
         * The html 'silver' color constant.
         */
        public const silver:RGB = RGB.fromNumber(0xC0C0C0) ;
        
        /**
         * The html 'teal' color constant.
         */
        public const teal:RGB = RGB.fromNumber(0x008080) ;
        
        /**
         * The html 'white' color constant.
         */
        public const white:RGB = RGB.fromNumber(0xFFFFFF) ;
        
        /**
         * The html 'yellow' color constant.
         */
        public const yellow:RGB = RGB.fromNumber(0xFFFF00) ;
        
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
                "aqua", "black", "blue", "fuchsia", "gray", "green", "lime", "maroon", 
                "navy", "olive", "purple", "red", "silver", "teal", "white", "yellow"
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
         * @private
         */
        private const _colors:Vector.<RGB> = Vector.<RGB>
        ([
            aqua, black, blue, fuchsia, gray, green, lime, maroon, 
            navy, olive, purple, red, silver, teal, white, yellow
        ]);
    }
}
