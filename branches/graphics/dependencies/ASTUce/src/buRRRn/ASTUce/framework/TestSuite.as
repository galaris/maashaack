
/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [ASTUce: ActionScript Test Unit compact edition AS3]. 
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  
    - Alcaraz Marc (aka eKameleon) <vegas@ekameleon.net> (2007-2008)

*/
package buRRRn.ASTUce.framework
    {
    import buRRRn.ASTUce.config;
    import buRRRn.ASTUce.strings;
    
    import system.Reflection;
    import system.Strings;
    
    /**
     * A TestSuite is a composite of Tests.
     * <p>It runfs collection of test cases.</p>
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * var suite:TestSuite = new TestSuite();
     * suite.addTest( new SimpleTest( "testHelloWorld" );
     * suite.addTest( new SimpleTest( "testOtherThing" );
     * </pre>
     * Alternatively, a testSuite can extract the tests to be run automatically.
     * To do so you pass the class of your ITest to the constructor.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * var suite:TestSuite = new TestSuite( SimpleTest );
     * </pre>
     * <p>This constructor creates a suite with all the methods starting with "test" that take no arguments.</p>
     */       
    public class TestSuite implements ITest
        {
        	
        /**
         * @private
         */
        private var _unknown:String = "[Unknown]";
        
        /**
         * @private
         */
        private var _tests:Array    = [];
        
        /**
         * @private
         */
        private var _name:String;
        
        /**
         * @private
         */
        public var simpleTrace:Boolean;
        
        /**
         * Creates a new TestSuite instance.
         * <p><b>Note :<b>theConstructor argument can be either a String an ITest or a Class in case of a Class tests will be extracted automatically.</p>
         */
        public function TestSuite( theConstructor:* = null, name:String = "", simpleTrace:Boolean = false )
            {
            if( (name != "") && (name != null) )
                {
                _name = name;
                }
            
            this.simpleTrace = simpleTrace;
            
            //Constructs an empty TestSuite
            if( theConstructor == null )
                {
                return;
                }
            
            if( theConstructor is String )
                {
                try
                    {
                    var originalCtor:String = theConstructor;
                    theConstructor = Reflection.getClassByName( theConstructor );
                    }
                catch( e:Error )
                    {
                    _name = originalCtor ;
                    return;
                    }
                }
            
            if( theConstructor is ITest )
                {
                //trace( "ctor addtest : " + Reflection.getClassName( theConstructor ) );
                addTest( theConstructor );
                return;
                }
            
            //Constructs a TestSuite from the given class.
            var className:String = "";
            
            if( theConstructor is Class )
                {
                className = Reflection.getClassName( theConstructor );
                }
            
            if( className != "" )
                {
                _name = className;
                }
            else
                {
                _name = _unknown;
                }
            
            try
                {
                var ctorResult:* = new theConstructor();
                }
            catch( er:Error )
                {
                /* note:
                   some class could have a constructor that throw an error
                   to simulate protected/private ctor for implementing singleton pattern.
                   
                   note:
                   this will catch also a "malformed" TestCase where the ctor arguments
                   are not optionnal
                   (code)
                   ...
                   class TestSomething extend TestCase {
                   public function TestSomething( name:String ) //<- here the ctor will fail
                   ...
                   
                   ...
                   class TestSomething extend TestCase {
                   public function TestSomething( name:String = "" ) //<- here the ctor will pass
                   ...
                   (end)
                   
                   TODO:
                   - maybe add a trick to be able to instanciate such "malformed" test
                     see <buRRRn.ASTUce.tests.framework.NoArgTestCaseTest>
                         <buRRRn.ASTUce.tests.framework.TestCaseTest.testNoArgTestCasePasses>
                         
                */
                if( er.errorID == 1063 )
                    {
                    addTest( _warning( Strings.format( strings.ctorIsMalformed, className ), er.message ) );
                    }
                else
                    {
                    addTest( _warning( Strings.format( strings.ctorNotInstanciable, className ), er.message ) );
                    }
                return;
                }
            
            if( !(ctorResult is ITest) )
                {
                addTest( _warning( Strings.format( strings.ctorNotATest, className ) ) );
                return;
                }
            
            //Adds all the methods starting with "test" as test cases to the suite.
            var names:Array = Reflection.getClassMethods( ctorResult, config.testInheritedTests );
            //trace( "method names: " + names );
            
            /* note:
               we want to prefilter the list of methods
               before calling _addTestMethod.
               
               For now
               _isTestMethodFilter() and _isTestMethod()
               do te same thing
               but later when reflection will be fully implemented
               _isTestMethod() gonna also check if the
               testMethod has 0 parameters and return the type void
               and this will be more intensive than to just
               get all the methods starting with "test"
            */
            names = names.filter( _isTestMethodFilter );
            //trace( "method names filtered: " + names );
            
            for( var i:int=0; i<names.length; i++ )
                {
                _addTestMethod( names[i], theConstructor );
                }
            
            if( testCount == 0 )
                {
                addTest( _warning( Strings.format( strings.noTestsFound, className ) ) );
                }
            
            
            }
       
       /**
        * @private
        */
       private static function _warning( message:String, detail:String = "" ):ITest
            {
            return new TestWarning( message, detail );
            }

       /**
        * @private
        */
       private function _addTestMethod( method:String, theConstructor:Class ):void
            {
            if( !_isTestMethod( method ) )
                {
                return;
                }
            
            addTest( createTest( theConstructor, method ) );
            }
        
        /*
        for now we can only reflect public methods, ctors, etc.
        so we don't need the following
        
        private function _isPublicTestMethod( method:String ):Boolean
            {
            
            }
        */
        
        /**
         * @private
         */
        private function _isTestMethod( method:String ):Boolean
            {
            /* TODO:
               - add check for paramters length == 0
               - add check for return type == void
            */
            method = method.toLowerCase();
            return Strings.startsWith( method, "test" );
            }
        
       /**
        * @private
        */
       private function _isTestMethodFilter( element:*, index:int, arr:Array ):Boolean
            {
            var method:String = element.toLowerCase();
            
            /* note:
               toString and valueOF are a special case
               because they are defined in the prototype
               and so will not be filtered correctly
            */
            if( (method == "tostring") || (method == "tostring") )
                {
                return false;
                }
            
            return Strings.startsWith( element.toLowerCase(), "test" );
            }
        
        /**
         * Indicates the number of TestCase elements in this suite.
         */
        public function get countTestCases():int
            {
            var count:int = 0;
            
            for( var i:int=0; i<tests.length; i++ )
                {
                count += tests[i].countTestCases;
                }
            
            return count;
            }
        
        /**
         * Indicates the name of the suite. if no name is defined we return "[Unknown]".
         */
        public function get name():String
            {
            if( (_name == null) || (_name == "") )
                {
                return _unknown;
                }
            
            return _name;
            }
        
        /**
         * @private
         */
        public function set name( value:String ):void
            {
            _name = value;
            }
        
        /**
         * Indicates the number of tests in this suite.
         */
        public function get testCount():int
            {
            return _tests.length;
            }
        
        /**
         * Indicates the tests as an Array.
         */
        public function get tests():Array
            {
            return _tests;
            }
        
        /**
         * Creates a test corresponding to the method name in theConstructor class.
         */
        public static function createTest( theConstructor:Class, name:String ):ITest
            {
            if( theConstructor == null )
                {
                return( _warning( Strings.format( strings.canNotCreateTest, name ) ) );
                }
            
            var test:ITest;
            var classname:String = Reflection.getClassName( theConstructor );
            try
                {
                //is for that kind of things that you like dynamic languages ;)
                test = new theConstructor( name );
                }
            catch( e:Error )
                {
                /* see notes in contructor
                */
                if( e.errorID == 1063 )
                    {
                    return _warning( Strings.format( strings.ctorIsMalformedMethod, name, classname ), e.message );
                    }
                else
                    {
                    return _warning( Strings.format( strings.ctorNotInstanciableMethod, name, classname ), e.message );
                    }
                }
            
            return test;
            }
        
        /**
         * Adds a test to the suite.
         */
        public function addTest( test:ITest ):void
            {
            /* attention:
               If you try to test something that has not been
               included or loaded then off course you obtain a warning.
            */
            if( test == null )
                {
                addTest( _warning( strings.argTestDoesNotExist ) );
                return;
                }
            
            if( !(test is ITest) )
                {
                addTest( _warning( strings.argTestNotATest ) );
                return;
                }
            
            _tests.push( test );
            }
        
        /**
         * Adds the tests from the given class to the suite.
         */
        public function addTestSuite( testConstructor:Class ):void
            {
            addTest( new TestSuite( testConstructor ) );
            }
        
        /**
         * Runs the tests and collects their result in a <TestResult>.
         */
        public function run( result:TestResult ):void
            {
            var i:int;
            var test:ITest;
            
            for( i=0; i< tests.length; i++ )
                {
                if( result.shouldStop )
                    {
                    break;
                    }
                
                test = tests[i];
                runTest( test, result );
                }
            }
        
        /**
         * Runs the test.
         */
        public function runTest( test:ITest, result:TestResult ):void
            {
            test.run( result );
            }
        
        /**
         * Returns the test at the given index.
         * @return the test at the given index.
         */
        public function testAt( index:int ):ITest
            {
            return _tests[ index ];
            }
        
        /**
         * Returns a string representation of the test suite.
         * <pre class="prettyprint">
         * toString( increment:int = 0, asSimpleTrace:Boolean = false, [simpleTraceDepth:int = 0] )
         * </pre>
         */
        public function toString( ...args ):String
            {
            var increment:int = 0;
            var asSimpleTrace:Boolean = false;
            var simpleTraceDepth:int  = 0;
            
            if( (args.length > 0) && (args[0] is Number) )
                {
                increment = int( args[0] );
                }
            
            if( (args.length > 1) && (args[1] is Boolean) )
                {
                asSimpleTrace = args[1];
                }
            
            if( (args.length > 2) && (args[2] is Number) )
                {
                asSimpleTrace    = false ;
                simpleTraceDepth = int( args[2] );
                }
            else
                {
                simpleTraceDepth = 0;
                }
            
            var str:String    = "";
            var CRLF:String   = "\n";
            var TAB:String    = "\t";
            var SPC:String    = TAB;
            
            if( increment > 0 )
                {
                for( var j:int=0; j<increment; j++ )
                    {
                    SPC += TAB;
                    }
                TAB = SPC;
                }
            
            str  += name;
            
            if( testCount > 0 )
                {
                str += CRLF + TAB + "{" + CRLF;
                if( asSimpleTrace || simpleTrace )
                    {
                    str += TAB + countTestCases + " Tests ..." + CRLF;
                    }
                else
                    {
                    for( var i:int=0; i<testCount; i++ )
                        {
                        
                        if( tests[i] is TestSuite )
                            {
                            increment++;
                            simpleTraceDepth--;
                            }
                        
                        str += TAB + tests[i].toString( increment, asSimpleTrace, simpleTraceDepth ) + CRLF;
                        
                        if( tests[i] is TestSuite )
                            {
                            increment--;
                            simpleTraceDepth++;
                            }
                        }
                    }
                str += TAB + "}";
                }
            return str;
            
            }
        
        }
    
    }

