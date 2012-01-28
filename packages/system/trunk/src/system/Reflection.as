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

package system
{
    import core.reflect.invoke;

    import system.reflection.*;

    import flash.system.ApplicationDomain;
    import flash.utils.describeType;
    import flash.utils.getQualifiedClassName;
    import flash.utils.getQualifiedSuperclassName;

    /* 
    TODO:
    - add options to return
    - class methods
    - static methods
    - prototype methods
    etc.
     */

    /**
     * Provides a basic reflection mecanisms on the language.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.Arrays ;
     * 
     * import system.data.Map ;
     * import system.data.maps.HashMap ;
     * 
     * import system.reflection.ClassInfo ;
     * import system.Reflection ;
     * 
     * import system.Serializable ;
     * 
     * trace( "# Object isDynamic() : " + Reflection.getClassInfo(Object).isDynamic() ) ; // # Object isDynamic() : true
     * trace( "# String isFinal()   : " + Reflection.getClassInfo(String).isFinal()   ) ; // # String isFinal()   : true
     * trace( "# Math isStatic()    : " + Reflection.getClassInfo(Math).isStatic()    ) ; // # Math isStatic()   : true
     * 
     * trace("---------") ;
     * 
     * var map:HashMap = new HashMap() ;
     * 
     * var classInfo:ClassInfo ;
     * classInfo = Reflection.getClassInfo( map ) ;
     * 
     * trace( "# isInstance() : " + classInfo.isInstance() ) ; // # isInstance() : true
     * trace( "# isDynamic()  : " + classInfo.isDynamic()  ) ; // # isDynamic()  : false
     * trace( "# isFinal()    : " + classInfo.isFinal()    ) ; // # isFinal()    : false
     * trace( "# isStatic()   : " + classInfo.isStatic()   ) ; // # isStatic()   : false
     * 
     * trace( "# hasInterface( Map , Serializable ) : " + classInfo.hasInterface( Map , Serializable )  ) ; // # hasInterface( Map , Serializable ) : true
     * trace( "# inheritFrom( Object ) : " + classInfo.inheritFrom( Object )  ) ; // # inheritFrom( Object ) : true
     * 
     * trace("---------") ;
     * 
     * classInfo = Reflection.getClassInfo(Reflection) ;
     * 
     * trace( "# Reflection isStatic() : "  + classInfo.isStatic() ) ; // # Reflexion isStatic() : true
     * 
     * trace( "---" ) ;
     * 
     * trace( "# hasClassByName('system.data.maps.HashMap')      : " + Reflection.hasClassByName("system.data.maps.HashMap") ) ; // hasClassByName('system.data.maps.HashMap') : true
     * trace( "# getClassByName('system.data.maps.HashMap')      : " + Reflection.getClassByName("system.data.maps.HashMap") ) ; // getClassByName('system.data.maps.HashMap') : [class HashMap]
     * trace( "# getDefinitionByName('system.data.maps.HashMap') : " + Reflection.getDefinitionByName("system.data.maps.HashMap") ) ; // getDefinitionByName('system.data.maps.HashMap') : [class HashMap]
     * 
     * trace( "---" ) ;
     * 
     * trace( "# getClassName(map)      : " + Reflection.getClassName(map) )       ; // getClassName(map)      : HashMap
     * trace( "# getClassName(map,true) : " + Reflection.getClassName(map, true) ) ; // getClassName(map,true) : system.data.maps::HashMap
     * trace( "# getClassPackage(map)   : " + Reflection.getClassPackage(map) )    ; // getClassPackage(map)   : system.data.maps
     * trace( "# getClassPath(map)      : " + Reflection.getClassPath(map) )       ; // getClassPath(map)      : system.data.maps.HashMap
     * 
     * trace( "# getClassMethods(map)        : " + Reflection.getClassMethods(map)        ) ; // getClassMethods(map)         : put,clone,remove,keyIterator,containsKey,toSource,size,toString,putAll,getKeys,get,clear,iterator,containsValue,getValues,isEmpty
     * trace( "# getClassMethods(map,true)   : " + Reflection.getClassMethods(map,true)   ) ; // getClassMethods(map,true)    : put,clone,remove,keyIterator,containsKey,toSource,size,toString,putAll,getKeys,get,clear,iterator,containsValue,getValues,isEmpty
     * trace( "# getMethodByName(map,'put')  : " + Reflection.getMethodByName(map,"put")  ) ; // getMethodByName(map, 'put')  : function Function() {}
     * trace( "# getMethodByName(map,'test') : " + Reflection.getMethodByName(map,"test") ) ; // getMethodByName(map, 'test') : null
     *
     * trace( "# getSuperClassName(core)    : " + Reflection.getSuperClassName(map) )    ; // getSuperClassName(map)     : Object
     * trace( "# getSuperClassPackage(core) : " + Reflection.getSuperClassPackage(map) ) ; // getSuperClassPackage(map)  : null
     * trace( "# getSuperClassPath(core)    : " + Reflection.getSuperClassPath(map) )    ; // getSuperClassPath(map)     : Object
     * 
     * trace("---------") ;
     * 
     * Array.prototype.toString = function():String
     * {
     *     return "[" + this.join(",") + "]" ;
     * }
     * 
     * var ar:Array
     * 
     * // test with no argument
     * ar = Reflection.invokeClass( Array ) ;
     * trace( ar ) ;
     * //output: []
     * 
     * // test with 0 argument
     * ar = Reflection.invokeClass( Array , [] ) ;
     * trace( ar ) ;
     * //output: []
     * 
     * // test with 2 arguments
     * ar = Reflection.invokeClass( Array , Arrays.initialize(2,0) ) ;
     * trace( ar ) ;
     * //output: [0,0]
     * 
     * // test with 32 arguments
     * ar = Reflection.invokeClass( Array , Arrays.initialize(32,0) ) ;
     * trace( ar ) ;
     * //output: [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
     * 
     * // test with 33 arguments
     * 
     * try
     * {
     *     ar = Reflection.invokeClass( Array , Arrays.initialize(33,0) ) ;
     *     trace( ar ) ;
     * }
     * catch( e:Error )
     * {
     *     trace(e) ; // ArgumentError: Reflection.invokeClass() method failed : arguments limit exceeded, you can pass a maximum of 32 arguments.
     * }
     * </pre>
     */
    public class Reflection
    {
        /**
         * @private
         */
        private static function _formatName( path:String ):String 
        {
            var a:Array = path.split( "." ) ;
            return (a.length > 1) ? a.pop( ) : path ;
        }
        
        /**
         * @private
         */
        private static function _formatPackage( path:String ):String 
        {
            var a:Array = path.split( "." ) ;
            if (a.length > 1) 
            {
                a.pop( ) ;
                return a.join( "." ) ;
            }
            else 
            {
                return null ;
            }
        }
        
        /**
         * @private
         */
        private static function _formatPath( path:String ):String 
        {
            return (path.split( "::" )).join( "." ) ;
        }
        
        /**
         * Returns the class reference from a string class name.
         * The string name notation can be either "flash.system::Capabilities" or "flash.system.Capabilities" 
         * but you have to provide the full qualified path of the class "Capabilities" alone will not work.
         * @return the class reference from a string class name.
         */
        public static function getClassByName( name:String ):Class
        {
            name = _formatPath( name );
            return ApplicationDomain.currentDomain.getDefinition( name ) as Class;
        }
        
        /**
         * Returns the ClassInfo object of the specified object.
         * @return the ClassInfo object of the specified object.
         */
        public static function getClassInfo( o:*, ...filters ):ClassInfo
        {
            var filter:FilterType = FilterType.none; 
            //default
            var value:int ;
            var len:int = filters.length ;
            for( var i:int ; i < len ; i++ )
            {
                value |= int( filters[i] );
            }
            if( value > 0 )
            {
                filter = new FilterType( value );
            }
            return new _ClassInfo( o, filter );
        }
        
        /**
         * Returns an array of public methods defined in the class of an object.
         * @return an array of public methods defined in the class of an object.
         */
        public static function getClassMethods( o:*, inherited:Boolean = false ):Array
        {
            var type:XML = describeType( o );
            var fullname:String = getClassName( o, true );
            var members:Array = [];
            for each( var member:XML in type.method )
            {
                if( inherited )
                {
                    members.push( String( member.@name ) );
                }
                else if( String( member.@declaredBy ) == fullname )
                {
                    members.push( String( member.@name ) );
                }
            }
            return members;
        }
        
        /**
         * Returns the class name as string of an object.
         * @return the class name as string of an object.
         */
        public static function getClassName( o:*, path:Boolean = false ):String
        {
            return ( path == true ) ? getQualifiedClassName( o ) : _formatName( getClassPath( o ) ) ;
        }
        
        /**
         * Returns the package string representation of the specified instance passed in arguments.
         * @param o the reference of the object to apply reflexion.
         * @return the package string representation of the specified instance passed in arguments.
         */
        public static function getClassPackage( o:* ):String 
        {
            return _formatPackage( getClassPath( o ) ) ;
        }
        
        /**
         * Returns the full path string representation of the specified instance passed in arguments (package + name).
         * @param instance the reference of the object to apply reflexion.
         * @return the full path string representation of the specified instance passed in arguments (package + name).
         */
        public static function getClassPath( o:* ):String 
        {
            return _formatPath( getQualifiedClassName( o ) ) ;
        }
        
        /**
         * Returns the instance of a public definition in the current Domain.
         * The definition can be a class, namespace, function or object.
         * @return the instance of a public definition in the current Domain.
         */
        public static function getDefinitionByName( name:String ):Object
        {
            return ApplicationDomain.currentDomain.getDefinition( name );
        }
        
        /**
         * Returns the method reference of the specified object with the passed-in property name.
         * @return the method reference of the specified object with the passed-in property name.
         */
        public static function getMethodByName( o:*, name:String ):Function
        {
            var methods:Array = getClassMethods( o );
            if( methods.indexOf( name ) > - 1 )
            {
                return o[name] as Function ;
            }
            
            return null;
        }
        
        /**
         * Returns the super class name as string of an object.
         * @return the super class name as string of an object.
         */
        public static function getSuperClassName(o:*):String 
        {
            return _formatName( getSuperClassPath( o ) ) ;
        }
        
        /**
         * Returns the super class package string representation of the specified instance passed in arguments.
         * @param o the reference of the object to apply reflexion.
         * @return the super class package string representation of the specified instance passed in arguments.
         */
        public static function getSuperClassPackage(o:*):String 
        {
            return _formatPackage( getSuperClassPath( o ) ) ;
        }
        
        /**
         * Returns the super class path string representation of the specified instance passed in arguments.
         * @param o the reference of the object to apply reflexion.
         * @return the super class path string representation of the specified instance passed in arguments.
         */
        public static function getSuperClassPath(o:*):String 
        {
            return _formatPath( getQualifiedSuperclassName( o ) ) ;
        }
        
        /**
         * Returns the TypeInfo object of the specified object.
         * @return the TypeInfo object of the specified object.
         */
        public static function getTypeInfo( o:* ):TypeInfo
        {
            return new _TypeInfo( o );
        }
        
        /**
         * Returns a boolean telling if the class exists from a string name.
         * @return a boolean telling if the class exists from a string name.
         */
        public static function hasClassByName( name:String ):Boolean
        {
            try
            {
                var c:Class = getClassByName( name );
            }
            catch( e:Error )
            {
                return false;
            }
            return true;
        }
        
        /**
         * Wrapping method which select which build method use according to the argument count (32 max).
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.Arrays ;
         * import system.Reflection ;
         * 
         * Array.prototype.toString = function():String
         * {
         *     return "[" + this.join(",") + "]" ;
         * }
         * 
         * var ar:Array
         * 
         * // test with no argument
         * ar = Reflection.invokeClass( Array ) ;
         * trace( ar ) ;
         * //output: []
         * 
         * // test with 0 argument
         * ar = Reflection.invokeClass( Array , [] ) ;
         * trace( ar ) ;
         * //output: []
         * 
         * // test with 2 arguments
         * ar = Reflection.invokeClass( Array , Arrays.initialize(2,0) ) ;
         * trace( ar ) ;
         * //output: [0,0]
         * 
         * // test with 32 arguments
         * ar = Reflection.invokeClass( Array , Arrays.initialize(32,0) ) ;
         * trace( ar ) ;
         * //output: [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
         * 
         * // test with 33 arguments
         * ar = Reflection.invokeClass( Array , Arrays.initialize(33,0) ) ;
         * trace( ar ) ;
         * 
         * //output:
         * // ArgumentError: Reflection.invokeClass() method failed : arguments limit exceeded, you can pass a maximum of 32 arguments.
         * </pre>
         * @param c The Class of the instance to build.
         * @param args The array of all arguments to passed-in the constructor of the specified class.
         */
        public static function invokeClass( c:Class, args:Array = null ):*
        {
            if ( args && args.length > 32 )
            {
                throw new ArgumentError( "Reflection.invokeClass() method failed : arguments limit exceeded, you can pass a maximum of 32 arguments." ) ; 
            }
            else
            {
                return invoke( c , args ) ;
            }
        }
    }
}
