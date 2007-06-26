
/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [ES4a: ECMAScript 4 MaasHaack framework].
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
*/

package system.serializers
    {
    
    public class Basic
        {
        
        private static var _prettyIndent:int       = 0;     //default
        private static var _prettyPrinting:Boolean = false; //default
        private static var _indentor:String        = "    ";//default
        
        public static function get prettyIndent():int
            {
            return _prettyIndent;
            }
        
        public static function set prettyIndent( value:int ):void
            {
            _prettyIndent = value;
            }
        
        public static function get prettyPrinting():Boolean
            {
            return _prettyPrinting;
            }
        
        public static function set prettyPrinting( value:Boolean ):void
            {
            _prettyPrinting = value;
            }
    
        public static function get indentor():String
            {
            return _indentor;
            }
        
        public static function set indentor( value:String ):void
            {
            _indentor = value;
            }
        
        public static function serialize( value:* ):String
            {
            if( value === undefined )
                {
                return "undefined";
                }
            
            if( value === null )
                {
                return "null";
                }
            
            return value.toString();
            }
        
        public static function deserialize( source:String ):*
            {
            return {};
            }
        
        }
    
    }

