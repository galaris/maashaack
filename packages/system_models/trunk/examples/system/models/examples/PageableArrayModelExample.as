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
    import core.dump;
    
    import system.models.arrays.PageableArrayModel;
    
    import flash.display.Sprite;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
    
    [SWF(width="740", height="480", frameRate="24", backgroundColor="#666666")]
    
    public class PageableArrayModelExample extends Sprite
    {
        public function PageableArrayModelExample()
        {
            stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
            
            model = new PageableArrayModel( 2 ) ;
            
            // model.count =  3 ;
            
            model.initialized.connect( init ) ; 
            model.updated.connect( update ) ; 
            
            var datas:Array  = [] ;
            
            for ( var i:uint = 0 ; i < 20 ; i++ )
            {
                datas.push( { id:i } ) ;
            }
            
            model.init( datas , false , false ) ;
            
            model.currentPage = 2 ;
        }
        
        protected var model:PageableArrayModel ;
        
        protected function init( model:PageableArrayModel ):void
        {
            trace( model + " init" ) ;
        }
        
        protected function update( value:* , model:PageableArrayModel ):void
        {
            trace( model + " update " + model.currentPage + "/" + model.pageCount + " value:" + dump(value) ) ;
        }
        
        protected function keyDown( e:KeyboardEvent ):void
        {
            var code:uint = e.keyCode ;
            switch( code )
            {
                case Keyboard.LEFT :
                {
                    if ( model.hasPrevious() )
                    {
                        model.previous() ;
                    }
                    else
                    {
                        model.lastPage() ;
                    }
                    break ;
                }
                case Keyboard.RIGHT :
                {
                    if ( model.hasNext() )
                    {
                        model.next() ;
                    }
                    else
                    {
                        model.firstPage() ;
                    }
                    break ;
                }
                case Keyboard.SPACE :
                {
                    model.lock() ;
                    model.count = 4 ; // change the count value but not update the model.
                    model.unlock() ;
               }
            }
        }
    }
}
