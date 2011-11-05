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
    import core.reflect.getClassPath;
    
    /**
     * The enumeration of the quantity of pixels within a physical area of the screen ; usually referred to as dpi (dots per inch).
     */
    public final class ScreenDensity
    {
        /**
         * Creates a new ScreenDensity instance.
         * @param value The value of the enumeration.
         * @param name The name key of the enumeration.
         */
        public function ScreenDensity( value:int = 0 , name:String = "" )
        {
            _value = value ;
            _name  = name  ;
        }
        
        /**
         * Resources for low-density (ldpi) screens (~120dpi). (Scaling ratio 0.75x.)
         */
        public static const ldpi:ScreenDensity = new ScreenDensity( 120 , "ldpi" ) ;
        
        /**
         * Resources for medium-density (mdpi) screens (~160dpi). (This is the baseline density.)
         */
        public static const mdpi:ScreenDensity = new ScreenDensity( 160 , "mdpi" ) ;
        
        /**
         * Resources for high-density (hdpi) screens (~240dpi). (Scaling ratio 1.5x.)
         */
        public static const hdpi:ScreenDensity = new ScreenDensity( 240 , "hdpi" ) ;
        
        /**
         * Resources for extra high-density (xhdpi) screens (~320dpi). (Scaling ratio 2.0x.)
         */
        public static const xhdpi:ScreenDensity = new ScreenDensity( 320 , "xhdpi" ) ;
        
        /**
         * Resources for all densities. 
         * These are density-independent resources. 
         * The system does not scale resources tagged with this qualifier, regardless of the current screen's density.
         */
        public static const nodpi:ScreenDensity = new ScreenDensity( 0 , "nodpi" ) ;
        
        /**
         * Resources for screens somewhere between mdpi and hdpi; approximately 213 dpi.
         */
        public static const tvdpi:ScreenDensity = new ScreenDensity( 213 , "tvdpi" ) ;
        
        /**
         * Matches the specified DPI value to a <code>ScreenDensity</code> value.
         *  @param dpi The DPI value.  
         *  @return The corresponding <code>ScreenDensity</code> value.
         */
        public static function getPreferredScreenDensity( dpi:int ):ScreenDensity
        {
            if ( dpi <= 140 )
            {
                return ldpi ;
            }
            
            if ( dpi <= 180 )
            {
                return mdpi ;
            }
            
            if ( dpi <= 280 )
            {
                return hdpi ;
            }
            
            if ( dpi <= 340 )
            {
                return xhdpi ;
            }
            
            return nodpi ;
        }
        
        /**
         * Returns the source code String representation of the object.
         * @return the source code String representation of the object.
         */
        public function toSource( indent:int = 0 ):String
        {
            var classname:String = getClassPath( this , true );
            if( _name != "" )
            {
                return classname + "." + _name ;
            }
            return classname;
        }
        
        /**
         * Returns the String representation of the object.
         * @return the String representation of the object.
         */
        public function toString():String
        {
            return _name;
        }
        
        /**
         * Returns the primitive value of the object.
         * @return the primitive value of the object.
         */
        public function valueOf():int
        {
            return _value;
        }
        
        /**
         * @private
         */
        protected var _name:String ;
        
        /**
         * @private
         */
        protected var _value:int ;
    }
}
