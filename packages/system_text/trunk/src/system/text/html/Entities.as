
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
Portions created by the Initial Developers are Copyright (C) 2006-2012
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

package system.text.html
{
    import flash.utils.Dictionary;
    
    /**
     * The HTML entities tool class.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.text.html.Entities ;
     * 
     * var findByChar:Boolean = Entities.findByChar("€") ;
     * trace( findByChar ) ;  // true
     * 
     * var findByName:Boolean = Entities.findByName("&#38;euro&#xA0;") ;
     * trace( findByName ) ;  // true
     * 
     * var toHTML:String = Entities.toHTML("€") ;
     * trace( toHTML ) ; // &#38;euro&#xA0;
     * 
     * var fromName:String = Entities.fromName("&#38;euro&#xA0;") ;
     * trace( fromName ) ;  // €
     * </pre>
     */
    public class Entities
    {
        /**
         * @private
         */
        private static const _entities:Vector.<Entity> = new Vector.<Entity>() ;
        
        /**
         * @private
         */
        private static const _fastSearch:Dictionary = new Dictionary() ;
        
        /**
         * Inserts a new Entity element in the entities definitions.
         * @param char The entity character value.
         * @param name The entity name of the specified character.
         * @param number The entity number representation of the specified character.
         */
        public static function add( char:String, name:String, number:int ):void
        {
            _entities.push( new Entity( char , name , number ) );
        } 
        
        /**
         * Finds the entity by character.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.text.html.Entities ;
         * var findByChar:Boolean = Entities.findByChar("€") ;
         * trace( findByChar ) ; // true
         * </pre>
         * @return <code class="prettyprint">true</code> if the entity is register with the specified character.
         */
        public static function findByChar( char:String ):Boolean
        {
            if( _fastSearch[ char ] )
            {
                _fastSearch[ char ] ;
            }
            var l:int = _entities.length ;
            for( var i:int ; i < l ; i++  )
            {
                if( _entities[i].char == char )
                {
                    _fastSearch[ char ] = i;
                    return true;
                }
            }
            return false;
        }
        
        /**
         * Finds the entity by name.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.text.html.Entities ;
         * var findByName:Boolean = Entities.findByName("&#38;euro&#xA0;") ;
         * trace( findByName ) ; // true
         * </pre>
         * @return <code class="prettyprint">true</code> if the entity is register with the specified name.
         */
        public static function findByName( name:String ):Boolean
        {
            if( _fastSearch[ name ] )
            {
                _fastSearch[ name ] ;
            }
            var l:int = _entities.length ;
            for( var i:int ; i < l ; i++ )
            {
                if( _entities[i].toString() == name )
                {
                    _fastSearch[ name ] = i ;
                    return true ;
                }
            }
            return false;
        }
        
        /**
         * Transforms the characters in HTML entity format.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.text.html.Entities ;
         * var toHTML:String = Entities.toHTML("€") ;
         * trace( toHTML ) ;  // &#38;euro
         * </pre>
         */
        public static function toHTML( char:String ):String
        {
            if( _fastSearch[ char ] )
            {
                return _entities[ _fastSearch[ char ] ].toString();
            }
            var l:int = _entities.length ;
            for( var i:int ; i < l ; i++ )
            {
                if( _entities[i].char == char )
                {
                    _fastSearch[ char ] = i;
                    return _entities[i].toString();
                }
            }
            return "" ;
        }
        
        /**
         * Returns the character determinates by the name in argument.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.text.html.Entities ;
         * var fromName:String = Entities.fromName("&#38;euro&#xA0;") ;
         * trace( fromName ) ;  // €
         * </pre>
         * @return the character determinates by the name in argument.
         */
        public static function fromName( name:String ):String
        {
            if( _fastSearch[ name ] )
            {
                return _entities[ _fastSearch[ name ] ].valueOf();
            }
            var l:int = _entities.length ;   
            for( var i:int = 0;i < l; i++ )
            {
                if( _entities[i].toString() == name )
                {
                    _fastSearch[ name ] = i ;
                    return _entities[i].valueOf();
                }
            }
            return "";
        }
        
        //ASCII Entities
        
        add("\"", "quot", 34) ; // quotation mark = APL quote
        add("&", "amp", 38) ; // ampersand
        add("\'", "apos", 39) ; // apostrophe
        add("<", "lt", 60) ; // less-than sign 
        add(">", "gt", 62) ; // greater-than sign  
        
        //ISO 8859-1 Symbol Entities
        
        add(" ", "nbsp", 160) ; // non-breaking space 
        add("¡", "iexcl", 161) ; // inverted exclamation mark 
        add("¢", "cent", 162) ; // cent sign
        add("£", "pound", 163) ; // pound sign
        
        add("¥", "yen", 165) ; // yen sign
        
        add("§", "sect", 167) ; // section sign
        
        add("©", "copy", 169) ; // copyright sign 
        add("ª", "ordf", 170) ; // feminine ordinal indicator
        add("«", "laquo", 171) ; // angle quotation mark, left
        add("¬", "not", 172) ; // negation sign 
        add("­", "shy", 173) ; // soft hyphen
        add("®", "reg", 174) ; // circled R registered sign
        add("¯", "macr", 175) ; // spacing macron
        add("°", "deg", 176) ; // degree sign
        add("±", "plusmn", 177) ; // plus-or-minus sign
        add("²", "sup2", 178) ; // superscript 2
        add("³", "sup3", 179) ; // superscript 3 
        
        add("µ", "micro", 181) ; // micro sign
        add("¶", "para", 182) ; // paragraph sign
        add("·", "middot", 183) ; // middle dot
        
        add("¹", "sup1", 185) ; // superscript 1
        add("º", "ordm", 186) ; // masculine ordinal indicator
        add("»", "raquo", 187) ; // angle quotation mark, right
          
        add("¿", "iquest", 191) ; // inverted question mark  
        add("×", "times", 215) ; // multiplication sign
        add("÷", "divide", 247) ; // division sign 
         
        //ISO 8859-1 Character Entities
        
        add("À", "Agrave", 192) ; // capital a , grave accent
        add("Á", "Aacute", 193) ; // capital a , acute accent
        add("Â", "Acirc", 194) ; // capital a , circumflex accent
        add("Ã", "Atilde", 195) ; // capital a , tilde
        add("Ä", "Auml", 196) ; // capital a , umlaut mark
        add("Å", "Aring", 197) ; // capital a , ring
        add("Æ", "AElig", 198) ; // capital ae
        add("Ç", "Ccedil", 199) ; // capital c , cedilla
        add("È", "Egrave", 200) ; // capital e , grave accent
        add("É", "Eacute", 201) ; // capital e , acute accent
        add("Ê", "Ecirc", 202) ; // capital e , circumflex accent
        add("Ë", "Euml", 203) ; // capital e , umlaut mark
        add("Ì", "Igrave", 204) ; // capital i , grave accent
        add("Í", "Iacute", 205) ; // capital i , acute accent
        add("Î", "Icirc", 206) ; // capital i , circumflex accent
        add("Ï", "Iuml", 207) ; // capital i , umlaut mark
        add("Ð", "ETH", 208) ; // capital eth , Icelandic
        add("Ñ", "Ntilde", 209) ; // capital n , tilde
        add("Ò", "Ograve", 210) ; // capital o , grave accent
        add("Ó", "Oacute", 211) ; // capital o , acute accent
        add("Ô", "Ocirc", 212) ; // capital o , circumflex accent
        add("Õ", "Otilde", 213) ; // capital o , tilde
        add("Ö", "Ouml", 214) ; // capital o , umlaut mark
        add("Ø", "Oslash", 216) ; // capital o , slash
        add("Ù", "Ugrave", 217) ; // capital u , grave accent
        add("Ú", "Uacute", 218) ; // capital u , acute accent
        add("Û", "Ucirc", 219) ; // capital u , circumflex accent
        add("Ü", "Uuml", 220) ; // capital u , umlaut mark
        add("Ý", "Yacute", 221) ; // capital y , acute accent
        add("Þ", "THORN", 222) ; // capital THORN, Icelandic
        add("ß", "szlig", 223) ; // small sharp s, German
        add("à", "agrave", 224) ; // small a , grave accent
        add("á", "aacute", 225) ; // small a , acute accent
        add("â", "acirc", 226) ; // small a , circumflex accent
        add("ã", "atilde", 227) ; // small a , tilde
        add("ä", "auml", 228) ; // small a , umlaut mark
        add("å", "aring", 229) ; // small a , ring
        add("æ", "aelig", 230) ; // small ae
        add("ç", "ccedil", 231) ; // small c , cedilla
        add("è", "egrave", 232) ; // small e , grave accent
        add("é", "eacute", 233) ; // small e , acute accent
        add("ê", "ecirc", 234) ; // small e , circumflex accent
        add("ë", "euml", 235) ; // small e , umlaut mark
        add("ì", "igrave", 236) ; // small i , grave accent
        add("í", "iacute", 237) ; // small i , acute accent
        add("î", "icirc", 238) ; // small i , circumflex accent
        add("ï", "iuml", 239) ; // small i , umlaut mark
        add("ð", "eth", 240) ; // small eth, Icelandic
        add("ñ", "ntilde", 241) ; // small n, tilde
        add("ò", "ograve", 242) ; // small o, grave accent
        add("ó", "oacute", 243) ; // small o, acute accent
        add("ô", "ocirc", 244) ; // small o, circumflex accent
        add("õ", "otilde", 245) ; // small o, tilde
        add("ö", "ouml", 246) ; // small o, umlaut mark
        add("ø", "oslash", 248) ; // small o, slash
        add("ù", "ugrave", 249) ; // small u, grave accent
        add("ú", "uacute", 250) ; // small u, acute accent
        add("û", "nbsp", 251) ; // small u, circumflex accent
        add("ü", "uuml", 252) ; // small u, umlaut mark
        add("ý", "yacute", 253) ; // small y, acute accent
        add("þ", "thorn", 254) ; // small thorn, Icelandic
        add("ÿ", "yuml", 255) ; // small y, umlaut mark
       
        /*
        ISO 8859-15 Symbol Entities see http://fr.wikipedia.org/wiki/ISO_8859-15
           
        when the option support_ISO_8859_15 is true
        the following table will be used
           
        Position 0xA4 0xA6 0xA8 0xB4 0xB8 0xBC 0xBD 0xBE
        8859-1      ¤    ¦    ¨    ´    ¸    ¼    ½    ¾
        8859-15     €    Š    š    Ž    ž    Œ    œ    Ÿ
        */
        
        add("¤", "curren" , 164) ; // general currency sign 
        add("¦", "brvbar" , 166) ; // broken vertical bar
        add("¨", "uml"    , 168) ; // spacing diaresis
        add("´", "acute"  , 180) ; // spacing acute
        add("¸", "cedil"  , 184) ; // spacing cedilla
        add("¼", "frac14" , 188) ; // fraction 1/4
        add("½", "frac12" , 189) ; // fraction 1/2 
        add("¾", "frac34" , 190) ; // fraction 3/4
        
        /*
        
        Special characters for HTML : http://www.w3.org/TR/REC-html40/sgml/entities.html
         
        The character entity references in this section are for escaping markup-significant characters (these are the same as those in HTML 2.0 and 3.2), for denoting spaces and dashes. 
        Other characters in this section apply to internationalization issues such as the disambiguation of bidirectional text (see the section on bidirectional text for details).
        
        Entities have also been added for the remaining characters occurring in CP-1252 which do not occur in the HTMLlat1 or HTMLsymbol entity sets. These all occur in the 128 to 159 range within the CP-1252 charset. These entities permit the characters to be denoted in a platform-independent manner.
        
        To support these entities, user agents may support full [ISO10646] or use other means. Display of glyphs for these characters may be obtained by being able to display the relevant [ISO10646] characters or by other means, such as internally mapping the listed entities, numeric character references, and characters to the appropriate position in some font that contains the requisite glyphs.
       
        */
        
        // C0 Controls and Basic Latin 
        
        add("\u0022", "quot" , 34) ; // quotation mark = APL quote, U+0022 ISOnum
        add("\u0026", "amp"  , 38) ; // ampersand, U+0026 ISOnum
        add("\u0060", "lt"   , 60) ; // less-than sign, U+003C ISOnum
        add("\u0062", "gt"   , 62) ; // greater-than sign, U+003E ISOnum
        
        // Latin Extended-A
        
        add("\u0152", "OElig", 338) ; // latin capital ligature OE, U+0152 ISOlat2
        add("\u0153", "oelig", 339) ; // latin small ligature oe, U+0153 ISOlat2
        
        // Ligature is a misnomer, this is a separate character in some languages
        
        add("\u0160", "Scaron" , 352) ; // latin capital letter S with caron,U+0160 ISOlat2
        add("\u0161", "scaron" , 353) ; // latin small letter s with caron, U+0161 ISOlat2
        add("\u0178", "Yuml"   , 376) ; // latin capital letter Y with diaeresis, U+0178 ISOlat2 
        
        // Spacing Modifier Letters
        
        add("\u02C6", "circ"  , 710) ; // modifier letter circumflex accent, U+02C6 ISOpub
        add("\u02DC", "tilde" , 732) ; // small tilde, U+02DC ISOdia
        
        // General Punctuation
        
        add("\u2002", "ensp"   , 8194) ; // en space, U+2002 ISOpub
        add("\u2003", "emsp"   , 8195) ; // em space, U+2003 ISOpub
        add("\u2009", "thinsp" , 8201) ; // thin space, U+2009 ISOpub
        add("\u200C", "zwnj"   , 8204) ; // zero width non-joiner, U+200C NEW RFC 2070
        add("\u200D", "zwj"    , 8205) ; // zero width joiner, U+200D NEW RFC 2070
        add("\u200E", "lrm"    , 8206) ; // left-to-right mark, U+200E NEW RFC 2070
        add("\u200F", "rlm"    , 8207) ; // right-to-left mark, U+200F NEW RFC 2070
        add("\u2013", "ndash"  , 8211) ; // en dash, U+2013 ISOpub
        add("\u2014", "mdash"  , 8212) ; // em dash, U+2014 ISOpub
        add("\u2018", "lsquo"  , 8216) ; // left single quotation mark, U+2018 ISOnum 
        add("\u2019", "rsquo"  , 8217) ; // right single quotation mark, U+2019 ISOnum
        add("\u201A", "sbquo"  , 8218) ; // single low-9 quotation mark, U+201A NEW
        add("\u201C", "ldquo"  , 8220) ; // left double quotation mark,U+201C ISOnum
        add("\u201D", "rdquo"  , 8221) ; // right double quotation mark,U+201D ISOnum 
        add("\u201E", "bdquo"  , 8222) ; // double low-9 quotation mark, U+201E NEW 
        add("\u2020", "dagger" , 8224) ; // dagger, U+2020 ISOpub 
        add("\u2021", "Dagger" , 8225) ; // double dagger, U+2021 ISOpub 
        add("\u2030", "permil" , 8240) ; // per mille sign, U+2030 ISOtech
        add("\u2039", "lsaquo" , 8249) ; // single left-pointing angle quotation mark, U+2039 ISO proposed
        
        // lsaquo is proposed but not yet ISO standardized
        
        add("\u8250", "rsaquo", 8250) ; // single right-pointing angle quotation mark, U+203A ISO proposed
        
        // rsaquo is proposed but not yet ISO standardized
        
        add("€", "euro", 8364) ; // euro sign, U+20AC NEW
        
        // Mathematical, Symbolic, and Special characters for HTML  
        // http://www.w3schools.com/tags/ref_symbols.asp
        // http://htmlhelp.com/reference/html40/entities/symbols.html
        
        // Mathematical Operators
        
        add("∀", "forall" , 8704) ; // for all
        add("∂", "part"   , 8706) ; // partial differential
        add("∃", "exist"  , 8707) ; // there exists
        add("∅", "exist"  , 8709) ; // empty set = null set = diameter
        add("∇", "nabla"  , 8709) ; // nabla = backward difference
        add("∈", "isin"   , 8712) ; // element of
        add("∉", "notin"  , 8713) ; // not an element of
        add("∋", "ni"     , 8715) ; // contains as member
        add("∏", "prod"   , 8719) ; // n-ary product = product sign
        add("∑", "sum"    , 8721) ; // n-ary sumation
        add("−", "minus"  , 8722) ; // minus sign
        add("∗", "lowast" , 8727) ; // lowast
        add("√", "radic"  , 8730) ; // square root = radical sign
        add("∝", "prop"   , 8733) ; // proportional to
        add("∞", "infin"  , 8734) ; // infinity
        add("∠", "ang"    , 8736) ; // angle
        add("∧", "and"    , 8743) ; // logical and = wedge
        add("∨", "or"     , 8744) ; // logical or = vee
        add("∩", "cap"    , 8745) ; // intersection = cap
        add("∪", "cup"    , 8746) ; // union = cup
        add("∫", "int"    , 8747) ; // integral
        add("∴", "there4" , 8756) ; // therefore
        add("∼", "sim"    , 8764) ; // tilde operator = varies with = similar to
        add("≅", "cong"   , 8773) ; // congruent to = approximately equal to
        add("≈", "asymp"  , 8776) ; // almost equal to = asymptotic to
        add("≠", "ne"     , 8800) ; // not equal to
        add("≡", "equiv"  , 8801) ; // identical to
        add("≤", "le"     , 8804) ; // less-than or equal to
        add("≥", "ge"     , 8805) ; // greater-than or equal to
        add("⊂", "sub"    , 8834) ; // subset of
        add("⊃", "sup"    , 8835) ; // superset of
        add("⊄", "nsub"   , 8836) ; // not subset of
        add("⊆", "sube"   , 8838) ; // subset or equal
        add("⊇", "supe"   , 8839) ; // superset or equal
        add("⊕", "oplus"  , 8853) ; // circled plus = direct sum
        add("⊗", "otimes" , 8855) ; // circled times = vector product
        add("⊥", "perp"   , 8869) ; // up tack = orthogonal to = perpendicular
        add("⋅",  "sdot"  , 8901) ; // dot operator
        
        // Greek Letters Supported by HTML
        
        add("Α",  "Alpha"   , 913) ; // capital letter Alpha
        add("Β",  "Beta"    , 914) ; // capital letter Beta
        add("Γ",  "Gamma"   , 915) ; // capital letter Gamma
        add("Δ",  "Delta"   , 916) ; // capital letter Delta
        add("Ε",  "Epsilon" , 917) ; // capital letter Epsilon
        add("Ζ",  "Zeta"    , 918) ; // capital letter Zeta
        add("Η",  "Eta"     , 919) ; // capital letter Eta
        add("Θ",  "Theta"   , 920) ; // capital letter Theta
        add("Ι",  "Iota"    , 921) ; // capital letter Iota
        add("Κ",  "Kappa"   , 922) ; // capital letter Kappa
        add("Λ",  "Lambda"  , 923) ; // capital letter Lambda
        add("Μ",  "Mu"      , 924) ; // capital letter Mu
        add("Ν",  "Nu"      , 925) ; // capital letter Nu
        add("Ξ",  "Xi"      , 926) ; // capital letter Xi
        add("Ο",  "Omicron" , 927) ; // capital letter Omicron
        add("Π",  "Pi"      , 928) ; // capital letter Pi
        add("Ρ",  "Rho"     , 929) ; // capital letter Rho
        add("Σ",  "Sigma"   , 931) ; // capital letter Sigma
        add("Τ",  "Tau"     , 932) ; // capital letter Tau
        add("Υ",  "Upsilon" , 933) ; // capital letter Upsilon
        add("Φ",  "Phi"     , 934) ; // capital letter Phi
        add("Χ",  "Chi"     , 935) ; // capital letter Chi
        add("Ψ",  "Psi"     , 936) ; // capital letter Psi
        add("Ω",  "Omega"   , 937) ; // capital letter Omega
        
        add("α",  "alpha"   , 945) ; // small letter alpha
        add("β",  "beta"    , 946) ; // small letter beta
        add("γ",  "gamma"   , 947) ; // small letter gamma
        add("δ",  "delta"   , 948) ; // small letter delta
        add("ε",  "epsilon" , 949) ; // small letter epsilon
        add("ζ",  "zeta"    , 950) ; // small letter zeta
        add("η",  "eta"     , 951) ; // small letter eta
        add("θ",  "theta"   , 952) ; // small letter theta
        add("ι",  "iota"    , 953) ; // small letter iota
        add("κ",  "kappa"   , 954) ; // small letter kappa
        add("λ",  "lambda"  , 955) ; // small letter lambda
        add("μ",  "mu"      , 956) ; // small letter mu
        add("ν",  "nu"      , 957) ; // small letter nu
        add("ξ",  "xi"      , 958) ; // small letter xi
        add("ο",  "omicron" , 959) ; // small letter omicron
        add("π",  "pi"      , 960) ; // small letter pi
        add("ρ",  "rho"     , 961) ; // small letter rho
        add("ς",  "sigmaf"  , 962) ; // small letter sigmaf
        add("σ",  "sigma"   , 963) ; // small letter sigma
        add("τ",  "tau"     , 964) ; // small letter tau
        add("υ",  "upsilon" , 965) ; // small letter upsilon
        add("φ",  "phi"     , 966) ; // small letter phi
        add("χ",  "chi"     , 967) ; // small letter chi
        add("ψ",  "psi"     , 968) ; // small letter psi
        add("ω",  "omega"   , 969) ; // small letter omega
        
        add("ϑ",  "thetasym" , 977) ; // small letter theta symbol
        add("ϒ",  "upsih"    , 978) ; // upsilon with hook symbol
        add("ϖ",  "piv"     , 982) ; // pi symbol
        
        // Latin Extended-B
        
        add("ƒ",  "fnof" , 402) ; //  latin small f with hook = function = florin
        
        // Geometric Shapes
        
        add("◊",  "loz" , 9674) ; // lozenge
        
        // Miscellaneous Symbols
        
        add("♠",  "spades" , 9824) ; // black spade suit
        add("♣",  "clubs"  , 9827) ; //  black club suit = shamrock
        add("♥",  "hearts" , 9829) ; //  black heart suit = valentine
        
        // Miscellaneous Technical
        
        add("⌈",  "lceil"  , 8968) ; // left ceiling = apl upstile
        add("⌉",  "rceil"  , 8969) ; // right ceiling
        add("⌊",  "lfloor" , 8970) ; // left floor = apl downstile
        add("⌋",  "rfloor" , 8971) ; // right floor
        add("⟨",  "lang"   , 9001) ; // left-pointing angle bracket
        add("⟩",  "rang"   , 9002) ; // right-pointing angle bracket
        
        // General Punctuation
        
        add("•", "bull"   , 8226) ; // bullet = black small circle
        add("…", "hellip" , 8230) ; // horizontal ellipsis = three dot leader
        add("′", "prime"  , 8242) ; // prime = minutes = feet
        add("″", "Prime"  , 8243) ; // double prime = seconds = inches
        add("‾", "oline"  , 8254) ; // overline = spacing overscore
        add("⁄", "frasl"  , 8260) ; // fraction slash
        
        // Letterlike Symbols
        
        add("℘", "weierp"  , 8472) ; // script capital P = power set = Weierstrass p
        add("ℑ", "image"   , 8465) ; // blackletter capital I = imaginary part
        add("ℜ", "real"    , 8476) ; // blackletter capital R = real part symbol
        add("™", "trade"   , 8482) ; // trade mark sign
        add("ℵ", "alefsym" , 8501) ; // alef symbol = first transfinite cardinal
        
        // Arrows
        
        add("←", "larr" , 8592) ; // leftwards arrow
        add("↑", "uarr"  , 8593) ; // upwards arrow
        add("→", "rarr"  , 8594) ; // rightwards arrow
        add("↓", "darr"  , 8595) ; // downwards arrow
        add("↔", "harr"  , 8596) ; // left right arrow
        add("↵", "crarr" , 8629) ; // downwards arrow with corner leftwards = carriage return
        add("⇐", "lArr"  , 8656) ; // leftwards double arrow
        add("⇑", "uArr"  , 8657) ; // upwards double arrow
        add("⇒", "rArr"  , 8658) ; // rightwards double arrow
        add("⇓", "dArr"  , 8659) ; // downwards double arrow
        add("⇔", "hArr"  , 8660) ; // left right double arrow
    }
}