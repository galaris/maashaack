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

package system.serializers.eden
    {
    import library.ASTUce.framework.*;
    
    import system.eden;
    
    public class SerializeTest extends TestCase
        {
        
        private var _pretty:Boolean;
        
        public function SerializeTest( name:String="" )
            {
            super( name );
            }
        
        public function setUp():void
            {
            _pretty = eden.prettyPrinting;
            eden.prettyPrinting = false;
            }
        
        public function tearDown():void
            {
            eden.prettyPrinting = _pretty;
            }
        
        public function testUndefined():void
            {
            assertEquals( eden.serialize( undefined ), "undefined" );
            }
        
        public function testNull():void
            {
            assertEquals( eden.serialize( null ), "null" );
            }
        
        public function testString():void
            {
            var empty:String   = eden.serialize( "" );
            var simple:String  = eden.serialize( "hello world" );
            var esc:String     = eden.serialize( "\b\t\v\n\f\r\"\'\\" );
            var unicode:String = eden.serialize( "♠♣♥♦" );
            
            assertEquals( empty , "\"\"" );
            assertEquals( simple , "\"hello world\"" );
            assertEquals( esc , "\"\\b\\t\\v\\n\\f\\r\\\"\\\'\\\\\"" );
            assertEquals( unicode , "\"\\u2660\\u2663\\u2665\\u2666\"" );
            }
        
        public function testBoolean():void
            {
            assertEquals( eden.serialize( true ), "true" );
            assertEquals( eden.serialize( false ), "false" );
            assertEquals( eden.serialize( new Boolean(false) ), "false" );
            }
        
        public function testNumber():void
            {
            assertEquals( eden.serialize( 123456789 ), "123456789" );
            assertEquals( eden.serialize( -1 ), "-1" );
            assertEquals( eden.serialize( 0.123 ), "0.123" );
            assertEquals( eden.serialize( 2e31 ), "2e+31" ); //test also with ECMA-262
            }
        
        public function testDate():void
            {
            var value:String  = eden.serialize( new Date( 133830000000 ) );
            var value2:String = eden.serialize( new Date( 133830000001 ) );
            var ymd:String    = eden.serialize( new Date(2007,5,1) );
            var ymdh:String   = eden.serialize( new Date(2007,5,1,2) );
            var ymdhm:String  = eden.serialize( new Date(2007,5,1,2,3) );
            var ymdhms:String = eden.serialize( new Date(2007,5,1,2,3,4) );
            
            assertEquals( value,  "new Date(1974,2,30)" );
            assertEquals( value2, "new Date(1974,2,30,0,0,0,1)" );
            assertEquals( ymd,    "new Date(2007,5,1)");
            assertEquals( ymdh,   "new Date(2007,5,1,2)");
            assertEquals( ymdhm,  "new Date(2007,5,1,2,3)");
            assertEquals( ymdhms, "new Date(2007,5,1,2,3,4)");
            }
        
        public function testArray():void
            {
            var a1:String  = eden.serialize( [1] );
            var a2:String  = eden.serialize( [1,2] );
            var a3:String  = eden.serialize( [1,2,3] );
            var mix:String = eden.serialize( [ null,undefined,true,false,"a",1,{},[] ] );
            
            assertEquals( a1,  "[1]" );
            assertEquals( a2,  "[1,2]" );
            assertEquals( a3,  "[1,2,3]" );
            assertEquals( mix, "[null,undefined,true,false,\"a\",1,{},[]]" );
            }
        
        /* note:
           be carefull here
           depending on the host the enumeration of elements
           either in objects or arrays can cause to generate a different order
           you write
           {a:1,b:2,c:[1,2,3]}
           but the serialization gives
           {c:[1,2,3],a:1,b:2}
           
           we'll flag that as "for in order"
           and those tests can be for now commented out if they fail on your host
        */
        public function testArrayComplex():void
            {
            var complex:String = eden.serialize( [ {a:1,b:2,c:[1,2,3]}, [{x:9,y:8},7,6,5] ] );
            var obj:* = eden.deserialize( complex );
            
            assertEquals( 1, obj[0].a );
            assertEquals( 2, obj[0].b );
            assertEquals( 1, obj[0].c[0] );
            assertEquals( 2, obj[0].c[1] );
            assertEquals( 3, obj[0].c[2] );
            assertEquals( 9, obj[1][0].x );
            assertEquals( 8, obj[1][0].y );
            assertEquals( 7, obj[1][1] );
            assertEquals( 6, obj[1][2] );
            assertEquals( 5, obj[1][3] );
            }
        
        public function testObject():void
            {
            var s1:String  = eden.serialize( {a:1} );
            var o1:*       = eden.deserialize( s1 );
            
            var s2:String  = eden.serialize( {a:1,b:2} );
            var o2:*       = eden.deserialize( s2 );
            
            var s3:String  = eden.serialize( {a:1,b:2,c:3} );
            var o3:*       = eden.deserialize( s3 );
            
            var mix:String = eden.serialize( { a:null, b:undefined, c:true, d:false, e:"a", f:1, g:{}, h:[] } );
            var mixD:*     = eden.deserialize( mix );
            
            assertEquals( 1, o1.a );
            
            assertEquals( 1,  o2.a );
            assertEquals( 2,  o2.b );
            
            assertEquals( 1,  o3.a );
            assertEquals( 2,  o3.b );
            assertEquals( 3,  o3.c );
            
            assertEquals( null, mixD.a );
            assertEquals( undefined, mixD.b );
            assertEquals( true, mixD.c );
            assertEquals( false, mixD.d );
            assertEquals( "a", mixD.e );
            assertEquals( 1, mixD.f );
            assertEquals( "{}", eden.serialize(mixD.g) );
            assertEquals( "[]", eden.serialize(mixD.h) );
            }
        
        }
    
    }
