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

package graphics.desktop
{
    import graphics.geom.AspectRatio;
    import graphics.screens.DisplayMetrics;
    import graphics.screens.PIXEL_TO_INCH;
    import graphics.screens.runtimeDPI;
    
    import system.signals.Signal;
    
    import flash.display.Stage;
    import flash.events.Event;
    import flash.events.StageOrientationEvent;
    
    /**
     * Provides information about the native display size and density.
     */
    public final class NativeDisplay
    {
        /**
         * Creates a new NativeDisplay instance.
         * @param stage The Stage reference to initialize the NativeDisplay instance.
         */
        public function NativeDisplay( stage:Stage = null )
        {
            this.stage = stage ;
        }
        
        /**
         * The aspect ratio of the application.
         */
        public function get aspectRatio():AspectRatio
        {
            return new AspectRatio( _metrics.widthPixels , _metrics.heightPixels ) ;
        }
        
        /**
         * Indicates if the NativeDisplay instance is available (The Stage reference not must be null).
         */
        public function get available():Boolean
        {
            return _stage != null ;
        }
        
        /**
         * Indicates the height of the display.
         */
        public function get height():int
        {
            return _metrics.heightPixels ;
        }
        
        /**
         * Gets display metrics that describe the size and density of this display.
         */
        public function get metrics():DisplayMetrics
        {
            return _metrics ;
        }
        
        /**
         * Emited a message when the stage orientation changes.
         */
        public function get orientationChange():Signal
        {
            return _orientationChange ;
        }
        
        /**
         * Emited a message when the stage orientation begins changing.
         */
        public function get orientationChanging():Signal
        {
            return _orientationChanging ;
        }
        
        /**
         * Emited a message when the stage is resized.
         */
        public function get resize():Signal
        {
            return _resizer ;
        }
        
        /**
         * The Stage reference of the application.
         */
        public function get stage():Stage
        {
            return _stage ;
        }
        
        /**
         * The Stage reference of the application.
         */
        public function set stage( stage:Stage ):void
        {
            if( _stage )
            {
//                _stage.removeEventListener( StageOrientationEvent.ORIENTATION_CHANGE   , _change   ) ;
//                _stage.removeEventListener( StageOrientationEvent.ORIENTATION_CHANGING , _changing ) ;
//                _stage.removeEventListener( Event.RESIZE                               , _resize   ) ;
            }
            _stage = stage ;
            if( _stage )
            {
                //_stage.addEventListener( StageOrientationEvent.ORIENTATION_CHANGE   , _change   , false ) ;
                //_stage.addEventListener( StageOrientationEvent.ORIENTATION_CHANGING , _changing , false ) ;
                //_stage.addEventListener( Event.RESIZE                               , _resize   , false ) ;
            }
            setToDefaults() ;
        }
        
        /**
         * Indicates the width of the display.
         */
        public function get width():int
        {
            return _metrics.widthPixels ;
        }
        
        /**
         * Sets the object with this default values.
         */
        protected function setToDefaults():void
        {
            _metrics.setToDefaults() ;
            if( _stage )
            {
                // var orientation:String = _stage.orientation ; // http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/display/StageOrientation.html
                
                _metrics.heightPixels = _stage.stageHeight ;
                _metrics.widthPixels  = _stage.stageWidth  ;
                
                if( descriptor.device == DeviceType.desktop )
                {
                    _metrics.heightPixels = ( descriptor.fullScreen ) ? _stage.fullScreenHeight : _stage.stageHeight ;
                    _metrics.widthPixels  = ( descriptor.fullScreen ) ? _stage.fullScreenWidth  : _stage.stageWidth  ;
                }
                else
                {
                    _metrics.heightPixels = _stage.fullScreenHeight ;
                    _metrics.widthPixels  = _stage.fullScreenWidth   ;
                }
                
                _metrics.densityDpi    = runtimeDPI.valueOf() ;
                _metrics.density       = runtimeDPI.valueOf() / DisplayMetrics.DENSITY_DEFAULT ;
                _metrics.xdpi          = _metrics.widthPixels  * PIXEL_TO_INCH ;
                _metrics.ydpi          = _metrics.heightPixels * PIXEL_TO_INCH ;
                _metrics.scaledDensity = runtimeDPI.density ;
            }
        }
        
        /**
         * @private
         */
        protected const _metrics:DisplayMetrics = new DisplayMetrics();
        
        /**
         * @private
         */
        protected const _orientationChange:Signal = new Signal() ;
        
        /**
         * @private
         */
        protected const _orientationChanging:Signal = new Signal() ;
        
        /**
         * @private
         */
        protected const _resizer:Signal = new Signal() ;
        
        /**
         * @private
         */
        protected var _stage:Stage ;
        
        /**
         * @private
         */
        protected function _change( e:StageOrientationEvent ):void
        {
            e.preventDefault() ;
            e.stopImmediatePropagation() ;
            setToDefaults() ;
            _orientationChange.emit( e.beforeOrientation , e.afterOrientation ) ;
        }
        
        /**
         * @private
         */
        protected function _changing( e:StageOrientationEvent ):void
        {
            e.preventDefault() ;
            e.stopImmediatePropagation() ;
            setToDefaults() ;
            _orientationChanging.emit( e.beforeOrientation , e.afterOrientation ) ;
        }
        
        /**
         * @private
         */
        protected function _resize( e:Event ):void
        {
            setToDefaults() ;
            _resizer.emit() ;
        }
    }
}
