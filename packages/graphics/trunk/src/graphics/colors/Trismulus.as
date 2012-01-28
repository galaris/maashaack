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

package graphics.colors 
{
    /**
     * Enumeration of all trismulus references (Reference values of a perfect reflecting diffuser).
     */
    public class Trismulus 
    {
        /// 2° (CIE 1931)
            	
        /**
         * The A illuminant reference (Incandescent) - 2° (CIE 1931).
         */
        public static const A_2:XYZ = new XYZ(109.85, 100, 35.585) ;
        
        /**
         * The C illuminant reference - 2° (CIE 1931).
         */
        public static const C_2:XYZ = new XYZ(98.074, 100, 118.232) ;
        
        /**
         * The D50 illuminant reference - 2° (CIE 1931).
         */
        public static const D50_2:XYZ = new XYZ(96.422, 100, 82.521) ;
        
        /**
         * The D55 illuminant reference - 2° (CIE 1931).
         */
        public static const D55_2:XYZ = new XYZ(95.682, 100, 92.149) ;
        
        /**
         * The D65 illuminant reference (Daylight) - 2° (CIE 1931).
         */
        public static const D65_2:XYZ = new XYZ(95.047, 100, 108.883) ;
        
        /**
         * The D75 illuminant reference - 2° (CIE 1931).
         */
        public static const D75_2:XYZ = new XYZ(94.972, 100, 122.638) ;
        
        /**
         * The F2 illuminant reference (Fluorescent) - 2° (CIE 1931).
         */
        public static const F2_2:XYZ = new XYZ(99.187, 100, 67.395) ;
        
        /**
         * The F7 illuminant reference - 2° (CIE 1931).
         */
        public static const F7_2:XYZ = new XYZ(95.044, 100, 108.755) ;
        
        /**
         * The F11 illuminant reference - 2° (CIE 1931).
         */
        public static const F11_2:XYZ = new XYZ(100.966, 100, 64.370) ;
        
        /// 10° (CIE 1964)
        
        /**
         * The A illuminant reference (Incandescent) - 10° (CIE 1964).
         */
        public static const A_10:XYZ = new XYZ(111.144, 100, 35.2) ;
        
        /**
         * The C illuminant reference - 10° (CIE 1964).
         */
        public static const C_10:XYZ = new XYZ(97.285, 100, 116.145) ;
        
        /**
         * The D50 illuminant reference - 10° (CIE 1964).
         */
        public static const D50_10:XYZ = new XYZ(96.720, 100, 81.427) ;
        
        /**
         * The D55 illuminant reference - 10° (CIE 1964).
         */
        public static const D55_10:XYZ = new XYZ(95.799, 100, 90.926) ;
        
        /**
         * The D55 illuminant reference (Daylight) - 10° (CIE 1964).
         */
        public static const D65_10:XYZ = new XYZ(94.811, 100, 107.304) ;
        
        /**
         * The D75 illuminant reference - 10° (CIE 1964).
         */
        public static const D75_10:XYZ = new XYZ(94.416, 100, 120.641) ;
        
        /**
         * The F2 illuminant reference (Fluorescent) - 10° (CIE 1964).
         */
        public static const F2_10:XYZ = new XYZ(103.280, 100, 69.026) ;
        
        /**
         * The F7 illuminant reference - 10° (CIE 1964).
         */
        public static const F7_10:XYZ = new XYZ(95.792, 100, 107.687) ;
        
        /**
         * The F11 illuminant reference - 10° (CIE 1964).
         */
        public static const F11_10:XYZ = new XYZ(103.866, 100, 65.627) ;
    }
}
