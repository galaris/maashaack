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

package system.logging 
{
    import library.ASTUce.framework.TestCase;

    public class LoggerStringsTest extends TestCase 
    {
        public function LoggerStringsTest( name:String = "" )
        {
            super(name);
        }
        
        public function testCHARS_INVALID():void
        {
            assertEquals( LoggerStrings.CHARS_INVALID , "The following characters are not valid\: []~$^&\/(){}<>+\=_-`!@#%?,\:;'\\" ) ;
        }
        
        public function testCHAR_PLACEMENT():void
        {
            assertEquals( LoggerStrings.CHAR_PLACEMENT , "'*' must be the right most character." ) ;
        }
        
        public function testEMPTY_FILTER():void
        {
            assertEquals( LoggerStrings.EMPTY_FILTER , "filter must not be null or empty." ) ;
        }
        
        public function testDEFAULT_CHANNEL():void
        {
            assertEquals( LoggerStrings.DEFAULT_CHANNEL , "" ) ;
        }
        
        public function testILLEGALCHARACTERS():void
        {
            assertEquals( LoggerStrings.ILLEGALCHARACTERS , "[]~$^&/\\(){}<>+=`!#%?,:;'\"@" ) ;
        }
        
        public function testINVALID_CHARS():void
        {
            assertEquals( LoggerStrings.INVALID_CHARS , "Channels can not contain any of the following characters : []~$^&/\\(){}<>+=`!#%?,:;'\"@" ) ;
        }
        
        public function testINVALID_LENGTH():void
        {
            assertEquals( LoggerStrings.INVALID_LENGTH , "Channels must be at least one character in length." ) ;
        }
        
        public function testINVALID_TARGET():void
        {
            assertEquals( LoggerStrings.INVALID_TARGET , "Log, Invalid target specified." ) ;
        }
    }
}
