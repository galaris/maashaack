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

package core.functors 
{
    import library.ASTUce.framework.TestCase;

    import core.dump;

    public class bindTest extends TestCase 
    {
        public function bindTest(name:String = "")
        {
            super(name);
        }
        
        public function testBindScope():void
        {
            var scope:Object = 
            {
                toString : function():String
                {
                    return "scope" ;
                }
            };
            
            var action:Function = function( ...arguments:Array ):String
            {
                return this.toString() ;
            };
            
            var proxy:Function = bind( action , scope ) ;
            
            assertEquals( "scope" , proxy() , "#1" ) ;
        }
        
        public function testBindNullScope():void
        {
            var action:Function = function( ...arguments:Array ):String
            {
                return this.toString() ;
            };
            
            var proxy:Function = bind( action , null ) ;
            
            assertEquals( "[object global]" , proxy() , "#1" ) ;
        }
        
        public function testBindBasicArguments():void
        {
            var scope:Object = 
            {
                toString : function():String
                {
                    return "scope" ;
                }
            };
            
            var action:Function = function( ...arguments:Array ):String
            {
                return dump(arguments);
            };
            
            var proxy:Function = bind( action , scope ) ;
            
            assertEquals( "[1,2,3]" , proxy(1,2,3) , "#1" ) ;
        }
        
        public function testBindComplexArguments():void
        {
            var scope:Object = 
            {
                toString : function():String
                {
                    return "scope" ;
                }
            };
            
            var action:Function = function( ...arguments:Array ):String
            {
                return dump(arguments);
            };
            
            var proxy:Function = bind( action , scope , 4,5,6 ) ;
            
            assertEquals( "[4,5,6,1,2,3]" , proxy(1,2,3) , "#1" ) ;
        }
    }
}
