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
  Portions created by the Initial Developers are Copyright (C) 2006-2010
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

package system
{
    import core.strings.center;
    import core.strings.indexOfAny;
    import core.strings.insert;
    import core.strings.lastIndexOfAny;
    import core.strings.padLeft;
    import core.strings.padRight;
    import core.strings.repeat;
    import core.strings.trim;
    import core.strings.trimEnd;
    import core.strings.trimStart;
    
    import system.comparators.StringComparator;
    import system.formatters.StringFormatter;
    
    /**
     * A static class for String utilities.
     */
    public class Strings
    {
        /**
         * Returns the center String representation of the specified String value.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.Strings ;
         * trace( Strings.center("hello world", 0) )         ; // hello world
         * trace( Strings.center("hello world", 20) )        ; //     hello world
         * trace( Strings.center("hello world", 20, "_" ) )  ; // ____hello world_____
         * </pre>
         * @param str The String to center.
         * @param size The number of character to center the String expression. (default 0)
         * @param separator The optional separator character use before and after the String to center. (default " ")
         * @return the center String representation of the specified String value.
         */
        public static const center:Function = core.strings.center ;
        
        /**
         * Compares the two specified String objects. Allows to take into account the string case for comparison. 
         * @param o1 first string to compare with the second string.
         * @param o2 second string to compare with the first string.
         * @param strict (optionnal) useCase boolean, default to false.
         */
        public static function compare( o1:String, o2:String, strict:Boolean = false ):int
        {
            return comparator.compare(o1,o2, !strict) ;
        }
        
        /**
         * Determines whether the end of this instance matches the specified String.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.Strings ;
         * 
         * var result:* ;
         * 
         * result = Strings.endsWith( "hello world", "world" );
         * trace("> " + result) ; // true
         * 
         * result = Strings.endsWith( "hello world", "hello" );
         * trace("> " + result) ; // false
         * </pre>
         */
        public static function endsWith( str:String, value:String ):Boolean
        {
            if( (str == null) || (value == null) || (str.length < value.length) )
            {
                return false;
            }
            
            return comparator.compare( str.substr( str.length - value.length ), value ) == 0;
        }
        
        /**
         * Contain a list of evaluators to be used in Strings.format
         * 
         * ex:
         * Strings.evaluators = { math: new MathEvaluator() };
         * Strings.format( "my result is ${2+3}math$" ); // "my result is 5"
         * 
         * note:
         * property names in the evaluators object can only contains
         * lower case alphabetical chars and digit chars
         */
        public static var evaluators:Object = {};
        
        /** 
         * Format a string using indexed, named and/or evaluated parameters.
         * <p>Method call :</p>
         * <li>StringUtil.format(pattern:String, ...arguments:Array):String</li>
         * <li>StringUtil.format(pattern:String, [arg0:*,arg1:*,arg2:*, ...] ):String</li>
         * <li>StringUtil.format(pattern:String, [arg0:*,arg1:*,arg2:*, ...], ...args:Array ):String</li>
         * <li>StringUtil.format(pattern:String, {name0:value0,name1:value1,name2:value2, ...} ):String</li>
         * <li>StringUtil.format(pattern:String, {name0:value0,name1:value1,name2:value2, ...} , ...args:Array ) :String</li>
         * <p>Replaces the pattern item in a specified String with the text equivalent of the value of a specified Object instance.</p>
         * <p>Formats item : {token[,alignment][:paddingChar]}</p>
         * <p>If you want to escape the "{" and "}" chars use "{{" and "}}"
         * <li>"some {{formatitem}} to be escaped" -> "some {formatitem} to be escaped"</li>
         * <li>"some {{format {0} item}} to be escaped", "my" -> "some {format my titem} to be escaped"</li>
         * </p>
         * </p>
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.Strings ;
         * 
         * var result:String ;
         * 
         * // indexed from the arguments
         * 
         * result = Strings.format( "hello {1} {0} world", "big", "the" ); 
         * trace("> " + result) ; //"hello the big world"
         *
         * result = Strings.format("Brad's dog has {0,6:#} fleas.", 41) ;
         * trace("> " + result) ;
         *
         * result = Strings.format("Brad's dog has {0,-6} fleas.", 12) ;
         * trace("> " + result) ;
         *
         * result = Strings.format("{3} {2} {1} {0}", "a", "b", "c", "d") ;
         * trace("> " + result) ;
         * 
         * // named from an object
         * 
         * result = Strings.format( "hello I'm {name}", {name:"HAL"} );
         * trace("> " + result) ; //"hello I'm HAL"
         * 
         * // indexed from an array
         * 
         * var names:Array = ["A","B","C","D"];
         * var scores:Array = [16,32,128,1024];
         * for( var i:int=0; i<names.length; i++ )
         * {
         *     trace( Strings.format( "{0} scored {1,5}", [names[i], scores[i]] ) );
         * }
         * // "A scored    16"
         * // "B scored    32"
         * // "C scored   128"
         * // "D scored  1024"
         * 
         * // resolve toString
         * var x:Object = {};
         * x.toString = function() { return "john doe"; } ;
         * trace( Strings.format( "Who is {0} ?", x ) ) ; //"Who is john doe ?"
         * 
         * // you can off course reuse the index
         * var fruits:Array = ["apple", "banana", "pineapple"] ;
         * trace( Strings.format( "I like all fruits {0},{1},{2}, etc. but still I prefer above all {0}", fruits ) ); // "I like all fruits apple,banana,pineapple, etc. but still I prefer above all apple"
         * 
         * // indexed from an array + the arguments
         * var fruits:Array = ["apple", "banana", "pineapple"];
         * trace( Strings.format( "fruits: {0}, {1}, {2}, {3}, {4}, {5}", fruits, "grape", "tomato" ) ); //"fruits: apple, banana, pineapple, grape, tomato, undefined"
         * 
         * // passing reference and padding
         * var what = "answer" ;
         * result = Strings.format( "your {0} is within {answer,20:.}", {answer:"my answer"}, what ) ; 
         * trace("> " + result ) // "your answer is within ...........my answer"
         * 
         * // using evaluated parameters
         * Strings.evaluators = { math: new MathEvaluator() };
         * Strings.format( "my result is ${2+3}math$" ); // "my result is 5"
         * 
         * //by default evaluated parameters use EdenEvaluator with serialized result
         * Strings.format( "here some object '${ {a:1,b:2} }$'" ); //"here some object '{a:1,b:2}'"
         * 
         * //use EdenEvaluator with stringified result
         * Strings.evaluators = { math: new EdenEvaluator(false) };
         * Strings.format( "here some object '${ {a:1,b:2} }eden$'" ); //"here some object '[object Object]'"
         * Strings.format( "the host is ${system.Environment.host}eden$" ); //"the host is Flash 9.0.115.0"
         * 
         * //use chained evaluators
         * Strings.evaluators = { eden: new EdenEvaluator(false), date: new DateEvaluator() ];
         * Strings.format( "my date is ${new Date(2007,4,22,13,13,13)}eden,date$" ); //"my date is 22.05.2007 13:13:13"
         * 
         * </pre>
         */
        public static function format( format:String, ...args ):String
        {
            var output:String ;
            formatter.parameters = args ;
            formatter.evaluators = Strings.evaluators ;
            output = formatter.format( format ) ;
            formatter.source = "" ;
            return output ;
        }
        
        /**
         * Reports the index of the first occurrence in this instance of any character in a specified array of Unicode characters.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.Strings;
         * 
         * Strings.indexOfAny("hello world", [2, "hello", 5]); // 1
         * Strings.indexOfAny("Five = 5", [2, "hello", 5]); // 2
         * Strings.indexOfAny("actionscript is good", [2, "hello", 5]); // -1
         * </pre>
         * @return the index of the first occurrence in this instance of any character in a specified array of Unicode characters.
         */
        public static const indexOfAny:Function = core.strings.indexOfAny ;
        
        /**
         * Inserts a specified instance of String at a specified index position in this instance.
         * note :
         * if index is null, we directly append the value to the end of the string.
         * if index is zero, we directly insert it to the begining of the string.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.Strings;
         * 
         * var result:String;
         * 
         * result = Strings.insert("hello", 0, "a" );  // ahello
         * trace(result) ;
         * 
         * result = Strings.insert("hello", -1, "a" ); // hellao
         * trace(result) ;
         * 
         * result = Strings.insert("hello", 10, "a" ); // helloa
         * trace(result) ;
         * 
         * result = Strings.insert("hello", 1, "a" );  // haello
         * trace(result) ;
         * </pre>
         * @return the string modified by the method.
         */
        public static const insert:Function = core.strings.insert ;
        
        /**
         * Reports the index position of the last occurrence in this instance of one or more characters specified in a Unicode array.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint"> 
         * trace( Strings.lastIndexOfAny("hello world", ["2", "hello", "5"]) ); // 0
         * trace( Strings.lastIndexOfAny("Five 5 = 5 and not 2" , ["2", "hello", "5"]) ); // 19
         * trace( Strings.lastIndexOfAny("Five 5 = 5 and not 2" , ["5", "hello", "2"]) ); // 9
         * trace( Strings.lastIndexOfAny("Five 5 = 5 and not 2" , ["5", "hello", "2"] , 8) ); // 5
         * trace( Strings.lastIndexOfAny("Five 5 = 5 and not 2" , ["5", "hello", "2"] , 8 , 3) ); // -1
         * </pre> 
         * @param source The String to ckeck.
         * @param anyOf The Array of Unicode characters to find in the String.
         * @param startIndex The init position of the search process.
         * @param count The number of elements to check.
         * @return the index position of the last occurrence in this instance of one or more characters specified in a Unicode array.
         * @throws ArgumentError if the anyOf argument is 'null' or 'undefined'.
         */
        public static const lastIndexOfAny:Function = core.strings.lastIndexOfAny ;
        
        /**
         * Right-aligns the characters in this instance, padding on the left with a specified Unicode character for a specified total length.
         * <pre class="prettyprint">
         * import system.Strings;
         * 
         * var result:String;
         * 
         * result = Strings.padLeft("hello", 8);
         * trace(result); //  "   hello"
         * 
         * result = Strings.padLeft("hello", 8, ".") ;
         * trace(result); //  "...hello" 
         * </pre>
         * @return The right-aligns the characters in this instance, padding on the left with a specified Unicode character for a specified total length.
         */
        public static const padLeft:Function = core.strings.padLeft ;
        
        /**
         * Left-aligns the characters in this string, padding on the right with a specified Unicode character, for a specified total length.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.Strings ;
         * 
         * var result:String ;
         * 
         * result = Strings.padRight("hello", 8) ;
         * trace(result) ; //  "hello   "
         * 
         * result = Strings.padRight("hello", 8, ".") ;
         * trace(result) ; //  "hello..." 
         * </pre>
         * @return The left-aligns the characters in this string, padding on the right with a specified Unicode character, for a specified total length.
         */
        public static const padRight:Function = core.strings.padRight ;
        
        /**
         * Returns a new String value who contains the specified String characters repeated count times.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.Strings ;
         * 
         * trace( Strings.repeat("hello", 0) ) ; // hello
         * trace( Strings.repeat("hello", 3) ) ; // hellohellohello
         * </pre>
         * @return a new String value who contains the specified String characters repeated count times.
         */
        public static const repeat:Function = core.strings.repeat ;
        
        /**
         * Determines whether a specified string is a prefix of the current instance. 
         * <p><b>Example : </b></p>
         * <pre class="prettyprint">
         * import system.Strings ;
         * 
         * trace( Strings.startsWith("hello world", "h") ) ; // true
         * trace( Strings.startsWith("hello world", "hello") ) ; // true
         * trace( Strings.startsWith("hello world", "a") ) ; // false
         * </pre>
         * @return <code class="prettyprint">true</code> if the specified string is a prefix of the current instance.
         */
        public static function startsWith( str:String, value:String ):Boolean
        {
            //special case
            if( (value == "") && (str != null) )
            {
                return true;
            }
            
            if( (str == "") || (str == null) || (value == null) || (str.length < value.length) )
            {
                return false;
            }
            
            //shortcut
            if( str.charAt( 0 ) != value.charAt( 0 ) )
            {
                return false;
            }
            
            return comparator.compare( str.substr( 0, value.length ), value ) == 0;
        }
        
        /**
        * Split every individual char in a string to an array of Char instances.
        * @param str The string to split
        * @param modifier The optional string modifier name (a function to apply)
        */
        public static function splitToChars( str:String, modifier:String = "toString" ):Array
        {
            var arr:Array = [];
            var i:int;
            var l:int = str.length ;
            for( i=0 ; i<l ; i++ )
            {
                arr.push( new Char( String( str[modifier]() ) , i ) );
            }
            
            return arr;
        }
        
        /**
         * Removes all occurrences of a set of specified characters (or strings) from the beginning and end of this instance.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * trace( Strings.trim("\r\t   hello world   \t ") ); // hello world
         * </pre>
         * @param source The string to trim.
         * @param trimChars The optional array of characters to trim. If this argument is null the <code class="prettyprint">Strings.whiteSpaceChars</code> static array is used.
         * @return The new trimed string.
         */
        public static const trim:Function = core.strings.trim ;
        
        /**
         * Removes all occurrences of a set of characters specified in an array from the end of this instance.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * trace( Strings.trimEnd("---hello world---" , Strings.whiteSpaceChars.concat("-") ) ); // ---hello world
         * </pre>
         * @param source The string to trim.
         * @param trimChars The optional array of characters to trim. If this argument is null the <code class="prettyprint">Strings.whiteSpaceChars</code> static array is used.
         * @return The new trimed string.
         */
        public static const trimEnd:Function = core.strings.trimEnd ;
        
        /**
         * Removes all occurrences of a set of characters specified in an array from the beginning of this instance.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * trace( Strings.trimStart("---hello world---" , Strings.whiteSpaceChars.concat("-") ) ); // hello world---
         * </pre>
         * @param source The string to trim.
         * @param trimChars The optional array of characters to trim. If this argument is null the <code class="prettyprint">Strings.whiteSpaceChars</code> static array is used.
         * @return The new trimed string.
         */
        public static const trimStart:Function = core.strings.trimStart ;
        
        //////////////////////////////////////////////////////////////////////
        
        /**
         * @private
         * @see system.Strings#format
         */
        protected static var formatter:StringFormatter = new StringFormatter() ;
        
        /**
         * @private
         * @see system.Strings#compare
         */
        protected static var comparator:StringComparator = new StringComparator() ;
    }
}
