
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

package system
    {
    
    /* Class: Serializer
       The generic Serializer class for the ES4a framework.
    */
    public class Serializer extends Serializers
        {
        import system.serializers.Basic;
        
        private static var __:Namespace            = basic; //default
        private static var _target:Class           = Basic; //default
        private static var _prettyIndent:int       = 0;     //default
        private static var _prettyPrinting:Boolean = false; //default
        private static var _indentor:String        = "    ";//default 4 spaces
        
        public static function get format():SerializationFormat
            {
            switch( __ )
                {
                case eden1:
                return SerializationFormat.eden1;

                case wddx:
                return SerializationFormat.wddx;
                
                case php:
                return SerializationFormat.php;
                
                case json:
                return SerializationFormat.json;
                
                case basic:
                default:
                return SerializationFormat.basic;
                }
            
            }
        
        public static function set format( formatter:SerializationFormat ):void
            {
            /* note:
               you can not have the namespace and the serializer class with
               the same case and/or name.
               
               wrong:
               class eden
               namespace eden
               
               good:
               class eden
               namespace eden1
            */
            import buRRRn.eden.eden;
            import system.serializers.Basic;
            import system.serializers.WDDX;
            import system.serializers.PHP;
            import system.serializers.JSON;
            
            switch( formatter )
                {
                case SerializationFormat.eden1:
                __      = eden1;
                _target = eden;
                break;
                
                case SerializationFormat.wddx:
                __      = wddx;
                _target = WDDX;
                break;
                
                case SerializationFormat.php:
                __      = php;
                _target = PHP;
                break;
                
                case SerializationFormat.json:
                __      = json;
                _target = JSON;
                break;
                
                case SerializationFormat.basic:
                default:
                __      = basic;
                _target = Basic;
                }
            
            }
        
        public static function get prettyIndent():int
            {
            return _target.prettyIndent;
            }
        
        public static function set prettyIndent( value:int ):void
            {
            _target.prettyIndent = value;
            }
        
        public static function get prettyPrinting():Boolean
            {
            return _target.prettyPrinting;
            }
        
        public static function set prettyPrinting( value:Boolean ):void
            {
            _target.prettyPrinting = value;
            }

        public static function get indentor():String
            {
            return _target.indentor;
            }
        
        public static function set indentor( value:String ):void
            {
            _target.indentor = value;
            }
        
        /* Method: serialize
        */
        basic static function serialize( value:* ):String
            {
            import system.serializers.Basic;
            return Basic.serialize( value );
            }
        
        eden1 static function serialize( value:* ):String
            {
            import buRRRn.eden.eden;
            return eden.serialize( value );
            }
        
        wddx static function serialize( value:* ):String
            {
            import system.serializers.WDDX;
            return WDDX.serialize( value );
            }
        
        public static function serialize( value:* ):String
            {
            return __::serialize( value );
            }
        
        /* Method: deserialize
        */
        basic static function deserialize( source:String ):*
            {
            return {}; //stub
            }
        
        eden1 static function deserialize( source:String ):*
            {
            return {}; //stub
            }
        
        public static function deserialize( source:String ):*
            {
            return __::deserialize( source );
            }
        
        format = config.serializer;
        }
    
    }




