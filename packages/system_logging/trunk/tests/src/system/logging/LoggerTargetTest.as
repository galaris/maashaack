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
    import library.ASTUce.framework.ArrayAssert;
    import library.ASTUce.framework.TestCase;
    
    import system.errors.InvalidFilterError;
    import system.signals.Receiver;
    
    public class LoggerTargetTest extends TestCase 
    {
        public function LoggerTargetTest( name:String = "" )
        {
            super(name);
        }
        
        public var target:LoggerTarget ;
        
        public function setUp():void
        {
            target = new LoggerTarget() ;
        }
        
        public function tearDown():void
        {
            target = undefined  ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( target , "Constructor failed.") ;
        }
        
        public function testInterface():void
        {
            assertTrue( target is Receiver ) ;
        }
        
        public function testFactory():void
        {
            assertEquals( target.factory , Log , "01 - The factory property failed.") ;
            var factory:LoggerFactory = new LoggerFactory() ;
            target.factory = factory ;
            assertEquals( target.factory , factory , "02 - The factory property failed.") ;
        }
        
        public function testFilters():void
        {
            ArrayAssert.assertEquals( target.filters , ["*"] , "01 - filters property failed.") ;
            
            target.filters = ["test" , "test" ] ;
            ArrayAssert.assertEquals( target.filters , ["test"] , "02 - filters property failed.") ;
            
            target.filters = ["test", "system.*"] ;
            ArrayAssert.assertEquals( target.filters , ["test", "system.*"] , "03 - filters property failed.") ;
            
            target.filters = null ;
            ArrayAssert.assertEquals( target.filters , ["*"] , "04 - filters property failed.") ;
        }
        
        public function testFiltersWithNullFilter():void
        {
            try
            {
                target.filters = [ null ] ;
                fail("01-01 - if the filter is null the target must throws an error") ;
            }
            catch( e:Error )
            {
                assertTrue( e is InvalidFilterError , "02 - if the filter is null the target must throws an error") ;
                assertEquals( e.message , "filter must not be null or empty." , "01-03 - if the filter is null the target must throws an error") ;
            }
        }
        
        public function testFiltersWithAtLeastOneNullFilter():void
        {
            try
            {
                target.filters = ["hello" , null] ;
                fail("02-01 - if the filter is null the target must throws an error") ;
            }
            catch( e:Error )
            {
                assertTrue( e is InvalidFilterError , "02-02 - if the filter is null the target must throws an error") ;
                assertEquals( e.message , "filter must not be null or empty." , "02-03 - if the filter is null the target must throws an error") ;
            }
        }
    }
}
