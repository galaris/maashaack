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
  Portions created by the Initial Developer are Copyright (C) 2004-2006
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  
  	- Alcaraz Marc (aka eKameleon) <vegas@ekameleon.net> (2007-2008)

*/	
package system.text.html
    {
    import flash.utils.Dictionary;
    
    /**
     * The HTML entities tool class.
     */
    public class Entities
        {
        
        /**
         * @private
         */
        private static var _e:Array = [];

        /**
         * @private
         */
        private static var _fastSearch:Dictionary = new Dictionary() ;
        
        public static var support_ISO_8859_15:Boolean = false;
        
        /**
         * Inserts a new Entity element in the entities definitions.
         */
        public static function add( entity:Entity ):void
            {
            _e.push( entity );
            } 
        
        /**
         * Finds the entity by character.
         * @return <code class="prettyprint">true</code> if the entity is register with the specified character.
         */
        public static function findByChar( char:String ):Boolean
            {
            if( _fastSearch[ char ] )
                {
                _fastSearch[ char ] ;
                }
            var l:uint = _e.length ;
            for( var i:uint = 0 ; i<l ; i++  )
                {
                if( _e[i].char == char )
                    {
                    _fastSearch[ char ] = i;
                    return true;
                    }
                }
            
            return false;
            }

        /**
         * Finds the entity by name.
         * @return <code class="prettyprint">true</code> if the entity is register with the specified name.
         */
        public static function findByName( name:String ):Boolean
            {
            if( _fastSearch[ name ] )
                {
                _fastSearch[ name ] ;
                }
            
            var l:uint = _e.length ;
            for( var i:uint = 0 ; i < l ; i++ )
                {
                if( _e[i].toString() == name )
                    {
                    _fastSearch[ name ] = i ;
                    return true ;
                    }
                }
            
            return false;
            }
        
        /**
         * Transforms the characters in HTML entity format.
         */
        public static function toHTML( char:String ):String
            {
            if( _fastSearch[ char ] )
                {
                return _e[ _fastSearch[ char ] ].toString();
                }
            
            var l:uint = _e.length ;            
            for( var i:uint = 0 ; i < l ; i++ )
                {
                if( _e[i].char == char )
                    {
                    return _e[i].toString();
                    }
                }
            
            return "";
            }
        
        /**
         * Returns the character determinates by the name in argument.
         * @return the character determinates by the name in argument.
         */        
        public static function fromName( name:String ):String
            {
            if( _fastSearch[ name ] )
                {
                return _e[ _fastSearch[ name ] ].valueOf();
                }
            var l:uint = _e.length ;   
            for( var i:uint = 0; i < l ; i++ )
                {
                if( _e[i].toString() == name )
                    {
                    return _e[i].valueOf();
                    }
                }
            
            return "";
            }
        
        //ASCII Entities
        add( new Entity( "\"" , "quot" , 34 ) ) ; // quotation mark 
        add( new Entity(  "&" , "amp"  , 38 ) ) ; // ampersand
        add( new Entity( "\'" , "apos" , 39 ) ) ; // apostrophe
        add( new Entity(  "<" , "lt"   , 60 ) ) ; // less-than sign 
        add( new Entity(  ">" , "gt"   , 62 ) ) ; // greater-than sign  
        
        //ISO 8859-1 Symbol Entities
        add( new Entity(  " " ,   "nbsp" , 160 ) ) ; // non-breaking space 
        add( new Entity(  "¡" ,  "iexcl" , 161 ) ) ; // inverted exclamation mark 
        add( new Entity(  "¢" ,   "cent" , 162 ) ) ; // cent sign
        add( new Entity(  "£" ,  "pound" , 163 ) ) ; // pound sign
        
        add( new Entity(  "¥" ,    "yen" , 165 ) ) ; // yen sign
        
        add( new Entity(  "§" ,   "sect" , 167 ) ) ; // section sign
        
        add( new Entity(  "©" ,   "copy" , 169 ) ) ; // copyright sign 
        add( new Entity(  "ª" ,   "ordf" , 170 ) ) ; // feminine ordinal indicator
        add( new Entity(  "«" ,  "laquo" , 171 ) ) ; // angle quotation mark, left
        add( new Entity(  "¬" ,    "not" , 172 ) ) ; // negation sign 
        add( new Entity(  "­" ,    "shy" , 173 ) ) ; // soft hyphen
        add( new Entity(  "®" ,    "reg" , 174 ) ) ; // circled R registered sign
        add( new Entity(  "¯" ,   "macr" , 175 ) ) ; // spacing macron
        add( new Entity(  "°" ,    "deg" , 176 ) ) ; // degree sign
        add( new Entity(  "±" , "plusmn" , 177 ) ) ; // plus-or-minus sign
        add( new Entity(  "²" ,   "sup2" , 178 ) ) ; // superscript 2
        add( new Entity(  "³" ,   "sup3" , 179 ) ) ; // superscript 3 
        
        add( new Entity(  "µ" ,  "micro" , 181 ) ) ; // micro sign
        add( new Entity(  "¶" ,   "para" , 182 ) ) ; // paragraph sign
        add( new Entity(  "·" , "middot" , 183 ) ) ; // middle dot
        
        add( new Entity(  "¹" ,   "sup1" , 185 ) ) ; // superscript 1
        add( new Entity(  "º" ,   "ordm" , 186 ) ) ; // masculine ordinal indicator
        add( new Entity(  "»" ,  "raquo" , 187 ) ) ; // angle quotation mark, right
          
        add( new Entity(  "¿" , "iquest" , 191 ) ) ; // inverted question mark  
        add( new Entity(  "×" , "times"  , 215 ) ) ; // multiplication sign
        add( new Entity(  "÷" , "divide" , 247 ) ) ; // division sign 
         
        //ISO 8859-1 Character Entities
        add( new Entity(  "À" , "Agrave" , 192 ) ) ; // capital a , grave accent
        add( new Entity(  "Á" , "Aacute" , 193 ) ) ; // capital a , acute accent
        add( new Entity(  "Â" , "Acirc"  , 194 ) ) ; // capital a , circumflex accent
        add( new Entity(  "Ã" , "Atilde" , 195 ) ) ; // capital a , tilde
        add( new Entity(  "Ä" , "Auml"   , 196 ) ) ; // capital a , umlaut mark
        add( new Entity(  "Å" , "Aring"  , 197 ) ) ; // capital a , ring
        add( new Entity(  "Æ" , "AElig"  , 198 ) ) ; // capital ae
        add( new Entity(  "Ç" , "Ccedil" , 199 ) ) ; // capital c , cedilla
        add( new Entity(  "È" , "Egrave" , 200 ) ) ; // capital e , grave accent
        add( new Entity(  "É" , "Eacute" , 201 ) ) ; // capital e , acute accent
        add( new Entity(  "Ê" , "Ecirc"  , 202 ) ) ; // capital e , circumflex accent
        add( new Entity(  "Ë" , "Euml"   , 203 ) ) ; // capital e , umlaut mark
        add( new Entity(  "Ì" , "Igrave" , 204 ) ) ; // capital i , grave accent
        add( new Entity(  "Í" , "Iacute" , 205 ) ) ; // capital i , acute accent
        add( new Entity(  "Î" , "Icirc"  , 206 ) ) ; // capital i , circumflex accent
        add( new Entity(  "Ï" , "Iuml"   , 207 ) ) ; // capital i , umlaut mark
        add( new Entity(  "Ð" , "ETH"    , 208 ) ) ; // capital eth , Icelandic
        add( new Entity(  "Ñ" , "Ntilde" , 209 ) ) ; // capital n , tilde
        add( new Entity(  "Ò" , "Ograve" , 210 ) ) ; // capital o , grave accent
        add( new Entity(  "Ó" , "Oacute" , 211 ) ) ; // capital o , acute accent
        add( new Entity(  "Ô" , "Ocirc"  , 212 ) ) ; // capital o , circumflex accent
        add( new Entity(  "Õ" , "Otilde" , 213 ) ) ; // capital o , tilde
        add( new Entity(  "Ö" , "Ouml"   , 214 ) ) ; // capital o , umlaut mark
        add( new Entity(  "Ø" , "Oslash" , 216 ) ) ; // capital o , slash
        add( new Entity(  "Ù" , "Ugrave" , 217 ) ) ; // capital u , grave accent
        add( new Entity(  "Ú" , "Uacute" , 218 ) ) ; // capital u , acute accent
        add( new Entity(  "Û" , "Ucirc"  , 219 ) ) ; // capital u , circumflex accent
        add( new Entity(  "Ü" , "Uuml"   , 220 ) ) ; // capital u , umlaut mark
        add( new Entity(  "Ý" , "Yacute" , 221 ) ) ; // capital y , acute accent
        add( new Entity(  "Þ" , "THORN"  , 222 ) ) ; // capital THORN, Icelandic
        add( new Entity(  "ß" , "szlig"  , 223 ) ) ; // small sharp s, German
        add( new Entity(  "à" , "agrave" , 224 ) ) ; // small a , grave accent
        add( new Entity(  "á" , "aacute" , 225 ) ) ; // small a , acute accent
        add( new Entity(  "â" ,  "acirc" , 226 ) ) ; // small a , circumflex accent
        add( new Entity(  "ã" , "atilde" , 227 ) ) ; // small a , tilde
        add( new Entity(  "ä" ,   "auml" , 228 ) ) ; // small a , umlaut mark
        add( new Entity(  "å" ,  "aring" , 229 ) ) ; // small a , ring
        add( new Entity(  "æ" ,  "aelig" , 230 ) ) ; // small ae
        add( new Entity(  "ç" , "ccedil" , 231 ) ) ; // small c , cedilla
        add( new Entity(  "è" , "egrave" , 232 ) ) ; // small e , grave accent
        add( new Entity(  "é" , "eacute" , 233 ) ) ; // small e , acute accent
        add( new Entity(  "ê" ,  "ecirc" , 234 ) ) ; // small e , circumflex accent
        add( new Entity(  "ë" ,   "euml" , 235 ) ) ; // small e , umlaut mark
        add( new Entity(  "ì" , "igrave" , 236 ) ) ; // small i , grave accent
        add( new Entity(  "í" , "iacute" , 237 ) ) ; // small i , acute accent
        add( new Entity(  "î" ,  "icirc" , 238 ) ) ; // small i , circumflex accent
        add( new Entity(  "ï" ,   "iuml" , 239 ) ) ; // small i , umlaut mark
        add( new Entity(  "ð" ,    "eth" , 240 ) ) ; // small eth, Icelandic
        add( new Entity(  "ñ" , "ntilde" , 241 ) ) ; // small n, tilde
        add( new Entity(  "ò" , "ograve" , 242 ) ) ; // small o, grave accent
        add( new Entity(  "ó" , "oacute" , 243 ) ) ; // small o, acute accent
        add( new Entity(  "ô" ,  "ocirc" , 244 ) ) ; // small o, circumflex accent
        add( new Entity(  "õ" , "otilde" , 245 ) ) ; // small o, tilde
        add( new Entity(  "ö" ,   "ouml" , 246 ) ) ; // small o, umlaut mark
        add( new Entity(  "ø" , "oslash" , 248 ) ) ; // small o, slash
        add( new Entity(  "ù" , "ugrave" , 249 ) ) ; // small u, grave accent
        add( new Entity(  "ú" , "uacute" , 250 ) ) ; // small u, acute accent
        add( new Entity(  "û" ,   "nbsp" , 251 ) ) ; // small u, circumflex accent
        add( new Entity(  "ü" ,   "uuml" , 252 ) ) ; // small u, umlaut mark
        add( new Entity(  "ý" , "yacute" , 253 ) ) ; // small y, acute accent
        add( new Entity(  "þ" ,  "thorn" , 254 ) ) ; // small thorn, Icelandic
        add( new Entity(  "ÿ" ,   "yuml" , 255 ) ) ; // small y, umlaut mark
        
        // FIXME add( new Entity(  "€" ,   "euro" , 8364 ) ) ; // euro sign ???
        
        /* ISO 8859-15 Symbol Entities
           see http://fr.wikipedia.org/wiki/ISO_8859-15
           
           when the option support_ISO_8859_15 is true
           the following table will be used
           
           Position 0xA4 0xA6 0xA8 0xB4 0xB8 0xBC 0xBD 0xBE
           8859-1      ¤    ¦    ¨    ´    ¸    ¼    ½    ¾
           8859-15     €    Š    š    Ž    ž    Œ    œ    Ÿ
        */
        if( Entities.support_ISO_8859_15 )
            {
            /* TODO:
               either we can switch
               but in theory we could use both 8859-1 and 8859-15
               as we have only findByChar and findByName methods
               
               need to be unit tested to be 100% sure
            */
            }
        else
            {
            add( new Entity(  "¤" , "curren" , 164 ) ) ; // currency sign
            add( new Entity(  "¦" , "brvbar" , 166 ) ) ; // broken vertical bar
            add( new Entity(  "¨" ,    "uml" , 168 ) ) ; // spacing diaresis
            add( new Entity(  "´" ,  "acute" , 180 ) ) ; // spacing acute
            add( new Entity(  "¸" ,  "cedil" , 184 ) ) ; // spacing cedilla
            add( new Entity(  "¼" , "frac14" , 188 ) ) ; // fraction 1/4
            add( new Entity(  "½" , "frac12" , 189 ) ) ; // fraction 1/2 
            add( new Entity(  "¾" , "frac34" , 190 ) ) ; // fraction 3/4
            }
        
        }

    }