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

package system.serializers.eden
{
    import core.chars.isAlpha;
    import core.chars.isDigit;
    import core.chars.isHexDigit;
    import core.reflect.getDefinitionByName;
    import core.reflect.hasClassByName;
    import core.strings.endsWith;
    import core.strings.format;
    import core.strings.lineTerminatorChars;
    import core.strings.startsWith;

    import system.Reflection;
    import system.terminals.console;
    import system.text.parser.GenericParser;
    
    /* note:
    how to debug eden (part 1)
       
    by default eden
    use namespace release;
       
    to have all the traces displayed in the console
    use namespace debug;
       
    with that you will also have the logs displaying in the console
    even if config.showLogs = false
     */
    //import system.serializers.eden.debug;
    //import system.serializers.eden.release;
    
    /* note:
    how to debug eden (part 2)
       
    If you want to monitor more precisely some code snapshot
    you can use the VirtualMachine beginTrace/endTrace functions
    (which reuse the flash.trace.Trace function calls)
       
    if you uncomment those methods in doesExistInGlobalScope method
    you will see for ex:
    ------------------------------------------------------
     - system.serializers.eden::ECMAScript/isDigitNumber("0")
     - String/split("",4294967295)
     - String$/_split()
     - Array/get length()
     - system.serializers.eden::GenericParser$/isDigit("0")
     - Array/get length()
     - global/parseInt()
    ------------------------------------------------------
       
    avoid to trace too much or you could crash the Flash Player
     */
    //import system.diagnostics.VirtualMachine;
    
    /**
     * The ECMAScript parser class.
     */
    public class ECMAScript extends GenericParser
    {
        /* note:
           Always commit changes with the release namespace
        */
        use namespace release;
        //use namespace debug;
        
        /**
         * Creates a new ECMAScript instance.
         * @param source The string expression to parse.
         */
        public function ECMAScript( source:String )
        {
            super( source ) ;
            localscope = {};
        }
        
        /**
         * The comments string representation.
         */
        public static var comments:String = "";
        
        /**
         * The following are reserved as future keywords by the ECMAScript specification.
         */
        public static const FUTUR_KEYWORDS:Array = 
        [
            "abstract" ,
            "boolean", 
            "byte",
            "char", 
            "class", 
            "const",
            "debugger", 
            "double",
            "enum", 
            "export", 
            "extends",
            "final", 
            "float",
            "goto",
            "implements", 
            "import", 
            "int", 
            "interface",
            "long",
            "native",
            "package", 
            "private", 
            "protected", 
            "public",
            "short", 
            "static", 
            "super", 
            "synchronized",
            "throws", 
            "transient",
            "volatile"
        ] ;
        
        /**
         * The following are reserved words and may not be used as variables, functions, methods, or object identifiers. 
         * The following are reserved as existing keywords by the ECMAScript specification:
         */
        public static const RESERVED_KEYWORDS:Array = 
        [
            "break"      , 
            "case"       , 
            "catch"      , 
            "continue"   , 
            "default"    , 
            "delete"     , 
            "do"         , 
            "else"       , 
            "finally"    , 
            "for"        , 
            "function"   , 
            "if"         , 
            "in"         , 
            "instanceof" , 
            "new"        , 
            "return"     , 
            "switch"     , 
            "this"       , 
            "throw"      , 
            "try"        , 
            "typeof"     , 
            "var"        , 
            "void"       , 
            "while"      ,
            "with"       
        ] ;
        
        /**
         * The local scope reference.
         */
        public var localscope:* ;
        
        /**
         * Evaluate the specified string source value with the parser.
         */
        public static function evaluate( source:String ):*
        {
            var parser:ECMAScript = new ECMAScript( source );
            return parser.eval();
        }
        
        /**
         * Eval the source and returns the serialized object.
         */
        public function eval():*
        {
            debug( "eval()" );
            comments = ""; 
            //clean comments before starting a new eval
            var value:* = _ORC;
            var tmp:*;
            
            if( source.length == 1 )
            {
                _1char = true;
            }
            
            while( hasMoreChar( ) )
            {
                _scanSeparators( );
                
                if( !isAlpha( ch ) )
                {
                    next() ;
                }
                
                tmp = _scanValue() ;
                
                _scanSeparators() ;
                
                if( tmp != _ORC )
                {
                    value = tmp;
                }
                
                /* note: poor man semicolon auto-insertion */
                if( ch == " " )
                {
                    ch = ";";
                }
            }
            
            if( value == _ORC )
            {
                value = undefined;
            }
            
            if( ! _singleValue )
            {
                value = localscope;
            }
            
            return value;
        }
        
        /**
         * Dispatch a log message. 
         * Add a config to either
         * <li> store logs (nonblock parsing)</li>
         * <li> display logs (nonblock parsing)</li>
         * <li> throw an error (block parsing)</li>
         * <li>add a safety mecanism to prevent infinite loop log when the same error is logged over and over in non-blocking mode</li>
         */
        public function log( str:String ):void
        {
            if( config.verbose )
            {
                trace( str );
            }
        }
        
        /**
         * Indicates if the specified path is authorized in the config.authorized Array.
         */
        public function isAuthorized( path:String ):Boolean
        {
            var authorized:Array = config.authorized ;
            
            if ( authorized == null || authorized.length == 0 )
            {
                return false ;
            }
            
            var pathMode:Boolean ;
            var strictMode:Boolean  = config.strictMode ;
            var firstLetter:String  = path.charAt( 0 ) ;
            
            if( path.indexOf( "." ) > -1 )
            {
                pathMode = true;
            }
            
            if( !strictMode )
            {
                firstLetter = firstLetter.toLowerCase();
            }
            
            var filterFirstLetter:Function = function( value:*, index:int, arrObj:Array ):*
            {
                if( !strictMode )
                {
                    value = value.toLowerCase();
                };
                return startsWith( value, firstLetter ) ;
            } ;
            
            var whiteList:Array = authorized.filter( filterFirstLetter ) ;
            if( whiteList && whiteList.length == 0 )
            {
                return false ;
            }
            
            var cur:String ;
            var len:int = whiteList.length ;
            for( var i:int ; i<len ; i++ )
            {
                cur = whiteList[i] ;
                if( pathMode )
                {
                    if ( endsWith( cur, "*" ) )
                    {
                        if ( startsWith( path, replace( cur, "*", "" ) ) )
                        {
                            return true;
                        }
                    }
                }
                else if( path == replace( cur, ".*", "" ) )
                {
                    return true;
                }
            }
            return false;
        }
        
        /**
         * Indicates if the specified expression is a digit number value.
         */
        public function isDigitNumber( num:String ):Boolean
        {
            debug( "isDigitNumber( \"" + num + "\" )" );
            var numarr:Array = num.split( "" );
            for( var i:int = 0; i < numarr.length ; i++ )
            {
                if( !isDigit( numarr[i] ) )
                {
                    return false;
                }
            }
            return true;
        }
        
        /**
         * Indicates if the specified expression is a start identifier.
         * @see ECMA-262 spec 7.6 (PDF p26/188)
         */
        public function isIdentifierStart( c:String ):Boolean
        {
            debug( "isIdentifierStart( \"" + c + "\" )" );
            if( isAlpha( c ) || (c == "_") || (c == "$" ) )
            {
                return true;
            }
            
            if( c.charCodeAt( 0 ) < 128 )
            {
                return false;
            }
            
            return false;
        }
        
        /**
         * Indicates if the identifier is a part.
         */
        public function isIdentifierPart( c:String ):Boolean
        {
            debug( "isIdentifierPart( \"" + c + "\" )" );
            if( isIdentifierStart( c ) )
            {
                return true;
            }
            if( isDigit( c ) )
            {
                return true;
            }
            if( c.charCodeAt( 0 ) < 128 )
            {
                return false;
            }
            return false;
        }
        
        /**
         * Inidcates if the specified character is a line terminator.
         * <p>Note: line terminators</p>
         * <pre class="prettyprint">
         * "\n" - u000A - LF : Line Feed
         * "\R" - u000D - CR : Carriage Return
         * ???  - u2028 - LS : Line Separator
         * ???  - u2029 - PS : Paragraphe Separator
         * </pre>
         * @see ECMA-262 spec 7.3 (PDF p24/188)
         */
        public function isLineTerminator( c:String ):Boolean
        {
            return lineTerminatorChars.indexOf( c ) > -1 ;
        }
        
        /**
         * Indicates if the specified indentifier is a reserved keyword.
         * Reserved Keywords see : <b>ECMA-262 spec 7.5.2 p13 (PDF p25/188)</b>
         */
        public function isReservedKeyword( identifier:String ):Boolean
        {
            debug( "isReservedKeyword( \"" + identifier + "\" )" );
            if( !config.strictMode )
            {
                identifier = identifier.toLowerCase() ;
            }
            if( RESERVED_KEYWORDS.indexOf( identifier ) > -1 )
            {
                log( format( strings.reservedKeyword, identifier ) ) ;
                return true ;
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Indicates if the specified identifier string value is a future reserved keyword.  
         * <p><b>Note :</b> Future Reserved Keywords in ECMA-262 spec 7.5.3</p>
         */
        public function isFutureReservedKeyword( identifier:String ):Boolean
        {
            //debug( "isFutureReservedKeyword( \"" + identifier + "\" )" );
            if( ! config.strictMode )
            {
                identifier = identifier.toLowerCase() ;
            }
            if( FUTUR_KEYWORDS.indexOf( identifier ) > -1 )
            {
                log( format( strings.futurReservedKeyword, identifier ) ) ;
                return true ;
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Indicates if the specified path is valid.
         */
        public function isValidPath( path:String ):Boolean
        {
            debug( "isValidPath( \"" + path + "\" )" );
            var paths:Array = _pathAsArray( path );
            var subpath:String;
            
            var len:int = paths.length ;
            
            for( var i:int ; i < len ; i++ )
            {
                subpath = paths[i];
                if( isReservedKeyword( subpath ) || isFutureReservedKeyword( subpath ) )
                {
                    log( format( strings.notValidPath, path ) );
                    return false;
                }
            }
            if( config.security && !isAuthorized(path) )
            {
                log( format(path, strings.notAuthorizedPath) ) ;
                return config.undefineable;
            }
            return true;
        }
        /**
         * Hook to catch the global trace function call
         */
        protected function trace( message:String ):void
        {
            console.writeLine( message );
        }
        
        debug function traceGlobalPool():void
        {
            trace( "---------------------" );
            trace( "global pool:" );
            for( var member:String in _globalPool )
            {
                trace( member + " = " + _globalPool[member] );
            }
            trace( "---------------------" );
        }
        
        debug function tracePool():void
        {
            trace( "---------------------" );
            trace( "local pool:" );
            for( var member:String in _localPool )
            {
                trace( member );
            }
            trace( "---------------------" );
        }
        
        debug function debug( message:String ):void
        {
            trace( message );
        }
        
        release function traceGlobalPool():void
        {
            //do nothing;
        }
        
        release function tracePool():void
        {
            //do nothing
        }
        
        release function debug( message:String ):void
        {
            //do nothing
        }
        
        /**
         * Replaces the 'search' string with the 'replace' String.
         * @private
         */
        protected function replace( str:String , search:String , replace:String ):String 
        {
            return str.split(search).join(replace) ;
        }
        
        /**
         * @private
         */
        private var _1char:Boolean ;
        
        /**
         * Object Replacement Character
         * @private
         */
        private var _ORC:String = "\uFFFC";
        
        /**
         * @private
         */
        private var _singleValue:Boolean = true;
        
        /**
         * @private
         */
        private var _inAssignement:Boolean ;
        
        // private var _inFunction:Boolean ;
        
        /* note:
        a pool contains string indexes to object references
        (yeah this could be surely optimized with a Dictionnary)
        ex:
        (code)
        _globalPool[ "system.serializers.eden.config" ] = system.serializers.eden.config;
        _localPool[ "x.y.z" ] = localScope.x.y.z;
        (end)
           
         */
        private static var _globalPool:Array = [];
        
        /**
         * @private
         */
        private var _inConstructor:int ;
        
        /**
         * @private
         */
        private var _localPool:Array = [];
        
        /**
         * Indicates if the specified path does exist in the local scope.
         */
        private function _doesExistInLocalScope( path:String ):Boolean
        {
            debug( "doesExistInLocalScope( \"" + path + "\" )" );
            if( _localPool[ path ] != undefined )
            {
                return true;
            }
            
            var scope:* = localscope;
            var paths:Array = _pathAsArray( path );
            var subpath:*;
            var arrayIndex:Boolean;
            var len:int = paths.length ;
            for( var i:int ; i < len ; i++ )
            {
                arrayIndex = false;
                subpath    = paths[i];
                if( isDigitNumber( subpath ) )
                {
                    subpath = parseInt( subpath );
                    arrayIndex = true;
                }
                if( scope[ subpath ] == undefined )
                {
                    return false;
                }
                if( arrayIndex )
                {
                    _localPool[ paths.slice( 0, i ).join( "." ) + "." + subpath ] = scope[ subpath ];
                }
                scope = scope[ subpath ];
            }
            return true;
        }
        
        /**
         * Indicates if the specified path does exist in the global scope.
         */
        private function _doesExistInGlobalScope( path:String ):Boolean
        {
            debug( "doesExistInGlobalScope( \"" + path + "\" )" );
            if( _globalPool[ path ] != undefined )
            {
                traceGlobalPool( );
                return true;
            }
            
            //fix for global function in redtamarin
            if( path.indexOf( "." ) == -1 )
            {
                switch( path )
                {
                    case "decodeURI":
                    {
                        _globalPool[ path ] = decodeURI;
                        return true;
                    }
                    case "decodeURIComponent":
                    {
                        _globalPool[ path ] = decodeURIComponent;
                        return true;
                    }
                    case "encodeURI":
                    _globalPool[ path ] = encodeURI;
                    return true;
                    
                    case "encodeURIComponent":
                    _globalPool[ path ] = encodeURIComponent;
                    return true;
                    
                    case "isNaN":
                    _globalPool[ path ] = isNaN;
                    return true;
                    
                    case "isFinite":
                    _globalPool[ path ] = isFinite;
                    return true;
                    
                    case "parseInt":
                    _globalPool[ path ] = parseInt;
                    return true;
                    
                    case "parseFloat":
                    _globalPool[ path ] = parseFloat;
                    return true;
                    
                    case "escape":
                    _globalPool[ path ] = escape;
                    return true;
                    
                    case "unescape":
                    _globalPool[ path ] = unescape;
                    return true;
                    
                    case "isXMLName":
                    _globalPool[ path ] = isXMLName;
                    return true;
                }
            }
            
            var scope:*;
            var scopepath:String = "";
            var subpath:* = "";
            var paths:Array = _pathAsArray( path );
            var arrayIndex:Boolean;
            
            var foundScope:Boolean ;
            
            var len:int = paths.length ;
            for( var i:int = 0; i < len ; i++ )
            {
                if( ! foundScope )
                {
                    if( i == 0 )
                    {
                        scopepath = paths[i];
                    }
                    else
                    {
                        scopepath += "." + paths[i];
                    }
                    
                    if( _globalPool[ scopepath ] != undefined )
                    {
                        foundScope = true;
                        scope = _globalPool[ scopepath ];
                    }
                    else if( hasClassByName( scopepath ) )
                    {
                        foundScope = true;
                        scope = getDefinitionByName( scopepath );
                        debug( "GLOBAL POOL: " + scopepath );
                        _globalPool[ scopepath ] = scope;
                    }
                }
                else
                {
                    arrayIndex = false;
                    subpath = paths[i];
                    //VirtualMachine.beginTrace();
                    if( isDigitNumber( subpath ) )
                    {
                        subpath = parseInt( subpath );
                        arrayIndex = true;
                    }
                    //VirtualMachine.endTrace();
                    if( scope[ subpath ] == undefined )
                    {
                        return false;
                    }
                    
                    if( arrayIndex )
                    {
                        debug( ">> GLOBAL POOL : " + scopepath + "." + paths[i - 1] + "." + subpath );
                        _globalPool[ scopepath + "." + paths[i - 1] + "." + subpath ] = scope[ subpath ];
                    }
                    else
                    {
                        debug( ">> GLOBAL POOL : " + scopepath + "." + subpath );
                        _globalPool[ scopepath + "." + subpath ] = scope[ subpath ];
                    }
                    scope = scope[ subpath ];
                }
            }
            if( foundScope )
            {
                return true;
            }
            return false;
        }
        
        /* group: scanners */
        
        /**
         * Scan the comments. 
         * - add a log/store mecanism for the comments
         *   so after a parsing we can review all the comments
         * - allow an option to ouput comment strings instead
         *   of the parsing result
         *   -> could be usefull to parse code for documentation
         */
        private function _scanComments():void
        {
            debug( "scanComments()" );
            next() ;
            switch( ch )
            {
                case "/" :
                {
                    comments += "//";
                    while( !isLineTerminator( ch ) && hasMoreChar( ) )
                    {
                        next( );
                        comments += ch;
                    }
                    
                    _scanSeparators( );
                    break;
                }
                case "*" :
                {
                    comments += "/*";
                    var ch_:String = next( );
                    comments += ch_;
                    
                    while( (ch_ != "*") && (ch != "/") )
                    {
                        ch_ = ch;
                        next( );
                        comments += ch ;
                        if( ch == "" )
                        {
                            log( strings.unterminatedComment );
                            break ;
                        }
                    }
                    next( );
                    break;
                }
                case "" :
                default :
                {
                    log( strings.errorComment );
                }
            }
            
        }
        
        /**
         * Scan the separators.
         */
        private function _scanSeparators():void
        {
            debug( "scanSeparators()" );
            var scan:Boolean = true;
            while( scan )
            {
                switch( ch )
                {
                    /* note:
                    White Space
                    "\t" - \u0009 - TAB
                    "\v" - \u000B - VT
                    "\f" - \u000C - FF
                    " "  - \u0020 - SP
                    ???  - \u00A0 - NBSP
                    see: ECMA-262 spec 7.2 (PDF p23/188)
                     */
                    case "\u0009": 
                    case "\u000B": 
                    case "\u000C": 
                    case "\u0020": 
                    case "\u00A0":
                    {
                        next() ;
                        break;
                    }
                    /* note:
                    line terminators
                    "\n" - \u000A - LF
                    "\R" - \u000D - CR
                    ???  - \u2028 - LS
                    ???  - \u2029 - PS
                    see: ECMA-262 spec 7.3 (PDF p24/188)
                     */
                    case "\u000A": 
                    case "\u000D": 
                    case "\u2028": 
                    case "\u2029":
                    {
                        next( );
                        break;
                    }
                    case "/":
                    {
                        _scanComments() ;
                        break;
                    }
                    default:
                    {
                        scan = false ;
                    }
                }
            }
        }
        
        /**
         * Scan the whitespaces.  
         * <p><b>White Space :</b></p>
         * <pre class="prettyprint">
         * "\t" - u0009 - TAB
         * "\v" - u000B - VT
         * "\f" - u000C - FF
         * " "  - u0020 - SP
         * ???  - u00A0 - NBSP
         * </pre>
         * <p><b>See :</b> ECMA-262 spec 7.2 (PDF p23/188)</p>
         */
        private function _scanWhiteSpace():void
        {
            debug( "scanWhiteSpace()" );
            var scan:Boolean = true;
            while( scan )
            {
                switch( ch )
                {
                    case "\u0009": 
                    case "\u000B": 
                    case "\u000C": 
                    case "\u0020": 
                    case "\u00A0":
                    {
                        next( );
                        break;
                    }
                    case "/":
                    {
                        _scanComments( );
                        break;
                    }
                    default:
                    {
                        scan = false;
                    }
                }
            }
        }
        
        /**
         * Scans the identifiers.
         */
        private function _scanIdentifier():String
        {
            debug( "scanIdentifier()" );
            var id:String = "";
            if( isIdentifierStart( ch ) )
            {
                id += ch;
                next( );
                while( isIdentifierPart( ch ) )
                {
                    id += ch;
                    next() ;
                }
            }
            else
            {
                log( strings.errorIdentifier );
            }
            return id;
        }
        
        /**
         * Scan the paths.
         */
        private function _scanPath():String
        {
            debug( "scanPath()" );
            var path:String = "";
            var subpath:String = "";
            if( isIdentifierStart( ch ) )
            {
                path += ch;
                next( );
                while( isIdentifierPart( ch ) || (ch == ".") || (ch == "[") )
                {
                    if( ch == "[" )
                    {
                        next( );
                        _scanWhiteSpace( );
                        if( isDigit( ch ) )
                        {
                            subpath = String( _scanNumber( ) );
                            _scanWhiteSpace( );
                            path += "." + subpath;
                        }
                        else if( (this.ch == "\"") || (this.ch == "\'") )
                        {
                            subpath = _scanString( ch );
                            _scanWhiteSpace( );
                            path += "." + subpath;
                        }
                        
                        if( ch == "]" )
                        {
                            next() ;
                            continue;
                        }
                    }
                    path += ch;
                    next() ;
                }
            }
            
            /*
            if( path.startsWith( "_global." ) )
            {
                path = path.substr( "_global.".length );
            }
             */
            
            /*
            if( !_inConstructor && ch == "(" )
            {
                _inFunction = true;
                return scanFunction( path );
            }
             */
            
            /*
            if( ch == "(" )
            {
                _inFunction = true;
                return scanFunction( path );
            }
             */
            debug( "scanPath returns [" + path + "]" );
            return path;
        }
        
        /* group: evaluators */
        
        /**
         * @private
         */
        private function _pathAsArray( path:String ):Array
        {
            debug( "_pathAsArray( \"" + path + "\" )" ) ;
            var paths:Array;
            if( path.indexOf( "." ) > - 1 )
            {
                paths = path.split( "." ) ;
            }
            else
            {
                paths = [ path ] ;
            }
            debug( "_pathAsArray returns [" + path + "]" );
            return paths;
        }
        
        /**
         * @private
         */
        private function _createPath( path:String ):void
        {
            debug( "_createPath( \"" + path + "\" )" );
            var paths:Array = _pathAsArray( path );
            var prop:* = paths.shift( );
            var subpath:String = "";
            var member:*;
            
            if( localscope[ prop ] == undefined )
            {
                if( isDigitNumber( prop ) )
                {
                    prop = parseInt( prop );
                }
                
                localscope[ prop ] = {};
                _localPool[ prop ] = localscope[ prop ];
            }
            
            if( paths.length > 0 )
            {
                subpath = prop;
                var scope:* = localscope[ prop ];
                
                for( var i:int = 0; i < paths.length ; i++ )
                {
                    member = paths[i];
                    subpath += "." + member;
                    
                    if( isDigitNumber( member ) )
                    {
                        member = parseInt( member );
                    }
                    
                    if( scope[member] == undefined )
                    {
                        scope[member] = {};
                        _localPool[ subpath ] = scope[member];
                    }
                    
                    scope = scope[member];
                }
            }
        }
        
        /**
         * Scans the Strings.
         */
        private function _scanString( quote:String ):String
        {
            debug( "scanString( " + quote + " )" );
            var str:String = "";
            if( ch == quote )
            {
                while( (next( ) != "") )
                {
                    switch( ch )
                    {
                        case quote:
                        {
                            next( );
                            return str;
                        }
                        case "\\":
                        {
                            /* note:
                            Escape Sequence
                            \ followed by one of ' " \ b f n r t v
                            or followed by x hexdigit hexdigit
                            or followed by u hexdigit hexdigit hexdigit hexdigit
                            see: ECMA-262 specs 7.8.4 (PDF p30 to p32/188)
                             */
                            switch( next() )
                            {
                                case "b": 
                                {
                                    str += "\b" ; //backspace \u0008
                                    break;
                                }
                                case "t": 
                                {
                                    str += "\t" ; //horizontal tab \u0009
                                    break;
                                }
                                case "n": 
                                {
                                    str += "\n" ; //line feed \u000A
                                    break;
                                }
                                case "v": 
                                {
                                    str += "\v" ; // vertical tab \u000B /* TODO: check \v bug */
                                    break;
                                }
                                case "f": 
                                {
                                    str += "\f" ; //form feed \u000C
                                    break;
                                }
                                case "r": 
                                {
                                    str += "\r" ; //carriage return \u000D
                                    break;
                                }
                                case "\"": 
                                {
                                    str += "\"" ; //double quote \u0022
                                    break;
                                }
                                case "\'": 
                                {
                                    str += "\'"; //single quote \u0027
                                    break;
                                }
                                case "\\": 
                                {
                                    str += "\\" ; //backslash \u005c
                                    break;
                                }
                                case "u" :
                                { 
                                    //unicode escape sequence \uFFFF
                                    var ucode:String = source.substring( pos, pos + 4 ) ;
                                    str += String.fromCharCode( parseInt( ucode, 16 ) ) ;
                                    pos += 4 ;
                                    break;
                                }
                                case "x" :
                                { 
                                    //hexadecimal escape sequence \xFF
                                    var xcode:String = source.substring( pos, pos + 2 ) ;
                                    str += String.fromCharCode( parseInt( xcode, 16 ) ) ;
                                    pos += 2;
                                    break;
                                }
                                default :
                                {
                                    str += ch ;
                                }
                            }
                            break;
                        }
                        default:
                        {
                            if( ! isLineTerminator( ch ) )
                            {
                                str += ch;
                            }
                            else
                            {
                                log( strings.errorLineTerminator );
                            }
                        }
                    }
                }
            }
            log( strings.errorString );
            return "";
        }
        
        /**
         * Scans Numbers.
         */
        private function _scanNumber():Number
        {
            debug( "scanNumber()" );
            var value:Number;
            
            var num:String = "";
            // var oct:String  = "";
            var hex:String = "";
            var sign:String = "";
            var isSignedExp:String = "";
            
            if( ch == "-" )
            {
                sign = "-";
                next() ;
            }
            
            if( ch == "0" )
            {
                next() ;
                if( (ch == "x") || (ch == "X") )
                {
                    next() ;
                    
                    while( isHexDigit( ch ) )
                    {
                        hex += ch;
                        next() ;
                    }
                    
                    if( hex == "" )
                    {
                        log( strings.malformedHexadecimal );
                        return NaN;
                    }
                    else
                    {
                        return Number( sign + "0x" + hex );
                    }
                }
                else
                {
                    num += "0";
                }
            }
            
            while( isDigit( ch ) )
            {
                num += ch;
                next() ;
            }
            
            if( ch == "." )
            {
                num += ".";
                next( );
                
                while( isDigit( ch ) )
                {
                    num += ch;
                    next() ;
                }
            }
            
            if( ch == "e" )
            {
                num += "e";
                isSignedExp = next( );
                
                if( (isSignedExp == "+") || (isSignedExp == "-") )
                {
                    num += isSignedExp;
                    next( );
                }
                
                while( isDigit( ch ) )
                {
                    num += ch;
                    next() ;
                }
            }
            
            /*
            if( (num.charAt(0) == "0") && isOctalNumber( num ) )
            {
            value = parseInt( sign + num );
            }
            else
            {
            value = Number( sign + num );
            }
             */
            
            /* note:
            we do not support octal numbers anymore
             */
            value = Number( sign + num );
            
            if( !isFinite( value ) )
            {
                log( strings.errorNumber );
                return NaN ;
            }
            else
            {
                return value ;
            }
        }
        
        /**
         * Scans an objet litteral.
         */
        private function _scanObject():Object
        {
            debug( "scanObject()" );
            var obj:Object = {} ;
            var member:String ;
            var value:*;
            if( ch == "{" )
            {
                next() ;
                _scanSeparators( );
                if( ch == "}" )
                {
                    next( );
                    return obj;
                }
                while( ch != "" )
                {
                    member = _scanIdentifier( );
                    _scanWhiteSpace();
                    if( ch != ":" )
                    {
                        break;
                    }
                    
                    next( );
                    _inAssignement = true ;
                    value = _scanValue() ;
                    _inAssignement = false ;
                    if( !isReservedKeyword( member ) && !isFutureReservedKeyword( member ) )
                    {
                        obj[member] = value;
                    }
                    _scanSeparators( );
                    if( ch == "}" )
                    {
                        next( );
                        return obj;
                    }
                    else if( ch != "," )
                    {
                        break;
                    }
                    next() ;
                    _scanSeparators() ;
                }
            }
            log( strings.errorObject );
            return undefined;
        }
        
        /**
         * Scan an array litteral
         */
        private function _scanArray():Array
        {
            debug( "scanArray()" );
            var arr:Array = [];
            
            if( ch == "[" )
            {
                next( );
                _scanSeparators();
                
                if( ch == "]" )
                {
                    next( );
                    return arr;
                }
                
                while( ch != "" )
                {
                    arr.push( _scanValue() );
                    _scanSeparators( );
                    
                    if( ch == "]" )
                    {
                        next() ;
                        return arr;
                    }
                    else if( ch != "," )
                    {
                        break ;
                    }
                    next( );
                    _scanSeparators() ;
                }
            }
            
            log( strings.errorArray );
            return undefined;
        }
        
        /**
         * Scans the Functions.
         */
        private function _scanFunction( fcnPath:String, pool:*, ref:* = null ):*
        {
            if( config.security && !isAuthorized( fcnPath ) )
            {
                log( format( strings.notAuthorizedFunction , fcnPath ) ) ;
                return config.undefineable;
            }
            debug( "scanFunction( " + fcnPath + " )" );
            
            var args:Array = [];
            var fcnName:String;
            var fcnObj:*;
            var fcnObjScope:*;
            
            var isClass:Boolean = pool[ fcnPath ] is Class;
            
            if( fcnPath.indexOf( "." ) > - 1 )
            {
                fcnName = fcnPath.split( "." ).pop();
            }
            else
            {
                fcnName = fcnPath;
            }
            
            if( ! isClass )
            {
                fcnPath = fcnPath.split( "." + fcnName ).join( "" );
            }
            
            _scanWhiteSpace( );
            
            next( );
            
            _scanSeparators( ); // FIXME ???
            
            var foundEndParenthesis:Boolean = false;
            
            while( ch != "" )
            {
                if( ch == ")" )
                {
                    foundEndParenthesis = true;
                    next( );
                    break;
                }
                
                args.push( _scanValue( ) );
                
                _scanSeparators( );
                
                if( ch == "," )
                {
                    next( );
                    _scanSeparators( );
                }
                
                if( (pos == source.length) && (ch != ")") )
                {
                    log( "unterminated parenthesis, check your function/constructor \"" + fcnPath + "\"" );
                    return config.undefineable;
                }
            }
            
            if( ! foundEndParenthesis )
            {
                log( "unterminated parenthesis, check your function/constructor \"" + fcnPath + "\"" );
                return config.undefineable;
            }
            
            if( isClass || (fcnPath == fcnName) )
            {
                fcnObj      = pool[ fcnPath ] ;
                fcnObjScope = null ;
            }
            else
            {
                fcnObj      = pool[ fcnPath ][ fcnName ] ;
                fcnObjScope = pool[ fcnPath ] ;
            }
            
            /*
            if( config.security && !isAuthorized( fcnPath ) )
            {
            log( String.format( strings.notAuthorizedFunction, fcnPath ) );
            return config.undefineable;
            }
            //         else
            //             {
            //             this.debug( fcnPath + " is authorized (scanFunction)" );
            //             }
             */
            if( ! isClass && (ref == null) && (fcnObj == undefined) )
            {
                log( format( strings.doesNotExist, fcnPath ) );
                return config.undefineable;
            }
            else
            {
                
                if( _inConstructor > 0 )
                {
                    _inConstructor-- ;
                    try
                    {
                        return Reflection.invokeClass( fcnObj as Class, args ) ;
                    }
                    catch( e:Error )
                    {
                        log( "malformed ctor - " + e.toString( ) );
                        return config.undefineable;
                    }
                }
                
                var result:*;
                
                if( ref != null )
                {
                    result = ref[ fcnName ].apply( ref, args );
                }
                else
                {
                    result = fcnObj.apply( fcnObjScope, args );
                }
                
                if( ch == "." )
                {
                    next( );
                    return _scanFunction( _scanPath(), pool, result );
                }
                else
                {
                    if( ! config.allowFunctionCall )
                    {
                        log( format( strings.notFunctionCallAllowed, fcnPath, args ) );
                        return config.undefineable;
                    }
                    return result;
                }
            }
            
            
            
            log( strings.errorFunction );
        }
        
        /**
         * Scans the keywords.
         */
        private function _scanKeyword( pre:String = "" ):*
        {
            debug( "scanKeyword( " + pre + " )" );
            
            var word:String = "";
            var baseword:String = _scanPath( );
            
            word = pre + baseword;
            
            if( word == "" )
            {
                return _ORC;
            }
            
            switch( word )
            {
                case "undefined":
                {
                    return config.undefineable;
                }
                case "null": // Null literal
                {
                    return null;
                }
                case "true": // Boolean literal
                {
                    return true ;
                }
                case "false":
                {
                    return false ;
                }
                // Number literals
                /* note:
                here we use shortcuts for common const to speedup the parsing
                but if they were not here they would be parsed just fine ;)
                 */
                case "NaN":
                {
                    return NaN;
                }
                case "-Infinity":
                {
                    return - Infinity;
                }
                case "Infinity"  :
                case "+Infinity" :
                {
                    return Infinity;
                }
                case "new" :
                {
                    _inConstructor ++;
                    _scanWhiteSpace();
                    baseword = _scanPath() ;
                }
                default:
                {
                    var localRef:Boolean = false;
                    var globalRef:Boolean = false;
                    var result:*;
                    
                    if ( config.allowAliases && aliases.containsAlias( baseword ) )
                    {
                        baseword = aliases.getValue(baseword) ;
                    }
                    
                    if( _doesExistInGlobalScope( baseword ) )
                    {
                        globalRef = true;
                    }
                    else if( _doesExistInLocalScope( baseword ) )
                    {
                        localRef = true;
                        _singleValue = false;
                    }
                    else if( isValidPath( baseword ) && ! _inAssignement && ! _inConstructor )
                    {
                        _createPath( baseword );
                        localRef     = true  ;
                        _singleValue = false ;
                    }
                    
                    /* coded in the train listening RUN-DMC "It's Tricky"
                    and refactored listening Ugly Kid joe "too bad" :D
                     */
                    if( ! _inAssignement && (source.indexOf( "=" ) > - 1) )
                    {
                        if( localRef )
                        {
                            _scanLocalAssignement( baseword );
                        }
                        else if( globalRef )
                        {
                            _scanGlobalAssignement( baseword );
                        }
                    }
                    
                    _scanSeparators(); // test the separators between the constructor and the (
                    
                    if( ! localRef && ! globalRef )
                    {
                        log( baseword + " not found in MEMORY!" );
                        return config.undefineable;
                    }
                    
                    if( localRef )
                    {
                        if( ch == "(" )
                        {
                            result = _scanFunction( baseword, _localPool );
                        }
                        else
                        {
                            result = _localPool[ baseword ];
                        }
                        return (pre == "-") ? - result : result;
                    }
                    
                    if( globalRef )
                    {
                        if( ch == "(" )
                        {
                            result = _scanFunction( baseword, _globalPool );
                        }
                        else
                        {
                            result = _globalPool[ baseword ];
                        }
                        return (pre == "-") ? - result : result;
                    }
                    return config.undefineable;
                }
            }
            log( strings.errorKeyword );
        }
        
        /**
         * Scans the global assignement of the specified path.
         */
        private function _scanGlobalAssignement( path:String ):void
        {
            debug( "scanGlobalAssignement( " + path + " )" );
            var scope:*;
            var scopepath:String = "";
            var subpath:* = "";
            var paths:Array = _pathAsArray( path );
            var member:String = paths.pop( );
            var foundScope:Boolean = false;
            var size:int = paths.length ;
            for( var i:int ; i < size ; i++ )
            {
                if( ! foundScope )
                {
                    if( i == 0 )
                    {
                        scopepath = paths[i];
                    }
                    else
                    {
                        scopepath += "." + paths[i];
                    }
                    
                    if( Reflection.hasClassByName( scopepath ) )
                    {
                        foundScope = true;
                        scope = Reflection.getDefinitionByName( scopepath );
                    }
                }
                else
                {
                    subpath = paths[i];
                    
                    if( isDigitNumber( subpath ) )
                    {
                        subpath = parseInt( subpath );
                    }
                    
                    if( scope[ subpath ] == undefined )
                    {
                        return;
                    }
                    
                    scope = scope[ subpath ];
                }
            }
            
            _scanWhiteSpace( );
            
            if( ch == "=" )
            {
                _singleValue = false;
                _inAssignement = true;
                next( );
                _scanWhiteSpace( );
                
                if( isLineTerminator( ch ) )
                {
                    /* TODO: check if undefineable value is not preferable here */
                    log( "assignement = without RHS !" );
                    return;
                }
                
                var value:* = _scanValue( );
                scope[ member ] = value;
                _globalPool[ path ] = scope[member];
                
                _inAssignement = false;
            }
        }
        
        /**
         * Scans the root local assignement of the specified name value..
         */
        private function _scanRootLocalAssignement( name:String ):void
        {
            debug( "scanRootLocalAssignement( " + name + " )" );
            _scanWhiteSpace( );
            
            if( ch == "=" )
            {
                _singleValue = false;
                _inAssignement = true;
                next( );
                //scanWhiteSpace();
                _scanSeparators( );
                
                if( isLineTerminator( ch ) )
                {
                    /* TODO: check if undefineable value is not preferable here */
                    log( "assignement = without RHS !" );
                    return;
                }
                
                var value:* = _scanValue( );
                
                if( value == _ORC )
                {
                    value = config.undefineable;
                }
                
                localscope[ name ] = value;
                _localPool[ name ] = localscope[ name ];
                tracePool( );
                _inAssignement = false;
            }
        }
        
        /**
         * Scans the local assigment of the specified path.
         */
        private function _scanLocalAssignement( path:String ):void
        {
            debug( "scanLocalAssignement( " + path + " )" );
            
            if( path.indexOf( "." ) == - 1 )
            {
                _scanRootLocalAssignement( path );
                return;
            }
            
            var paths:Array = _pathAsArray( path );
            var prop:* = paths.shift( );
            var member:* = paths.pop( );
            
            if( isDigitNumber( prop ) )
            {
                prop = parseInt( prop );
            }
            
            if( isDigitNumber( member ) )
            {
                member = parseInt( member );
            }
            
            var subpath:*;
            var scope:*;
            
            scope = localscope[ prop ];
            
            var size:int = paths.length ;
            for( var i:int ; i < size ; i++ )
            {
                subpath = paths[i];
                
                if( isDigitNumber( subpath ) )
                {
                    subpath = parseInt( subpath );
                }
                
                if( scope[ subpath ] == undefined )
                {
                    return;
                }
                
                scope = scope[ subpath ];
            }
            _scanWhiteSpace( );
            if( ch == "=" )
            {
                _singleValue = false;
                _inAssignement = true;
                next( );
                //scanWhiteSpace();
                _scanSeparators( );
                
                if( isLineTerminator( ch ) )
                {
                    /* TODO: check if undefineable value is not preferable here */
                    log( "assignement = without RHS !" );
                    return;
                }
                
                var value:* = _scanValue( );
                scope[ member ] = value;
                _localPool[ path ] = scope[ member ];
                tracePool( );
                _inAssignement = false;
            }
        }
        
        /**
         * Scans the values.
         */
        private function _scanValue():*
        {
            debug( "scanValue() - ch:" + ch );
            _scanSeparators( );
            debug( "after scan - ch:" + ch );
            
            if( (pos == source.length) && !_1char )
            {
                debug( "prevent unecessary scan" );
                if( _inAssignement )
                {
                    debug( "RHS is missing" );
                }
                return;
            }
            
            switch( ch )
            {
                case "{" :
                {
                    return _scanObject() ;
                }
                case "[" :
                {
                    return _scanArray() ;
                }
                case "\"" : 
                case "\'" :
                {
                    return _scanString( ch );
                }
                case "-" : 
                case "+" :
                {
                    if( isDigit( source.charAt( pos ) ) )
                    {
                        return _scanNumber( );
                    }
                    else
                    {
                        var ch_:String = ch;
                        next( );
                        return _scanKeyword( ch_ );
                    }
                }
                case "0": 
                case "1": 
                case "2": 
                case "3": 
                case "4":
                case "5": 
                case "6": 
                case "7": 
                case "8": 
                case "9":
                {
                    return _scanNumber() ;
                }
                default:
                {
                    return _scanKeyword() ;
                }
            }
        }
    }
}