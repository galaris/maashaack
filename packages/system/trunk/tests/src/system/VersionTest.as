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

package system
    {
    import library.ASTUce.framework.*;
    
    import system.Version;
    
    /* TestSuite that runs all the ES4a tests
    */
    public class VersionTest extends TestCase
        {
        
        public function VersionTest( name:String="" )
            {
            super( name );
            }
        
        public function testConstructorEmpty():void
            {
            var v:Version = new Version();
            
            assertTrue( v is Version );
            assertEquals( 0, v.valueOf() );
            assertEquals( "0", v.toString() );
            }
        
        public function testConstructor():void
            {
            var v:Version = new Version( 1, 2, 3, 4 );
            
            assertEquals( 1, v.major );
            assertEquals( 2, v.minor );
            assertEquals( 3, v.build );
            assertEquals( 4, v.revision );
            assertEquals( 0x12030004, uint(v) );
            assertEquals( "1.2.3.4", v.toString() );
            }
        
        public function testConstructorNull():void
            {
            var n:* = null; //to avoid compiler warning
            var v:Version = new Version( n, n, n, n );
            
            assertEquals( 0, v.valueOf() );
            assertEquals( "0.0.0.0", v.toString(4) );
            }
        
        public function testConstructorMajorBoundary():void
            {
            var v1:Version = new Version( 1, 0, 0, 255 );
            
            //268435711 = 0x100000ff
            var v2:Version = new Version( 0x100000ff );
            
            assertEquals( v1, v2 );
            assertEquals( 0x100000ff, v1.valueOf() );
            assertEquals( 0x100000ff, v2.valueOf() );
            }
        
        public function testBoundaries():void
            {
            var v:Version = new Version();
            
            v.major = 0xfff;
            assertEquals( 0xf, v.major );
            /* note:
               before we were using int
               but now as we use uint the compiler will generate
               warning if you try to assign a negative number
            */
            //v.major = -500;
            //assertEquals( 0xf, v.major );
            
            v.minor = 0xfff;
            assertEquals( 0xf, v.minor );
            //v.minor = -500;
            //assertEquals( 0xf, v.minor );
            
            v.build = 0xfff;
            assertEquals( 0xff, v.build );
            //v.build = -500;
            //assertEquals( 0xff, v.build );
            
            v.revision = 0xffffff;
            assertEquals( 0xffff, v.revision );
            //v.revision = -500;
            //assertEquals( 0xffff, v.revision );
            
            }
        
        public function testOperators():void
            {
            var v1:Version   = new Version( 1 );
            var v2:Version   = new Version( 2 );
            var v2000:Version = new Version( 2, 0, 0, 0 );
            var v2001:Version = new Version( 2, 0, 0, 1 );
            
            assertEquals( v1, v1 );
            assertFalse( v1 == v2 );
            assertTrue( v1 != v2 );
            assertTrue( v2000 <= v2 );
            assertTrue( v2001 >= v2 );
            assertTrue( v2000 < v2001 );
            assertTrue( v2001 > v2000 );
            
            //perharps split those tests to "testOperators2"
            v2000.revision++;
            assertEquals( v2000, v2001 );
            
            v2.major--;
            assertEquals( v2, v1 );
            }
        
        public function testToString():void
            {
            var v1234:Version = new Version( 1, 2, 3, 4 );
            var v0000:Version = new Version( 0, 0, 0, 0 );
            
            assertEquals( "1.2.3.4", v1234.toString() );
            assertEquals( "0", v0000.toString() );
            
            assertEquals( "1", v1234.toString(1) );
            assertEquals( "1.2", v1234.toString(2) );
            assertEquals( "1.2.3", v1234.toString(3) );
            assertEquals( "1.2.3.4", v1234.toString(4) );
            
            assertEquals( "0", v0000.toString(1) );
            assertEquals( "0.0", v0000.toString(2) );
            assertEquals( "0.0.0", v0000.toString(3) );
            assertEquals( "0.0.0.0", v0000.toString(4) );
            
            assertEquals( "0", v0000.toString(10) );
            assertEquals( "0", v0000.toString(-10) );
            }
        
        public function testFromString():void
            {
            var v1234:Version = Version.fromString( "1.2.3.4" );
            assertEquals( "1.2.3.4", v1234.toString() );
            
            var v123:Version = Version.fromString( "1.2.3" );
            assertEquals( "1.2.3", v123.toString() );
            
            var v12:Version = Version.fromString( "1.2" );
            assertEquals( "1.2", v12.toString() );
            
            var v1:Version = Version.fromString( "1" );
            assertEquals( "1", v1.toString() );
            }
        
        public function testFromStringMalformed():void
            {
            var v01:Version = Version.fromString();
            var v02:Version = Version.fromString( null );
            var v03:Version = Version.fromString( "" );
            assertEquals( "0", v01.toString() );
            assertEquals( "0", v02.toString() );
            assertEquals( "0", v03.toString() );
            
            var dot03:Version = Version.fromString( "..." );
            var dot02:Version = Version.fromString( ".." );
            var dot01:Version = Version.fromString( "." );
            assertEquals( "0", dot03.toString() );
            assertEquals( "0", dot02.toString() );
            assertEquals( "0", dot01.toString() );
            }
        
        public function testFromNumber():void
            {
            var v0:Version = new Version( 1, 0, 0, 255 );
            //268435711 = 0x100000ff
            var n1:Number  = 0x100000ff;
            var v1:Version = Version.fromNumber( n1 );
            var n2:Number  = 268435711;
            var v2:Version = Version.fromNumber( n2 );
            
            var v3:Version = new Version( 10, 5, 50, 10000 );
            var n3:Number  = v3.valueOf();
            var v4:Version = Version.fromNumber( n3 );
            
            //TODO: add tests for special values: MAX_VALUE, etc.
            //var v5:Version = Version.fromNumber( Number.POSITIVE_INFINITY );
            
            assertEquals( v0, v1 );
            assertEquals( v0, v2 );
            assertEquals( n1, v1.valueOf() );
            assertEquals( n2, v2.valueOf() );
            assertEquals( v3, v4 );
            assertEquals( n3, v3.valueOf() );
            assertEquals( n3, v4.valueOf() );
            }
        
        public function testValue():void
            {
            var v0Max:Version = new Version( 15 );
            var v1Max:Version = new Version(  0, 15 );
            var v2Max:Version = new Version(  0,  0, 255 );
            var v3Max:Version = new Version(  0,  0,   0, 65535 );
            var v4Max:Version = new Version( 15, 15, 255, 65535 );
            
            assertEquals( 15, v0Max.major );
            assertEquals( 0xf0000000, v0Max.valueOf() );

            assertEquals( 15, v1Max.minor );
            assertEquals( 0x0f000000, v1Max.valueOf() );
            
            assertEquals( 255, v2Max.build );
            assertEquals( 0x00ff0000, v2Max.valueOf() );
            
            assertEquals( 65535, v3Max.revision );
            assertEquals( 0x0000ffff, v3Max.valueOf() );
            
            assertEquals( 0xffffffff, v4Max.valueOf() );
            
            }
        
        }
    
    }
