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
    import system.data.iterators.PageByPageIterator;
    import system.eden;
    
    import flash.display.Sprite;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
    
    [SWF(width="740", height="480", frameRate="24", backgroundColor="#666666")]
    
    /**
     * Basic example to use the PageByPageIterator class.
     */
    public class PageByPageIteratorExample extends Sprite 
    {
        public function PageByPageIteratorExample()
        {
            var ar:Array = [1, 2, 3, 4, 5, 6, 7, 8] ;
            
            it = new PageByPageIterator( ar , 3 ) ;
            
            next() ; // > next:1,2,3 currentPage:1 current:[1,2,3]
            next() ; // > next:4,5,6 currentPage:2 current:[4,5,6]
            next() ; // > next:7,8 currentPage:3 current:[7,8]
            next() ; // > next:1,2,3 currentPage:1 current:[1,2,3]
            prev() ; // > prev:7,8 currentPage:3 current:[7,8]
            
            it.seek(0) ;
            trace( "> seek(0) >> currentPage:" +  it.currentPage() + " current:" + eden.serialize(it.current()) ) ; 
            //> seek(0) >> currentPage:0 current:[]
            
            next() ; // > next:1,2,3 currentPage:1 current:[1,2,3]
            
            it.lastPage() ;
            trace( "> lastPage() >> currentPage:" +  it.currentPage() + " current:" + eden.serialize(it.current()) ) ; 
            // > lastPage() >> currentPage:3 current:[7,8]
            
            it.firstPage() ;
            trace( "> firstPage() >> currentPage:" +  it.currentPage() + " current:" + eden.serialize(it.current()) ) ; 
            // > firstPage() >> currentPage:1 current:[1,2,3]
            
            stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
        }
        
        public var it:PageByPageIterator ;
        
        public function next():void
        {
            if (!it.hasNext())
            {
                it.reset() ;
            }
            var next:* = it.next() ;
            trace( "> next:" + next + " currentPage:" + it.currentPage() + " current:" + eden.serialize(it.current()) ) ;
        }
        
        public function prev():void
        {
            var prev:* ;
            if ( it.hasPrevious())
            {
                prev = it.previous() ;
            }
            else
            {
                it.lastPage() ;
                prev = it.current() ;
            }
            trace( "> prev:" + prev + " currentPage:" + it.currentPage() + " current:" + eden.serialize(it.current()) ) ;
        }
        
        protected function keyDown( e:KeyboardEvent ):void
        {
            var code:uint = e.keyCode ;
            switch( code ) 
            {
                case Keyboard.LEFT :
                {
                    prev() ;
                    break ;
                }
                case Keyboard.RIGHT :
                {
                    next() ;
                    break ;
                }
                case Keyboard.RIGHT :
                {
                    it.lastPage() ;
                    break ;
                }
            }
        }
    }
}
