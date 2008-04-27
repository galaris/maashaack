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
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):

    - Marc ALCARAZ <ekameleon@gmail.com>

*/
package system.evaluators
    {
    
    import system.Strings;
    
    /**
    * Evaluates mathematical string expressions.
    */
    public class MathEvaluator implements IEvaluator
        {
        use namespace mathparser;
        
        public function MathEvaluator( context:Object = null )
            {
            if( context != null )
                {
                _context = context;
                }
            }

        public function eval( o:* ):*
            {
            return parse( o );
            }
        
        
        /* MathParser implementation */
        
        /* notes:
           we support all of the following
           
           - decimal, hexadecimal, octal notation:
             1 + 1
             0.5 + 0.7
             0xff + 0xbb
             010 + 5
             etc.
             
           - operators:
             * / %
             + -
             << >> >>>
             & ^ | ~
           
           - functions:
             abs acos asin atan atan2
             ceil cos
             exp
             floor
             log
             max min
             pow
             random round
             sin sqrt
             tan
             
             those functions replicate exactly what you can find
             in the Math object.
             
           - operators priority:
             from higher to lower priority
             ex: multiplication is performed before addition
             
             (14) fcn(...) (...)
                  function call and expression grouping
             
             ex: sin(4) + 25
             sin(4) will be evaluated first
             
             ex: 5 * (4 + 0.5)
             the expression within the parenthesis will occurs first
             
             (13) ~ + -
                  unary operators
             
             ex: +5 - +5 translate to (+5) - (+5)
             ex: -5 + -5 translate to (-5) + (-5)
             ex: ~3 - 7  translate to (~3) - 7
             any unary operators will be evaluated first
             
             (12) * / %
                  multiplication, division, modulo division
             
             ex: 5 * 3 + 1 translate to (5 * 3) + 1
             ex: 2 % 8 - 4 translate to (2 % 8) - 4
             
             (11) + -
                  addition, subtraction
             
             (10) << >> <<<
                  bit shifting
             
             (7)  &
                  bitwise AND
             
             (6)  ^
                  bitwise XOR
             
             (5)  |
                  bitwise OR
             
           - context
             when instanciating the MathEvaluator you can pass a context
             containing either variables or functions
             
             ex:
             var me:MathEvaluator = new MathEvaluator( {x:100, test:function(a:Number):Number {return a*a;} );
             trace( me.eval( "test(100) + 1" ) ); //return 10001
             
             but there are some limitations
              * your variable or function name must me lowercase
              * your variable or function name must contains only letter from a to z
                and can end with only one digit
                ex:
                test()  //OK
                test2() //OK
                2test() //BAD
                te2st() //BAD
                etc.
              * your function can only have one argument
              * your function name can not override default math functions as cos, sin, etc.
        
        
        we do not support logical ( || && !)
        or assignement operators (= == += etc.)
        
        reasons:
         * logical operators deal with boolean, here we want to deal only with numbers and math expression
         * we do not support variables nor variable assignation
        
        
        Parenthesis are used to alter the order of evaluation determined by operator precedence.
        Operators with the same priority are evaluated left to right.
        
        how the parser work:
        1) we first filter some multiple char operators to single chars
           ex: << translate to «
           and other filtering
           
        2) then we parse char by char (top to bottom parsing)
           to generate tokens in postfix order (reverse polish notation)
           the expression 5 + 4 become [5,4,+]
           but while doing that we also do a lot of other things
           - evaluate function call
           - remove space chars
           - re-order tokens by operators priority
           - evaluate  hexadecimal notation to decimal
           - etc.
           
        3) finally we iterate trough our tokens
           and evaluate them by operators
           ex: [5,4,+]
           we find the op +, then addition the 2 values
           etc.
           till the end of the tokens list
        
        */
        
        private namespace mathparser;
        private var _value:Number = 0;
        private var _context:Object = {};
        
        mathparser const maxHexValue:Number = 0xFFFFFF;
        
        mathparser var expression:String;
        mathparser var currentPos:uint;
        mathparser var tokens:Array;
        
        mathparser function isDigit( c:String ):Boolean
            {
            return ("0" <= c) && (c <= "9");
            }
        
        mathparser function isHexDigit( c:String ):Boolean
            {
            return isDigit( c ) || (("A" <= c) && (c <= "F")) || (("a" <= c) && (c <= "f"));
            }
        
        mathparser function isOctalDigit( c:String ):Boolean
            {
            return ("0" <= c) && (c <= "7");
            }
        
        mathparser function isOperator( c:String ):Boolean
            {
            switch( c )
                {
                case "*": case "/": case "%":
                case "+": case "-":
                case "«": case "»": case "›":
                case "&": case "^": case "|":
                case "sin":
                return true;
                
                default:
                return false;
                }
            }
        
        mathparser function isAlpha( c:String ):Boolean
            {
            return (("A" <= c) && (c <= "Z")) || (("a" <= c) && (c <= "z"));
            }
        
        mathparser function hasMoreChar():Boolean
            {
            return currentPos < expression.length;
            }
        
        mathparser function getChar( pos:int = -1 ):String
            {
            if( pos < 0 )
                {
                pos = currentPos;
                }
            
            return expression.charAt( pos );
            }
        
        mathparser function getNextChar():String
            {
            currentPos++;
            return getChar();
            }
        
        mathparser function addToNextToken( value:String ):void
            {
            tokens.push( value );
            }
        
        mathparser function addToLastToken( value:String ):void
            {
            tokens[ tokens.length-1 ] += value;
            }
        
        mathparser function getLastToken():String
            {
            return tokens[ tokens.length-1 ];
            }
        
        mathparser function getValue( num:String ):Number
            {
            var ch0:String;
            var ch1:String;
            var isBitNot:Boolean = false;
            var isNeg:String     = "";
            
            if( num.charAt(0) == "~" )
                {
                num      = num.substr(1);
                isBitNot = true;
                }
            
            if( num.charAt(0) == "-" )
                {
                num   = num.substr(1);
                isNeg = "-";
                }
            
            ch0 = num.charAt(0);
            ch1 = num.charAt(1);
            
            if( (ch0 == "0") && num.length > 1 )
                {
                if( isOctalDigit( ch1 ) && (num.indexOf(".") == -1) && (num.indexOf("e") == -1) )
                    {
                    if( isBitNot )
                        {
                        return ~parseInt( isNeg + num );
                        }
                    else
                        {
                        return parseInt( isNeg + num );
                        }
                    }
                }
            
            if( isBitNot )
                {
                return ~Number( isNeg + num );
                }
            else
                {
                return Number( isNeg + num );
                }
            
            }
        
        mathparser function getFunctionValue( name:String, expressions:Array ):String
            {
            var args:Array = [];
            var me:MathEvaluator = new MathEvaluator( _context );
            
            for( var i:uint = 0; i<expressions.length; i++ )
                {
                if( expressions[i] != "" )
                    {
                    args.push( me.eval( expressions[i] ) );
                    }
                }
            
            switch( name )
                {
                case "abs":
                return String( Math.abs( args[0] ) );
                break;
                
                case "acos":
                return String( Math.acos( args[0] ) );
                break;
                
                case "asin":
                return String( Math.asin( args[0] ) );
                break;
                
                case "atan":
                return String( Math.atan( args[0] ) );
                break;
                
                case "atan2": //2
                return String( Math.atan2( args[0], args[1] ) );
                break;
                
                case "ceil":
                return String( Math.ceil( args[0] ) );
                break;
                
                case "cos":
                return String( Math.cos( args[0] ) );
                break;
                
                case "exp":
                return String( Math.exp( args[0] ) );
                break;
                
                case "floor":
                return String( Math.floor( args[0] ) );
                break;
                
                case "log":
                return String( Math.log( args[0] ) );
                break;
                
                case "max": //2
                return String( Math.max( args[0], args[1] ) );
                break;
                
                case "min": //2
                return String( Math.min( args[0], args[1] ) );
                break;
                
                case "pow": //2
                return String( Math.pow( args[0], args[1] ) );
                break;
                
                case "random": //0
                return String( Math.random() );
                break;
                
                case "round":
                return String( Math.round( args[0] ) );
                break;
                
                case "sin":
                return String( Math.sin( args[0] ) );
                break;
                
                case "sqrt":
                return String( Math.sqrt( args[0] ) );
                break;
                
                case "tan":
                return String( Math.tan( args[0] ) );
                break;
                
                default:
                if( _context[ name ] )
                    {
                    return _context[ name ]( args[0] );
                    }
                }
            
            return "";
            }
        
        mathparser function getVariableValue( name:String ):String
            {
            if( _context[ name ] )
                {
                return _context[ name ];
                }
            
            return "";
            }
        
        mathparser function filterSpecialChars( expression:String ):String
            {
            /* note:
               for case 1E5, SIN(4), 0Xff, etc.
            */
            expression = expression.toLowerCase();
            
            /* note:
               optimize multi char to single char
            */
            expression = expression.split( "<<" ).join( "«" );
            expression = expression.split( ">>>" ).join( "›" );
            expression = expression.split( ">>" ).join( "»" );
            
            /* note:
               for case +5 - +5 -> +5 - 5
            */
            expression = expression.split( "- +" ).join( "- " );
            
            /* note:
               for case +-5 * -+10 -> -5 * -10 
            */
            expression = expression.split( "+-" ).join( "-" );
            expression = expression.split( "-+" ).join( "-" );
            
            return expression;
            }
        
        mathparser function getParenthesisBlock():Array
            {
            var startNode:uint = 0;
            var endNode:uint   = 0;
            
            var expressions:Array = ["",""];
            var num:uint  = 0;
            var ch:String = "";
            
            for( ;; )
                {
                ch = getNextChar();
                
                switch( ch )
                    {
                    case "(":
                    startNode++;
                    expressions[num] += ch;
                    break;
                    
                    case ")":
                    endNode++;
                    expressions[num] += ch;
                    break;
                    
                    case ",":
                    num++;
                    break;
                    
                    default:
                    expressions[num] += ch;
                    }
                
                if( startNode == endNode )
                    {
                    break;
                    }
                
                }
            
            currentPos++;
            expressions[0] = expressions[0].substr( 1 ); //remove the first (
            expressions[num] = expressions[num].substr( 0, expressions[num].length-1 ); //remove the last ) 
            return expressions;
            }
        
        mathparser function getOperatorPriority( op:String ):uint
            {
            /* note:
               function call and expression grouping priorities
               and unary priorities
               are dealt inside toPostfixNotation().
            */
            switch( op )
                {
                case "*":
                case "/":
                case "%":
                return 12;
                
                case "+":
                case "-":
                return 11;
                
                case "«": // <<
                case "»": // >>
                case "›": // >>>
                return 10;
                
                case "&": //bitwise AND
                return 7;
                
                case "^": //bitwise XOR
                return 6;
                
                case "|": //bitwise OR
                return 5;
                
                default:
                return 0;
                }
            }
        
        mathparser function toPostfixNotation():void
            {
            var ch:String;
            var ch2:String;
            var bitNot:String;
            var neg:String;
            var opr:String;
            var hex:String;
            var dot:Boolean;
            var exp:Boolean;
            var digit:String;
            
            var stack:Array = [];
            
            while( hasMoreChar() )
                {
                ch = getChar();
                
                bitNot = "";
                neg    = "";
                
                switch( ch )
                    {
                    case " ":
                    case "\t":
                    case "\r":
                    case "\n":
                    currentPos++;
                    break;
                    
                    case "(":
                    stack.push( ch );
                    currentPos++;
                    break;
                    
                    case ")":
                    opr = stack.pop();
                    
                    while( opr != "(" )
                        {
                        addToNextToken( opr );
                        opr = stack.pop();
                        }
                    
                    currentPos++;
                    break;
                    
                    case "*": case "/": case "%":
                    case "+": case "-":
                    case "«": case "»": case "›": // << >> >>>
                    case "&": case "^": case "|":
                    if( stack.length != 0 )
                        {
                        opr = stack.pop();
                        
                        while( getOperatorPriority( opr ) >= getOperatorPriority( ch ) )
                            {
                            addToNextToken( opr );
                            opr = stack.pop();
                            }
                        
                        stack.push( opr );
                        stack.push( ch );
                        addToNextToken( "" );
                        }
                    else
                        {
                        stack.push( ch );
                        addToNextToken( "" );
                        }
                    
                    currentPos++;
                    break;
                    
                    case "0": case "1": case "2": case "3": case "4":
                    case "5": case "6": case "7": case "8": case "9":
                    case "~":
                    if( tokens.length == 0 )
                        {
                        addToNextToken( "" );
                        }          
                    
                    /* note:
                       unary priorities
                    */
                    if( ch == "~" )
                        {
                        bitNot = "~";
                        ch = getNextChar();
                        }
                    
                    if( ch == "+" )
                        {
                        ch = getNextChar();
                        }
                    
                    if( ch == "-" )
                        {
                        neg = "-";
                        ch  = getNextChar();
                        }
                    
                    if( ch == "0" )
                        {
                        while( ch == "0" )
                            {
                            ch = getNextChar();
                            }
                        
                        currentPos--;
                        ch = getChar();
                        }
                    
                    ch2 = getChar( currentPos + 1 );
                    
                    if( (ch == "0") && (ch2 == "x") )
                        {
                        hex         = "";
                        currentPos += 2;
                        ch          = getChar();
                        
                        while( isHexDigit( ch ) )
                            {
                            hex += ch;
                            ch   = getNextChar();
                            }
                        
                        if( hex.length > maxHexValue )
                            {
                            hex = hex.substr( 0, maxHexValue );
                            }
                        
                        if( hex == "" )
                            {
                            hex = "0";
                            }
                        
                        addToLastToken( bitNot + neg + "0x" + hex );
                        }
                    else
                        {
                        dot   = false;
                        exp   = false;
                        digit = "";
                        
                        while( isDigit( ch ) || (ch == ".") || (ch == "e") )
                            {
                            if( ch == "e" )
                                {
                                if( exp )
                                    {
                                    ch = getNextChar();
                                    continue;
                                    }
                                
                                exp    = true;
                                digit += ch;
                                ch     = getNextChar();
                                
                                if( (ch == "+") || (ch == "-") )
                                    {
                                    digit += ch;
                                    ch     = getNextChar();
                                    }
                                
                                continue;
                                }
                            
                            if( ch == "." )
                                {
                                if( dot )
                                    {
                                    ch = getNextChar();
                                    continue;
                                    }
                                
                                dot = true;
                                }
                            
                            digit += ch;
                            ch     = getNextChar();
                            }
                        
                        addToLastToken( bitNot + neg + digit );
                        }
                    
                    break;
                    
                    case "a": //abs, acos, asin, atan, atan2
                    case "b":
                    case "c": //ceil, cos
                    case "d":
                    case "e": //exp
                    case "f": //floor
                    case "g":
                    case "h":
                    case "i":
                    case "j":
                    case "k":
                    case "l": //log
                    case "m": //max, min
                    case "n":
                    case "o":
                    case "p": //pow
                    case "q":
                    case "r": //random, round
                    case "s": //sin, sqrt
                    case "t": //tan
                    case "u":
                    case "v":
                    case "w":
                    case "x":
                    case "y":
                    case "z":
                    
                    var name:String = ch;
                    
                    while( isAlpha( ch ) )
                        {
                        ch = getNextChar();
                        if( isAlpha( ch ) || isDigit( ch ) )
                            {
                            name += ch;
                            }
                        else
                            {
                            currentPos--;
                            }
                        }
                    
                    if( tokens.length == 0 )
                        {
                        addToNextToken( "" );
                        }
                    
                    var peek:String = getChar( currentPos + 1 );
                    
                    if( Strings.endsWith( peek, "(" ) )
                        {
                        addToLastToken( getFunctionValue( name , getParenthesisBlock() ) );
                        }
                    else
                        {
                        addToLastToken( getVariableValue( name ) );
                        currentPos++;
                        }
                    
                    break;
                    
                    
                    default:
                    /* NOTE: by default we ignore anyother chars */
                    currentPos++;
                    }
                
                }
            
            while( stack.length != 0 )
                {
                opr = stack.pop();
                
                if( opr != "" )
                    {
                    addToNextToken( opr );
                    }
                }
            
            if( (getLastToken() == "") || (getLastToken() == null) )
                {
                tokens.pop();
                }
            
            if( tokens.length%2 == 0 )
                {
                tokens.unshift( "0" );
                }
            
            //trace( "RPN: ["+this.tokens+"]" );
            }
        
        mathparser function evaluate():Number
            {
            var op:String;
            var value:*;
            var valueA:*;
            var valueB:*;
            
            for( var i:uint = 0; i < tokens.length; i++ )
                {
                op    = tokens[i];
                value = null;
                
                if( isOperator( op ) )
                    {
                    valueA = getValue( tokens[ i-2 ] );
                    valueB = getValue( tokens[ i-1 ] );
                    
                    switch( op )
                        {
                        case "+":
                        value = valueA + valueB;
                        break;
                        
                        case "-":
                        value = valueA - valueB;
                        break;
                        
                        case "*":
                        value = valueA * valueB;
                        break;
                        
                        case "/":
                        value = valueA / valueB;
                        break;
                        
                        case "%":
                        value = valueA % valueB;
                        break;
                        
                        case "^":
                        value = valueA ^ valueB;
                        break;
                        
                        case "&":
                        value = valueA & valueB;
                        break;
                        
                        case "|":
                        value = valueA | valueB;
                        break;
                        
                        case "«": // <<
                        value = valueA << valueB;
                        break;
                        
                        case "»": // >>
                        value = valueA >> valueB;
                        break;
                        
                        case "›": // >>>
                        value = valueA >>> valueB;
                        break;
                        
                        default:
                        /* NOTE: this CANNOT happen */
                        trace( "## ERROR : unsupported operator \"" + op + "\" ##" );
                        }
                    }
                
                if( value != null )
                    {
                    tokens.splice( i-2, 3, value );
                    return evaluate();
                    }
                }
            
            if( tokens.length > 1 )
                {
                return evaluate();
                }
            else
                {
                return getValue( tokens[0] );
                }
            }
        
        mathparser function reset():void
            {
            expression = "";
            currentPos =  0;
            tokens     = [];
            }
        
        mathparser function parse( expression:String ):Number
            {
            reset();
            this.expression = filterSpecialChars( expression );
            toPostfixNotation();
            return evaluate();
            }
        
        }
    }

