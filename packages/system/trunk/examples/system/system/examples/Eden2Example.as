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
    import system.eden;

    import flash.display.Sprite;

    [SWF(width="740", height="480", frameRate="24", backgroundColor="#666666")]
    
    public dynamic class Eden2Example extends Sprite 
    {
        public function Eden2Example()
        {
            var i:uint ;
            
            trace(" ----o test Array") ;
            
            for ( i = 1 ; i<=7 ; i++) 
            {
                trace("a" + i + " : " + this["a"+i]) ;
            }
            
            trace(" ----o test Boolean") ;
            
            for ( i = 1 ; i<=9 ; i++) 
            {
                trace("b" + i + " : " + this["b"+i]) ;
            }
            
            trace(" ----o test Number") ;
            
            var n1:Number = eden.deserialize( "12" );
            var n2:Number = eden.deserialize( "0xFF0000" );
            var n3:Number = eden.deserialize( "NaN" );
            
            trace("n1 : " + (n1 == 12)) ;
            trace("n2 : " + (n2 == 16711680)) ;
            trace("n3 : " + isNaN(n3) ) ;
            
            trace(" ----o test Date") ;
            
            trace("d1 : " + (d1.valueOf() == new Date(100).valueOf()) ) ;
            trace("d2 : " + (d2.valueOf() == new Date(2006,2,30).valueOf()) ) ;
            trace("d3 : " + (d3.valueOf() == new Date(2006,11,25,1,2,3,4).valueOf()) ) ;
            
            trace(" ----o Test Object") ;
            
            var source:String = '{ prop1:"value1", prop2:"value2" }' ;
            var o1:* = eden.deserialize(source) ;
            for (var prop:String in o1) 
            {
                trace(prop + " : " + o1[prop]) ;
            }
        }
        
        public var a1:Array = eden.deserialize( "[]" );
        public var a2:Array = eden.deserialize( "[0,1,2,3]" );
        public var a3:Array = eden.deserialize( "new Array()" );
        public var a4:Array = eden.deserialize( "new Array(\"hello\")" );
        public var a5:Array = eden.deserialize( "new Array(5)" );
        public var a6:Array = eden.deserialize( "new Array(false)" );
        public var a7:Array = eden.deserialize( "new Array(0,1,2,3)" );
        
        public var b1:Boolean = eden.deserialize( "true" );
        public var b2:Boolean = eden.deserialize( "false" );
        public var b3:Boolean = eden.deserialize( "new Boolean()" );
        public var b4:Boolean = eden.deserialize( "new Boolean(\"\")" );
        public var b5:Boolean = eden.deserialize( "new Boolean(true)" );
        public var b6:Boolean = eden.deserialize( "new Boolean(false)" );
        public var b7:Boolean = eden.deserialize( "new Boolean(0)" );
        public var b8:Boolean = eden.deserialize( "new Boolean(NaN)" );
        public var b9:Boolean = eden.deserialize( "new Boolean(null)" );
        
        public var d1:Date = eden.deserialize( "new Date(100)" );
        public var d2:Date = eden.deserialize( "new Date(2006,2,30)" );
        public var d3:Date = eden.deserialize( "new Date(2006,11,25,1,2,3,4)" );
        public var d4:Date = eden.deserialize( "new Date(null)" );
        public var d5:Date = eden.deserialize( "new Date(NaN)" );
    }
}
