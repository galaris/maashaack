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
    public class AudioMediaType extends MediaType
    {
        private var _value:int;
        private var _subtype:String;
        private var _extensions:Array;
        
        public function AudioMediaType( value:int = 0, subtype:String = "", extensions:Array = null )
        {
            super( "audio", 0x200000 );
            
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
        
        public static const basic:AudioMediaType          = new AudioMediaType(  1, "basic", ["au","snd"] );
        public static const mid:AudioMediaType            = new AudioMediaType(  2, "mid", ["mid", "rmi"] );
        public static const mpeg:AudioMediaType           = new AudioMediaType(  3, "mpeg", ["mp3"] );
        public static const example:AudioMediaType        = new AudioMediaType(  4, "example" );
        public static const x_aiff:AudioMediaType         = new AudioMediaType(  5, "x-aiff", ["aif", "aifc", "aiff"] );
        public static const x_mpegurl:AudioMediaType      = new AudioMediaType(  6, "x-mpegurl", ["m3u"] );
        public static const x_pn_realaudio:AudioMediaType = new AudioMediaType(  7, "x-pn-realaudio", ["ra","ram"] );
        public static const x_wav:AudioMediaType          = new AudioMediaType(  8, "x-wav", ["wav"] );
        public static const wav:AudioMediaType            = new AudioMediaType(  9, "wav", ["wav"] );
        public static const mp4:AudioMediaType            = new AudioMediaType( 10, "mp4", ["f4a", "f4b"] );
        
    }
}