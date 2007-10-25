
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
    
    /* Class: Strings
       A static class for String utilities.
    */
    public class Strings
        {
        
        /* Method: _PadHelper
           Helper method for the padLeft and padRight method.
        */
        private static function _padHelper( str:String, totalWidth:int, paddingChar:String = " ", isRightPadded:Boolean = true ):String
            {
            if( (totalWidth < str.length) || (totalWidth < 0) )
                {
                return str;
                }
            
            /* note:
               we want to limit the string to ONLY ONE char
               
               for now we do that but perharps it would better
               to throw an Error
            */
            if( paddingChar.length > 1 )
                {
                paddingChar = paddingChar.charAt( 0 );
                }
            
            while( str.length != totalWidth )
                {
                if( isRightPadded == true )
                    {
                    str += paddingChar;
                    }
                else
                    {
                    str = paddingChar + str;
                    }
                }
            
            return str;
            }
        
        /* Method: _trimHelper
           Helper method used by trim, trimStart and trimEnd methods.
        */
        private static function _trimHelper( str:String, trimChars:Array, trimStart:Boolean = false, trimEnd:Boolean = false ):String
            {
            var iLeft:int;
            var iRight:int;
            
            if( trimStart )
                {
                for( iLeft=0; (iLeft<str.length) && (trimChars.indexOf( str.charAt( iLeft ) ) > -1); iLeft++ )
                    {
                    }
                
                str = str.substr( iLeft );
                }
            
            if( trimEnd )
                {
                for( iRight=str.length-1; (iRight>=0) && (trimChars.indexOf( str.charAt( iRight ) ) > -1); iRight-- )
                    {            
                    }
                
                str = str.substring( 0, iRight+1 );
                }
            
            return str;
            }
        
        /* Method: compare
           Compares the two specified String objects.
           
           Parameters:
             o1     - first string to compare
             o2     - with second string
             strict - optionnal ignoreCase boolean, default to false.
                      allows to take into account the string case for comparison.
             
           note:
           we don't do a string diff, we just compare the length of the strings
           and if the length are equals only then we compare by value.
           
           attention
           if you have used core2 before
           where you were used to a compare(o1, o2, ignoreCase = false) signature
           note that the default parameter have changed
           (ignoreCase = false) != (strict = false)
        */
        public static function compare( o1:*, o2:*, strict:Boolean = false ):int
            {
            
            if( (o1 == null) || (o2 == null) )
                {
                if( o1 == o2 )
                    {
                    return 0; //both null
                    }
                else if( o1 == null )
                    {
                    return -1; //o1 is null -1
                    }
                else
                    {
                    return 1; //o2 is null 1
                    }
                }
            
            if( !(o1 is String) || !(o2 is String) )
                {
                throw new Error( "Arguments String expected." );
                }
            
            if( !strict == true )
                {
                o1 = o1.toLowerCase();
                o2 = o2.toLowerCase();
                }
            
            if( o1 == o2 )
                {
                return 0;
                }
            else if( o1.length == o2.length )
                {
                /* TODO:
                   implement a string diff algorithm
                */
                //return difference( o1, o2, option );
                return 0;
                }
            else if( o1.length > o2.length )
                {
                return 1;
                }
            else
                {
                return -1;
                }
            }
        
        /* Method: endsWith
           Determines whether the end of this instance matches the specified String.
        */
        public static function endsWith( str:String, value:String ):Boolean
            {
            if( (value == null) || (str.length < value.length) )
                {
                return false;
                }
            
            return compare( str.substr( str.length-value.length ), value) == 0;
            }
        
        /* Method: format
           Format a string using indexed or named parameters.
           
           method call:
           format( format:String, ...args )
           format( format:String, [arg0:*,arg1:*,arg2:*, ...] )
           format( format:String, [arg0:*,arg1:*,arg2:*, ...], ...args )
           format( format:String, {name0:value0,name1:value1,name2:value2, ...} )
           format( format:String, {name0:value0,name1:value1,name2:value2, ...}, ...args )
           
           formats item:
           (code)
           {token[,alignment][:paddingChar]}
           (end)
           
           If you want to use the "{" and "}" chars use "{{" and "}}"
           "some {{formatitem}} to be escaped" -> "some {formatitem} to be escaped"
           "some {{format {0} item}} to be escaped", "my" -> "some {format my titem} to be escaped"
           
           parameters:
           token       - A numeric [0-9] or named [a-zA-Z] index to indicate
                         which element to format.
                         
                         example:
                         (code)
                         Strings.format( "the {method} is not {state}", {method:"toString",state:"available"} );
                         Strings.format( "the {0} is not {1}", ["toString","available"] );
                         Strings.format( "the {0} is not {1}", "toString", "available" );
                         (end)
                         
                         note:
                         You can not have more than 10 indexes (0 to 9).
                         If the token is null the "null" string is returned.
                         If the token is undefined the "undefined" string is returned.
           
           alignment   - This optionnal integer allow you to align and pad your token.
                         The alignement is right-justified if positive
                         and left-justified if negative.
                         
                         example:
                         (code)
                         Strings.format( "hello {0,10}", "world" );  //"hello      world"
                         Strings.format( "hello {0,-10}", "world" ); //"hello world     "
                         (end)
                         
                         This integer also indicate the minimum width of the padding,
                         if the length of your token is less than the padding
                         then the token will be padded with spaces. 
                         
           
           paddingChar - The padding char by default is the space char.
                         
                         example:
                         (code)
                         Strings.format( "hello {0,10:_}", "world" );  //"hello _____world"
                         Strings.format( "hello {0,-10:.}", "world" ); //"hello world....."
                         (end)
                         
                         You can define any other padding char.
           
           more example:
           (code)
            //indexed from the arguments
            Strings.format( "hello {1} {0} world", "big", "the" ); //"hello the big world"
            
            //named from an object
            Strings.format( "hello I'm {name}", {name:"HAL"} ); //"hello I'm HAL"
            
            //passing reference and padding
            var what = "answer"
            Strings.format( "your {0} is within {answer,20:.}", {answer:"my answer"}, what ); //"your answer is within ...........my answer"
            
            //indexed from an array
            var names:Array = ["A","B","C","D"];
            var scores:Array = [16,32,128,1024];
            for( var i:int=0; i<names.length; i++ )
                {
                trace( Strings.format( "{0} scored {1,5}", [names[i], scores[i]] ) );
                }
            //"A scored    16"
            //"B scored    32"
            //"C scored   128"
            //"D scored  1024"
            
            //resolve toString
            var x:Object = {};
                x.toString = function() { return "john doe"; };
            trace( Strings.format( "Who is {0} ?", x ) ); //"Who is john doe ?"
            
            //you can off course reuse the index
            var fruits:Array = ["apple", "banana", "pineapple"];
            trace( Strings.format( "I like all fruits {0},{1},{2}, etc. but still I prefer above all {0}", fruits ) ); //"I like all fruits apple,banana,pineapple, etc. but still I prefer above all apple"
            
            //indexed from an array + the arguments
            var fruits:Array = ["apple", "banana", "pineapple"];
            trace( Strings.format( "fruits: {0}, {1}, {2}, {3}, {4}, {5}", fruits, "grape", "tomato" ) ); //"fruits: apple, banana, pineapple, grape, tomato, undefined"
           (end)
           
        */
        public static function format( format:String, ...args ):String
            {
           if( (args == null) || (args.length == 0) || (format == "") )
                {
                return format; //nothing to format
                }
            
            var paddingChar:String  = " "; //default padding char is SPC
            var indexedValues:Array = [];  //cf {0} {1} etc.
            var namedValues:Object  = {};  //cf {toto} {titi} etc.
            //var numeric:RegExp      = /^[0-9]*/;
            //var alphabetic:RegExp   = /^[A-Za-z]./;
            //var alphaLetter:RegExp  = /^[A-Za-z]/;
            
            //parse arguments
            if( args.length >= 1 )
                {
                if( args[0] is Array )
                    {
                    indexedValues = indexedValues.concat( args[0] );
                    args.shift();
                    }
                else if( (args[0] is Object) && (String(args[0]) == "[object Object]") )
                    {
                    for( var prop:String in args[0] )
                        {
                        namedValues[ prop ] = args[0][ prop ];
                        }
                    args.shift();
                    }
                }
            
            indexedValues = indexedValues.concat( args );
            
            //escape {{ and }}
            var ORC1:String = "\uFFFC"; //Object Replacement Character
            var ORC2:String = "\uFFFD"; //Object Replacement Character
            if( indexOfAny( format, [ "{{", "}}" ] ) > -1 )
                {
                /* note:
                   little limitation here
                   we cover the case of {{{0}}} -> to be able
                   to escape and inject within the escaped
                   Strings.format( "{{{0}}}", "hello" ) -> "{hello}"
                   but in more complex cases as {{{{{0}}}}} this scenario will fail
                   
                   workaround:
                   if you really really really need to escape
                   as much as {{{{ and }}}} do that
                   Strings.format( "{left}{0}{right}", {left:"{{{{", "}}}}"}, "hello" ) -> "{{{{hello}}}}"
                   
                   TODO:
                   use regexp once String.format for JS/AS1 is stable
                */
                format = format.split( "{{{" ).join( ORC1+"{" );
                format = format.split( "{{" ).join( ORC1 );
                format = format.split( "}}}" ).join( "}"+ORC2 );
                format = format.split( "}}" ).join( ORC2 );
                }
            
            // {0} {1}
            // {0,5} {0,-5}
            // {0,5:_} {0,-5:_}
            // {toto} {titi}
            // {toto,5} {toto,-5}
            // {titi,5:_} {titi,-5:_}
            var parseExpression:Function = function( expression:String ):String
                {
                use namespace AS3; //to avoid 3594 warning
                var value:String      = "";
                var spaceAlign:int    = 0;
                var isAligned:Boolean = false;
                var padding:String    = paddingChar; //default
                
                if( indexOfAny( expression, [ ",", ":" ] ) > -1 )
                    {
                    var vPos:int = expression.indexOf( "," );
                    if( vPos == -1 )
                        {
                        throw new Error( "malformed format, could not find [,] before [:]." );
                        }
                    
                    var fPos:int = expression.indexOf( ":" );
                    
                    if( fPos == -1 )
                        {
                        spaceAlign = int( expression.substr( vPos+1 ) );
                        }
                    else
                        {
                        spaceAlign  = int( expression.substring( vPos+1, fPos ) );
                        padding     = expression.substr( fPos+1 );
                        }
                    
                    isAligned  = true;
                    expression = expression.substring( 0, vPos );
                    }
                
                /* note:
                   there must be a bug in playerglobal.swc
                   when compiling this warning occurs
                   "3594: test is not a recognized method of the dynamic class RegExp"
                   but Global.as shows
                    (code)
                    public dynamic class RegExp
                    {
                        //...
                    	public native function test(str:String):Boolean;
                        //...
                    }
                    (end)
                    
                    to solve that little bug:
                    use namespace AS3;
                    apparently when you define an inner function
                    or an internal function outside a package
                    the AS3 namespace is not found anymore
                */
                
                /*
                if( alphabetic.test(expression) || alphaLetter.test(expression) )
                    {
                    value = String( namedValues[ expression ] );
                    }
                else if( numeric.test(expression) )
                    {
                    value = String( indexedValues[ int(expression) ] );
                    }
                */
                var c:String = expression.split("")[0];
                if( (("A" <= c) && (c <= "Z")) || (("a" <= c) && (c <= "z")) )
                    {
                    value = String( namedValues[ expression ] );
                    }
                else if( ("0" <= c) && (c <= "9") )
                    {
                    value = String( indexedValues[ int(expression) ] );
                    }
                
                if( isAligned )
                    {
                    if( (spaceAlign > 0) && (value.length < spaceAlign) )
                        {
                        value = padLeft( value, spaceAlign, padding );
                        }
                    else( -value.length < spaceAlign )
                        {
                        value = padRight( value, -spaceAlign, padding );
                        }
                    }
                
                return value;
                }
            
            var expression:String = "";
            var formated:String   = "";
            var ch:String         = "";
            var pos:int           = 0;
            var len:int           = format.length;
            
            var next:Function = function():String
                {
                ch = format.charAt( pos );
                pos++;
                return ch;
                }
            
            //parsing
            while( pos < len )
                {
                next();
                if( ch == "{" )
                    {
                    expression = next();
                    while( next() != "}" )
                        {
                        expression += ch;
                        }
                    formated += parseExpression( expression );
                    }
                else
                    {
                    formated += ch;
                    }
                }
            
            if( indexOfAny( format, [ ORC1, ORC2 ] ) > -1 )
                {
                formated = formated.split( ORC1 ).join( "{" );
                formated = formated.split( ORC2 ).join( "}" );
                }
            
            return formated;
            }
        
        /* Method: indexOfAny
        */
        public static function indexOfAny( str:String, anyOf:Array, startIndex:int = 0, count:int = -1 ):int
            {
            var i:int;
            var endIndex:int;
            
            if( str.length == 0 )
                {
                return -1;
                }
            
            if( startIndex < 0 )
                {
                startIndex = 0;
                }
            
            if( (count < 0) || (count > anyOf.length - startIndex) )
                {
                endIndex =  anyOf.length - 1;
                }
            else
                {
                endIndex = startIndex + count - 1;
                }
            
            for( i=startIndex; i<=endIndex ; i++ )
                {
                if( str.indexOf( anyOf[i] ) > -1 )
                    {
                    return i;
                    }
                }
            
            return -1;
            }
        
        /* Method: insert
           Inserts a specified instance of String at
           a specified index position in this instance.
           
           note:
           if index is null, we directly append the value to the end of the string.
           
           if index is zero, we directly insert it to the begining of the string.
        */
        public function insert( str:String, startIndex:int, value:String ):String
            {
            var strA:String = "";
            var strB:String = "";
            
            if( startIndex == 0 )
                {
                return value + str;
                }
            else if( startIndex == str.length )
                {
                return str + value;
                }
            
            strA = str.substr( 0, startIndex );
            strB = str.substr( startIndex );
            
            return strA + value + strB;
            }
        
        /* Method: padLeft
           Right-aligns the characters in this instance,
           padding with paddingChar (or spaces if not precised)
           on the left for a specified total length.
        */
        public static function padLeft( str:String, totalWidth:int, paddingChar:String = " " ):String
            {
            return _padHelper( str, totalWidth, paddingChar, false );
            }
        
        /* Method: padRight
           Left-aligns the characters in this string,
           padding with paddingChar (or spaces if not precised)
           on the right for a specified total length.
        */
        public static function padRight( str:String, totalWidth:int, paddingChar:String = " " ):String
            {
            return _padHelper( str, totalWidth, paddingChar, true );
            }
        
        /* Method: startsWith
           Determines whether a specified string is a prefix
           of the current instance.
        */
        public static function startsWith( str:String, value:String ):Boolean
            {
            if( (value == null) || (str.length < value.length) )
                {
                return false;
                }
            
            if( str.charAt( 0 ) != value.charAt( 0 ) )
                {
                return false;
                }
            
            return compare( str.substr( 0, value.length), value) == 0;
            }
        
        /* Method: trim
           Removes all occurrences of a set of specified characters (or strings)
           from the beginning and end of this instance.
        */
        public static function trim( str:String, trimChars:Array = null ):String
            {
            if( trimChars == null )
                {
                trimChars = whiteSpaceChars;
                }
            
            return _trimHelper( str, trimChars, true, true );
            }

        /* Method: trimEnd
           Removes all occurrences of a set of characters specified
           in an array from the end of this instance.
        */
        public static function trimEnd( str:String, trimChars:Array = null ):String
            {
            if( trimChars == null )
                {
                trimChars = whiteSpaceChars;
                }
            
            return _trimHelper( str, trimChars, false, true );
            }

        /* Method: trimStart
           Removes all occurrences of a set of characters specified
           in an array from the beginning of this instance.
        */
        public static function trimStart( str:String, trimChars:Array = null ):String
            {
            if( trimChars == null )
                {
                trimChars = whiteSpaceChars;
                }
            
            return _trimHelper( str, trimChars, true, false );
            }
        
        
        /* Property: whiteSpaceChars
            Contains a read-only list of white space chars.
            
            note:
            http://developer.mozilla.org/es4/proposals/string.html
            http://www.fileformat.info/info/unicode/category/Zs/list.htm
            http://www.fileformat.info/info/unicode/category/Zl/list.htm
            http://www.fileformat.info/info/unicode/category/Zp/list.htm
            http://www.fileformat.info/info/unicode/char/200b/index.htm
            http://www.fileformat.info/info/unicode/char/feff/index.htm
            http://www.fileformat.info/info/unicode/char/2060/index.htm
            
            TODO:
            we maybe could also define 0xFFEF and/or 0x2060,
            but not completely sure of all the implication,
            0xFFEF in byte order mark etc.
         */
        public static const whiteSpaceChars:Array =    [ "\u0009" /*Horizontal tab*/,
                                                         "\u000A" /*Line feed or New line*/,
                                                         "\u000B" /*Vertical tab*/,
                                                         "\u000C" /*Formfeed*/,
                                                         "\u000D" /*Carriage return*/,
                                                         "\u0020" /*Space*/,
                                                         "\u00A0" /*Non-breaking space*/,
                                                         "\u1680" /*Ogham space mark*/,
                                                         "\u180E" /*Mongolian vowel separator*/,
                                                         "\u2000" /*En quad*/,
                                                         "\u2001" /*Em quad*/,
                                                         "\u2002" /*En space*/,
                                                         "\u2003" /*Em space*/,
                                                         "\u2004" /*Three-per-em space*/,
                                                         "\u2005" /*Four-per-em space*/,
                                                         "\u2006" /*Six-per-em space*/,
                                                         "\u2007" /*Figure space*/,
                                                         "\u2008" /*Punctuation space*/,
                                                         "\u2009" /*Thin space*/,
                                                         "\u200A" /*Hair space*/,
                                                         "\u200B" /*Zero width space*/,
                                                         "\u2028" /*Line separator*/,
                                                         "\u2029" /*Paragraph separator*/,
                                                         "\u202F" /*Narrow no-break space*/,
                                                         "\u205F" /*Medium mathematical space*/,
                                                         "\u3000" /*Ideographic space*/ ];

        
        
        
        }
    
    
    }

