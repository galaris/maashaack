
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
       A clone of the builtin String class with some extensions.
    */
    public class Strings
        {
        private var _value:String;
        
        public function Strings( str:String = "" )
            {
            _value = str;
            }
        
        public function get length():int
            {
            return _value.length;
            }
        
        public function valueOf():String
            {
            return _value.valueOf();
            }
        
        public function toString():String
            {
            return _value;
            }
        
        /* group: native
           
           note:
           as String class is final in AS3
           we have to reimplement all the native String methods,
           keeping the same function signatures.
           
           For now we use by default the AS3 namespace b/c it is more optimized,
           this could evolve later to provide better portability,
           for ex if JS2 would introduce a JS2 namespace.
        */
		
		public function indexOf( s:String="undefined", i:Number=0 ):int 
		    {
			return String(this).AS3::indexOf( s, i );
		    }
        
		public function charAt( i:Number=0 ):String
		    {
			return String(this).AS3::charAt( i );
		    }
        
		public function charCodeAt( i:Number=0 ):Number
		    {
			return String(this).AS3::charCodeAt( i );
		    }
        
		public function concat( ...args ):String
		    {
			var s:String = String(this);
			for( var i:uint = 0, n:uint = args.length; i < n; i++ )
			    {
				s = s + String( args[i] );
			    }
			return s;
		    }
        
		public function localeCompare( other:String=void 0 ):int 
		    {
			return String(this).AS3::localeCompare(other);
		    }
        
		public function match( p:*=void 0 ):Array
		    {
			return String(this).AS3::match( p );
		    }
        
		public function replace( p:*=void, repl:*=void ):String
		    {
			return String(this).AS3::replace( p, repl );
		    }
        
		public function search( p:*=void 0 ):int
		    {
			return String(this).AS3::search( p );
		    }
        
		public function slice( start:Number=0, end:Number=0x7fffffff ):String
		    {
			return String(this).AS3::slice( start, end );
		    }
        
		public function split( delim:*=void 0, limit:Number=0xffffffff ):Array
		    {
			return String(this).AS3::split( delim, limit );
		    }
        
		public function substring( start:Number=0, end:Number=0x7fffffff ):String
		    {
			return String(this).AS3::substring( start, end );
		    }
        
		public function substr( start:Number=0, len:Number=0x7fffffff ):String
		    {
			return String(this).AS3::substr( start, len );
		    }

		public function toLowerCase():String
		    {
			return String(this).AS3::toLowerCase();
		    }
        
		public function toLocaleLowerCase():String
		    {
			return String(this).AS3::toLowerCase();
		    }
        
		public function toUpperCase():String
		    {
			return String(this).AS3::toUpperCase();
		    }
        
		public function toLocaleUpperCase():String
		    {
			return String(this).AS3::toUpperCase();
		    }        
        
        
        /* group: core2 extended
           
           note:
           we keep it simple for now, more to come ;)
        */
        
        /* Method: compare
           Compares the two specified String objects.
           
           Parameters:
             strA       - first string to compare
             strB       - with second string
             ignoreCase - optionnal, allow to take into account the case for comparison
             
           note:
           we don't do a string diff, we just compare the length of the strings
           and if the length are equals only then we compare by value.
        */
        public static function compare( strA:String, strB:String, ignoreCase:Boolean = true ):int
            {
            if( (strA == null) || (strB == null) )
                {
                if( strA == strB )
                    {
                    return 0; //both null
                    }
                else if( strA == null )
                    {
                    return -1; //strA is null -1
                    }
                else
                    {
                    return 1; //strB is null 1
                    }
                }
            
            /* note:
               little hack in the case we cannot inherit from String
               we then use the primitive valueOf
            */
            strA = strA.valueOf();
            strB = strB.valueOf();   
            
            if( !(strA is String) || !(strB is String) )
                {
                throw new Error( "Arguments String expected." );
                }
            
            if( ignoreCase == true )
                {
                strA = strA.toLowerCase();
                strB = strB.toLowerCase();
                }
            
            if( strA == strB )
                {
                return 0;
                }
            else if( strA.length > strB.length )
                {
                return 1;
                }
            else
                {
                return -1;
                }
            }
        
        
        /* Method: format
           format a string.
           
           method call:
           format( format:String, ...args )
           format( format:String, [arg0:*,arg1:*,arg2:*, ...] )
           format( format:String, [arg0:*,arg1:*,arg2:*, ...], ...args )
           format( format:String, {name0:value0,name1:value1,name2:value2, ...} )
           format( format:String, {name0:value0,name1:value1,name2:value2, ...}, ...args )
           
           formats item:
           {token[,alignment][:paddingChar]}
           
           If you want to use the "{" and "}" chars use "{{" and "}}"
           "some {{formatitem}} to be escaped" -> "some {formatitem} to be escaped"
           "some {{format {0} item}} to be escaped", "my" -> "some {format my titem} to be escaped"
           
           
           token       - A numeric [0-9] or named [a-zA-Z] index to indicate
                         which element to format.
                         
                         ex:
                         (code)
                         String.format( "the {method} is not {state}", {method:"toString",state:"available"} )
                         String.format( "the {0} is not {1}", ["toString","available"] )
                         String.format( "the {0} is not {1}", "toString", "available" )
                         (end)
                         
                         note:
                         You can not have more than 10 indexes (0 to 9).
                         If the token is null the "null" string is returned.
                         If the token is undefined the "undefined" string is returned.
           
           alignment   - This optionnal integer allow you to align and pad your token.
                         The alignement is right-justified if positive
                         and left-justified if negative.
                         This integer also indicate the minimum width of the padding,
                         if the length of your token is less than the padding
                         then the token will be padded with spaces. 
                         
           
           paddingChar - The padding char by default is the space char.
                         You can define any other padding char.
           
        */
        public static function format( format:String, ...args ):String
            {
           if( (args == null) || (args.length == 0) || (format == "") )
                {
                trace( "#shortcut" );
                return format; //nothing to format
                }
            
            var paddingChar:String  = " "; //default padding char is SPC
            var indexedValues:Array = [];  //cf {0} {1} etc.
            var namedValues:Object  = {};  //cf {toto} {titi} etc.
            var hasIndexes:Boolean  = false;
            var hasNames:Boolean    = false;
            var numeric:RegExp      = /^[0-9]*/;
            var alphabetic:RegExp   = /^[A-Za-z]./;
            var alphaLetter:RegExp  = /^[A-Za-z]/;
            
            if( args.length >= 1 )
                {
                if( args[0] is Array )
                    {
                    indexedValues = indexedValues.concat( args[0] );
                    hasIndexes = true;
                    args.shift();
                    }
                else if( (args[0] is Object) && (String(args[0]) == "[object Object]") )
                    {
                    for( var prop:String in args[0] )
                        {
                        namedValues[ prop ] = args[0][ prop ];
                        }
                    hasNames = true;
                    args.shift();
                    }
                }
            
            indexedValues = indexedValues.concat( args );
            
            //escape {{ and }}
            var ORC1:String = "\uFFFC"; //Object Replacement Character
            var ORC2:String = "\uFFFD"; //Object Replacement Character
            if( new Strings(format).indexOfAny( [ "{{", "}}" ] ) > -1 )
                {
                format = format.split( "{{" ).join( ORC1 );
                format = format.split( "}}" ).join( ORC2 );
                }
            
            if( indexedValues.length > 0 )
                {
                hasIndexes = true;
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
                
                if( new Strings(expression).indexOfAny( [ ",", ":" ] ) > -1 )
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
                if( alphabetic.test(expression) || alphaLetter.test(expression) )
                    {
                    value = String( namedValues[ expression ] );
                    }
                else if( numeric.test(expression) )
                    {
                    value = String( indexedValues[ int(expression) ] );
                    }
                
                if( isAligned )
                    {
                    if( (spaceAlign > 0) && (value.length < spaceAlign) )
                        {
                        value = new Strings(value).padLeft( spaceAlign, padding );
                        }
                    else( -value.length < spaceAlign )
                        {
                        value = new Strings(value).padRight( -spaceAlign, padding );
                        }
                    }
                
                return value.toString();
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
            
            if( new Strings(format).indexOfAny( [ ORC1, ORC2 ] ) > -1 )
                {
                formated = formated.split( ORC1 ).join( "{{" );
                formated = formated.split( ORC2 ).join( "}}" );
                }
            
            return formated;
            }
        
        
        
        
        /* Method: _PadHelper
           Helper method for the padLeft and padRight method.
        */
        private function _padHelper( totalWidth:int, paddingChar:String = " ", isRightPadded:Boolean = true ):String
            {
            if( (totalWidth < this.length) || (totalWidth < 0) )
                {
                return this.toString();
                }
            
            var str:String = this.toString();
            
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
        private function _trimHelper( trimChars:Array, trimStart:Boolean = false, trimEnd:Boolean = false ):String
            {
            var str:String = this.toString();
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
        

        /* Method: endsWith
           Determines whether the end of this instance matches the specified String.
        */
        public function endsWith( value:String ):Boolean
            {
            if( (value == null) || (this.length < value.length) )
                {
                return false;
                }
            
            return compare( this.substr( this.length-value.length ), value) == 0;
            }

        /* Method: startsWith
           Determines whether a specified string is a prefix
           of the current instance.
        */
        public function startsWith( value:String ):Boolean
            {
            if( (value == null) || (this.length < value.length) )
                {
                return false;
                }
            
            if( this.charAt( 0 ) != value.charAt( 0 ) )
                {
                return false;
                }
            
            return compare( this.substr( 0, value.length), value) == 0;
            }


        
        /* Method: padLeft
           Right-aligns the characters in this instance,
           padding with paddingChar (or spaces if not precised)
           on the left for a specified total length.
        */
        public function padLeft( totalWidth:int, paddingChar:String = " " ):String
            {
            return _padHelper( totalWidth, paddingChar, false );
            }
        
        /* Method: padRight
           Left-aligns the characters in this string,
           padding with paddingChar (or spaces if not precised)
           on the right for a specified total length.
        */
        public function padRight( totalWidth:int, paddingChar:String = " " ):String
            {
            return _padHelper( totalWidth, paddingChar, true );
            }
        
        /* Method: indexOfAny
        */
        public function indexOfAny( anyOf:Array, startIndex:int = 0, count:int = -1 ):int
            {
            var i:int;
            var endIndex:int;
            
            if( this.length == 0 )
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
                if( this.indexOf( anyOf[i] ) > -1 )
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
        public function insert( startIndex:int, value:String ):String
            {    
            var str:String = this.toString();
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
        
        /* Method: trim
           Removes all occurrences of a set of specified characters (or strings)
           from the beginning and end of this instance.
        */
        public function trim( trimChars:Array = null ):String
            {
            if( trimChars == null )
                {
                trimChars = whiteSpaceChars;
                }
            
            return _trimHelper( trimChars, true, true );
            }

        /* Method: trimEnd
           Removes all occurrences of a set of characters specified
           in an array from the end of this instance.
        */
        public function trimEnd( trimChars:Array = null ):String
            {
            if( trimChars == null )
                {
                trimChars = whiteSpaceChars;
                }
            
            return _trimHelper( trimChars, false, true );
            }

        /* Method: trimStart
           Removes all occurrences of a set of characters specified
           in an array from the beginning of this instance.
        */
        public function trimStart( trimChars:Array = null ):String
            {
            if( trimChars == null )
                {
                trimChars = whiteSpaceChars;
                }
            
            return _trimHelper( trimChars, true, false );
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

