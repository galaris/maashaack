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
    import graphics.colors.RGB;

    import flash.display.Sprite;
    
    public class RGBExample extends Sprite 
    {
        public function RGBExample()
        {
            trace("---- black") ;
            
            var black:RGB = new RGB() ;
            
            trace( "black : " + black ) ;
            trace( "black.toHexString('#') : " + black.toHexString("#") ) ;
            
            black.difference() ;
            trace( "black difference : " + black ) ;
            
            trace("---- red") ;
            
            var red:RGB = new RGB(255, 0, 0) ;
            
            trace( "red : " + red ) ;
            trace( "red.toHexString('#') : " + red.toHexString("#") ) ;
            
            red.difference() ;
            trace( "red difference : " + red ) ;
            
            trace("---- blue") ;
            
            var blue:RGB = new RGB(92, 160, 205) ;
            
            trace( "blue : " + blue ) ;
            trace( "blue.toHexString('#') : " + blue.toHexString("#") ) ;
            
            blue.difference() ;
            trace( "blue difference       : " + blue ) ;
            
            blue.fromNumber( 0x23516D ) ;
            trace( "blue                  : " + blue   ) ;
            trace( "blue.red              : " + blue.r ) ;
            trace( "blue.green            : " + blue.g ) ;
            trace( "blue.blue             : " + blue.b ) ;
        }
    }
}
