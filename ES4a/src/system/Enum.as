
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

package system
    {
    
    public class Enum implements ISerializable
        {
        private var _value:int;
        private var _name:String;
        
        public function Enum( value:int = 0, name:String = "" )
            {
            _value = value;
            _name  = name;
            }
        
        public function valueOf():int
            {
            return _value;
            }
        
        public function toString():String
            {
            return _name;
            }
        
        public function toSource( indent:int = 0 ):String
            {
            var classname:String = Reflection.getClassName(this);
            if( _name != "" )
                {
                return classname + "." + _name;
                }
            
            return classname;
            }
        
        }
    
    }

