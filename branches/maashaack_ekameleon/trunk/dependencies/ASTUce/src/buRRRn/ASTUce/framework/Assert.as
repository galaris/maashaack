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
  - Marc Alcaraz <vegas@ekameleon.net>.
*/

package buRRRn.ASTUce.framework
    {
    import buRRRn.ASTUce.config;
    import buRRRn.ASTUce.strings;
    
    import system.Equatable;
    import system.Strings;
    import system.eden;
    
    /**
     * A set of assert methods. Messages are only displayed when an assert fails. It is a static only class.
     * <p><b>Notes :</b></p>
     * <li>in ES4 we do not have protected/private constructor (which is good imho)</li>
     * <li>we could make a public const Assert instancied by an internal class _Assert</li>
     * <p>defined outside of the package but this would not allow us to inherit from Assert as class can not extends from an instance (from what I tested)</p>
     * <li>so we choose to define this class on the model of the Math class as a static only class (with static only members)</li>
     * <li>to really not instanciate the class we could throw an error if someone tried to do a <code class="prettyprint">myAssert = new Assert()</code> but well the class does not vehiculate states and we don't care if someone instanciate it ;)</li>
     */ 
    public class Assert
        {
        
        /* Constructor: Assert
           it is a static only class.
           
           notes:
           - in ES4 we do not have protected/private constructor (which is good imho)
           - we could make a public const Assert instancied by an internal class _Assert
             defined outside of the package but this would not allow us to inherit
             from Assert as class can not extends from an instance
             (from what I tested)
           - so we choose to define this class on the model of the Math class
             as a static only class (with static only members)
           - to really not instanciate the class we could
             throw an error if someone tried to do
             a myAssert = new Assert()
             but well the class does not vehiculate states
             and we don't care if someone instanciate it ;)
           
        public function Assert()
            {
            
            }
        */
        
        /**
         * @private
         */
        protected static function _serialize( o:* ):String
            {
            /* note:
               we don't want to have prettyPrinting messing
               with our lines output so we deactivate it
            */
            var pretty:Boolean = eden.prettyPrinting;
            eden.prettyPrinting = false;
            
            var str:String = eden.serialize( o );
            
            /* note:
               in case original serializer would output nothing
               we use the Basic serializer to at least obtain
               the toString() representation
            */
            /* temporaly removed
            if( (str == "{}") || (str == "") )
                {
                var tmp:* = Serializer.format;
                Serializer.format = SerializationFormat.basic;
                str = Serializer.serialize( o );
                Serializer.format = tmp;
                }
            */
            eden.prettyPrinting = pretty;
            return str;
            }
        
        /**
         * @private
         */      
        protected static function _failNotEquals( expected:*, actual:*, message:String = "" ):void
            {
            if( buRRRn.ASTUce.config.showObjectSource )
                {
                expected = _serialize( expected );
                actual   = _serialize( actual );
                }
            
            if( buRRRn.ASTUce.config.invertExpectedActual )
                {
                var tmp:*  = expected;
                expected   = actual;
                actual     = tmp;
                }
            
            fail( format( expected, actual, message ) );
            }
        
        /**
         * @private
         */
        private static function _failSame( message:String = "" ):void
            {
            var formatted:String = "";
            
            if( (message != null) && (message != "") )
                {
                formatted = message + " ";
                }
            
            fail( Strings.format( strings.expectedNotSame, formatted ) );
            }
        
        /**
         * @private
         */
        private static function _failNotSame( expected:*, actual:*, message:String = "" ):void
            {
            var formatted:String = "";
            
            if( (message != null) && (message != "") )
                {
                formatted = message + " ";
                }
            
            if( buRRRn.ASTUce.config.showObjectSource )
                {
                expected = _serialize( expected );
                actual   = _serialize( actual );
                }
            
            if( buRRRn.ASTUce.config.invertExpectedActual )
                {
                var tmp:*  = expected;
                expected   = actual;
                actual     = tmp;
                }
            
            fail( Strings.format( strings.expectedSame, formatted, expected, actual ) );
            }
        
        /**
         * Asserts that a condition is true.
         * <p>If it isn't it throws an AssertionFailedError (with the given message if provided).</p>
         * <p><b>Note :</b></p>
         * - the order of the arguments are inversed because
         *   we can not declare overloaded methods in ES4.
         * - also optionnal arguments must be defined as default parameter value
         *   and as they can be defined only at the end that's why the order
         *   of arguments is inversed.
         * - not defining default parameters would make them required parameters
         * - by default a non-declared string is equal to null
         *   but here as the goal is to display messages we define the
         *   default value to the empty string
         */
        public static function assertTrue( condition:Boolean, message:String = "" ):void
            {
            if( !condition )
                {
                fail( message );
                }
            }
        
        /**
         * Asserts that a condition is false. If it isn't it throws an AssertionFailedError (with the given message if provided).
         */
        public static function assertFalse( condition:Boolean, message:String = "" ):void
            {
            assertTrue( !condition, message );
            }
        
        /**
         * Asserts that any two objects are equal. If they are not an AssertionFailedError is thrown (with the given message if provided).
         */
        public static function assertEquals( expected:*, actual:*, message:String = "" ):void
            {
            
            if( ((expected == undefined) && (actual != undefined)) ||
                ((expected != undefined) && (actual == undefined)) )
                {
                _failNotEquals( expected, actual, message );
                }
            
            if( (expected == null) && (actual == null) )
                {
                return;
                }
            
            if( expected == actual )
                {
                return;
                }
            
            //special case: you can't compare NaN with himself
            if( ((expected is Number) && (actual is Number)) &&
                (isNaN(expected) && isNaN(actual)) )
                {
                return;
                }
            
            if( (expected is Equatable) && expected.equals( actual ) )
                {
                return;
                }
            
            /* note:
               maybe something to improve here
               ComparisonFailure allow to show the string diff
               between two strings
               ex:
               assertEquals( "hello", "hallo" ) -> <...e...> but was <...a...>
               
               but as we use serialization to represent our result
               ex:
               assertEquals( true, false ) --> <true> but was <false>
               
               we could apply the string diff of ComparisonFailure to the serialization result
               this could be a cleare representation of the failure for objects, arrays, etc.
               ex:
               assertEquals( [1,2,3], [1,5,3] ) --> <[...,2,...]> but was <[...,5,...]>
            */
            if( (expected is String) && (actual is String) )
                {
                throw new ComparisonFailure( expected, actual, message );
                }
            else
                {
                _failNotEquals( expected, actual, message );
                }
            
            }
        
        /**
         * Asserts that an object is not null. If it is an AssertionFailedError is thrown with the given message.
         */
        public static function assertNotNull( o:*, message:String = "" ):void
            {
            assertTrue( o != null, message );
            }
        
        /**
         * Asserts that an object is null. If it is not an AssertionFailedError is thrown with the given message.
         */
        public static function assertNull( o:*, message:String = "" ):void
            {
            assertTrue( o == null, message );
            }
        
        /**
         * Asserts that two objects refer to the same object.
         * If they are not an AssertionFailedError is thrown with the given message.
         * <p><b>Note :</b>Same object mean same reference so the comparison is by reference not by value</p>
         */
        public static function assertSame( expected:*, actual:*, message:String = "" ):void
            {
            if( expected === actual )
                {
                return;
                }
            
            _failNotSame( expected, actual, message );
            }
        
        /**
         * Asserts that two objects does not refer to the same object.
         * If they are an AssertionFailedError is thrown with the given message.
         */
        public static function assertNotSame( expected:*, actual:*, message:String = "" ):void
            {
            if( expected === actual )
                {
                _failSame( message );
                }
            }
        
        /**
         * Asserts that an object is undefined.
         * If it is not an AssertionFailedError is thrown with the given message.
         */
        public static function assertUndefined( o:*, message:String = "" ):void
            {
            assertTrue( o === undefined, message );
            }
        
        /**
         * Asserts that an object is not undefined.
         * If it is an AssertionFailedError is thrown with the given message.
         */
        public static function assertNotUndefined( o:*, message:String = "" ):void
            {
            assertTrue( o !== undefined, message );
            }
        
        /**
         * Fails a test with the given message or with no message.
         */
        public static function fail( message:String = "" ):void
            {
            throw new AssertionFailedError( message );
            }
        
        /**
         * Formats the result.
         */
        public static function format( expected:*, actual:*, message:String = "" ):String
            {
            var formatted:String = "";
            
            if( (message != null) && (message != "") )
                {
                formatted = message + " ";
                }
            
            return Strings.format( strings.expectedButWas, formatted, expected, actual );
            }
        
        }
    
    }



