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
    import system.data.Map;
    import system.data.maps.SortedArrayMap;

    import flash.display.Sprite;

    public class SortedArrayMapExample2 extends Sprite 
    {
        public function SortedArrayMapExample2()
        {
            var map:SortedArrayMap = new SortedArrayMap() ;
            
            map.put( { id:5 } , { name:'name4' } ) ;
            map.put( { id:1 } , { name:'name1' } ) ;
            map.put( { id:3 } , { name:'name5' } ) ;
            map.put( { id:2 } , { name:'name2' } ) ;
            map.put( { id:4 } , { name:'name3' } ) ;
            
            trace("----- original Map") ;
            
            debug( map ) ; // {5:name4,1:name1,3:name5,2:name2,4:name3}
            
            trace("----- sort by key with sort() method") ;
            
            map.sortBy = SortedArrayMap.KEY ; // default
            
            map.options = SortedArrayMap.NUMERIC | SortedArrayMap.DESCENDING ;
            map.sortOn("id") ;
            debug( map ) ; // {5:name4,4:name3,3:name5,2:name2,1:name1}
            
            map.options = SortedArrayMap.NUMERIC  ;
            map.sortOn("id") ;
            debug( map ) ; // {1:name1,2:name2,3:name5,4:name3,5:name4}
            
            
            trace("----- sort by value with sort() method") ;
            
            map.sortBy = SortedArrayMap.VALUE ;
            
            map.options = SortedArrayMap.DESCENDING ;
            map.sortOn("name") ;
            debug( map ) ; // {3:name5,5:name4,4:name3,2:name2,1:name1}
            
            map.options = SortedArrayMap.NONE ;
            map.sortOn("name") ;
            debug( map ) ; // {1:name1,2:name2,4:name3,5:name4,3:name5}
        }
        
        public function debug( map:Map ):void
        {
        
            var vit:Iterator = map.iterator() ;
            var kit:Iterator = map.keyIterator() ;
            var value:* ;
            var key:*   ;
            var str:String = "{" ;
            while( vit.hasNext() ) 
            {
                value = vit.next() ;
                key   = kit.next() ;
                
                str += key.id + ":" + value.name ;
                
                if (vit.hasNext())
                {
                    str += "," ;
                }
            }
            str += "}" ;
            trace(str) ;
        }
    }
}
