
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

package buRRRn.ASTUce.samples.money
    {
    import buRRRn.ASTUce.framework.TestCase;
    
    public class MoneyTest extends TestCase
        {
        
        private var _12eu:Money;
        private var _14eu:Money;
        private var _7usd:Money;
        private var _21usd:Money;
        
        private var _MB1:IMoney;
        private var _MB2:IMoney;
        
        public function MoneyTest( name:String = "" )
            {
            super( name );
            }
        
        public function setUp():void
            {
            _12eu  = new Money( 12, "€" );
            _14eu  = new Money( 14, "€" );
            _7usd  = new Money(  7, "$" );
            _21usd = new Money( 21, "$" );
            
            _MB1 = MoneyBag.create( _12eu, _7usd );
            _MB2 = MoneyBag.create( _14eu, _21usd );
            }
        
        public function testBagMultiply():void
            {
            // {[12€][7$]} *2 == {[24€][14$]}
            var expected:IMoney = MoneyBag.create( new Money(24,"€"), new Money(14,"$") );
            assertEquals( expected, _MB1.multiply(2) );
            assertEquals( _MB1, _MB1.multiply(1) );
            assertTrue( _MB1.multiply(0).isZero() );
            }
        
        public function testBagNegate():void
            {
            // {[12€][7$]} negate == {[-12€][-7$]}
            var expected:IMoney = MoneyBag.create( new Money(-12,"€"), new Money(-7,"$") );
            assertEquals( expected, _MB1.negate() );
            }
        
        public function testBagSimpleAdd():void
            {
            // {[12€][7$]} + [14€] == {[26€][7$]}
            var expected:IMoney = MoneyBag.create( new Money(26,"€"), new Money(7,"$") );
            assertEquals( expected, _MB1.add( _14eu ) );
            }
        
        public function testBagSubtract():void
            {
            // {[12€][7$]} - {[14€][21$] == {[-2€][-14$]}
            var expected:IMoney = MoneyBag.create( new Money(-2,"€"), new Money(-14,"$") );
            assertEquals( expected, _MB1.subtract( _MB2 ) );
            }
        
        public function testBagSumAdd():void
            {
            // {[12€][7$]} + {[14€][21$]} == {[26€][28$]}
            var expected:IMoney = MoneyBag.create( new Money(26,"€"), new Money(28,"$") );
            assertEquals( expected, _MB1.add( _MB2 ) );
            }
        
        public function testIsZero():void
            {
            assertTrue( _MB1.subtract( _MB1 ).isZero() );
            assertTrue( MoneyBag.create( new Money(0,"€"), new Money(0,"$") ).isZero() );
            }
        
        public function testMixedSimpleAdd():void
            {
            // [12€] + [7$] == {[12€][7$]}
            var expected:IMoney = MoneyBag.create( _12eu, _7usd );
            assertEquals( expected, _12eu.add( _7usd ) );
            }
        
        public function testBagNotEquals():void
            {
            var bag:IMoney = MoneyBag.create( _12eu, _7usd );
            assertFalse( bag.equals( new Money(12,"¥").add( _7usd ) ) );
            }
        
        public function testMoneyBagEquals():void
            {
            assertTrue( !_MB1.equals( null ) );
            assertEquals( _MB1, _MB1 );
            
            var equal:IMoney = MoneyBag.create( new Money(12,"€"), new Money(7,"$") );
            assertTrue(  _MB1.equals( equal ) );
            assertTrue( !_MB1.equals( _12eu ) );
            assertTrue( !_12eu.equals( _MB1 ) );
            assertTrue( !_MB1.equals( _MB2 ) );
            }
        
        public function testMoneyEquals():void
            {
            assertTrue( !_12eu.equals( null ) );
            
            var equalMoney:Money = new Money( 12, "€" );
            assertEquals( _12eu, _12eu );
            assertEquals( _12eu, equalMoney );
            }
        
        public function testSimplify():void
            {
            var money:IMoney = MoneyBag.create( new Money(26,"€"), new Money(28,"€") );
            assertEquals( new Money(54,"€"), money );
            }
        
        public function testNormalize2():void
            {
            // {[12€][7$]} - [12€] == [7$]
            var expected:Money = new Money( 7, "$" );
            assertEquals( expected, _MB1.subtract( _12eu ) );
            }
        
        public function testNormalize3():void
            {
            // {[12€][7$]} - {[12€][3$]} == [4$]
            var ms1:IMoney = MoneyBag.create( new Money(12,"€"), new Money(3,"$") );
            var expected:Money = new Money( 4, "$" );
            assertEquals( expected, _MB1.subtract( ms1 ) );
            }
        
        public function testNormalize4():void
            {
            // [12€] - {[12€][3$]} == [-3$]
            var ms1:IMoney = MoneyBag.create( new Money(12,"€"), new Money(3,"$") );
            var expected:Money = new Money( -3, "$" );
            assertEquals( expected, _12eu.subtract( ms1 ) );
            }
        
        public function testPrint():void
            {
            assertEquals( "[12€]", _12eu.toString() );
            }
        
        public function testSimpleAdd():void
            {
            // [12€] + [14€] == [26€]
            var expected:Money = new Money( 26, "€" );
            assertEquals( expected, _12eu.add( _14eu ) );
            }
        
        public function testSimpleBagAdd():void
            {
            // [14€] + {[12€][7$]} == {[26€][7$]}
            var expected:IMoney = MoneyBag.create( new Money(26,"€"), new Money(7,"$") );
            assertEquals( expected, _14eu.add( _MB1 ) );
            }
        
        public function testSimpleMultiply():void
            {
            // [14€] *2 == [28€]
            var expected:Money = new Money( 28, "€" );
            assertEquals( expected, _14eu.multiply(2) );
            }
        
        public function testSimpleNegate():void
            {
            // [14€] negate == [-14€]
            var expected:Money = new Money( -14, "€" );
            assertEquals( expected, _14eu.negate() );
            }
        
        public function testSimpleSubtract():void
            {
            // [14€] - [12€] == [2€]
            var expected:Money = new Money( 2, "€" );
            assertEquals( expected, _14eu.subtract( _12eu ) );
            }
        
        }
    
    }

