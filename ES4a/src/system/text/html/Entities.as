
package system.text.html
    {
    import flash.utils.Dictionary;
        
    
    public class Entities
        {
        
        static private var _e:Array = [];
        static private var _fastSearch:Dictionary = new Dictionary();
        
        public function Entities()
            {
            }
        
        public static function add( entity:Entity ):void
            {
            _e.push( entity );
            } 
        
        public static function findByChar( char:String ):Boolean
            {
            if( _fastSearch[ char ] )
                {
                _fastSearch[ char ]
                }
            
            for( var i:int = 0; i<_e.length; i++ )
                {
                if( _e[i].char == char )
                    {
                    _fastSearch[ char ] = i;
                    return true;
                    }
                }
            
            return false;
            }
        
        public static function findByName( name:String ):Boolean
            {
            if( _fastSearch[ name ] )
                {
                _fastSearch[ name ]
                }
            
            for( var i:int = 0; i<_e.length; i++ )
                {
                if( _e[i].toString() == name )
                    {
                    _fastSearch[ name ] = i;
                    return true;
                    }
                }
            
            return false;
            }
        
        public static function toHTML( char:String ):String
            {
            if( _fastSearch[ char ] )
                {
                return _e[ _fastSearch[ char ] ].toString();
                }
            
            for( var i:int = 0; i<_e.length; i++ )
                {
                if( _e[i].char == char )
                    {
                    return _e[i].toString();
                    }
                }
            
            return "";
            }
        
        public static function fromName( name:String ):String
            {
            if( _fastSearch[ name ] )
                {
                return _e[ _fastSearch[ name ] ].valueOf();
                }
            
            for( var i:int = 0; i<_e.length; i++ )
                {
                if( _e[i].toString() == name )
                    {
                    return _e[i].valueOf();
                    }
                }
            
            return "";
            }
        
        //ASCII Entities
        add( new Entity( "\"", "quot", 34 ) );
        add( new Entity( "\'", "apos", 39 ) );
        add( new Entity(  "&",  "amp", 38 ) );
        add( new Entity(  "<",   "lt", 60 ) );
        add( new Entity(  ">",   "gt", 62 ) );
        
        //ISO 8859-1 Symbol Entities
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  "¡",  "iexcl", 161 ) );
        add( new Entity(  "¢",   "cent", 162 ) );
        add( new Entity(  "£",  "pound", 163 ) );
        add( new Entity(  "¤", "curren", 164 ) );
        add( new Entity(  "¥",    "yen", 165 ) );
        add( new Entity(  "¦", "brvbar", 166 ) );
        add( new Entity(  "§",   "sect", 167 ) );
        add( new Entity(  "¨",    "uml", 168 ) );
        add( new Entity(  "©",   "copy", 169 ) );
        add( new Entity(  "ª",   "ordf", 170 ) );
        add( new Entity(  "«",  "laquo", 171 ) );
        add( new Entity(  "¬",    "not", 172 ) );
        add( new Entity(  "­",    "shy", 173 ) );
        add( new Entity(  "®",    "reg", 174 ) );
        add( new Entity(  "¯",   "macr", 175 ) );
        add( new Entity(  "°",    "deg", 176 ) );
        add( new Entity(  "±", "plusmn", 177 ) );
        add( new Entity(  "²",   "sup2", 178 ) );
        add( new Entity(  "³",   "sup3", 179 ) );
        add( new Entity(  "´",  "acute", 180 ) );
        add( new Entity(  "µ",  "micro", 181 ) );
        add( new Entity(  "¶",   "para", 182 ) );
        add( new Entity(  "·", "middot", 183 ) );
        add( new Entity(  "¸",  "cedil", 184 ) );
        add( new Entity(  "¹",   "sup1", 185 ) );
        add( new Entity(  "º",   "ordm", 186 ) );
        add( new Entity(  "»",  "raquo", 187 ) );
        add( new Entity(  "¼", "frac14", 188 ) );
        add( new Entity(  "½", "frac12", 189 ) );
        add( new Entity(  "¾", "frac34", 190 ) );
        add( new Entity(  "¿", "iquest", 191 ) );
        add( new Entity(  "×",  "times", 215 ) );
        add( new Entity(  "÷", "divide", 247 ) );
        
        //ISO 8859-1 Character Entities
        /*
À   capital a, grave accent     &Agrave;    &#192;
Á   capital a, acute accent     &Aacute;    &#193;
Â   capital a, circumflex accent    &Acirc;     &#194;
Ã   capital a, tilde    &Atilde;    &#195;
Ä   capital a, umlaut mark  &Auml;  &#196;
Å   capital a, ring     &Aring;     &#197;
Æ   capital ae  &AElig;     &#198; 
        */
        add( new Entity(  "À", "Agrave", 192 ) );
        add( new Entity(  "Á", "Aacute", 193 ) );
        add( new Entity(  "Â",  "Acirc", 194 ) );
        add( new Entity(  "Ã", "Atilde", 195 ) );
        add( new Entity(  "Ä",   "Auml", 196 ) );
        add( new Entity(  "Å",  "Aring", 197 ) );
        add( new Entity(  "Æ",  "AElig", 198 ) );
        /*
Ç   capital c, cedilla      &Ccedil;    &#199;
È   capital e, grave accent     &Egrave;    &#200;
É   capital e, acute accent     &Eacute;    &#201;
Ê   capital e, circumflex accent    &Ecirc;     &#202;
Ë   capital e, umlaut mark  &Euml;  &#203;
Ì   capital i, grave accent     &Igrave;    &#204;
Í   capital i, acute accent     &Iacute;    &#205;
Î   capital i, circumflex accent    &Icirc;     &#206;
Ï   capital i, umlaut mark  &Iuml;  &#207;
        */
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        /*
Ð   capital eth, Icelandic      &ETH;   &#208;
Ñ   capital n, tilde    &Ntilde;    &#209;
Ò   capital o, grave accent     &Ograve;    &#210;
Ó   capital o, acute accent     &Oacute;    &#211;
Ô   capital o, circumflex accent    &Ocirc;     &#212;
Õ   capital o, tilde    &Otilde;    &#213;
Ö   capital o, umlaut mark  &Ouml;  &#214;
Ø   capital o, slash    &Oslash;    &#216;
        */
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        /*
Ù   capital u, grave accent     &Ugrave;    &#217;
Ú   capital u, acute accent     &Uacute;    &#218;
Û   capital u, circumflex accent    &Ucirc;     &#219;
Ü   capital u, umlaut mark  &Uuml;  &#220;
Ý   capital y, acute accent     &Yacute;    &#221;
Þ   capital THORN, Icelandic    &THORN;     &#222;
ß   small sharp s, German   &szlig;     &#223;
        */
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        /*
à   small a, grave accent   &agrave;    &#224;
á   small a, acute accent   &aacute;    &#225;
â   small a, circumflex accent  &acirc;     &#226;
ã   small a, tilde  &atilde;    &#227;
ä   small a, umlaut mark    &auml;  &#228;
å   small a, ring   &aring;     &#229;
æ   small ae    &aelig;     &#230;
ç   small c, cedilla    &ccedil;    &#231;
        */
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        /*
è   small e, grave accent   &egrave;    &#232;
é   small e, acute accent   &eacute;    &#233;
ê   small e, circumflex accent  &ecirc;     &#234;
ë   small e, umlaut mark    &euml;  &#235;
ì   small i, grave accent   &igrave;    &#236;
í   small i, acute accent   &iacute;    &#237;
î   small i, circumflex accent  &icirc;     &#238;
ï   small i, umlaut mark    &iuml;  &#239;
        */
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        /*
ð   small eth, Icelandic    &eth;   &#240;
ñ   small n, tilde  &ntilde;    &#241;
ò   small o, grave accent   &ograve;    &#242;
ó   small o, acute accent   &oacute;    &#243;
ô   small o, circumflex accent  &ocirc;     &#244;
õ   small o, tilde  &otilde;    &#245;
ö   small o, umlaut mark    &ouml;  &#246;
ø   small o, slash  &oslash;    &#248;
        */
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        /*
ù   small u, grave accent   &ugrave;    &#249;
ú   small u, acute accent   &uacute;    &#250;
û   small u, circumflex accent  &ucirc;     &#251;
ü   small u, umlaut mark    &uuml;  &#252;
ý   small y, acute accent   &yacute;    &#253;
þ   small thorn, Icelandic  &thorn;     &#254;
ÿ   small y, umlaut mark    &yuml;  &#255;
        */
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
        add( new Entity(  " ",   "nbsp", 160 ) );
      //add( new Entity(  " ",   "nbsp", 160 ) );
        
        
        }
    }

