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
    public class VideoMediaType extends MediaType
    {
        private var _value:int;
        private var _subtype:String;
        private var _extensions:Array;
        
        public function VideoMediaType( value:int = 0, subtype:String = "", extensions:Array = null )
        {
            super( "video", 0x800000 );
            
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
        
        public static const vid3gpp:VideoMediaType     = new VideoMediaType(  1, "3gpp" );
        public static const vid3gpp2:VideoMediaType    = new VideoMediaType(  2, "3gpp2" );
        public static const DV:VideoMediaType          = new VideoMediaType(  3, "DV" );
        public static const example:VideoMediaType     = new VideoMediaType(  4, "example" );
        public static const H264:VideoMediaType        = new VideoMediaType(  5, "H264" );
        public static const JPEG:VideoMediaType        = new VideoMediaType(  6, "JPEG" );
        public static const mp4:VideoMediaType         = new VideoMediaType(  7, "mp4", ["f4v", "f4p"] );
        public static const mpeg:VideoMediaType        = new VideoMediaType(  8, "mpeg", ["mpeg", "mpg", "mpe", "mp2", "mpa", "mpv2"] );
        public static const ogg:VideoMediaType         = new VideoMediaType(  9, "ogg", ["ogg"] );
        public static const quicktime:VideoMediaType   = new VideoMediaType( 10, "quicktime", ["qt", "mov"] );
        public static const raw:VideoMediaType         = new VideoMediaType( 11, "raw" );
        public static const x_ms_asf:VideoMediaType    = new VideoMediaType( 12, "x-ms-asf", ["asf", "asr", "asx"] );
        public static const x_msvideo:VideoMediaType   = new VideoMediaType( 13, "x-msvideo", ["avi"] );
        public static const x_sgi_movie:VideoMediaType = new VideoMediaType( 14, "x-sgi-movie", ["movie"] );
        public static const x_flv:VideoMediaType       = new VideoMediaType( 15, "x-flv", ["flv" ] );
    }
}