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
    import system.data.collections.ArrayCollection;
    import system.data.maps.MultiSetMap;
    
    import flash.display.Sprite;
    
    public class MultiSetMapExample extends Sprite 
    {
        public function MultiSetMapExample()
        {
            var s:MultiSetMap = new MultiSetMap() ;
            
            trace("----- Test put()") ;
            
            trace("put key1:valueA1 : " + s.put("key1", "valueA1")) ;
            trace("put key1:valueA2 : " + s.put("key1", "valueA2")) ;
            trace("put key1:valueA2 : " + s.put("key1", "valueA2")) ;
            trace("put key1:valueA3 : " + s.put("key1", "valueA3")) ;
            trace("put key2:valueA2 : " + s.put("key2", "valueA2")) ;
            trace("put key2:valueB1 : " + s.put("key2", "valueB1")) ;
            trace("put key2:valueB2 : " + s.put("key2", "valueB2")) ;
            
            trace("size : " + s.size()) ;
            trace("totalSize : " + s.totalSize()) ;
            
            trace("---- Test toArray") ;
            
            var ar:Array = s.toArray() ;
            trace("s.toArray : " + ar) ;
            
            trace("----- Test contains") ;
            
            trace("contains valueA1 : " + s.contains("valueA1") ) ;
            trace("contains valueA1 in key1 : " + s.containsByKey("key1", "valueA1") ) ;
            trace("contains valueA1 in key2 : " + s.containsByKey("key2", "valueA1") ) ;
            
            trace("---- Test removeBy(key, value)") ;
            
            trace("remove key1:valueA2 : " + s.removeByKey("key1", "valueA2")) ;
            trace("put    key1:valueA2 : " + s.put("key1", "valueA2")) ;
            trace("put    key1:valueA2 : " + s.put("key1", "valueA2")) ;
            
            trace("---- Test remove(key)") ;
            
            trace("remove key2 : " + s.remove("key2")) ;
            trace("size : " + s.size()) ;
            
            trace("---- Test putCollection(key, co:Collection)") ;
            
            var co:Collection = new ArrayCollection(["valueA1", "valueA4", "valueA1"]) ;
            
            s.putCollection("key1", co) ;
            
            trace("s : " + s) ;
        }
    }
}
