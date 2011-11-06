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

package graphics.display
{
    import graphics.transitions.FrameTimer;

    import system.process.Lockable;

    import flash.display.Sprite;
    import flash.events.Event;
    
    /**
     * The Movable Object Block (MOB) defines an advanced Sprite object.
     */
    public class MOB extends Sprite implements Lockable
    {
        /**
         * Creates a new MOB instance.
         */
        public function MOB()
        {
            addEventListener( Event.ADDED_TO_STAGE     , _addedToStage    ) ;
            addEventListener( Event.REMOVED_FROM_STAGE , removedFromStage ) ;
        }
        
        /**
         * Launch an event with a delayed interval.
         */
        public function doLater():void 
        {
            if ( isLocked() ) 
            {
                return ;
            }
            if( ___timer___.timer.connected() )
            {
                ___timer___.timer.disconnect( redraw ) ;
            }
            ___timer___.timer.connect( redraw , 0 , true ) ;
            ___timer___.start() ;
        }
        
        /**
         * Indicates if the object is locked.
         */
        public function isLocked():Boolean
        {
            return _locked > 0 ;
        }
        
        /**
         * Locks the object.
         */
        public function lock():void
        {
            _locked ++ ;
        }
        
        /**
         * Reset the lock security of the object.
         */
        public function resetLock():void 
        {
            _locked = 0 ;
        }
        
        /**
         * Unlocks the display.
         */
        public function unlock():void
        {
            _locked = Math.max( _locked - 1  , 0 ) ;
        }
        
        /**
         * Update the display.
         */
        public function update():void 
        {
            
        }
        
        /**
         * @private
         */
        protected var _changed:Boolean ;
        
        /**
         * @private
         */ 
        protected var _locked:uint ;
        
        /**
         * Invoked when the sprite is added to the stage.
         */
        protected function addedToStage( e:Event = null ):void
        {
            //
        }
        
        /**
         * Defines a change in the sprite and invalidate the stage rendering. 
         */
        protected function change():void
        {
            _changed = true;
            invalidate();
        }
        
        /**
         * Invalidate the Stage reference of the sprite.
         */
        protected function invalidate():void 
        {
            if ( stage ) 
            {
                stage.invalidate() ;
            }
        }
        
        /**
         * Invoked when the sprite is removed from the stage.
         */
        protected function removedFromStage( e:Event = null ):void
        {
            //
        }
        
        /**
         * Redraws the sprite.
         */
        protected function redraw():void 
        {
            if( ___timer___.running )
            {
                ___timer___.stop() ;
            }
            update() ;
        }
        
        /**
         * Invoked when the stage is rendering.
         */
        protected function renderStage( e:Event ):void
        {
            if ( _changed ) 
            {
                redraw() ;
            }
        }
        
        
        /**
         * @private
         */
        private const ___timer___:FrameTimer = new FrameTimer(24, 1) ;
        
        /**
         * Invoked when the sprite is added to the stage.
         */
        private function _addedToStage( e:Event = null ):void
        {
            addedToStage( e ) ;
            stage.addEventListener(Event.RENDER, renderStage );
            if ( _changed && stage ) 
            {
                stage.invalidate() ;
            }
        }
    }
}
