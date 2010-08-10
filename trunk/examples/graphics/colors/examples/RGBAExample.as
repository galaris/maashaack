/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is PEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
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
