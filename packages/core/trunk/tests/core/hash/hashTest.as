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
  Portions created by the Initial Developers are Copyright (C) 2006-2012
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

package core.hash
{
    import flash.utils.ByteArray;
    
    import library.ASTUce.framework.TestCase;
    
    public class hashTest extends TestCase
    {
        private var _str0:String = "abcdefghijklmnopqrstuvwxyz1234567890";
        private var _str1:String = "hello world";
        private var _str2:String = "0123456789";
        private var _str3:String = " ";
        
        private var _key0:ByteArray;
        private var _key1:ByteArray;
        private var _key2:ByteArray;
        private var _key3:ByteArray;
        
        public function hashTest( name:String = "" )
        {
            super( name );
        }
        
        public function setUp():void
        {
            _key0 = new ByteArray();
            _key0.writeMultiByte( _str0, "UTF-8" );
            
            _key1 = new ByteArray();
            _key1.writeMultiByte( _str1, "UTF-8" );
            
            _key2 = new ByteArray();
            _key2.writeMultiByte( _str2, "UTF-8" );
            
            _key3 = new ByteArray();
            _key3.writeMultiByte( _str3, "UTF-8" );
        }
        
        public function tearDown():void
        {
            _key0 = null;
            _key1 = null;
            _key2 = null;
            _key3 = null;
        }
        
        public function testRS():void
        {
            assertEquals( 4097835502 , rs( _key0 ) );
            assertEquals( 3247313108 , rs( _key1 ) );
            assertEquals( 3157342001 , rs( _key2 ) );
            assertEquals(         32 , rs( _key3 ) );
        }
        
        public function testJS():void
        {
            assertEquals( 1651003062 , js( _key0 ) );
            assertEquals( 3161187078 , js( _key1 ) );
            assertEquals(  930588967 , js( _key2 ) );
            assertEquals( 2935291918 , js( _key3 ) );
        }
        
        public function testPJW():void
        {
            assertEquals( 126631744 , pjw( _key0 ) );
            assertEquals(  18131988 , pjw( _key1 ) );
            assertEquals( 108769001 , pjw( _key2 ) );
            assertEquals(        32 , pjw( _key3 ) );
        }
        
        public function testELF():void
        {
            assertEquals( 126631744 , elf( _key0 ) );
            assertEquals(  18131988 , elf( _key1 ) );
            assertEquals( 108769001 , elf( _key2 ) );
            assertEquals(        32 , elf( _key3 ) );
        }
        
        public function testBKDR():void
        {
            //default seed is 131
            assertEquals( 3153586616 , bkdr( _key0 ) );
            assertEquals( 1310283332 , bkdr( _key1 ) );
            assertEquals( 2525108581 , bkdr( _key2 ) );
            assertEquals(         32 , bkdr( _key3 ) );
        }
        
        public function testBKDR31():void
        {
            assertEquals( 2134697992 , bkdr( _key0, 31 ) );
            assertEquals( 1794106052 , bkdr( _key1, 31 ) );
            assertEquals( 1584875013 , bkdr( _key2, 31 ) );
            assertEquals(         32 , bkdr( _key3, 31 ) );
        }
        
        public function testBKDR1313():void
        {
            assertEquals( 1529523244 , bkdr( _key0, 1313 ) );
            assertEquals( 2343089372 , bkdr( _key1, 1313 ) );
            assertEquals( 2383507213 , bkdr( _key2, 1313 ) );
            assertEquals(         32 , bkdr( _key3, 1313 ) );
        }
        
        public function testBKDR13131():void
        {
            assertEquals( 2933456568 , bkdr( _key0, 13131 ) );
            assertEquals(   50879556 , bkdr( _key1, 13131 ) );
            assertEquals(  965475301 , bkdr( _key2, 13131 ) );
            assertEquals(         32 , bkdr( _key3, 13131 ) );
        }
        
        public function testBKDR131313():void
        {
            assertEquals( 2550573228 , bkdr( _key0, 131313 ) );
            assertEquals(   24154140 , bkdr( _key1, 131313 ) );
            assertEquals(   37203341 , bkdr( _key2, 131313 ) );
            assertEquals(         32 , bkdr( _key3, 131313 ) );
        }
        
        public function testSDBM():void
        {
            assertEquals( 3449571336 , sdbm( _key0 ) );
            assertEquals(  430867652 , sdbm( _key1 ) );
            assertEquals( 2833570821 , sdbm( _key2 ) );
            assertEquals(         32 , sdbm( _key3 ) );
        }
        
        public function testDJB():void
        {
            assertEquals( 729241521 , djb( _key0 ) );
            assertEquals( 894552257 , djb( _key1 ) );
            assertEquals( 995771986 , djb( _key2 ) );
            assertEquals(    177605 , djb( _key3 ) );
        }
        
        public function testDEK():void
        {
            assertEquals( 2923964919 , dek( _key0 ) );
            assertEquals( 2204797599 , dek( _key1 ) );
            assertEquals( 2875583397 , dek( _key2 ) );
            assertEquals(          0 , dek( _key3 ) );
        }
        
        public function testBRP():void
        {
            assertEquals( 1726880944 , brp( _key0 ) );
            assertEquals( 2113713764 , brp( _key1 ) );
            assertEquals( 1456331833 , brp( _key2 ) );
            assertEquals(         32 , brp( _key3 ) );
        }
        
        public function testFNV():void
        {
            assertEquals( 3243095106 , fnv( _key0 ) );
            assertEquals( 3484467168 , fnv( _key1 ) );
            assertEquals(  630372793 , fnv( _key2 ) );
            assertEquals(         32 , fnv( _key3 ) );
        }
        
        public function testAP():void
        {
            assertEquals(  882643939 , ap( _key0 ) );
            assertEquals( 2669898470 , ap( _key1 ) );
            assertEquals( 4225317007 , ap( _key2 ) );
            assertEquals( 1431655690 , ap( _key3 ) );
        }
    }
}