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
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):

*/

package system.reflection
    {
    import system.Enum;

    public class AccessorType extends Enum
        {
        
        public function AccessorType( value:int, name:String )
            {
            super(value, name);
            }
        
        public const readOnly:AccessorType  = new AccessorType( 1, "readonly" );
        public const writeOnly:AccessorType = new AccessorType( 2, "writeonly" );
        public const readWrite:AccessorType = new AccessorType( 3, "readwrite" );
        
        }
    }

