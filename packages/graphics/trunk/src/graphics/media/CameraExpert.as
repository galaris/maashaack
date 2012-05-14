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
  Portions created by the Initial Developers are Copyright (C) 2006-2012
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


package graphics.media 
{
    import flash.events.ActivityEvent;
    import flash.events.StatusEvent;
    import flash.media.Camera;
    
    /**
     * This expert can manage a Camera reference.
     */
    public class CameraExpert extends MediaExpert 
    {
        /**
         * Creates a new CameraExpert instance.
         * @param option The CameraOption reference to set the current Camera object.
         * @param name Specifies which camera to get, as determined from the array returned by the names property. For most applications, get the default camera by omitting this parameter.
         */
        public function CameraExpert( option:CameraOption = null , name:* = null  )
        {
            this.name  = name ;
            this.current = option ;
        }
        
        /**
         * Indicates the Camera reference of the expert by name.
         */
        public function get camera():Camera
        {
            return _camera ;
        }
        
        /**
         * Determinates or change the name of the Camera of the expert.
         */
        public function get name():String
        {
            return _camera.name ;
        }
        
        /**
         * @private
         */
        public function set name( value:String ):void
        {
            dispose() ;
            _camera = Camera.getCamera( value ) ;
            if ( _camera )
            {
                _camera.addEventListener( ActivityEvent.ACTIVITY , _activityChange ) ;
                _camera.addEventListener( StatusEvent.STATUS     , _statusChange   ) ;
                update() ;
            }
        }
        
        /**
         * @private
         */
        public override function set current( o:* ):void
        {
            super.current = o ;
            update() ;
        }
        
        /**
         * Dispose the object.
         */
        public function dispose():void
        {
            if ( _camera )
            {
                _camera.removeEventListener( ActivityEvent.ACTIVITY , _activityChange ) ;
                _camera.removeEventListener( StatusEvent.STATUS     , _statusChange   ) ;
                _camera = null ;
            }
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the <code class="prettyprint">IValidator</code> object validate the value. Overrides this method in your concrete IModelObject class.
         * @param value the object to test.
         * @return <code class="prettyprint">true</code> is this specific value is valid.
         */
        public override function supports( value:* ):Boolean 
        {
            return value is CameraOption ;
        }
        
        /**
         * Updates the media.
         */
        public override function update():void
        {
            if( !isLocked() )
            {
                if ( _camera && _current )
                {   
                    (_current as CameraOption).apply( _camera ) ;
                }
            }
        }
        
        /**
         * @private
         */
        private var _camera:Camera ;
    }
}
