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
    import system.data.queues.CircularQueue;
    
    import flash.display.Sprite;
    
    [SWF(width="740", height="480", frameRate="24", backgroundColor="#666666")]
    
    public class CircularQueueExample extends Sprite 
    {
        public function CircularQueueExample()
        {
            var q:CircularQueue = new CircularQueue(5) ;
            
            trace ("maxSize : " + q.maxSize()) ;
            trace ("enqueue item1 : " + q.enqueue ("item1")) ;
            trace ("enqueue item2 : " + q.enqueue ("item2")) ;
            trace ("enqueue item3 : " + q.enqueue ("item3")) ;
            trace ("enqueue item4 : " + q.enqueue ("item4")) ;
            trace ("enqueue item5 : " + q.enqueue ("item5")) ;
            trace ("enqueue item6 : " + q.enqueue ("item6")) ;
            
            trace ("element : " + q.element()) ;
            trace ("dequeue : " + q.dequeue()) ;
            trace ("element : " + q.element()) ;
            trace ("size : " + q.size()) ;
            trace ("isFull : " + q.isFull()) ; 
            trace ("array : " + q.toArray()) ;
            
            trace("") ;
            
            trace ("queue : " + q) ;
            
            trace("") ;
            
            trace ("dequeue : " + q.dequeue()) ;
            trace ("enqueue item6 : " + q.enqueue("item6")) ;
            trace ("enqueue item7 : " + q.enqueue("item7")) ;
            trace ("peek : " + q.peek()) ;
            trace ("size : " + q.size()) ;
            trace ("isFull : " + q.isFull()) ; 
            
            trace("") ;
            
            trace ("q : " + q) ;
            
            trace ("------- clone") ;
            
            var clone:CircularQueue = q.clone() ;
            
            trace ("dequeue clone : " + clone.dequeue()) ;
            trace ("enqueue clone item8 : " + clone.enqueue("item8")) ;
            trace ("original queue : " + q) ;
            trace ("clone queue : " + clone) ;
            trace ("clone iterator :") ;
            
            var i:Iterator = clone.iterator() ;
            
            while (i.hasNext()) 
            {
                trace ("\t+ " + i.next()) ;
            }
            
            trace("clone.toSource : " + clone.toSource()) ;
        }
    }
}
