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
    public class TextMediaType extends MediaType
    {
        private var _value:int;
        private var _subtype:String;
        private var _extensions:Array;
        
        public function TextMediaType( value:int = 0, subtype:String = "", extensions:Array = null )
        {
            super( "text", 0x700000 );
            
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
        
        public static const calendar:TextMediaType                   = new TextMediaType(  1, "calendar" );
        public static const css:TextMediaType                        = new TextMediaType(  2, "css", ["css"] );
        public static const csv:TextMediaType                        = new TextMediaType(  3, "csv", ["csv"] );
        public static const dns:TextMediaType                        = new TextMediaType(  4, "dns" );
        public static const ecmascript:TextMediaType                 = new TextMediaType(  5, "ecmascript", ["es"] );
        public static const enriched:TextMediaType                   = new TextMediaType(  6, "enriched" );
        public static const example:TextMediaType                    = new TextMediaType(  7, "example" );
        public static const h323:TextMediaType                       = new TextMediaType(  8, "h323", ["323"] );
        public static const html:TextMediaType                       = new TextMediaType(  9, "html", ["html", "htm", "stm"] );
        public static const javascript:TextMediaType                 = new TextMediaType( 10, "javascript", ["js"] );
        public static const plain:TextMediaType                      = new TextMediaType( 11, "plain", ["txt", "bas", "c", "h", "cpp", "java", "cgi", "ini"] );
        public static const richtext:TextMediaType                   = new TextMediaType( 12, "richtext", ["rtx"] );
        public static const rtf:TextMediaType                        = new TextMediaType( 13, "rtf", ["rtf"] );
        public static const scriptlet:TextMediaType                  = new TextMediaType( 14, "scriptlet", ["sct"] );
        public static const sgml:TextMediaType                       = new TextMediaType( 15, "sgml" );
        public static const tab_separated_values:TextMediaType       = new TextMediaType( 16, "tab-separated-values", ["tsv"] );
        public static const uri_list:TextMediaType                   = new TextMediaType( 17, "uri-list" );
        public static const vcard:TextMediaType                      = new TextMediaType( 18, "vcard", ["vcf"] );
        public static const xml:TextMediaType                        = new TextMediaType( 19, "xml", ["xml", "xsd", "xsl", "xslt"] );
        public static const xml_external_parsed_entity:TextMediaType = new TextMediaType( 20, "xml-external-parsed-entity", ["ent"] );
        public static const x_component:TextMediaType                = new TextMediaType( 21, "x-component", ["htc"] );
        public static const x_setext:TextMediaType                   = new TextMediaType( 22, "x-setext", ["etx"] );
        public static const x_vcard:TextMediaType                    = new TextMediaType( 23, "x-vcard", ["vcf"] );
        public static const x_perl:TextMediaType                     = new TextMediaType( 24, "x-perl", ["pl", "pm"] );
        public static const x_php:TextMediaType                      = new TextMediaType( 25, "x-php", ["php"] );
        public static const x_python:TextMediaType                   = new TextMediaType( 26, "x-python", ["py"] );
        public static const x_as3:TextMediaType                      = new TextMediaType( 27, "x-as3", ["as3"] );
        public static const x_sh:TextMediaType                       = new TextMediaType( 28, "x-sh", ["sh"] );
        public static const x_sql:TextMediaType                      = new TextMediaType( 29, "x-sql", ["sql"] );
        
    }
}