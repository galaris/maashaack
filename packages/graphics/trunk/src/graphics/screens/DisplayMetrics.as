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

package graphics.screens
{
    import core.strings.fastformat;
    /**
     * A structure describing general information about a display, such as its size, density, and font scaling.
     */
    public final class DisplayMetrics
    {
        /**
         * Creates a new DisplayMetrics instance.
         */
        public function DisplayMetrics()
        {
            setToDefaults() ;
        }
        
        /**
         * The reference density used throughout the system.
         */
        public static const DENSITY_DEFAULT:int = ScreenDensity.mdpi.valueOf() ;
        
        /**
         * The device's density.
         */
        public static const DENSITY_DEVICE:int = runtimeDPI.valueOf() ;
        
        /**
         * The logical density of the display.
         */
        public var density:Number = 0.0 ;
        
        /**
         * The screen density expressed as dots-per-inch.
         */
        public var densityDpi:int = 0 ;
        
        /**
         * The absolute height of the display in pixels.
         */
        public var heightPixels:int = 0 ;
        
        /**
         * A scaling factor for fonts displayed on the display.
         */
        public var scaledDensity:Number = 0.0 ;
        
        /**
         * The absolute width of the display in pixels.
         */
        public var widthPixels:int = 0 ;
        
        /**
         * The exact physical pixels per inch of the screen in the X dimension.
         */
        public var xdpi:Number = 0.0 ;
        
        /**
         * The exact physical pixels per inch of the screen in the Y dimension.
         */
        public var ydpi:Number = 0.0 ;
        
        /**
         * Sets the DisplayMetrics object with the passed-in DisplayMetrics object.
         */
        public function setTo( dm:DisplayMetrics ):void
        {
            widthPixels   = dm.widthPixels ;
            heightPixels  = dm.heightPixels ;
            density       = dm.density ;
            densityDpi    = dm.densityDpi ;
            scaledDensity = dm.scaledDensity ;
            xdpi          = dm.xdpi ;
            ydpi          = dm.ydpi ;
        }
        
        /**
         * Initialize the DisplayMetrics object with this default valut.
         */
        public function setToDefaults():void 
        {
            widthPixels   = 0 ;
            heightPixels  = 0 ;
            density       = DENSITY_DEVICE / DENSITY_DEFAULT ;
            densityDpi    = DENSITY_DEVICE ;
            scaledDensity = density ;
            xdpi          = DENSITY_DEVICE ;
            ydpi          = DENSITY_DEVICE ;
        }
        
        /**
         * Returns the String representation of the object.
         * @return the String representation of the object.
         */
        public function toString( expression:String = "[DisplayMetrics density:{0} densityDPI:{1} heightPixels:{2} scaledDensity:{3} widthPixels:{4} xdpi:{5} ydpi:{6}]" ):String
        {
            return fastformat( expression || "" , density , densityDpi, heightPixels, scaledDensity, widthPixels, xdpi, ydpi ) ;
        }
    }
}
