
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
    import system.data.Set;
    import system.data.sets.ArraySet;
    
    import flash.display.Sprite;
    
    public class ArraySetExample extends Sprite 
    {
        public function ArraySetExample()
        {
            var s:ArraySet = new ArraySet([17, 68]) ;
            
            trace("set add 12 : " + s.add(12)) ;
            trace("set add 24 : " + s.add(24)) ;
            trace("set add 48 : " + s.add(48)) ;
            
            trace("set : " + s) ;
            
            trace("set.toSource : " + s.toSource()) ;
            
            trace("---- iterator()") ;
            
            var it:Iterator = s.iterator() ;
            while( it.hasNext() ) 
            {
                trace(it.next()) ;
            }
            
            trace("---- clone()") ;
            
            var s2:Set = s.clone() ;
            
            trace("clone : " + s2) ;
            
            trace("---- equals()") ;
            
            trace("equals : " + s.equals(s2) ) ;
            
            trace("---- add()") ;
            
            s.add("test") ;
            s.add("coucou") ;
            
            s2.add(150) ;
            s2.add("hello") ;
            s2.add(true) ;
            s2.add("world") ;
            
            // remove
            
            s2.remove(17) ;
            
            trace("s : " + s) ;
            trace("s2 : " + s2) ;
            
            // --- removeAll
            
            trace("removeAll : " + s.removeAll(s2)) ;
            
            trace("s : " + s) ;
            
            trace("---- set.toArray : " + s.toArray()) ;
        }
    }
}
