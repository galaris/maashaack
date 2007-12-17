
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
    
    /* Class: RGB
       Define a RGB color
    */
    public class RGB
        {
        protected var _max:uint = 0xFF;
        
        private var _R:uint;
        private var _G:uint;
        private var _B:uint;
        
        public function RGB( red:uint = 0, green:uint = 0, blue:uint = 0 )
            {
            this.red   = red;
            this.green = green;
            this.blue  = blue;
            }
        
        protected function _cap( value:uint ):uint
            {
            return Math.min( value, _max ) as uint;
            }
        
        protected function _toHex( value:uint ):String
            {
            var hex:String = value.toString(16);
            return (hex.length%2)==0 ? hex: "0"+hex;
            }
        
        
        public function get red():uint
            {
            trace( "get red");
            return _R;
            }
        
        public function set red( value:uint ):void
            {
            _R = _cap(value);
            }
        
        public function get green():uint
            {
            return _G;
            }
        
        public function set green( value:uint ):void
            {
            _G = _cap(value);
            }
        
        public function get blue():uint
            {
            return _B;
            }
        
        public function set blue( value:uint ):void
            {
            _B = _cap(value);
            }
        
        
        public function valueOf():uint
            {
            return (red << 16) | (green << 8) | blue;
            }
        
        public function toString():String
            {
            return "[ R:"+red+", G:"+green+", B:"+blue+" ("+toHexString("0x")+")]";
            }
        
        public function toHexString( pre:String = "" ):String
            {
            return pre + _toHex( red ) + _toHex( green ) + _toHex( blue );
            }
        
        public function inverse():void
            {
            red   = _max - _R;
            green = _max - _G;
            blue  = _max - _B;
            }
        
        }
    
    }
