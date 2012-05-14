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
    import system.models.ChangeModel;
    import system.signals.Signal;
    import system.signals.Signaler;

    import flash.events.ActivityEvent;
    import flash.events.StatusEvent;
    
    /**
     * The abstract class to create the MicrophoneExpert and CameraExpert class.
     */
    public class MediaExpert extends ChangeModel
    {
        /**
         * Creates a new MediaExpert instance.
         */
        public function MediaExpert()
        {
            //
        }
        
        /**
         * Indicates if the expert use verbose debug mode or not.
         */
        public var verbose:Boolean = true ;
        
        
        /**
         * Emits a message when the media activity is changed.
         */
        public function get activity():Signaler
        {
            return _activity ;
        }
        
        /**
         * Emits a message when the media is muted.
         */
        public function get muted():Signaler
        {
            return _muted ;
        }
        
        /**
         * Emits a message when the media is unmuted.
         */
        public function get unmuted():Signaler
        {
            return _unmuted ;
        }
        
        /**
         * Updates the media.
         */
        public function update():void
        {
            // override this method.
        }
        
        /**
         * @private
         */
        protected const _activity:Signaler = new Signal() ;
        
        /**
         * @private
         */
        protected const _muted:Signaler = new Signal() ;
        
        /**
         * @private
         */
        protected const _unmuted:Signaler = new Signal() ;
        
        /**
         * Invoked when the activity of the media object is changing (Camera or Microphone).
         * @private
         */
        protected function _activityChange( e:ActivityEvent = null ):void
        {
            _activity.emit( e.activating , this ) ;
        }
        
        /**
         * Invoked when the media object status is changing (Camera or Microphone).
         * @private
         */
        protected function _statusChange( e:StatusEvent = null ):void
        {
            var code:String = e.code ;
            switch( code )
            {
                case CameraStatus.MUTED     :
                case MicrophoneStatus.MUTED :
                {
                    _muted.emit( this ) ;
                    break ;
                }
                
                case CameraStatus.UNMUTED     :
                case MicrophoneStatus.UNMUTED :
                {
                    _unmuted.emit( this ) ;
                    break ;
                }
            }
        }
    }
}
