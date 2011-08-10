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
package examples 
{
    import system.data.Iterator;
    import system.data.collections.ArrayCollection;
    
    import flash.display.Sprite;
    
    [SWF(width="740", height="480", frameRate="24", backgroundColor="#666666")]
    
    public class ArrayCollectionExample extends Sprite 
    {
        public function ArrayCollectionExample()
        {
            var ar:Array           = ["item1", "item2", "item3", "item4"] ;
            var co:ArrayCollection = new ArrayCollection( ar ) ;
            
            trace ("---- Collection methods") ;
            
            trace ( "insert item5 : " + co.add("item5") ) ;
            
            trace ( "contains items : " + co.contains("item2") ) ;
            
            trace ( "get(2) : " + co.get(2) ) ;
            
            trace ( "isEmpty : " + co.isEmpty() ) ;
            
            trace ( "remove : " + co.remove("item5") ) ;
            
            trace ( "size : " + co.size() ) ;
            
            trace ("toArray : " + co.toArray() ) ;
            
            trace ( "toString : " + co.toString() ) ;
            
            trace ( "toSource : " + co.toSource()) ;
            
            trace ("---- iterator") ;
            
            var it:Iterator = co.iterator() ;
            
            while ( it.hasNext() ) 
            {
                trace ( it.next() ) ;
            }
            
            trace ("---- optional methods") ;
            
            var c1:ArrayCollection = new ArrayCollection(["item1", "item3"]) ;
            var c2:ArrayCollection = new ArrayCollection(["item5", "item6"]) ;
            var c3:ArrayCollection = new ArrayCollection(["item2", "item4"]) ;
            
            trace("co : " + co) ;
            trace("c1 : " + c1) ;
            trace("c2 : " + c2) ;
            
            trace("co containsAll c1 : " + co.containsAll( c1 ) ) ;
            trace("co containsAll c2 : " + co.containsAll( c2 ) ) ;
            
            trace("co insertAll c2 : " + co.addAll( c2 ) ) ;
            trace("co removeAll c2 : " + co.removeAll( c1 ) ) ;
            
            trace("co retainAll c3 : " + co.retainAll( c3 ) ) ;
            
            trace("co : " + co) ;
        }
    }
}
