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
    import graphics.colors.RGBA;
    
    import flash.display.Sprite;
    
    public class RGBAExample extends Sprite
    {
        public function RGBAExample()
        {
            trace("---- black") ;
            
            var black:RGBA = new RGBA() ;
            
            trace( "black                  : " + black ) ;
            trace( "black.toHexString('#') : " + black.toHexString("#") ) ;
            trace( "black.alpha            : " + black.a       ) ;
            trace( "black.red              : " + black.r       ) ;
            trace( "black.green            : " + black.g       ) ;
            trace( "black.blue             : " + black.b       ) ;
            trace( "black.percent          : " + black.percent ) ;
            trace( "black.offset           : " + black.offset  ) ;
            
            trace("---- red") ;
            
            var red:RGBA = new RGBA(255 , 0 , 0 , 0.5 ) ;
            
            trace( "red         : " + red         ) ;
            trace( "red.alpha   : " + red.a       ) ;
            trace( "red.red     : " + red.r       ) ;
            trace( "red.green   : " + red.g       ) ;
            trace( "red.blue    : " + red.b       ) ;
            trace( "red.percent : " + red.percent ) ;
            trace( "red.offset  : " + red.offset  ) ;
            
            trace("---- blue") ;
            
            var blue:RGBA = new RGBA(92, 160, 205, 0.4) ;
            
            trace( "blue         : " + blue         ) ;
            trace( "blue.alpha   : " + blue.a       ) ;
            trace( "blue.red     : " + blue.r       ) ;
            trace( "blue.green   : " + blue.g       ) ;
            trace( "blue.blue    : " + blue.b       ) ;
            trace( "blue.percent : " + blue.percent ) ;
            trace( "blue.offset  : " + blue.offset  ) ;
            
            blue.offset = 255 ;
            trace( "blue         : " + blue ) ;
            
            blue.percent = 50 ;
            trace( "blue         : " + blue ) ;
            
            blue.fromNumber( 0x23516D ) ;
            trace( "blue         : " + blue ) ;
        }
    }
}
