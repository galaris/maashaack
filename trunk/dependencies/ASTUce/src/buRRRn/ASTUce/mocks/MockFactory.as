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
  ALCARAZ Marc <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):

*/
package buRRRn.ASTUce.mocks 
{
    import flash.utils.describeType;
    
    import system.Reflection;
    
    /**
     * The MockFactory class.
     * @see http://jsmock.sourceforge.net/jsmock.js
     * @see http://jsmock.sourceforge.net/examples/
     */
    public class MockFactory
    {
        
        /**
         * Creates a new MockFactory instance.
         */
        public function MockFactory()
        {
            expectationMatcher = new ExpectationMatcher() ;
            lastCallName       = null ;
            lastMock           = null ;
        }
        
        /**
         * The ExpectationMatcher reference.
         */ 
        public var expectationMatcher:ExpectationMatcher ;
        
        /**
         * The lastCallName value.
         */ 
        public var lastCallName:String ;
        
        /**
         * The last mock value.
         */ 
        public var lastMock:Mock ;
        
        /**
         * The 'andReturn' test.
         */
        public function andReturn( value:* ):void 
        {
            _verifyLastMockNotNull("Cannot set return value without an expectation");
            _initializeReturnExpectationForMock();    
            lastMock.calls[ lastCallName ].push( function():* 
            { 
                return value ;
            });
        }
        
        /**
         * The 'andThrow' test.
         */
        public function andThrow( message:String ):void 
        {
            _verifyLastMockNotNull("Cannot throw error without an expectation");
            _initializeReturnExpectationForMock() ;
            lastMock.calls[ lastCallName ].push( function():void 
            { 
                throw new Error( message ) ; 
            });
        }
        
        /**
         * The 'andStub' test.
         */
        public function andStub( block:* ):void  
        {
            _verifyLastMockNotNull("Cannot stub without an expectation") ;
            if( block is Function ) 
            {
                throw new Error("Stub must be a function") ;
            }
            _initializeReturnExpectationForMock();    
            lastMock.calls[ lastCallName].push( function( ...rest:Array ):* 
            { 
                return block.apply(this, rest) ; 
            });
        }        
        
        /**
         * Creates a new Mock object over the specified object in argument.
         */
        public function createMock( o:* ):Mock  
        {
            var mock:Mock = new Mock(this) ;
            if( o != null ) 
            {
                if( o is Class || o is Function ) 
                {
                    _createsMethods( o       , mock ) ; // constants (static methods)
                    _createsMethods( new o() , mock ) ; // properties // problem if the constructor need arguments
                } 
                else if( o is Object ) 
                {
                    _createsMethods( o , mock ) ;
                } 
                else 
                {
                    throw new Error("Cannot mock out a " + typeof(o));
                }
            }
            return mock;
        }
        
        /**
         * Creates a method.
         */
        public function createMethod( control:MockFactory , mock:Mock , method:String ):* 
        {
            mock[ method ] = function():* 
            {
                if( mock.recording ) 
                {
                    mock.recording       = false;
                    control.lastMock     = mock   ;
                    control.lastCallName = method ;
                    control.expectationMatcher.addExpectedMethodCall( mock, method, arguments );
                    return control ;
                } 
                else 
                {
                   control.expectationMatcher.addActualMethodCall( mock, method, arguments ) ;
                   if( mock.calls[method] != null) 
                   {
                       var returnValue:Function = mock.calls[method].shift() as Function ;
                       if( returnValue != null ) 
                       {
                          return ( returnValue as Function ).apply(this, arguments) ;
                       }
                    }
                }
                return null ;
            };
        }
        
        /**
         * Resets the mock factory.
         */
        public function reset():void
        {
            expectationMatcher.reset() ;
        }
        
        /**
         * Verifiy the mocks object.
         */
        public function verify():void 
        {
            if( !expectationMatcher.matches() )
            {
                var discrepancy:Discrepancy = expectationMatcher.discrepancy ;
                var message:String          = discrepancy.message;
                var method:String           = discrepancy.behavior.method ;
                var formattedArgs:Array     = (ArgumentsFormatter.format( discrepancy.behavior.arguments ) as Array) ;
                expectationMatcher.reset() ;
                throw new Error( message + " : " + method + "(" + formattedArgs + ")") ;   
            }
            else 
            {
                expectationMatcher.reset() ;
            }
        }
        
        /**
         * @private
         */
        private function _initializeReturnExpectationForMock():void 
        {
            if( lastMock.calls[lastCallName] !== undefined ) 
            {
                lastMock.calls[lastCallName] = [] ;
            } 
        } 
        
        /**
         * @private
         */
        private function _isPublicMethod( o:* , property:String ):Boolean 
        {
            try 
            {
                return o[property] is Function && ( property.charAt(0) != "_" ) ;
            } 
            catch( e:Error ) 
            {
                return false;
            }
        }
        
        /**
         * Creates the methods of the specified object in the mock object.
         */
        private function _createsMethods( o:* , mock:Mock ):void
        {
            // finds methods with describeType 
            
            // finds non enumerable properties in generic objects
            for( var property:String in o )   
            {
                if ( _isPublicMethod( o , property ) )
                {
                    createMethod( this , mock , property ); // only public methods.
                }
            }
        }        
        /**
         * @private
         */
        private function _verifyLastMockNotNull( message:String ):void 
        {
            if( lastMock == null ) 
            {
                throw new Error( message ) ;
            }
        }
        
        /**
         * Returns an array of public methods defined in the class of an object.
         * @return an array of public methods defined in the class of an object.
         */
        public static function getClassMethods( o:*, inherited:Boolean = false ):Array
        {
            var type:XML = describeType( o );
            var fullname:String = Reflection.getClassName( o, true );
            var members:Array = [];
            for each( var member:XML in type.method )
            {
                if( inherited )
                {
                    members.push( String( member.@name ) );
                }
                else if( String( member.@declaredBy ) == fullname )
                {
                    members.push( String( member.@name ) );
                }
            }
            return members;
        } 
    }
}
