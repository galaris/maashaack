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
    
    import system.models.maps.MapModel;
    
    import flash.display.Sprite;
    
    [SWF(width="740", height="480", frameRate="24", backgroundColor="#666666")]
    
    public class MapModelExample extends Sprite
    {
        public function MapModelExample()
        {
            model = new MapModel() ;
            
            trace( "# model primary key : " + model.primaryKey ) ;
            
            model.added.connect( added ) ;
            model.beforeChanged.connect( beforeChanged ) ;
            model.changed.connect( changed ) ;
            model.cleared.connect( cleared ) ;
            model.removed.connect( removed ) ;
            model.updated.connect( updated ) ;
            
            model.add( o1 ) ;
            model.add( o2 ) ;
            model.add( o3 ) ;
            
            trace( "#  model.get('key1') == o1 : " + ( model.get("key1") == o1 ) ) ;
            trace( "#  model.get('key1') == o4 : " + ( model.get("key1") == o4 ) ) ;
            
            model.update( o4 ) ;
            
            model.current = o1 ;
            model.current = o2 ;
            
            model.remove( o1 ) ;
            
            model.clear() ;
        }
        
        protected var model:MapModel ;
        
        protected var o1:Object = { id : "key1" } ;
        protected var o2:Object = { id : "key2" } ;
        protected var o3:Object = { id : "key3" } ;
        protected var o4:Object = { id : "key1" } ;
        
        protected function added( value:* , model:MapModel ):void
        {
            trace( model + " added : " + dump(value) ) ;
        }
        
        protected function beforeChanged( value:* , model:MapModel ):void
        {
            trace( model + " beforeChanged : " + dump(value) ) ;
        }
        
        protected function changed( value:* , model:MapModel ):void
        {
            trace( model + " changed : " + dump(value) ) ;
        }
        
        protected function cleared( model:MapModel ):void
        {
            trace( model + " cleared" ) ;
        }
        
        protected function removed( value:* , model:MapModel ):void
        {
            trace( model + " removed : " + dump(value) ) ;
        }
        
        protected function updated( value:* , model:MapModel ):void
        {
            trace( model + " updated : " + dump(value) ) ;
            trace( "#  model.get('key1') == o1 : " + ( model.get("key1") == o1 ) ) ;
            trace( "#  model.get('key1') == o4 : " + ( model.get("key1") == o4 ) ) ;
        }
    }
}
