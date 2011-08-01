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
    public class ApplicationMediaType extends MediaType
    {
        private var _value:int;
        private var _subtype:String;
        private var _extensions:Array;
        
        public function ApplicationMediaType( value:int = 0, subtype:String = "", extensions:Array = null )
        {
            super( "application", 0x100000 );
            
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
        
        public static const atom:ApplicationMediaType                       = new ApplicationMediaType(  1, "atom+xml", ["atom", "xml"] );
        public static const authPolicy:ApplicationMediaType                 = new ApplicationMediaType(  2, "auth-policy+xml" );
        public static const beep:ApplicationMediaType                       = new ApplicationMediaType(  3, "beep+xml" );
        public static const calendar:ApplicationMediaType                   = new ApplicationMediaType(  4, "calendar+xml" );
        public static const conferenceInfo:ApplicationMediaType             = new ApplicationMediaType(  5, "conference-info+xml" );
        public static const davmount:ApplicationMediaType                   = new ApplicationMediaType(  6, "davmount+xml" );
        public static const dialogInfo:ApplicationMediaType                 = new ApplicationMediaType(  7, "dialog-info+xml" );
        public static const dns:ApplicationMediaType                        = new ApplicationMediaType(  8, "dns" );
        public static const ecmascript:ApplicationMediaType                 = new ApplicationMediaType(  9, "ecmascript", ["es"] );
        public static const example:ApplicationMediaType                    = new ApplicationMediaType( 10, "example" );
        public static const http:ApplicationMediaType                       = new ApplicationMediaType( 11, "http" );
        public static const javascript:ApplicationMediaType                 = new ApplicationMediaType( 12, "javascript", ["js"] );
        public static const json:ApplicationMediaType                       = new ApplicationMediaType( 13, "json", ["json"] );
        public static const microsoft_word:ApplicationMediaType             = new ApplicationMediaType( 14, "msword", ["doc"] );
        public static const octetStream:ApplicationMediaType                = new ApplicationMediaType( 15, "octet-stream" );
        public static const ogg:ApplicationMediaType                        = new ApplicationMediaType( 16, "ogg", ["ogg"] );
        public static const pdf:ApplicationMediaType                        = new ApplicationMediaType( 17, "pdf", ["pdf"] );
        public static const pkcs10:ApplicationMediaType                     = new ApplicationMediaType( 18, "pkcs10" );
        public static const pkcs7_mime:ApplicationMediaType                 = new ApplicationMediaType( 19, "pkcs7-mime" );
        public static const pkcs7_signature:ApplicationMediaType            = new ApplicationMediaType( 20, "pkcs7-signature" );
        public static const pkcs8:ApplicationMediaType                      = new ApplicationMediaType( 21, "pkcs8" );
        public static const postscript:ApplicationMediaType                 = new ApplicationMediaType( 22, "postscript", ["ps", "eps"] );
        public static const rdf:ApplicationMediaType                        = new ApplicationMediaType( 23, "rdf+xml" );
        public static const rtf:ApplicationMediaType                        = new ApplicationMediaType( 24, "rtf" );
        public static const sgml:ApplicationMediaType                       = new ApplicationMediaType( 26, "sgml" );
        public static const smil:ApplicationMediaType                       = new ApplicationMediaType( 27, "smil" );
        public static const smil_xml:ApplicationMediaType                   = new ApplicationMediaType( 28, "smil+xml" );
        public static const vcard:ApplicationMediaType                      = new ApplicationMediaType( 29, "vcard+xml" );
        public static const adobe_fxp:ApplicationMediaType                  = new ApplicationMediaType( 30, "vnd.adobe.fxp", ["fxp", "fxpl"] );
        public static const mozilla_xul:ApplicationMediaType                = new ApplicationMediaType( 31, "vnd.mozilla.xul+xml", ["xul"] );
        public static const microsoft_excel:ApplicationMediaType            = new ApplicationMediaType( 32, "vnd.ms-excel", ["xls"] );
        public static const microsoft_powerpoint:ApplicationMediaType       = new ApplicationMediaType( 33, "vnd.ms-powerpoint", ["ppt"] );
        public static const microsoft_project:ApplicationMediaType          = new ApplicationMediaType( 34, "vnd.ms-project" );
        public static const widget:ApplicationMediaType                     = new ApplicationMediaType( 35, "widget", ["wgt"] );
        public static const xhtml:ApplicationMediaType                      = new ApplicationMediaType( 36, "xhtml+xml", ["xhtml", "xht", "xml", "html", "htm"] );
        public static const xml:ApplicationMediaType                        = new ApplicationMediaType( 37, "xml", ["xml"] );
        public static const xml_dtd:ApplicationMediaType                    = new ApplicationMediaType( 38, "xml-dtd", ["dtd", "mod"] );
        public static const xml_external_parsed_entity:ApplicationMediaType = new ApplicationMediaType( 39, "xml-external-parsed-entity", ["xml", "ent"] );
        public static const zip:ApplicationMediaType                        = new ApplicationMediaType( 40, "zip", ["zip"] );
        public static const x_gzip:ApplicationMediaType                     = new ApplicationMediaType( 41, "x-gzip", ["gz", "tgz"] );
        public static const gzip:ApplicationMediaType                       = new ApplicationMediaType( 42, "gzip", ["gz", "tgz"] );
        public static const AIR:ApplicationMediaType                        = new ApplicationMediaType( 43, "vnd.adobe.air-application-installer-package+zip", ["air"] );
        public static const x_shockwaveflash:ApplicationMediaType           = new ApplicationMediaType( 44, "x-shockwaveflash", ["swf"] );
        public static const photoshop:ApplicationMediaType                  = new ApplicationMediaType( 45, "photoshop", ["psd"] );
        public static const illustrator:ApplicationMediaType                = new ApplicationMediaType( 46, "illustrator", ["ai"] );
        
    }
}