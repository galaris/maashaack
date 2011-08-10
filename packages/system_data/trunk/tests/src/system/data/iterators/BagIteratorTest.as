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

package system.data.iterators 
{
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.data.Iterator;    

    public class BagIteratorTest extends TestCase 
    {

        public function BagIteratorTest( name:String = "" )
        {
            super( name );
        }
        
        public function setUp():void
        {

        }
      
        public function tearDown():void
        {

        }             

        public function testConstructor():void
        {
            var i:Iterator ;
            
            try
            {
                i = new BagIterator(null,null) ;
                fail( "01-01 - constructor failed if the passed-in Bag is a null object.") ;     
            }
            catch( e:Error )
            {
                assertTrue( e is ArgumentError , "01-02 - constructor failed if the passed-in Bag is a null object." ) ;
                assertEquals
                ( 
                    e.message , 
                    "[object BagIterator] constructor failed, the passed-in Bag argument not must be 'null'." , 
                    "01-03 - constructor failed."
                );
            }
            
            
//            i = new BagIterator( new HashBag() , new ArrayIterator([]) ) ;
//            
//            assertNotNull(it, "02 - constructor failed") ; 
        } 
      
        
        
    }
}
