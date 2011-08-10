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
package system.evaluators
{
    import buRRRn.ASTUce.framework.TestCase;
    
    import core.maths.ceil;
    
    public class MathEvaluatorTest extends TestCase
    {
        private var _ME:MathEvaluator;
        private var _ME2:MathEvaluator;
        
        public function MathEvaluatorTest(name:String = "")
        {
            super(name);
        }
        
        public function setUp():void
        {
            _ME = new MathEvaluator();
            _ME2 = new MathEvaluator({x:100, test:function(a:Number):Number
            {
                return a * a;
            }, test2:function(a:Number):Number
            {
                return a * a * 2;
            }});
        }
        
        public function testFunctionCall():void
        {
            assertEquals(Math.abs(-5), _ME.eval("abs(-5)"));
            assertEquals(Math.acos(6), _ME.eval("acos(6)"));
            assertEquals(Math.asin(1), _ME.eval("asin(1)"));
            assertEquals(Math.atan(3), _ME.eval("atan(3)"));
            assertEquals(Math.atan2(4, 4), _ME.eval("atan2(4,4)"));
            assertEquals(Math.ceil(5.03), _ME.eval("ceil(5.03)"));
            assertEquals(Math.cos(3), _ME.eval("cos(3)"));
            assertEquals(Math.exp(5), _ME.eval("exp(5)"));
            assertEquals(Math.floor(0.06), _ME.eval("floor(0.06)"));
            assertEquals(ceil(Math.log(7), 15), ceil(_ME.eval("log(7)"), 15));
            assertEquals(Math.max(2, 8), _ME.eval("max(2,8)"));
            assertEquals(Math.min(2, 8), _ME.eval("min(2,8)"));
            assertEquals(Math.pow(2, 8), _ME.eval("pow(2,8)"));
            assertNotNull(_ME.eval("random()"));
            // unless we can control the random seed we can not assertEquals 2 different random call
            assertEquals(Math.round(1.004), _ME.eval("round(1.004)"));
            assertEquals(Math.sin(1), _ME.eval("sin(1)"));
            assertEquals(Math.sqrt(8), _ME.eval("sqrt(8)"));
            assertEquals(Math.tan(13), _ME.eval("tan(13)"));
        }
        
        public function testFunctionCallComplex():void
        {
            assertEquals((Math.sin((4 * 50) / 3) + Math.pow(2, 2) + 1 - Math.sin(3)), _ME.eval("sin( (4*50) /3 ) + pow(2,2)+1-sin(3)"));
        }
        
        public function testContextCall():void
        {
            var ctx:Object = {x:100, test:function(a:Number):Number
            {
                return a * a;
            }, test2:function(a:Number):Number
            {
                return a * a * 2;
            }} ;
            assertEquals((ctx.test(10) ), _ME2.eval("test( 10 )"));
            assertEquals((100 + ctx.x ), _ME2.eval("100 + x"));
            assertEquals((ctx.test(ctx.x) ), _ME2.eval("test(x)"));
            assertEquals((ctx.test2(ctx.x) ), _ME2.eval("test2(x)"));
            assertEquals((ctx.test((ctx.x / 7) * 2) ), _ME2.eval("test((x/7)*2)"));
        }
        
        public function testUnary():void
        {
            assertEquals((~20), _ME.eval("~20"));
            assertEquals((-5 + -5), _ME.eval("-5 + -5"));
            assertEquals((+5 - +5), _ME.eval("+5 - +5"));
        }
        
        public function testMultiplication():void
        {
            assertEquals((0.5 * 33), _ME.eval("0.5*33"));
            assertEquals((0xff * 10), _ME.eval("0xff*10"));
        }
        
        public function testDivision():void
        {
            assertEquals((300 / 100), _ME.eval("300/100"));
            assertEquals((0xfff / 0xf), _ME.eval("0xfff/0xf"));
        }
        
        public function testModulo():void
        {
            assertEquals((5 % 10), _ME.eval("5%10"));
            assertEquals((0.005 % 2), _ME.eval("0.005%2"));
        }
        
        public function testAddition():void
        {
            assertEquals((1 + 1), _ME.eval("1+1"));
            assertEquals((0xfff + 0xfff), _ME.eval("0xfff+0xfff"));
        }
        
        public function testSubtraction():void
        {
            assertEquals((1 - 1), _ME.eval("1-1"));
            assertEquals((0xfff - 0xfff), _ME.eval("0xfff-0xfff"));
        }
        
        public function testBitShifting():void
        {
            assertEquals((5 << 4), _ME.eval("5<<4"));
            assertEquals((0xf000 >> 2), _ME.eval("0xf000>>2"));
            assertEquals((0x00f000 >>> 3), _ME.eval("0x00f000>>>3"));
        }
        
        public function testBitwise():void
        {
            assertEquals((10 ^ 2), _ME.eval("10^2"));
            assertEquals((7 | 3), _ME.eval("7|3"));
            assertEquals((2 & 2), _ME.eval("2&2"));
        }
        
        public function testPriority14():void
        {
            assertEquals((Math.sin(1) - Math.cos(1)), _ME.eval("sin(1)-cos(1)"));
            assertEquals((78 * (96 + 3 + 45)), _ME.eval("78 * (96 + 3 + 45)"));
        }
        
        public function testEmpty():void
        {
            assertEquals(0, _ME.eval(""));
        }
    }
}

