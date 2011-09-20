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

package core.strings 
{
    import library.ASTUce.framework.TestCase;
    
    public class bytesToHumanReadableTest extends TestCase 
    {
        public function bytesToHumanReadableTest(name:String = "")
        {
            super(name);
        }
        
        public function testBytesToHumanReadableAuto():void
        {
            var u:uint = 1024 ;
            assertEquals( "0 B" , bytesToHumanReadable( 0 ) , "#1" ) ;
            assertEquals( "1 KB" , bytesToHumanReadable( u ) , "#2" ) ;
            assertEquals( "1 MB" , bytesToHumanReadable( u*u ) , "#3" ) ;
            assertEquals( "1 GB" , bytesToHumanReadable( u*u*u ) , "#4" ) ;
            assertEquals( "1 TB" , bytesToHumanReadable( u*u*u*u ) , "#5" ) ;
            assertEquals( "1 PB" , bytesToHumanReadable( u*u*u*u*u ) , "#6" ) ;
            assertEquals( "1 EB" , bytesToHumanReadable( u*u*u*u*u*u ) , "#7" ) ;
            assertEquals( "1 ZB" , bytesToHumanReadable( u*u*u*u*u*u*u ) , "#8" ) ;
            assertEquals( "1 YB" , bytesToHumanReadable( u*u*u*u*u*u*u*u ) , "#9" ) ;
        }
        
        public function testBytesToHumanReadableSI():void
        {
            var u:uint = 1000 ;
            
            assertEquals( "0 B" , bytesToHumanReadable( 0 , 2 , true ) , "#1" ) ;
            assertEquals( "1 KiB" , bytesToHumanReadable( u , 2 , true ) , "#2" ) ;
            assertEquals( "1 MiB" , bytesToHumanReadable( u*u , 2 , true ) , "#3" ) ;
            assertEquals( "1 GiB" , bytesToHumanReadable( u*u*u , 2 , true ) , "#4" ) ;
            assertEquals( "1 TiB" , bytesToHumanReadable( u*u*u*u , 2 , true ) , "#5" ) ;
            assertEquals( "1 PiB" , bytesToHumanReadable( u*u*u*u*u , 2 , true ) , "#6" ) ;
            assertEquals( "1 EiB" , bytesToHumanReadable( u*u*u*u*u*u , 2 , true ) , "#7" ) ;
            assertEquals( "1 ZiB" , bytesToHumanReadable( u*u*u*u*u*u*u , 2 , true ) , "#8" ) ;
            assertEquals( "1 YiB" , bytesToHumanReadable( u*u*u*u*u*u*u*u , 2 , true ) , "#9" ) ;
        }
        
        public function testBytesToHumanReadableForce():void
        {
            var u:uint = 1024 ;
            
            assertEquals( "0 GB"          , bytesToHumanReadable( 0 , 2 , false , "G" ) , "#1" ) ;
            assertEquals( "0.01 GB"       , bytesToHumanReadable( u , 2 , false , "G" ) , "#2" ) ;
            assertEquals( "0.01 GB"       , bytesToHumanReadable( u*u , 2 , false , "G" ) , "#3" ) ;
            assertEquals( "1 GB"          , bytesToHumanReadable( u*u*u , 2 , false , "G" ) , "#4" ) ;
            assertEquals( "1024 GB"       , bytesToHumanReadable( u*u*u*u , 2 , false , "G" ) , "#5" ) ;
            assertEquals( "1048576 GB"    , bytesToHumanReadable( u*u*u*u*u , 2 , false , "G" ) , "#6" ) ;
            assertEquals( "1073741824 GB" , bytesToHumanReadable( u*u*u*u*u*u , 2 , false , "G" ) , "#7" ) ;
        }
    }
}
