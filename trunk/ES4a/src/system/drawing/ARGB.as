
/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [ES4a: ECMAScript 4 MaasHaack framework].
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
*/

package system.drawing
    {
    
    public class ARGB extends RGB
        {
        
        private var _alpha:uint;
        
        public function ARGB( alpha:uint, red:uint = 0, green:uint = 0, blue:uint = 0 )
            {
            super( red, green, blue );
            this.alpha = alpha;
            }
        
        public function get alpha():uint
            {
            return _alpha;
            }
        
        public function set alpha( value:uint ):void
            {
            trace( "alpha value:" + value );
            _alpha = _cap(value);
            }
        
        public function get alphaPercent():Number
            {
            return Math.round((alpha/0xFF)*100)/100;
            }
        
        public function set alphaPercent( value:Number ):void
            {
            if( value < 0 )
                {
                value = 0;
                }
            
            value = Math.min( value, 1);
            alpha = Math.round( 0xFF * value );
            }
        
        
        override public function valueOf():uint
            {
            return (alpha << 24) | (red << 16) | (green << 8) | blue;
            }
        
        override public function toString():String
            {
            return "[ R:"+red+", G:"+green+", B:"+blue+" ("+(alphaPercent*100)+"%) ("+toHexString("0x")+")]";
            }
        
        override public function toHexString( pre:String = "" ):String
            {
            return pre + _toHex( alpha ) + _toHex( red ) + _toHex( green ) + _toHex( blue );
            }
        
        }
    
    }
