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

package core.strings 
{
    /**
     * A wild expression is constructed like a regular expression but is based on a globbing algorithm like the one you found for searching files on a hard-drive.
     * <p><b>Syntax :</b></p>
     * <ul>
     * <li>1. ? : match any unique char - exactly 1 char must be found</li>
     * <li>2. * : match any number of chars - at least 0 or more any chars can be found</li>
     * <li>3. ! : ignore next char</li>
     * </ul>
     * <p><b>Rules :</b></p>
     * <ul>
     * <li>1. "*" is equal to "**" to "***" to an infinity number of "*" chars</li>
     * <li>2. "*?" is concatened to "*" (more precisely "*?*")</li>
     * <li>3. "*" if for zero char to infinity chars</li>
     * <li>4. "!*" ignore the pattern and look for the char "*" in string</li>
     * <li>5. "!?" ignore the pattern and look for the char "?" in string</li>
     * </ul>
     * <p><b>Tips and tricks :</b></p>
     * <p><b>1. find all the words in a string</b></p>
     * <pre class="prettyprint"> 
     * import core.strings.WildExp ;
     * var we:WildExp   = new WildExp( "*", WildExp.IGNORECASE | WildExp.MULTIWORD );
     * var result:Array = we.test( "any phrases with words inside" );
     * //result = [ "any", "phrases", "with", "words", "inside" ];
     * </pre>
     * <p><b>2. find comments in a string</b></p>
     * <pre class="prettyprint"> 
     * import core.strings.WildExp ;
     * var we:WildExp   = new WildExp( "*\/!**!*!/\*", WildExp.IGNORECASE | WildExp.MULTIWORD );
     * var result:Array = we.test( "toto = \"123\"; /\*hello world*\/" );
     * //result = [ "toto = \"123\"; ", "hello world" ] ;
     * </pre>
     * <p><b>3. find the name, arguments and body of a function</b></p>
     * <pre class="prettyprint"> 
     * import core.strings.WildExp ;
     * var we:WildExp = new WildExp( "function *(*)*{*}", WildExp.IGNORECASE | WildExp.MULTIWORD );
     * result = we.test( "function toto( a, b, c )\r\n{\treturn \"hello world\";\r\n\t}" );
     * //result = [ "toto", " a, b, c ", "\r\n", "\treturn \"hello world\";\r\n\t" ];
     * </pre>
     */
    public class WildExp 
    {
        /**
         * Creates a new WildExp instance.
         * 
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import core.strings.WildExp ;
         * 
         * var wild:WildExp ;
         * 
         * wild = new WildExp("foo.*" , WildExp.IGNORECASE ) ;
         * 
         * trace( wild.test("foo") ) ; // false
         * trace( wild.test("foo.") ) ; // true
         * trace( wild.test("foo.bar") ) ; // true
         * trace( wild.test("bar.foo.bar") ) ; // false
         * trace( wild.test("FOO.bar") ) ; // false
         * </pre>
         * 
         * @param pattern The pattern of the evaluator.
         * @param flag The option flag value.
         */
        public function WildExp ( pattern:String, options:uint = 0 ) 
        {
            wildcards     = [] ;
            questionMarks = [] ;
            
            _caseSensitive      = true  ;
            _multiline          = false ;
            _multiword          = false ;
            _wildcardFound      = false ;
            _questionMarksFound = false ;
            
            switch( options ) 
            {
                case IGNORECASE :
                {
                    _caseSensitive = false ;
                    break ;
                }
                case MULTILINE :
                {
                    _multiline = true ;
                    break ;
                }
                case IGNORECASE | MULTILINE :
                {
                    _caseSensitive = false ;
                    _multiline     = true ;
                    break ;
                }
                case MULTIWORD :
                {
                    _multiword = true ;
                    break ;
                }
                case IGNORECASE | MULTIWORD :
                {
                    _caseSensitive = false ;
                    _multiword     = true  ;
                    break ;
                }
                case MULTILINE | MULTIWORD :
                {
                    _multiline = true ;
                    _multiword = true ;
                    break ;
                }
                case IGNORECASE | MULTILINE | MULTIWORD : 
                {
                    _caseSensitive = false ;
                    _multiline     = true ;
                    _multiword     = true ;
                    break ;
                }
                case NONE : 
                default :
                {
                    //
                }
            }
            if( _caseSensitive ) 
            {
                pattern = pattern.toLowerCase();
            }
            source = pattern ;
        }
        
        /**
         * const the NONE value (0).
         */ 
        public static const NONE:uint = 0 ;
        
        /**
         * const the IGNORECASE value (1).
         */ 
        public static const IGNORECASE:uint = 1 ;
        
        /**
         * const the MULTILINE value (2).
         */ 
        public static const MULTILINE:uint = 2 ;
        
        /**
         * const the MULTIWORD value (4).
         */ 
        public static const MULTIWORD:uint = 4 ;
        
        /**
         * The array of all question marks.
         */
        public var questionMarks:Array ;
        
        /**
         * The source of this wildcard.
         */
        public var source:String ;
         
        /**
         * The array of all wildcards.
         */
        public var wildcards:Array ;
        
        /**
         * Adds a caracter in the questionMarks array, only if the array isn't empty.
         */
        public function addToQuestionMarks( chr:String ):void 
        {
            var l:int = questionMarks.length ;
            if( l == 0 ) 
            {
                return ;
            }
            questionMarks[ l - 1 ] += chr ;
        }
        
        /**
         * Adds a caracter in the wildcards array, only if the array isn't empty.
         */
        public function addToWildcards( chr:String ):void 
        {
            var l:int = wildcards.length ;
            if( l == 0 )
            {
                return ;
            }
            wildcards[ l - 1 ] += chr ;
        }
        
        /**
         * Test the specific expression in argument.
         */
        public function test( str:String ):*
        {
            var segment:Array ;
            var result:* ;
            
            var i:int ;
            var l:int ;
            
            var ORC:String  = "\uFFFC";
            var CRLF:String = "\r\n";
            
            if( _caseSensitive ) 
            {
                str = str.toLowerCase();
            }
            
            if( _multiline ) 
            {
                if( str.indexOf( CRLF ) > -1 ) 
                {
                    str = replace(str, CRLF, ORC ) ;
                }
                l = lineTerminatorChars.length ;
                for( i = 0 ; i < l ; i++ ) 
                {
                    if( str.indexOf( lineTerminatorChars[i] ) > -1 ) 
                    {
                        str = replace(str, lineTerminatorChars[i], ORC ) ;
                    }
                }
            }
            if( _multiword ) 
            {
                l = whiteSpaceChars.length ;
                for( i = 0 ; i < l ; i++ ) 
                {
                    if( str.indexOf( whiteSpaceChars[i] ) > -1 ) 
                    {
                        str = replace(str, whiteSpaceChars[i], ORC ) ;
                    }
                }
            }
            
            //trace(">>>>> " + str ) ;
            
            if( str.indexOf( ORC ) > -1 ) 
            {
                segment = str.split( ORC ) ;
                result  = [] ;
                l       = segment.length ;
                for( i = 0 ; i < l ; i++ ) 
                {
                    if( _testMatch( segment[i], source ) ) 
                    {
                        result.push( segment[i] ) ;
                    }
                }
                return ( result.length > 0 ) ? result : false ;
            }
            return _testMatch( str, source ) ;
        }
        
        /**
         * Returns the string representation of this object.
         * @return the string representation of this object.
         */ 
        public function toString():String 
        {
            return source ;
        }
        
        /**
         * @private
         */
        private var _caseSensitive:Boolean ;
        
        /**
         * @private
         */
        private var _multiline:Boolean ;
        
        /**
         * @private
         */
        private var _multiword:Boolean ;
        
        /**
         * @private
         */
        private var _wildcardFound:Boolean ;
        
        /**
         * @private
         */
        private var _questionMarksFound:Boolean ;
        
        private function _testMatch(str:String, pattern:String, ignoreChar:String = null ):Boolean 
        {
            var c:String , c1:String , pat:String , pat1:String ;
            
            c    = str.charAt( 0 ) ;
            c1   = str.charAt( 1 ) ;
            
            pat  = pattern.charAt( 0 ) ;
            pat1 = pattern.charAt( 1 ) ;
            
            if( pat != "?" ) 
            {
                _questionMarksFound = false ;
            }
            if( pat == "!" ) 
            {
                return _testMatch( str, pattern.substr( 1 ), pat1 );
            }
            if( pat == "?" && ( ignoreChar != "?" ) ) 
            {
                if( c != "" ) 
                {
                    if( _questionMarksFound )
                    {
                        addToQuestionMarks( c );
                    }
                    else 
                    {
                        questionMarks.push( c ) ;
                    }
                    _questionMarksFound = true ;
                    if ( (pat1 == "") && _wildcardFound ) 
                    {
                        pattern += "*" ;
                    }
                    return _testMatch( str.substr( 1 ), pattern.substr( 1 ) ) ;
                } 
                else 
                {
                    return false ;
                }
            }
            if( ( pat == "*" ) && ( ignoreChar != "*" ) ) 
            {
                _wildcardFound = true ;
                if( pat1 != "*" ) 
                {
                    wildcards.push( "" );
                }
                if( pat1 == "" ) 
                {
                    addToWildcards( str ) ;
                    return true ;
                }
                if( pattern.substr(1).indexOf( "*" ) > -1 ) 
                {
                    while( str != "" ) 
                    {
                        if( pat1 == "*" ) 
                        {
                            break ;
                        }
                        if( pat1 == "?" ) 
                        {
                            pattern = pattern.substr(1) ;
                            break ;
                        }
                        if( str == "" ) 
                        {
                            return false ;
                        }
                        if( str.charAt(0) == pat1 ) 
                        {
                            break ;
                        }
                        if( pat1 == "!" ) 
                        {
                            ignoreChar = pattern.charAt( 2 ) ;
                            pattern    = pattern.substr( 2 ) ;
                            pat1       = pattern.charAt( 1 ) ;
                        }
                        if( str.charAt(0) == ignoreChar ) 
                        {
                            str = str.substr(1) ; 
                            continue ;
                        }
                        addToWildcards( str.charAt( 0 ) ) ;
                        str = str.substr(1) ;
                    }
                    return _testMatch( str, pattern.substr( 1 ), ignoreChar ) ;
                } 
                else 
                {
                    var found:int = str.lastIndexOf( pat1 ) ;
                    if( found != -1 ) 
                    {
                        addToWildcards( str.substring( 0, found ) ) ;
                        return _testMatch( str.substr( found ), pattern.substr( 1 ) ) ;
                    }
                    else if( pat1 == "?" ) 
                    {
                        if( pattern.charAt(2) == "" )
                        {
                            return str.length >= 1 ;
                        }
                        else
                        {
                            return _testMatch( str.substr( 1 ), pattern.substr( 1 ) ) ;
                        }
                    }
                    return false;
                }
            }
            if( pat == "" ) 
            {
                return( c == "" ) ;
            }
            if( c != pat ) 
            {
                return false ;
            }
            if( c != "" ) 
            {
                return _testMatch( str.substr( 1 ), pattern.substr( 1 ) ) ;
            }
            else 
            {
                return false ;
            }
        }
        
        /**
         * Replaces the 'search' string with the 'replace' String.
         * @private
         */
        protected function replace( str:String , search:String , replace:String ):String 
        {
            return str.split(search).join(replace) ;
        }
    }
}
