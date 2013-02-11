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
  Portions created by the Initial Developers are Copyright (C) 2006-2013
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
    
    public class crcTest extends TestCase
    {
        private var _str0:String = "123456789";
        
        private var _key0:ByteArray;
        
        public function crcTest( name:String = "" )
        {
            super( name );
        }
        
        public function setUp():void
        {
            _key0 = new ByteArray();
            _key0.writeMultiByte( _str0, "UTF-8" );
            
        }
        
        public function tearDown():void
        {
            _key0 = null;
        }
        
        //8bits
        
        public function testCRC8():void
        {
            var crc:crc8 = new crc8();
                crc.update( _key0 );
            
            assertEquals( 0xbc  , crc.valueOf() );
            assertEquals(  "bc" , crc.toString() );
            assertEquals(  0xff , crc.length );
        }
        
        public function testCRC8ITU():void
        {
            var crc:crc8_itu = new crc8_itu();
                crc.update( _key0 );
            
            assertEquals( 0xa1  , crc.valueOf() );
            assertEquals(  "a1" , crc.toString() );
            assertEquals(  0xff , crc.length );
        }
        
        public function testCRC8ATM():void
        {
            var crc:crc8_atm = new crc8_atm();
                crc.update( _key0 );
            
            assertEquals( 0xf4  , crc.valueOf() );
            assertEquals(  "f4" , crc.toString() );
            assertEquals(  0xff , crc.length );
        }
        
        public function testCRC8CCITT():void
        {
            var crc:crc8_ccitt = new crc8_ccitt();
                crc.update( _key0 );
            
            assertEquals( 0xd2  , crc.valueOf() );
            assertEquals(  "d2" , crc.toString() );
            assertEquals(  0xff , crc.length );
        }
        
        public function testCRC8MAXIM():void
        {
            var crc:crc8_maxim = new crc8_maxim();
                crc.update( _key0 );
            
            assertEquals( 0xa1  , crc.valueOf() );
            assertEquals(  "a1" , crc.toString() );
            assertEquals(  0xff , crc.length );
        }
        
        public function testCRC8ICODE():void
        {
            var crc:crc8_icode = new crc8_icode();
                crc.update( _key0 );
            
            assertEquals( 0x7e  , crc.valueOf() );
            assertEquals(  "7e" , crc.toString() );
            assertEquals(  0xff , crc.length );
        }
        
        public function testCRC8J1850():void
        {
            var crc:crc8_j1850 = new crc8_j1850();
                crc.update( _key0 );
            
            assertEquals( 0x4b  , crc.valueOf() );
            assertEquals(  "4b" , crc.toString() );
            assertEquals(  0xff , crc.length );
        }
        
        public function testCRC8WCDMA():void
        {
            var crc:crc8_wcdma = new crc8_wcdma();
                crc.update( _key0 );
            
            assertEquals( 0x25 ,  crc.valueOf() );
            assertEquals(  "25" , crc.toString() );
            assertEquals(  0xff , crc.length );
        }
        
        public function testCRC8ROHC():void
        {
            var crc:crc8_rohc = new crc8_rohc();
                crc.update( _key0 );
            
            assertEquals( 0xd0  , crc.valueOf() );
            assertEquals(  "d0" , crc.toString() );
            assertEquals(  0xff , crc.length );
        }
        
        public function testCRC8DARC():void
        {
            var crc:crc8_darc = new crc8_darc();
                crc.update( _key0 );
            
            assertEquals( 0x15  , crc.valueOf() );
            assertEquals(  "15" , crc.toString() );
            assertEquals(  0xff , crc.length );
        }
        
        //16bits
        
        public function testCRC16():void
        {
            var crc:crc16 = new crc16();
                crc.update( _key0 );
            
            assertEquals( 0xbb3d  , crc.valueOf() );
            assertEquals(  "bb3d" , crc.toString() );
            assertEquals(  0xffff , crc.length );
        }
        
        public function testCRC16BUYPASS():void
        {
            var crc:crc16_buypass = new crc16_buypass();
                crc.update( _key0 );
            
            assertEquals( 0xfee8  , crc.valueOf() );
            assertEquals(  "fee8" , crc.toString() );
            assertEquals(  0xffff , crc.length );
        }
        
        public function testCRC16DDS10():void
        {
            var crc:crc16_dds10 = new crc16_dds10();
                crc.update( _key0 );
            
            assertEquals( 0x9ecf  , crc.valueOf() );
            assertEquals(  "9ecf" , crc.toString() );
            assertEquals(  0xffff , crc.length );
        }
        
        public function testCRC16EN13757():void
        {
            var crc:crc16_en13757 = new crc16_en13757();
                crc.update( _key0 );
            
            assertEquals( 0xc2b7  , crc.valueOf() );
            assertEquals(  "c2b7" , crc.toString() );
            assertEquals(  0xffff , crc.length );
        }
        
        public function testCRC16TELEDISK():void
        {
            var crc:crc16_teledisk = new crc16_teledisk();
                crc.update( _key0 );
            
            assertEquals(  0xfb3  , crc.valueOf() );
            assertEquals(   "fb3" , crc.toString() );
            assertEquals(  0xffff , crc.length );
        }
        
        public function testCRC16MODBUS():void
        {
            var crc:modbus = new modbus();
                crc.update( _key0 );
            
            assertEquals( 0x4b37  , crc.valueOf() );
            assertEquals(  "4b37" , crc.toString() );
            assertEquals(  0xffff , crc.length );
        }
        
        public function testCRC16MAXIM():void
        {
            var crc:crc16_maxim = new crc16_maxim();
                crc.update( _key0 );
            
            assertEquals( 0x44c2  , crc.valueOf() );
            assertEquals(  "44c2" , crc.toString() );
            assertEquals(  0xffff , crc.length );
        }
        
        public function testCRC16USB():void
        {
            var crc:crc16_usb = new crc16_usb();
                crc.update( _key0 );
            
            assertEquals( 0xb4c8  , crc.valueOf() );
            assertEquals(  "b4c8" , crc.toString() );
            assertEquals(  0xffff , crc.length );
        }
        
        public function testCRC16T10DIF():void
        {
            var crc:crc16_t10dif = new crc16_t10dif();
                crc.update( _key0 );
            
            assertEquals( 0xd0db  , crc.valueOf() );
            assertEquals(  "d0db" , crc.toString() );
            assertEquals(  0xffff , crc.length );
        }
        
        public function testCRC16DECTX():void
        {
            var crc:crc16_dect_x = new crc16_dect_x();
                crc.update( _key0 );
            
            assertEquals( 0x7f ,  crc.valueOf() );
            assertEquals(  "7f" , crc.toString() );
        }
        
        public function testCRC16DECTR():void
        {
            var crc:crc16_dect_r = new crc16_dect_r();
                crc.update( _key0 );
            
            assertEquals(   0x7e  , crc.valueOf() );
            assertEquals(    "7e" , crc.toString() );
            assertEquals(  0xffff , crc.length );
        }
        
        public function testCRC16DNP():void
        {
            var crc:crc16_dnp = new crc16_dnp();
                crc.update( _key0 );
            
            assertEquals( 0x82ea  , crc.valueOf() );
            assertEquals(  "82ea" , crc.toString() );
            assertEquals(  0xffff , crc.length );
        }
        
        public function testCRC16XMODEM():void
        {
            var crc:xmodem = new xmodem();
                crc.update( _key0 );
            
            assertEquals( 0x31c3  , crc.valueOf() );
            assertEquals(  "31c3" , crc.toString() );
            assertEquals(  0xffff , crc.length );
        }
        
        public function testCRC16CCITTFALSE():void
        {
            var crc:crc16_ccitt_false = new crc16_ccitt_false();
                crc.update( _key0 );
            
            assertEquals( 0x29b1  , crc.valueOf() );
            assertEquals(  "29b1" , crc.toString() );
            assertEquals(  0xffff , crc.length );
        }
        
        public function testCRC16AUGCCITT():void
        {
            var crc:crc16_aug_ccitt = new crc16_aug_ccitt();
                crc.update( _key0 );
            
            assertEquals( 0xe5cc  , crc.valueOf() );
            assertEquals(  "e5cc" , crc.toString() );
            assertEquals(  0xffff , crc.length );
        }
        
        public function testCRC16GENIBUS():void
        {
            var crc:crc16_genibus = new crc16_genibus();
                crc.update( _key0 );
            
            assertEquals( 0xd64e  , crc.valueOf() );
            assertEquals(  "d64e" , crc.toString() );
            assertEquals(  0xffff , crc.length );
        }
        
        public function testCRC16KERMIT():void
        {
            var crc:kermit = new kermit();
                crc.update( _key0 );
            
            assertEquals( 0x8921  , crc.valueOf() );
            assertEquals(  "8921" , crc.toString() );
            assertEquals(  0xffff , crc.length );
        }
        
        public function testCRC16X25():void
        {
            var crc:x25 = new x25();
                crc.update( _key0 );
            
            assertEquals( 0x906e  , crc.valueOf() );
            assertEquals(  "906e" , crc.toString() );
            assertEquals(  0xffff , crc.length );
        }
        
        public function testCRC16MCRF4XX():void
        {
            var crc:crc16_mcrf4xx = new crc16_mcrf4xx();
                crc.update( _key0 );
            
            assertEquals( 0x6f91 ,  crc.valueOf() );
            assertEquals(  "6f91" , crc.toString() );
            assertEquals(  0xffff , crc.length );
        }
        
        public function testCRC16RIELLO():void
        {
            var crc:crc16_riello = new crc16_riello();
                crc.update( _key0 );
            
            assertEquals( 0x63d0  , crc.valueOf() );
            assertEquals(  "63d0" , crc.toString() );
            assertEquals(  0xffff , crc.length );
        }
        
        
        //32bits
        
        public function testCRC32():void
        {
            var crc:crc32 = new crc32();
                crc.update( _key0 );
            
            assertEquals( 0xcbf43926  , crc.valueOf() );
            assertEquals(  "cbf43926" , crc.toString() );
            assertEquals(  0xffffffff , crc.length );
        }
        
        public function testCRC32_BZIP2():void
        {
            var crc:crc32_bzip2 = new crc32_bzip2();
                crc.update( _key0 );
            
            assertEquals( 0xfc891918  , crc.valueOf() );
            assertEquals(  "fc891918" , crc.toString() );
            assertEquals(  0xffffffff , crc.length );
        }
        
        public function testCRC32C():void
        {
            var crc:crc32_c = new crc32_c();
                crc.update( _key0 );
            
            assertEquals( 0xe3069283  , crc.valueOf() );
            assertEquals(  "e3069283" , crc.toString() );
            assertEquals(  0xffffffff , crc.length );
        }
        
        public function testCRC32D():void
        {
            var crc:crc32_d = new crc32_d();
                crc.update( _key0 );
            
            assertEquals( 0x87315576  , crc.valueOf() );
            assertEquals(  "87315576" , crc.toString() );
            assertEquals(  0xffffffff , crc.length );
        }
        
        public function testCRC32_MPEG2():void
        {
            var crc:crc32_mpeg2 = new crc32_mpeg2();
                crc.update( _key0 );
            
            assertEquals ( 0x376e6e7  ,  crc.valueOf() );
            assertEquals(   "376e6e7" , crc.toString() );
            assertEquals(  0xffffffff , crc.length );
        }
        
        public function testCRC32_POSIX():void
        {
            var crc:crc32_posix = new crc32_posix();
                crc.update( _key0 );
            
            assertEquals( 0x765e7680  , crc.valueOf() );
            assertEquals(  "765e7680" , crc.toString() );
            assertEquals(  0xffffffff , crc.length );
        }
        
        public function testCRC32Q():void
        {
            var crc:crc32_q = new crc32_q();
                crc.update( _key0 );
            
            assertEquals( 0x3010bf7f  , crc.valueOf() );
            assertEquals(  "3010bf7f" , crc.toString() );
            assertEquals(  0xffffffff , crc.length );
        }
        
        public function testJAMCRC():void
        {
            var crc:jamcrc = new jamcrc();
                crc.update( _key0 );
            
            assertEquals( 0x340bc6d9  , crc.valueOf() );
            assertEquals(  "340bc6d9" , crc.toString() );
            assertEquals(  0xffffffff , crc.length );
        }
        
        public function testXFER():void
        {
            var crc:xfer = new xfer();
                crc.update( _key0 );
            
            assertEquals( 0xbd0be338 ,  crc.valueOf() );
            assertEquals(  "bd0be338" , crc.toString() );
            assertEquals(  0xffffffff , crc.length );
        }
        
        public function testCRC32K():void
        {
            var crc:crc32_k = new crc32_k();
                crc.update( _key0 );
            
            assertEquals(  0x85a3197  , crc.valueOf() );
            assertEquals(   "85a3197" , crc.toString() );
            assertEquals(  0xffffffff , crc.length );
        }
    }
}