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

package library.mime
{
    public class ImageMediaType extends MediaType
    {
        private var _value:int;
        private var _subtype:String;
        private var _extensions:Array;
        
        public function ImageMediaType( value:int = 0, subtype:String = "", extensions:Array = null )
        {
            super( "image", 0x300000 );
            
            _value      = value;
            _subtype    = subtype;
            _extensions = [];
            
            if( extensions ) { _extensions = extensions; }
        }
        
        public function get subtype():String { return _subtype; }
        
        public function get extension():String
        {
            if( _extensions ) { return _extensions[0]; }
            return "";
        }
        
        public function get extensions():Array
        {
            if( _extensions ) { return _extensions; }
            return [];
        }
        
        public function toString():String { return type + "/" + _subtype; }
        
        public function valueOf():int { return category + _value; }
        
        public static const bmp:ImageMediaType                = new ImageMediaType(  1, "bmp", ["bmp"] );
        public static const gif:ImageMediaType                = new ImageMediaType(  2, "gif", ["gif"] );
        public static const jpeg:ImageMediaType               = new ImageMediaType(  3, "jpeg", ["jpe", "jpeg", "jpg"] );
        public static const x_png:ImageMediaType              = new ImageMediaType(  4, "x-png", ["png"] );
        public static const png:ImageMediaType                = new ImageMediaType(  5, "png", ["png"] );
        public static const tiff:ImageMediaType               = new ImageMediaType(  6, "tiff", ["tif", "tiff"] );
        public static const example:ImageMediaType            = new ImageMediaType(  7, "example" );
        public static const ico:ImageMediaType                = new ImageMediaType(  8, "ico", ["ico"] );
        public static const x_icon:ImageMediaType             = new ImageMediaType(  9, "x-icon", ["ico"] );
        public static const microsoft_icon:ImageMediaType     = new ImageMediaType( 10, "vnd.microsoft.icon", ["ico"] );
        public static const ief:ImageMediaType                = new ImageMediaType( 11, "ief", ["ief"] );
        public static const pipeg:ImageMediaType              = new ImageMediaType( 12, "pipeg", ["jfif"] );
        public static const pjpeg:ImageMediaType              = new ImageMediaType( 13, "pjpeg", ["jpeg"] );
        public static const cis_cod:ImageMediaType            = new ImageMediaType( 14, "cis-cod", ["cod"] );
        public static const x_cmu_raster:ImageMediaType       = new ImageMediaType( 15, "x-cmu-raster", ["ras"] );
        public static const x_cmx:ImageMediaType              = new ImageMediaType( 16, "x-cmx", ["cmx"] );
        public static const x_portable_anymap:ImageMediaType  = new ImageMediaType( 17, "x-portable-anymap", ["pnm"] );
        public static const x_portable_bitmap:ImageMediaType  = new ImageMediaType( 18, "x-portable-bitmap", ["pbm"] );
        public static const x_portable_graymap:ImageMediaType = new ImageMediaType( 19, "x-portable-graymap", ["pgm"] );
        public static const x_portable_pixmap:ImageMediaType  = new ImageMediaType( 20, "x-portable-pixmap", ["ppm"] );
        public static const x_rgb:ImageMediaType              = new ImageMediaType( 21, "x-rgb", ["rgb"] );
        public static const x_xbitmap:ImageMediaType          = new ImageMediaType( 22, "x-xbitmap", ["xbm"] );
        public static const x_xpixmap:ImageMediaType          = new ImageMediaType( 23, "x-xpixmap", ["xpm"] );
        public static const svg:ImageMediaType                = new ImageMediaType( 24, "svg+xml", ["svg", "svgz"] );
        public static const adobe_photoshop:ImageMediaType    = new ImageMediaType( 25, "vnd.adobe.photoshop", ["psd"] );
        
        
        
    }
}