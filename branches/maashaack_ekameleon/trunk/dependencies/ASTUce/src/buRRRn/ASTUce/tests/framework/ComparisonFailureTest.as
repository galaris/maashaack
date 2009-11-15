
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
*/

package buRRRn.ASTUce.tests.framework
    {
    import buRRRn.ASTUce.framework.*;

    public class ComparisonFailureTest extends TestCase
        {
        
        public function ComparisonFailureTest( name:String = "" )
            {
            super( name );
            }
        
        public function testComparisonErrorMessage():void
            {
            var failure:ComparisonFailure = new ComparisonFailure( "b", "c", "a" );
            assertEquals( "a expected:<b> but was:<c>", failure.getMessage() );
            }
        
        public function testComparisonErrorStartSame():void
            {
            var failure:ComparisonFailure = new ComparisonFailure( "ba", "bc", null );
            assertEquals( "expected:<...a> but was:<...c>", failure.getMessage() );
            }
        
        public function testComparisonErrorEndSame():void
            {
            var failure:ComparisonFailure = new ComparisonFailure( "ab", "cb", null );
            assertEquals( "expected:<a...> but was:<c...>", failure.getMessage() );
            }
        
        public function testComparisonErrorSame():void
            {
            var failure:ComparisonFailure = new ComparisonFailure( "ab", "ab", null );
            assertEquals( "expected:<ab> but was:<ab>", failure.getMessage() );
            }
        
        public function testComparisonErrorStartAndEndSame():void
            {
            var failure:ComparisonFailure = new ComparisonFailure( "abc", "adc", null );
            assertEquals( "expected:<...b...> but was:<...d...>", failure.getMessage() );
            }
        
        public function testComparisonErrorStartSameComplete():void
            {
            var failure:ComparisonFailure = new ComparisonFailure( "ab", "abc", null );
            assertEquals( "expected:<...> but was:<...c>", failure.getMessage() );
            }
        
        public function testComparisonErrorEndSameComplete():void
            {
            var failure:ComparisonFailure = new ComparisonFailure( "bc", "abc", null );
            assertEquals( "expected:<...> but was:<a...>", failure.getMessage() );
            }
        
        public function testComparisonErrorOverlapingMatches():void
            {
            var failure:ComparisonFailure = new ComparisonFailure( "abc", "abbc", null );
            assertEquals( "expected:<......> but was:<...b...>", failure.getMessage() );
            }
        
        public function testComparisonErrorOverlapingMatches2():void
            {
            var failure:ComparisonFailure = new ComparisonFailure( "abcdde", "abcde", null );
            assertEquals( "expected:<...d...> but was:<......>", failure.getMessage() );
            }
        
        public function testComparisonErrorWithActualNull():void
            {
            var failure:ComparisonFailure = new ComparisonFailure( "a", null, null );
            assertEquals( "expected:<a> but was:<null>", failure.getMessage() );
            }
        
        public function testComparisonErrorWithExpectedNull():void
            {
            var failure:ComparisonFailure = new ComparisonFailure( null, "a", null );
            assertEquals( "expected:<null> but was:<a>", failure.getMessage() );
            }
        
        }
    
    }

