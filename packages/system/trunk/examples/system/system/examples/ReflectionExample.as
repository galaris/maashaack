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
    import system.Arrays;
    import system.Reflection;
    import system.Serializable;
    import system.data.Map;
    import system.data.maps.HashMap;
    import system.reflection.ClassInfo;
    
    import flash.display.Sprite;
    
    [SWF(width="740", height="480", frameRate="24", backgroundColor="#666666")]
    
    public dynamic class ReflectionExample extends Sprite 
    {
        public function ReflectionExample()
        {
            trace( "# Object isDynamic() : " + Reflection.getClassInfo(Object).isDynamic() ) ; // # Object isDynamic() : true
            trace( "# String isFinal()   : " + Reflection.getClassInfo(String).isFinal()   ) ; // # String isFinal()   : true
            trace( "# Math isStatic()    : " + Reflection.getClassInfo(Math).isStatic()    ) ; // # Math isStatic()   : true
            
            trace("---------") ;
            
            var map:HashMap = new HashMap() ;
            
            var classInfo:ClassInfo ;
            
            classInfo = Reflection.getClassInfo( map ) ;
            
            trace( "# isInstance() : " + classInfo.isInstance() ) ; // # isInstance() : true
            trace( "# isDynamic()  : " + classInfo.isDynamic()  ) ; // # isDynamic()  : false
            trace( "# isFinal()    : " + classInfo.isFinal()    ) ; // # isFinal()    : false
            trace( "# isStatic()   : " + classInfo.isStatic()   ) ; // # isStatic()   : false
            
            trace( "# hasInterface( Map , Serializable ) : " + classInfo.hasInterface( Map , Serializable )  ) ; // # hasInterface( Map , Serializable ) : true
            trace( "# inheritFrom( Object ) : " + classInfo.inheritFrom( Object )  ) ; // # inheritFrom( Object ) : true
            
            trace("---------") ;
            
            classInfo = Reflection.getClassInfo(Reflection) ;
            
            trace( "# Reflection isStatic() : "  + classInfo.isStatic() ) ; // # Reflexion isStatic() : true
            
            trace( "---" ) ;
            
            trace( "# hasClassByName('system.data.maps.HashMap')      : " + Reflection.hasClassByName("system.data.maps.HashMap") ) ; // hasClassByName('system.data.maps.HashMap') : true
            
            trace( "# getClassByName('system.data.maps.HashMap')      : " + Reflection.getClassByName("system.data.maps.HashMap") ) ; // getClassByName('system.data.maps.HashMap') : [class HashMap]
            
            trace( "# getDefinitionByName('system.data.maps.HashMap') : " + Reflection.getDefinitionByName("system.data.maps.HashMap") ) ; // getDefinitionByName('system.data.maps.HashMap') : [class HashMap]
            
            trace( "---" ) ;
            
            trace( "# getClassName(map)      : " + Reflection.getClassName(map) )       ; // getClassName(map)      : HashMap
            trace( "# getClassName(map,true) : " + Reflection.getClassName(map, true) ) ; // getClassName(map,true) : system.data.maps::HashMap
            trace( "# getClassPackage(map)   : " + Reflection.getClassPackage(map) )    ; // getClassPackage(map)   : system.data.maps
            trace( "# getClassPath(map)      : " + Reflection.getClassPath(map) )       ; // getClassPath(map)      : system.data.maps.HashMap
            
            trace( "# getClassMethods(map)        : " + Reflection.getClassMethods(map)        ) ; // getClassMethods(map)         : put,clone,remove,keyIterator,containsKey,toSource,size,toString,putAll,getKeys,get,clear,iterator,containsValue,getValues,isEmpty
            trace( "# getClassMethods(map,true)   : " + Reflection.getClassMethods(map,true)   ) ; // getClassMethods(map,true)    : put,clone,remove,keyIterator,containsKey,toSource,size,toString,putAll,getKeys,get,clear,iterator,containsValue,getValues,isEmpty
            trace( "# getMethodByName(map,'put')  : " + Reflection.getMethodByName(map,"put")  ) ; // getMethodByName(map, 'put')  : function Function() {}
            trace( "# getMethodByName(map,'test') : " + Reflection.getMethodByName(map,"test") ) ; // getMethodByName(map, 'test') : null
            
            trace( "# getSuperClassName(core)    : " + Reflection.getSuperClassName(map) )    ; // getSuperClassName(map)     : Object
            trace( "# getSuperClassPackage(core) : " + Reflection.getSuperClassPackage(map) ) ; // getSuperClassPackage(map)  : null
            trace( "# getSuperClassPath(core)    : " + Reflection.getSuperClassPath(map) )    ; // getSuperClassPath(map)     : Object
            
            trace("---------") ;
            
            Array.prototype.toString = function():String
            {
                return "[" + this.join(",") + "]" ;
            };
            
            var ar:Array;
            
            // test with no argument
            ar = Reflection.invokeClass( Array ) ;
            trace( ar ) ;
            //output: []
            
            // test with 0 argument
            ar = Reflection.invokeClass( Array , [] ) ;
            trace( ar ) ;
            //output: []
            
            // test with 2 arguments
            ar = Reflection.invokeClass( Array , Arrays.initialize(2,0) ) ;
            trace( ar ) ;
            //output: [0,0]
            
            // test with 32 arguments
            ar = Reflection.invokeClass( Array , Arrays.initialize(32,0) ) ;
            trace( ar ) ;
            //output: [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
            
            // test with 33 arguments
            
            try
            {
                ar = Reflection.invokeClass( Array , Arrays.initialize(33,0) ) ;
                trace( ar ) ;
            }
            catch( e:Error )
            {
                trace(e) ; // ArgumentError: Reflection.invokeClass() method failed : arguments limit exceeded, you can pass a maximum of 32 arguments.
            }
        }
    }
}
