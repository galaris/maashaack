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
    import system.data.Bag;
    import system.data.Collection;
    import system.data.Set;
    import system.data.bags.ArrayBag;
    import system.data.collections.ArrayCollection;
    
    import flash.display.Sprite;
    
    [SWF(width="740", height="480", frameRate="24", backgroundColor="#666666")]
    
    public class ArrayBagExample extends Sprite 
    {
        public function ArrayBagExample()
        {
            var c1:Collection = new ArrayCollection( ["item1", "item1", "item3"] ) ;
            var c2:Collection = new ArrayCollection( ["item1", "item2", "item3", "item4", "item5"] ) ;
            
            trace (" c1 collection : " + c1) ;
            trace (" c2 collection : " + c2) ;
            
            trace ("---- create a new HashBag") ;
            
            var bag:Bag = new ArrayBag() ;
            
            trace (" bag : " + bag) ;
            
            trace ("---- add") ;
            
            trace (" + bag addAll c1 : " + bag.addAll(c1)) ;
            trace (" + bag addAll c2 : " + bag.addAll(c2)) ;
            
            trace (" bag : " + bag) ;
            
            trace (" > bag.toSource : " + bag.toSource()) ;
            
            trace ("---- containsAll") ;
            
            trace (" > bag containsAll c2 : " + bag.containsAll(c2)) ;
            
            trace ("--------------- add") ;
            
            trace (" + bag add item6 : " + bag.add("item6")) ;
            trace (" bag : " + bag ) ;
            
            trace (" + bag add item2 : " + bag.add("item2")) ;
            trace (" bag : " + bag ) ;
            
            trace (" + bag addCopies 2xitem2 : " + bag.addCopies("item2", 2)) ;
            trace (" bag : " + bag ) ;
                
            trace ("---- remove") ;
            trace (" > bag removeCopies 1 x item2 : " + bag.removeCopies("item2", 1)) ;
                
            trace ("---- size") ;
            trace (" - bag getCount item2 : " + bag.getCount("item2")) ;
            trace (" > bag size : " + bag.size()) ;
            
            trace ("---- retain") ;
            trace (" > bag : " + bag) ;
            trace (" > bag retainAll c1 : " + bag.retainAll(c1)) ;
            trace (" bag : " + bag) ;
                    
            trace ("----") ;
            
            var s:Set = bag.uniqueSet() ;
            trace(" bag uniqueSet : " + s) ;
        }
    }
}
