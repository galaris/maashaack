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
    import system.data.Collection;
    import system.data.ListIterator;
    import system.data.collections.ArrayCollection;
    import system.data.lists.LinkedList;
    
    import flash.display.Sprite;
    
    [SWF(width="740", height="480", frameRate="24", backgroundColor="#666666")]
    
    public class LinkedListExample extends Sprite 
    {
        public function LinkedListExample()
        {
            var c1:Collection = new ArrayCollection() ;
            c1.add("item0") ;
            c1.add("item1") ;
            c1.add("item2") ;
            
            trace("c1 : " + c1) ;
            
            var c2:Collection = new ArrayCollection() ;
            c2.add("item3") ;
            c2.add("item4") ;
            c2.add("item5") ;
            c2.add("item6") ;
            
            trace("c2 : " + c2) ;
            
            var list:LinkedList = new LinkedList( c1 ) ;
            trace(list) ;
            
            trace ("-----") ;
            
            trace ("create list : " + list) ;
            trace ("list toSource : " + list.toSource()) ;
            
            trace ("-----") ;
            
            trace("list.contains('item1') : " + list.contains("item1") ) ;
            trace("list.contains('item10') : " + list.contains("item10") ) ;
            
            trace ("-----") ;
            
            list.addAt(2,'test');
            trace("list.addAt(2,'test')" + list ) ;
            
            trace ("-----") ;
            
            list.addAll( c2 ) ;
            trace("list.addAll( c2 )" + list ) ;
            
            trace ("-----") ;
            
            list.remove("item2") ;
            trace ("list.remove('item4') : " + list) ;
            
            list.removeAt(2) ;
            trace ("list.removeAt(2) : " + list) ;
            
            
            list.removeFirst() ;
            trace ("list.removeFirst() : " + list) ;
            
            list.removeLast() ;
            trace ("list.removeLast() : " + list) ;
            
            trace ("-----") ;
            
            list.removeAt(1, 2) ;
            trace ("list.removeAt(1,2) : " + list) ;
            
            try
            {
                list.removeAt(10, 1) ;
            }
            catch( e:Error )
            {
                trace("list.removeAt(10,1) : " + e) ;
            }
            
            trace ("-----") ;
            
            list.add("item6") ;
            list.add("item7") ;
            list.add("item8") ;
            list.add("item9") ;
            list.add("item10") ;
            list.add("item11") ;
            
            list.removeRange(1, 3) ;
            trace ("list.removeRange(1,3) : " + list) ;
            
            try
            {
                list.removeRange(4,1) ;
            }
            catch(e:Error)
            {
                trace("list.removeRange(4,1) : " + e) ;
            }
            
            trace ("-----") ;
            
            list.addAllAt(0, c2) ;
            trace ("list.addAllAt(0, c2) : " + list) ;
            
            trace ("--- ListIterator") ;
            
            var it:ListIterator ;
            
            it = list.listIterator() ;
            var i:uint = 0 ;
            while (it.hasNext())
            {
                it.next() ;
                it.set("element" + i++) ;
            }
            trace ("list after set : " + list) ;
            
            trace ("---") ;
            
            it = list.listIterator( list.size() ) ;
            while(it.hasPrevious())
            {
                trace (it.previous()) ;
            }
            
            //*
            trace ("-----") ;
            
            list.addFirst("begin") ;
            trace ("list.addFirst('begin') : " + list) ;
             
            list.addLast("end") ;
            trace ("list.addLast('end') : " + list) ;
            
            trace ("list.getFirst() : " + list.getFirst()) ;
            trace ("list.getLast() : " + list.getLast()) ;
            
            list.removeFirst() ;
            trace ("list.removeFirst() : " + list) ;
            
            list.removeLast() ;
            trace ("list.removeLast() : " + list) ;
            
            trace ("---- clear") ;
            
            list.clear() ;
            
            trace("list.size() : " + list.size()) ;
            trace("list.isEmpty : " + list.isEmpty() ) ;
        }
    }
}
