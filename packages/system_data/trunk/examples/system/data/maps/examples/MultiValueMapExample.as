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
    import system.data.MultiMap;
    import system.data.maps.HashMap;
    import system.data.maps.MultiValueMap;
    
    import flash.display.Sprite;
    
    public class MultiValueMapExample extends Sprite 
    {
        public function MultiValueMapExample()
        {
            var map1:HashMap = new HashMap() ;
            
            map1.put("key1", "valueD1") ;
            map1.put("key2", "valueD2") ;
            
            trace ("> map1 : " + map1) ;
            trace ("> map1 containsKey 'key1' : " + map1.containsKey("key1")) ;
            
            trace ("--- use a map argument in constructor") ;
            
            var map:MultiValueMap = new MultiValueMap(map1) ;
            
            map.put("key1", "valueA1") ;
            map.put("key1", "valueA2") ;
            map.put("key1", "valueA3") ;
            map.put("key2", "valueA2") ;
            map.put("key2", "valueB1") ;
            map.put("key2", "valueB2") ;
            map.put("key3", "valueC1") ;
            map.put("key3", "valueC2") ;
            
            trace("init map    : " + map) ;
            trace("map toSource : " + map.toSource()) ;
            
            trace ("key1 >> " + map.get("key1")) ;
            trace ("key2 >> " + map.get("key2")) ;
            trace ("key3 >> " + map.get("key3")) ;
            
            var r:* = map.removeByKey("key1", "valueA2") ;
            trace( "map.removeByKey('key1', 'valueA2') : " + r ) ;
            
            // trace ("\r--- remove a value in key1 >> " + map.get("key1")) ;
            
            var it:Iterator ;
            
            trace ("\r--- use iterator") ;
            
            it = map.iterator() ;
            while(it.hasNext()) 
            {
                trace ("\t * " + it.next()) ;
            }
            
            trace ("\r--- use a key iterator : key1") ;
            it = map.iteratorByKey("key1") ;
            while(it.hasNext()) 
            {
                trace ("\t * " + it.next()) ;
            }
            
            trace ("\r--- putCollection key2 in key1") ;
            
            map.putCollection("key1", map.get("key2")) ;
            
            trace ("key1 >> " + map.get("key1")) ;
            
            trace ("\r--- different size") ;
            
            trace ("map size : " + map.size()) ;
            
            trace ("map totalSize : " + map.totalSize()) ;
            
            trace ("\r--- clone MultiMap") ;
            
            var clone:MultiMap = map.clone() ;
            
            clone.remove("key1") ;
            
            trace("clone : " + clone) ;
            trace ("clone size : " + clone.totalSize()) ;
            trace ("map size : " + map.totalSize()) ;
            
            trace ("\r--- valueIterator") ;
            it = map.valueIterator() ;
            while( it.hasNext() ) 
            {
                trace("\t> " + it.next()) ;
            }
        }
    }
}
