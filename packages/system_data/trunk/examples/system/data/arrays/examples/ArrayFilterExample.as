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
    import system.data.arrays.ArrayFilter;
    
    import flash.display.Sprite;
    
    [SWF(width="740", height="480", frameRate="24", backgroundColor="#666666")]
    
    /**
     * Example of the system.data.arrays.ArrayFilter class.
     */
    public class ArrayFilterExample extends Sprite 
    {
        public function ArrayFilterExample()
        {
            filter = new ArrayFilter() ;
            
            filter.change.connect( change ) ;
            
            debug() ;
            //
            filter.setCaseInsensitive( true ) ;
            filter.setDescending( true ) ;
            filter.setNumeric( true ) ;
            filter.setReturnIndexedArray( true ) ;
            filter.setUniqueSort( true ) ;
            debug() ;
            //
            filter.setCaseInsensitive( false ) ;
            debug() ;
            //
            filter.setDescending( false ) ;
            debug() ;
            //
            filter.setNumeric( false ) ;
            debug() ;
            //
            filter.setReturnIndexedArray( false) ;
            debug() ;
            //
            filter.setUniqueSort( false ) ;
            debug() ;
        }
        
        public var filter:ArrayFilter ;
        
        public function debug():void
        {
            trace("filter                : " + filter.filter ) ;
            trace("is NONE               : " + filter.isNone() ) ;
            trace("is CASEINSENSITIVE    : " + filter.isCaseInsensitive() ) ;
            trace("is DESCENDING         : " + filter.isDescending() ) ;
            trace("is NUMERIC            : " + filter.isNumeric() ) ;
            trace("is RETURNINDEXEDARRAY : " + filter.isReturnIndexedArray() ) ;
            trace("is UNIQUESORT         : " + filter.isUniqueSort() ) ;
            trace("---") ;
        }
        
        public function change( filter:ArrayFilter ):void
        {
            trace( "# change : " + filter ) ;
        }
    }
}
