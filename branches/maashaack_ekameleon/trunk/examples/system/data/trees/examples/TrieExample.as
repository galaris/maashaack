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
    import system.comparators.AlphaComparator;
    import system.data.trees.Trie;
    
    import flash.display.Sprite;
    
    public class TrieExample extends Sprite 
    {
        public function TrieExample()
        {
            var trie:Trie = new Trie() ;
            
            trie.add( "car" , "value1" ) ;
            trie.add( "cat" , "value2" ) ;
            trie.add( "dog" , "value3" ) ;
            trie.add( "DOG" , "value4" ) ;
            
            trace( "trie : " + trie ) ; // dog car cat
            
            trace( "trie.toArray() : " + trie.toArray() ) ; // value3,value1,value2
            trace( "trie.toArray(new AlphaComparator()) : " + trie.toArray(new AlphaComparator()) ) ; // value3,value1,value2
            
            trace( "trie.numTries : " + trie.numTries ) ; // 3
            trace( "trie.size()   : " + trie.size()   ) ; // 3
            
            trace( "trie.search( 'car' ) : " + trie.search( "car" ) ) ; // value1
            trace( "trie.search( 'cat' ) : " + trie.search( "cat" ) ) ; // value2
            trace( "trie.search( 'dog' ) : " + trie.search( "dog" ) ) ; // value3
            
            var search:Trie = trie.search( "ca" ) as Trie ;
            if ( search != null )
            {
                trace( "trie.search( 'ca' ) : " + search ) ; // car cat
            }
            
            trace( "trie.searchExact('ca')  : " + trie.searchExact("ca")  ) ; // null
            trace( "trie.searchExact('car') : " + trie.searchExact("car") ) ; // value1
            trace( "trie.searchExact('cat') : " + trie.searchExact("cat") ) ; // value2
            
            trace( "trie.firstElement() : " + trie.firstElement() ) ;
            
            trace( "trie.getTrieFor('c')   : " + trie.getTrieFor("c") ) ;
            trace( "trie.getTrieFor('ca')  : " + trie.getTrieFor("ca") ) ;
            trace( "trie.getTrieFor('car') : " + trie.getTrieFor("car") ) ;
            trace( "trie.getTrieFor('cat') : " + trie.getTrieFor("cat") ) ;
            
            ///////////////////
            
            trace( "trie.aerageClash : " + trie.aerageClash ) ;
            
            trace( "trie.entries  : " + trie.entries  ) ;
            trace( "trie.entry    : " + trie.entry    ) ;
            trace( "trie.position : " + trie.position ) ;
            
            trace( "search.entries  : " + search.entries  ) ;
            trace( "search.entry    : " + search.entry    ) ;
            trace( "search.position : " + search.position ) ;
            
            ///////////////////
            
            trie.remove("car") ;
            trace( trie ) ; // cat dog
            trace( trie.size() ) ; // 2
            
            trie.remove("dog") ;
            trace( trie ) ; // cat
            trace( trie.size() ) ; // 1
            
            trie.remove("cat") ;
            trace( trie ) ; // 
            trace( trie.size() ) ; // 0
            
            trace( "trie.isEmpty() : " + trie.isEmpty() ) ;
        }
    }
}