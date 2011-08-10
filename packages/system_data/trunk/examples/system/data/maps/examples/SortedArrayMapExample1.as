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
    import system.comparators.NumberComparator;
    import system.comparators.StringComparator;
    import system.data.maps.SortedArrayMap;

    import flash.display.Sprite;

    public class SortedArrayMapExample1 extends Sprite 
    {
        public function SortedArrayMapExample1()
        {
            var map:SortedArrayMap = new SortedArrayMap( [0] , ["item0"] ) ;
            
            map.put( 1 , "item8" ) ;
            map.put( 3 , "item7" ) ;
            map.put( 2 , "item6" ) ;
            map.put( 5 , "item5" ) ;
            map.put( 4 , "item4" ) ;
            map.put( 7 , "item3" ) ;
            map.put( 6 , "item2" ) ;
            map.put( 8 , "item1" ) ;
            
            trace("----- original Map") ;
            
            trace( map ) ;
            
            trace("----- sort by key with sort() method") ;
            
            map.comparator = new NumberComparator() ;
            
            map.options = SortedArrayMap.NUMERIC | SortedArrayMap.DESCENDING ;
            map.sort() ;
            trace( map ) ;
            
            map.options = SortedArrayMap.NUMERIC ;
            map.sort() ;
            trace( map ) ;
            
            trace("----- sort by value with sort() method") ;
            
            map.comparator = new StringComparator() ;
            
            map.sortBy = SortedArrayMap.VALUE ;
            
            map.options = SortedArrayMap.DESCENDING ;
            map.sort() ;
            trace( map ) ;
            
            map.options = SortedArrayMap.NONE ;
            map.sort() ;
            trace( map ) ;
        }
    }
}
