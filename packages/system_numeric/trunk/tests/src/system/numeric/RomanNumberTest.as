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

package system.numeric 
{
    import library.ASTUce.framework.TestCase;
    
    public class RomanNumberTest extends TestCase 
    {
        public function RomanNumberTest(name:String = "")
        {
            super( name );
        }
        
        public function testConstructor():void
        {
            var rn:RomanNumber ;
            try
            {
                rn = new RomanNumber();
            }
            catch( e:Error )
            {
                fail( "RomanNumber ctor failed" );
            }
        }
        
        public function testConstructorAsRomanString():void
        {
            var rn:RomanNumber = new RomanNumber( "MMVIII" );
            assertEquals( 2008, rn.valueOf() );
        }
        
        public function testDefault():void
        {
            var rn:RomanNumber = new RomanNumber();
            assertEquals( "", rn.toString() ); 
        }
        
        public function testBasicOperators():void
        {
            var rn:RomanNumber = new RomanNumber( 2008 );
            var rn2:RomanNumber = new RomanNumber( rn.valueOf() + 1 );
            var rn3:RomanNumber = new RomanNumber( uint(rn2) - 1 );
            
            assertEquals( 2009, rn2 );
            assertEquals( "MMIX", rn2.toString() );
            
            assertEquals( 2008, rn3 );
            assertEquals( "MMVIII", rn3.toString() );
        }
        
        public function testMaxRange():void
        {
            try
            {
                new RomanNumber( RomanNumber.MAX + 1 );
            }
            catch( e:Error )
            {
                assertEquals( e.message, "Max value for a RomanNumber is 3999" , "over maximum range throws a specific RangeError message.") ;
                assertTrue( e is RangeError , "over maximum range throws a RangeError object.") ;
            }
        }
        
        public function testMinRange():void
        {
            try
            {
                new RomanNumber( RomanNumber.MIN - 1 );
            }
            catch( e:Error )
            {
                assertTrue( e is RangeError , "under minimum range throws a RangeError object." ) ;
                assertEquals( e.message, "Min value for a RomanNumber is 0" , "under minimum range throws a specific RangeError message.") ;
            }
        }
        
        // parse
         
        public function testParseBasic():void
        {
            var rn:RomanNumber = new RomanNumber();
            
            assertEquals( "M", rn.parse( 1000 ) );
            assertEquals( "D", rn.parse(  500 ) );
            assertEquals( "C", rn.parse(  100 ) );
            assertEquals( "L", rn.parse(   50 ) );
            assertEquals( "X", rn.parse(   10 ) );
            assertEquals( "V", rn.parse(    5 ) );
            assertEquals( "I", rn.parse(    1 ) );
            assertEquals( "",  rn.parse(    0 ) );
        }
        
        public function testParseAdditionRule():void
        {
            var rn:RomanNumber = new RomanNumber();
            
            assertEquals( "MI", rn.parse( 1001 ) );
            assertEquals( "MD", rn.parse( 1500 ) );
            assertEquals( "MDC", rn.parse( 1600 ) );
            assertEquals( "CCLXVII", rn.parse( 267 ) );
        }
        
        public function testParseShortestNotationRule():void
        {
            var rn:RomanNumber = new RomanNumber();
            
            assertEquals( "LV",   rn.parse( 55 ) );
            assertEquals( "LXVI", rn.parse( 66 ) );
        }
        
        public function testParseSubstractionRule():void
        {
            var rn:RomanNumber = new RomanNumber();
            
            assertEquals( "XL",   rn.parse(   40 ) );
            assertEquals( "XLIV", rn.parse(   44 ) );
            assertEquals( "XLIX", rn.parse(   49 ) );
            assertEquals( "XCIX", rn.parse(   99 ) );
            assertEquals( "CM",   rn.parse(  900 ) );
            assertEquals( "MCM",  rn.parse( 1900 ) );
        }
        
        public function testParseSpecialCase():void
        {
            var rn:RomanNumber = new RomanNumber();
            
            assertEquals( "DCLXVI",   rn.parse(  666 ) ); //Using every symbol except M in descending order gives the beast number.
            assertEquals( "MCDXLIV",  rn.parse( 1444 ) ); //Smallest pandigital number (each symbol is used)
            assertEquals( "MDCLXVI",  rn.parse( 1666 ) ); //Largest efficient pandigital number (each symbol occurs exactly once)
            assertEquals( "MCMXLV",   rn.parse( 1945 ) );
            assertEquals( "MCMXCVII", rn.parse( 1997 ) );
            assertEquals( "MCMXCIX",  rn.parse( 1999 ) );
        }
        
        // parseRomanString 
         
        public function testParseRomanStringBasic():void
        {
            assertEquals( 1000, RomanNumber.parseRomanString( "M" ) );
            assertEquals(  500, RomanNumber.parseRomanString( "D" ) );
            assertEquals(  100, RomanNumber.parseRomanString( "C" ) );
            assertEquals(   50, RomanNumber.parseRomanString( "L" ) );
            assertEquals(   10, RomanNumber.parseRomanString( "X" ) );
            assertEquals(    5, RomanNumber.parseRomanString( "V" ) );
            assertEquals(    1, RomanNumber.parseRomanString( "I" ) );
            assertEquals(    0, RomanNumber.parseRomanString( ""  ) );
        }
        
        public function testParseRomanStringAdditionRule():void
        {
            assertEquals( 1001, RomanNumber.parseRomanString( "MI" ) );
            assertEquals( 1500, RomanNumber.parseRomanString( "MD" ) );
            assertEquals( 1600, RomanNumber.parseRomanString( "MDC" ) );
            assertEquals( 267,  RomanNumber.parseRomanString( "CCLXVII" ) );
        }
        
        public function testParseRomanStringShortestNotationRule():void
        {
            assertEquals( 55, RomanNumber.parseRomanString( "LV" ) );
            assertEquals( 66, RomanNumber.parseRomanString( "LXVI" ) );
        }
        
        public function testParseRomanStringSubstractionRule():void
        {
            assertEquals( 40,   RomanNumber.parseRomanString( "XL" ) );
            assertEquals( 44,   RomanNumber.parseRomanString( "XLIV" ) );
            assertEquals( 49,   RomanNumber.parseRomanString( "XLIX" ) );
            assertEquals( 99,   RomanNumber.parseRomanString( "XCIX" ) );
            assertEquals( 900,  RomanNumber.parseRomanString( "CM" ) );
            assertEquals( 1900, RomanNumber.parseRomanString( "MCM" ) );
        }
        
        public function testParseRomanStringSpecialCase():void
        {
            assertEquals(  666, RomanNumber.parseRomanString( "DCLXVI"   )) ; //Using every symbol except M in descending order gives the beast number.
            assertEquals( 1444, RomanNumber.parseRomanString( "MCDXLIV"  )) ; //Smallest pandigital number (each symbol is used)
            assertEquals( 1666, RomanNumber.parseRomanString( "MDCLXVI"  )) ; //Largest efficient pandigital number (each symbol occurs exactly once)
            assertEquals( 1945, RomanNumber.parseRomanString( "MCMXLV"   )) ;
            assertEquals( 1997, RomanNumber.parseRomanString( "MCMXCVII" )) ;
            assertEquals( 1999, RomanNumber.parseRomanString( "MCMXCIX"  )) ;
        }  
        
        public function testParseRomanStringBadChars():void
        {
            assertEquals(  0, RomanNumber.parseRomanString( "A" ) );
            assertEquals(  0, RomanNumber.parseRomanString( "DCA" ) );  
            assertEquals(  0, RomanNumber.parseRomanString( "MCMXCIA" ) );
            assertEquals(  0, RomanNumber.parseRomanString( "MCMXCAI" ) );
        }
         
        public function testToString():void
        {
            var rn:RomanNumber = new RomanNumber( 2008 );
            assertEquals( "MMVIII", rn.toString() );
        }
        
        public function testValueOf():void
        {
            var rn:RomanNumber = new RomanNumber( 2008 );
            assertEquals( 2008, rn );
        }
    }
}