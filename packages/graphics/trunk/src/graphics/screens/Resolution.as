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

package graphics.screens
{
    import graphics.geom.AspectRatio;
    
    /**
     * The enumeration of all standard display resolutions. 
     * More information about <a href="http://en.wikipedia.org/wiki/Display_resolution">Display Resolution in Wikipedia</a>.
     */
    public final class Resolution extends AspectRatio
    {
        /**
         * Creates a new Resolution instance.
         * @param width The width int value use to defines the resolution.
         * @param height The height int value use to defines the resolution. 
         */
        public function Resolution(  width:int = 0 , height:int = 0 )
        {
            super( width , height , true ) ;
        }
        
        /////// Video Graphics Array
        
        /**
         * The Quarter-QVGA (4:3) - width x height : 160x120. 
         * The term Quarter-QVGA signifies a resolution of one fourth the number of pixels in a QVGA display
         */
        public static const QQVGA:Resolution = new Resolution( 160 , 120 ) ;
        
        /**
         * The Half-QVGA (4:3) - width x height : 240x160. 
         * As seen on the Game Boy Advance, this resolution is half of QVGA, which is itself a quarter of VGA, which is 640×480 pixels.
         */
        public static const HQVGA:Resolution = new Resolution( 240 , 160 ) ;
        
        /**
         * The QVGA (4:3) - width x height : 320x240. Quarter Video Graphics Array
         */
        public static const QVGA:Resolution = new Resolution( 320 , 240 ) ;
        
        /**
         * The WQVGA (5:3) - width x height : 432x240. Wide QVGA or WQVGA is any display resolution having the same height in pixels as QVGA, but wider. This definition is consistent with other 'wide' versions of computer displays.
         */
        public static const WQVGA:Resolution = new Resolution( 432 , 240 ) ;
        
        /**
         * The HVGA (Half-size VGA) screens (3:2) - width x height : 480x320.
         */
        public static const HVGA:Resolution = new Resolution( 480 , 320 ) ;
        
        /**
         * The Video Graphics Array screens (4:3) - width x height : 640x480.
         */
        public static const VGA:Resolution = new Resolution( 640 , 480 ) ;
        
        /**
         * The Wide Video Graphics Array screens (4:3) - width x height : 800x480.
         */
        public static const WVGA:Resolution = new Resolution( 800 , 480 ) ;
        
        /**
         * The Full Wide Video Graphics Array screens (16:9) - width x height : 854x480.
         */
        public static const FWVGA:Resolution = new Resolution( 854 , 480 ) ;
        
        /**
         * The Super Video Graphics Array screens (4:3) - width x height : 800x600.
         */
        public static const SVGA:Resolution = new Resolution( 800 , 600 ) ;
        
        /**
         * The Wide Super Video Graphics Array screens (16:9) - width x height : 964x544.
         */
        public static const WSVGA:Resolution = new Resolution( 964 , 544 ) ;
        
        /////// Extended Graphics Array
        
        /**
         * The eXtended Graphics Array (4:3) resolution - width x height : 1024x768
         */
        public static const XGA:Resolution = new Resolution( 1024 , 768 ) ;
        
        /**
         * The eXtended Graphics Array Plus (4:3) resolution - width x height : 1152x864
         */
        public static const XGA_PLUS:Resolution = new Resolution( 1152 , 864 ) ;
        
        /**
         * The Wide eXtended Graphics Array (4:3) resolution - width x height : 1280x768
         */
        public static const WXGA:Resolution = new Resolution( 1280 , 768 ) ;
        
        /**
         * The Wide eXtended Graphics Array Plus (16:10) resolution - width x height : 1440x900
         */
        public static const WXGA_PLUS:Resolution = new Resolution( 1440 , 900 ) ;
        
        /**
         * The Super eXtended Graphics Array (4:3) resolution - width x height : 1280x1024
         */
        public static const SXGA:Resolution = new Resolution( 1280 , 1024 ) ;
        
        /**
         * The Super eXtended Graphics Array Plus (4:3) resolution - width x height : 1280x1024
         */
        public static const SXGA_PLUS:Resolution = new Resolution( 1400 , 1050 ) ;
        
        /**
         * The Widescreen Super eXtended Graphics Array Plus (16:10) resolution - width x height : 1650x1024
         */
        public static const WSXGA_PLUS:Resolution = new Resolution( 1650 , 1050 ) ;
        
        /**
         * The Ultra eXtended Graphics Array (4:3) resolution - width x height : 1280x1024
         */
        public static const UXGA:Resolution = new Resolution( 1600 , 1200 ) ;
        
        /**
         * The Widescreen Ultra eXtended Graphics Array (16:9) resolution - width x height : 1920x1200
         */
        public static const WUXGA:Resolution = new Resolution( 1920 , 1200 ) ;
        
        /////// Quad-extended Graphics Array
        
        /**
         * The Quad Wide eXtended Graphics Array (16:9) resolution - width x height : 2048x1152
         */
        public static const QWXGA:Resolution = new Resolution( 2048 , 1152 ) ;
        
        /**
         * The Quad EXtended Graphics Array (4:3) resolution - width x height : 2048x1536
         */
        public static const QXGA:Resolution = new Resolution( 2048 , 1536 ) ;
        
        /**
         * The Wide Quad eXtended Graphics Array (16:10) resolution - width x height : 2560x1600
         */
        public static const WQXGA:Resolution = new Resolution( 2560 , 1600 ) ;
        
        /**
         * The Quad Super eXtended Graphics Array (5:4) resolution - width x height : 2560x2048
         */
        public static const QSXGA:Resolution = new Resolution( 2560 , 2048 ) ;
        
        /**
         * The Wide Quad Super eXtended Graphics Array (25:16) resolution - width x height : 3200x2048
         */
        public static const WQSXGA:Resolution = new Resolution( 3200 , 2048 ) ;
        
        /**
         * The Quad Ultra Extended Graphics Array (4:3) resolution - width x height : 3200x2400
         */
        public static const QUXGA:Resolution = new Resolution( 3200 , 2400 ) ;
        
        /**
         * The Wide Quad Ultra Extended Graphics Array (16:10) resolution - width x height : 3840x2400
         */
        public static const WQUXGA:Resolution = new Resolution( 3840 , 2400 ) ;

    }
}
