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
    /**
     * The ExpectationMatcher class.
     */
    public class ExpectationMatcher 
    {
        
        /**
         * Creates a new ExpectationMatcher instance.
         */
        public function ExpectationMatcher() 
        {
            reset() ;
        }
        
        /**
         * Indicates the discrepancy value.
         */
        public function get discrepancy():Discrepancy 
        {
            return this._discrepancy ; 
        }
        
        /**
         * Inserts a new actual method to call.
         * @param caller The caller scope of the method to invoke.
         * @param method The name of the method to invoke.
         * @param arguments The arguments passed-in the method.
         */
        public function addActualMethodCall(  caller:* , method:String , methodArguments:Array ):void 
        {
            _actualBehaviorList.push( new InvocationBehavior( caller, method, methodArguments ) ) ;
        }
        
        /**
         * Inserts a new expected method to call.
         * @param caller The caller scope of the method to invoke.
         * @param method The method to invoke.
         * @param arguments The arguments passed-in the method.
         */
        public function addExpectedMethodCall( caller:* , method:String , methodArguments:Array ):void 
        {
            _expectationBehaviorList.push( new InvocationBehavior(caller, method, methodArguments ) ) ;
        }
        
        /**
         * Matches.
         */
        public function matches():Boolean
        {
            var self:ExpectationMatcher = this ;
            var matches:Boolean         = true ;
            eachIndexForMock
            ( 
                _expectationBehaviorList , 
                function( index:uint, expectedBehavior:* ):Boolean 
                { 
                    var actualBehavior:* = (self._actualBehaviorList.length > index) ? self._actualBehaviorList[index] : null ;
                    if(matches) 
                    {
                        if( actualBehavior === null ) 
                        {
                            self._discrepancy = new Discrepancy("Expected function not called", expectedBehavior);
                            matches = false;
                        }   
                        else if( expectedBehavior.method != actualBehavior.method ) 
                        {
                            self._discrepancy = new Discrepancy("Surprise call", actualBehavior);
                            matches = false;
                        }
                        else if( expectedBehavior.caller != actualBehavior.caller ) 
                        {
                            self._discrepancy = new Discrepancy("Surprise call from unexpected caller", actualBehavior);
                            matches = false ;
                        } 
                        else if( !this._matchArguments(expectedBehavior.methodArguments, actualBehavior.methodArguments) ) 
                        {
                            self._discrepancy = new Discrepancy("Unexpected Arguments", actualBehavior) ;
                            matches = false ;
                        }
                        return matches ;
                    }
                }
            );
      
            if( _actualBehaviorList.length > _expectationBehaviorList.length && matches ) 
            {
                _discrepancy = new Discrepancy("Surprise call", this._actualBehaviorList[this._expectationBehaviorList.length]) ;
                matches = false ;
            } 

            return matches;
        }        
        
        /**
         * Reset this object.
         */
        public function reset():void
        {
            _actualBehaviorList      = [] ;
            _expectationBehaviorList = [] ;
            _discrepancy             = null ; 
        }
        
        /**
         * @private
         */
        private var _actualBehaviorList:Array ;

        /**
         * @private
         */
        private var _discrepancy:Discrepancy ;
        
        /**
         * @private
         */
        private var _expectationBehaviorList:Array ;
           
       /**
        * @private
        */
       protected function _matchArguments( expectedArgs:Array , actualArgs:Array ):Boolean 
       {
            var expectedArray:Array  = _convertArgumentsToArray( expectedArgs ) ;
            var actualArray:Array    = _convertArgumentsToArray( actualArgs ) ;
            return ArgumentMatcher.matches( expectedArray , actualArray ) ;
        }

        /**
         * @private
         */
        protected function _convertArgumentsToArray( args:Array ):Array 
        {
            var convertedArguments:Array = [] ;
            for(var i:uint = 0; i < args.length; i++) 
            {
                convertedArguments[i] = args[i];    
            }
            return convertedArguments;
        }
           
    }
}
