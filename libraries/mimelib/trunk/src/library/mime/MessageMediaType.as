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
    public class MessageMediaType extends MediaType
    {
        private var _value:int;
        private var _subtype:String;
        private var _extensions:Array;
        
        public function MessageMediaType( value:int = 0, subtype:String = "", extensions:Array = null )
        {
            super( "message", 0x400000 );
            
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
        
        public static const CPIM:MessageMediaType                            = new MessageMediaType(  1, "CPIM" );
        public static const delivery_status:MessageMediaType                 = new MessageMediaType(  2, "delivery-status" );
        public static const disposition_notification:MessageMediaType        = new MessageMediaType(  3, "disposition-notification" );
        public static const example:MessageMediaType                         = new MessageMediaType(  4, "example" );
        public static const external_body:MessageMediaType                   = new MessageMediaType(  5, "external-body" );
        public static const feedback_report:MessageMediaType                 = new MessageMediaType(  6, "feedback-report" );
        public static const global:MessageMediaType                          = new MessageMediaType(  7, "global" );
        public static const global_delivery_status:MessageMediaType          = new MessageMediaType(  8, "global-delivery-status" );
        public static const global_disposition_notification:MessageMediaType = new MessageMediaType(  9, "global-disposition-notification" );
        public static const global_headers:MessageMediaType                  = new MessageMediaType( 10, "global-headers" );
        public static const http:MessageMediaType                            = new MessageMediaType( 11, "http" );
        public static const imdn:MessageMediaType                            = new MessageMediaType( 12, "imdn+xml" );
        public static const news:MessageMediaType                            = new MessageMediaType( 13, "news" );
        public static const partial:MessageMediaType                         = new MessageMediaType( 14, "partial" );
        public static const rfc822:MessageMediaType                          = new MessageMediaType( 15, "rfc822", ["mht", "mhtml", "nws"] );
        public static const s_http:MessageMediaType                          = new MessageMediaType( 16, "s-http" );
        public static const sip:MessageMediaType                             = new MessageMediaType( 17, "sip" );
        public static const sipfrag:MessageMediaType                         = new MessageMediaType( 18, "sipfrag" );
        public static const tracking_status:MessageMediaType                 = new MessageMediaType( 19, "tracking-status" );
        public static const si_simp:MessageMediaType                         = new MessageMediaType( 20, "vnd.si.simp" );
        
    }
}