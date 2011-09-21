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

package system.formatters 
{
    import core.strings.indexOfAny;
    import core.strings.padLeft;
    import core.strings.padRight;
    
    import system.Formattable;
    import system.evaluators.EdenEvaluator;
    import system.evaluators.MultiEvaluator;
    
    /** 
     * Format a string using indexed, named and/or evaluated parameters.
     * <p>Replaces the pattern item in a specified String with the text equivalent of the value of a specified Object instance.</p>
     * <p>Formats item : {token[,alignment][:paddingChar]}</p>
     * <p>If you want to escape the "{" and "}" chars use "{{" and "}}"
     * <li>"some {{formatitem}} to be escaped" -> "some {formatitem} to be escaped"</li>
     * <li>"some {{format {0} item}} to be escaped", "my" -> "some {format my titem} to be escaped"</li>
     * </p>
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.formatters.StringFormatter ;
     * import system.evaluators.DateEvaluator ;
     * import system.evaluators.EdenEvaluator ;
     * import system.evaluators.MathEvaluator ;
     * 
     * var formatter:StringFormatter = new StringFormatter() ;
     * 
     * var result:String ;
     * 
     * // indexed from the arguments
     * 
     * formatter.parameters = ["big", "the"] ;
     * trace( formatter.format( "hello {1} {0} world" ) ) ; //"hello the big world"
     *
     * formatter.parameters = [41] ;
     * trace( formatter.format( "Brad's dog has {0,6:#} fleas." )  ) ;
     *
     * formatter.parameters = [12] ;
     * trace( formatter.format( "Brad's dog has {0,-6} fleas." ) ) ;
     *
     * formatter.parameters = ["a", "b", "c", "d"] ;
     * trace( formatter.format( "{3} {2} {1} {0}" ) ) ;
     * 
     * // named from an object
     *
     * formatter.parameters = [ { name : "HAL" } ] ; 
     * trace( formatter.format( "hello I'm {name}" ) ) ; //"hello I'm HAL"
     * 
     * // indexed from an array
     * 
     * var names:Array = ["A","B","C","D"];
     * var scores:Array = [16,32,128,1024];
     * for( var i:int=0; i$lt;names.length; i++ )
     * {
     *     formatter.parameters = [ names[i], scores[i] ] ;
     *     trace( formatter.format( "{0} scored {1,5}" ) );
     * }
     * // "A scored    16"
     * // "B scored    32"
     * // "C scored   128"
     * // "D scored  1024"
     * 
     * // resolve toString
     * var x:Object = {};
     * x.toString = function() { return "john doe"; } ;
     * 
     * formatter.parameters = [ x ] ;
     * trace( formatter.format( "Who is {0} ?" ) ) ; //"Who is john doe ?"
     * 
     * // you can off course reuse the index
     * formatter.parameters = ["apple", "banana", "pineapple"] ;
     * trace( formatter.format( "I like all fruits {0},{1},{2}, etc. but still I prefer above all {0}" ) ); // "I like all fruits apple,banana,pineapple, etc. but still I prefer above all apple"
     * 
     * // indexed from an array + the arguments
     * formatter.parameters = [ ["apple", "banana", "pineapple"] , "grape", "tomato" ];
     * trace( formatter.format( "fruits: {0}, {1}, {2}, {3}, {4}" ) ); //"fruits: apple, banana, pineapple, grape, tomato
     * 
     * // passing reference and padding
     * 
     * var what = "answer" ;
     * formatter.parameters = [ {answer:"my answer"} , what  ] ;
     * trace( formatter.format( "your {0} is within {answer,20:.}" ) ) // "your answer is within ...........my answer"
     * 
     * // using evaluated parameters
     * formatter.parameters = null ;
     * formatter.evaluators = { math: new MathEvaluator() };
     * trace( formatter.format( "my result is ${2+3}math$" ) ) ; // "my result is 5"
     * 
     * //by default evaluated parameters use EdenEvaluator with serialized result
     * formatter.parameters = null ;
     * formatter.evaluators = null ;
     * trace( formatter.format( "here some object '${ {a:1,b:2} }$'" ) ) ; //"here some object '{a:1,b:2}'"
     * 
     * //use EdenEvaluator with stringified result
     * formatter.parameters = null ;
     * formatter.evaluators = { math: new EdenEvaluator(false) };
     * trace( formatter.format( "here some object '${ {a:1,b:2} }eden$'" ) ) ; //"here some object '[object Object]'"
     * trace( formatter.format( "the host is ${system.Environment.host}eden$" ) ); //"the host is Flash 9.0.115.0"
     * 
     * //use chained evaluators
     * formatter.parameters = null ;
     * formatter.evaluators = { eden: new EdenEvaluator(false), date: new DateEvaluator() ];
     * trace( formatter.format( "my date is ${new Date(2007,4,22,13,13,13)}eden,date$" ) ) ; //"my date is 22.05.2007 13:13:13"
     * </pre>
     */
    public class StringFormatter implements Formattable 
    {
        /**
         * Creates a new StringFormatter instance.
         */
        public function StringFormatter( parameters:Array = null , source:String = null , evaluators:Object = null )
        {
            this.evaluators = evaluators || {} ;
            this.parameters = parameters ;
            this.source     = source ;
        }
        
        /**
         * Contain a list of evaluators to be used in Strings.format
         * ex:
         * Strings.evaluators = { math: new MathEvaluator() };
         * Strings.format( "my result is ${2+3}math$" ); // "my result is 5"
         * 
         * note:
         * property names in the evaluators object can only contains
         * lower case alphabetical chars and digit chars
         */
        public var evaluators:Object = {} ;
        
        /**
         * The parameters used in the formatter.
         */
        public var parameters:Array ;
        
        /**
         * The source to format.
         */
        public var source:String ;
        
        /**
         * Formats the specified value.
         * @param value The object to format.
         * @return the string representation of the formatted value. 
         */
        public function format( value:* = null ):String
        {
            if ( value )
            {
                source = value ;
            }
            
            output = source ;
            
            var indexedValues:Array = [] ;
            var namedValues:Object  = {} ;
            
            if( !output || output == "" )
            {
                return "" ;
            }
            
            var evaluated:Object = _evaluate();
            
            if( evaluated != null && (evaluated.indexes.length == 0) && ((parameters == null) || (parameters.length == 0)) )
            {
                return output ; //nothing to format
            }
            
            var params:Array = [].concat(parameters) ;
            
            output = evaluated.format;
            
            if( params.length >= 1 )
            {
                if( params[0] is Array )
                {
                    indexedValues = indexedValues.concat( params[0] );
                    params.shift( );
                }
                else if( (params[0] is Object) && (String( params[0] ) == "[object Object]") )
                {
                    for( var prop:String in params[0] )
                    {
                        namedValues[ prop ] = params[0][ prop ];
                    }
                    params.shift() ;
                }
            }
            indexedValues = indexedValues.concat( params );
            if( indexedValues.length - 1 >= _hiddenIndex )
            {
                /* TODO:
                throw an error here ?
                 */
                trace( "## Warning : indexed tokens are too big ##" );
            }
            var l:int = evaluated.indexes.length ;
            for( var i:int = 0 ; i < l ; i++ )
            {
                indexedValues[ (_hiddenIndex + i) ] = evaluated.indexes[i];
            }
            
            var ORC1:String = "\uFFFC"; 
            //Object Replacement Character
            var ORC2:String = "\uFFFD"; 
            //Object Replacement Character
            if( indexOfAny( output, [ "{{", "}}" ] ) > - 1 )
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
                output = output.split( "{{{" ).join( ORC1 + "{" );
                output = output.split( "{{" ).join( ORC1 );
                output = output.split( "}}}" ).join( "}" + ORC2 );
                output = output.split( "}}" ).join( ORC2 );
            }
            
            var formated:String = _format( indexedValues, namedValues ) ;
            
            if( indexOfAny( output, [ ORC1, ORC2 ] ) > - 1 )
            {
                formated = formated.split( ORC1 ).join( "{" );
                formated = formated.split( ORC2 ).join( "}" );
            }
            
            return formated;
        }
        
        /**
         * @private
         */
        private static const _defaultEvaluator:EdenEvaluator = new EdenEvaluator();
        
        /**
         * @private
         */
        private static const _mEvaluators:MultiEvaluator = new MultiEvaluator();
        
        /**
         * The formatter can take index from 0 to infinity {0}, {1}, ..., {99}, etc. 
         * but _evaluate need to sync its indexes with the _format _indexes
         * so we pick an arbitrary number: 100
         * officially indexed token can go from {0} to {99}
         * to avoid a conflict with that arbitrary number.
         */
        private static var _hiddenIndex:uint = 100;
        
        /* internal:
        supported format
        ${...}$ default to EdenEvaluator
        ${...}name1,name2,...$
        
        TODO:
        there are no test for }...$ sequence
        so yeah it's weak and yeah you could break it with something like
        ${{a:1,b:"}",c:"$"}}$
         */
        private function _evaluate():Object
        {
            var obj:Object = 
            {
                format  : "" ,
                indexes : []
            };
            
            _mEvaluators.clear() ;
            
            var evalSequence:String = "" ;
            var evalString:String   = "" ;
            var inBetween:String    = "" ;
            
            var pos1:int;
            var pos2:int;
            var lpos:int;
            
            while( output.indexOf( "${" ) > - 1 )
            {
                pos1 = output.indexOf( "${" );
                pos2 = output.indexOf( "$", pos1 + 2 );
                if( pos2 == - 1 )
                {
                    throw new ( "malformed evaluator, could not find [$] after [}]." );
                }
                evalSequence = output.slice( pos1 + 2, pos2 );
                lpos         = evalSequence.lastIndexOf( "}" );
                inBetween    = evalSequence.substring( lpos + 1 );
                while( ! isValid( inBetween ) )
                {
                    pos2 = output.indexOf( "$", pos1 + 2 + pos2 );
                    if( pos2 == - 1 )
                    {
                        throw new Error( "malformed evaluator, could not find [$] after [}]." );
                    }
                    evalSequence = output.slice( pos1 + 2, pos2 );
                    lpos = evalSequence.lastIndexOf( "}" );
                    inBetween = evalSequence.substring( lpos + 1 );
                }
                if( lpos != evalSequence.length - 1 )
                {
                    var tmp:String = evalSequence.substring( lpos + 1 );
                    var evaluatorsAlias:Array;
                    if( tmp.indexOf( "," ) > - 1 )
                    {
                        evaluatorsAlias = tmp.split( "," );
                    }
                    else
                    {
                        evaluatorsAlias = [ tmp ];
                    }
                    var l:int = evaluatorsAlias.length ;
                    for( var i:uint = 0 ; i < l ; i++ )
                    {
                        if( evaluators[ evaluatorsAlias[i] ] )
                        {
                            _mEvaluators.add( evaluators[ evaluatorsAlias[i] ] );
                        }
                        else
                        {
                            /* TODO:
                            throw an error here ?
                             */
                            trace( "## Warning: \"" + evaluatorsAlias[i] + "\" is not a valid evaluator ##" );
                        }
                    }
                }
                
                if( _mEvaluators.size() == 0 )
                {
                    _mEvaluators.add( _defaultEvaluator ) ;
                }
                evalString = evalSequence.substring( 0, lpos );
                obj.indexes.push( _mEvaluators.eval( evalString ) );
                output = output.split( "${" + evalSequence + "$" ).join( "{" + (_hiddenIndex + (obj.indexes.length - 1)) + "}" );
            }
            obj.format = output;
            return obj;
        }
        
        /**
         * @private
         */
        private static function isValidChar( c:String ):Boolean
        {
            if( (("a" <= c) && (c <= "z")) || (("0" <= c) && (c <= "9")) || (c == ",") )
            {
                return true;
            }
            return false;
        };
        
        /**
         * @private
         */
        private static function isValid( str:String ):Boolean
        {
            if( str == "" )
            {
                return true;
            }
            var test:Array = str.split( "" );
            var l:int      = test.length ;
            for( var i:int = 0; i < l ; i++ )
            {
                if( ! isValidChar( test[i] ) )
                {
                    return false;
                } 
            }
            return true;
        };
        
        /**
         * @private
         */
        protected var ch:String ;
        
        /**
         * The source to format.
         */
        protected var output:String ;
        
        /**
         * @private
         */
        protected var pos:int ;
        
        /* internal:
        supported format
        {0} {1}
        {0,5} {0,-5}
        {0,5:_} {0,-5:_}
        {toto} {titi}
        {toto,5} {toto,-5}
        {titi,5:_} {titi,-5:_}
           
        TODO:
        to {0,5} {0,-5} add something like {0,~5} to support padding to center
         */
        private function _format( indexed:Array, named:Object, paddingChar:String = " " ):String
        {
            var expression:String = "" ;
            var formated:String   = "" ;
            var len:int           = output.length;
            ch  = "" ;
            pos = 0  ;
            while( pos < len )
            {
                next();
                if( ch == "{" )
                {
                    expression = next() ;
                    while( next() != "}" )
                    {
                        expression += ch;
                    }
                    formated += _parseExpression( expression , indexed , named , paddingChar );
                }
                else
                {
                    formated += ch;
                }
            }
            return formated;
        }
        
        /**
         * @private
         */
        protected function next():String
        {
            ch = output.charAt( pos );
            pos++;
            return ch;
        };
        
        /**
         * @private
         */
        private function _parseExpression( expression:String , indexed:Array , named:Object, paddingChar:String = " " ):String
        {
            var value:String      = "" ;
            var spaceAlign:int    = 0 ;
            var isAligned:Boolean = false ;
            var padding:String    = paddingChar ;
            if( indexOfAny( expression, [ ",", ":" ] ) > - 1 )
            {
                var vPos:int = expression.indexOf( "," );
                if( vPos == - 1 )
                {
                    throw new Error( "malformed format, could not find [,] before [:]." );
                }
                
                var fPos:int = expression.indexOf( ":" );
                
                if( fPos == - 1 )
                {
                    spaceAlign = int( expression.substr( vPos + 1 ) );
                }
                else
                {
                    spaceAlign = int( expression.substring( vPos + 1, fPos ) );
                    padding = expression.substr( fPos + 1 );
                }
                
                isAligned = true;
                expression = expression.substring( 0, vPos );
            }
            
            var c:String = expression.split( "" )[0];
            if( (("A" <= c) && (c <= "Z")) || (("a" <= c) && (c <= "z")) )
            {
                value = String( named[ expression ] );
            }
            else if( ("0" <= c) && (c <= "9") )
            {
                value = String( indexed[ int( expression ) ] );
            }
            if( isAligned )
            {
                if( (spaceAlign > 0) && (value.length < spaceAlign) )
                {
                    value = padLeft( value, spaceAlign, padding );
                }
                else if ( spaceAlign < - value.length )
                {
                    value = padRight( value, - spaceAlign, padding );
                }
            }
            return value;
        }
    }
}
