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

package system.reflection
{
    import system.Reflection;
    
    import flash.utils.describeType ;
    import flash.utils.getQualifiedClassName ;
    
    [ExcludeClass]
    
    /**
     * Implementation of the ClassInfo interface.
     */
    public class _ClassInfo extends _TypeInfo implements ClassInfo
    {
        /**
         * @private
         */
        private var _class:XML;
        
        /**
         * @private
         */
        private var _filter:FilterType;
        
        /**
         * @private
         */
        private function _getTraitMemberHelper( member:MemberType ):Array
        {
            var members:Array = [];
            var node:XML;
            var name:String = member.toString( );
            if( isInstance( ) )
            {
                for( var m1:String in _class[name] )
                {
                    node = _class[name][m1];
                    if( ! filter.showInherited && (node.@declaredBy != undefined) && ! _isDeclaredLocaly( String( node.@declaredBy ) ) )
                    {
                        continue;
                    }
                    members.push( String( node.@name ) );
                }
            }
            else
            {
                for( var m2:String in _class.factory[name] )
                {
                    node = _class.factory[name][m2];
                    
                    if( ! filter.showInherited && (node.@declaredBy != undefined) && ! _isDeclaredLocaly( String( node.@declaredBy ) ) )
                    {
                        continue;
                    }
                    
                    members.push( String( node.@name ) ) ;
                }
            }
            return members ;
        }

        /**
         * @private
         */
        private function _hasInterface( interfaceRef:* ):Boolean
        {
            var path:XMLList;
            var found:String;
            
            if( isInstance( ) && _class.hasOwnProperty( "implementsInterface" ) )
            {
                path = _class.implementsInterface;
            }
            else if( !isInstance( ) && _class.factory.hasOwnProperty( "implementsInterface" ) )
            {
                path = _class.factory.implementsInterface;
            }
            
            /* note:
               even if we receive a class/object reference
               we force a string comparison which will work everywhere (eg tamarin/redtamarin)
            */
            if( !(interfaceRef is String) )
            {
                interfaceRef = getQualifiedClassName( interfaceRef );
            }
            
            for each( var property:XML in path )
            {
                found = String( property.@type );
                
                if( found == interfaceRef )
                {
                    return true;
                }
            }
            
            return false;
        }
        
        /**
         * @private
         */
        private function _inheritFrom( classRef:* ):Boolean
        {
            var path:XMLList;
            var found:String;
            
            if( isInstance( ) && _class.hasOwnProperty( "extendsClass" ) )
            {
                path = _class.extendsClass;
            }
            else if( ! isInstance( ) && _class.factory.hasOwnProperty( "extendsClass" ) )
            {
                path = _class.factory.extendsClass;
            }
            
            /* note:
               even if we receive a class/object reference
               we force a string comparison which will work everywhere (eg tamarin/redtamarin)
            */
            if( !(classRef is String) )
            {
                classRef = getQualifiedClassName( classRef );
            }
            
            for each( var property:XML in path )
            {
                found = String( property.@type );
                
                if( found == classRef )
                {
                    return true;
                }
            }
            
            return false;
        }
        
        /**
         * @private
         */
        private function _isDeclaredLocaly( origin:String ):Boolean
        {
            if( config.normalizePath )
            {
                origin = _normalize( origin );
            }
            
            return name == origin;
        }
        
        /**
         * @private
         */
        private function _normalize( value:String ):String
        {
            return value.replace( "::", "." );
        }
        
        /**
         * Creates a new _ClassInfo instance.
         */
        public function _ClassInfo( o:*, applyFilter:FilterType )
        {
            super( o );
            
            _class = describeType( o );
            _filter = applyFilter;
        }
        
        /**
         * List all accessors in the class.
         */
        public function get accessors():Array
        {
            return _getTraitMemberHelper( MemberType.accessor );
        }
        
        /**
         * List all constants in the class.
         */
        public function get constants():Array
        {
            return _getTraitMemberHelper( MemberType.constant );
        }
        
        /**
         * Indicates the filter type value used in this class.
         */
        public function get filter():FilterType
        {
            return _filter;
        }
        
        /**
         * @private
         */        
        public function set filter( value:FilterType ):void
        {
            _filter = value;
        }
        
        /**
         * List all members in the class.
         */
        public function get members():Array
        {
            return null;
        }
        
        /**
         * List all methods in the class.
         */
        public function get methods():Array
        {
            var meths:Array = [];
            if( filter.usePrototypeInfo )
            {
                if( isInstance( ) )
                {
                    for( var m1:String in type )
                    {
                        if( typeof type[m1] == "function" )
                        {
                            if( ! filter.showInherited && (! type.hasOwnProperty( m1 ) && ! type.constructor.prototype.hasOwnProperty( m1 )) )
                            {
                                continue;
                            }
                            meths.push( m1 );
                        }
                    }
                }
                else
                {
                    for( var m2:String in type.prototype )
                    {
                        if( typeof type.prototype[m2] == "function" )
                        {
                            if( ! filter.showInherited && ! type.prototype.hasOwnProperty( m2 ) )
                            {
                                continue;
                            }
                            meths.push( m2 );
                        }
                    }
                }
            }
            if( filter.useTraitInfo )
            {
                meths = meths.concat( _getTraitMemberHelper( MemberType.method ) );
            }
            return meths;
        }
        
        /**
         * Indicates the name of the class.
         */
        public function get name():String
        {
            var path:String = _class.@name;
            if( config.normalizePath )
            {
                path = _normalize( path );
            }
            return path;
        }
        
        /**
         * List all properties in the class. 
         * Properties are the combination of variables, constants and accessors.
         */
        public function get properties():Array
        {
            var props:Array = [];
            if( filter.usePrototypeInfo )
            {
                if( isInstance( ) )
                {
                    for( var p1:String in type )
                    {
                        if( typeof type[p1] != "function" )
                        {
                            if( ! filter.showInherited && (! type.hasOwnProperty( p1 ) && ! type.constructor.prototype.hasOwnProperty( p1 )) )
                            {
                                continue;
                            }
                            props.push( p1 );
                        } 
                    }
                }
                else
                {
                    for( var p2:String in type.prototype )
                    {
                        if( typeof type.prototype[p2] != "function" )
                        {
                            if( ! filter.showInherited && ! type.prototype.hasOwnProperty( p2 ) )
                            {
                                continue;
                            }
                            props.push( p2 );
                        } 
                    }
                }
            }
            if( filter.useTraitInfo )
            {
                props = props.concat( variables );
                props = props.concat( constants );
                props = props.concat( accessors );
            }
            return props;
        }
        
        /**
         * Indicates the ClassInfo object of the super class.
         */
        public function get superClass():ClassInfo
        {
            var path:String = "";
            var c:Class;
            
            if( isInstance( ) && _class.hasOwnProperty( "extendsClass" ) )
            {
                path = _class.extendsClass[0].@type;
            }
            else if( ! isInstance( ) && _class.factory.hasOwnProperty( "extendsClass" ) )
            {
                path = _class.factory.extendsClass[0].@type;
            }
            
            if( path != "" )
            {
                c = Reflection.getClassByName( path );
                return new _ClassInfo( c, filter );
            }
            else
            {
                return null;
            }
        }
        
        /**
         * List all variables in the class.
         */
        public function get variables():Array
        {
            return _getTraitMemberHelper( MemberType.variable ) ;
        }
        
        /**
         * Indicates if the specified class implements all interfaces passed-in arguments.
         * @param ...interfaces All the interfaces to search in the current ClassInfo.
         * @return <code class="prettyprint">true</code> if the class has the specified interfaces.
         */
        public function hasInterface( ...interfaces ):Boolean
        {
            if( interfaces.length == 0 )
            {
                return false;
            }
            for( var i:int = 0; i < interfaces.length ; i++ )
            {
                if( !_hasInterface( interfaces[i] ) )
                {
                    return false;
                }
            }
            return true ;
        }
        
        /**
         * Indicates if the specified class inherit fromm all class passed-in arguments.
         * @param ...interfaces All the interfaces to search in the current ClassInfo.
         * @return <code class="prettyprint">true</code> if the class has the specified interfaces.
         */
        public function inheritFrom( ...classes:Array ):Boolean
        {
            if( classes.length == 0 )
            {
                return false;
            }
            
            for( var i:int = 0; i < classes.length ; i++ )
            {
                if( !_inheritFrom( classes[i] ) )
                {
                    return false;
                }
            }
            return true;
        }
        
        /**
         * Indicates if the specified object is dynamic.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.Reflection ;
         * trace( Reflection.getClassInfo(Object).isDynamic() ) ; // true
         * </pre>
         */    
        public function isDynamic():Boolean
        {
            return _class.@isDynamic == "true";
        }
        
        /**
         * Indicates if the specified object is final.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.Reflection ;
         * trace( Reflection.getClassInfo(String).isFinal() ) ; // true
         * </pre>
         */
        public function isFinal():Boolean
        {
            return _class.@isFinal == "true";
        }
        
        /**
         * Indicates if the specified object is instance.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.Reflection ;
         * 
         * trace( Reflection.getClassInfo( Array ).isInstance() ) ; // false
         * trace( Reflection.getClassInfo( new Array() ).isInstance() ) ; // true
         * </pre>
         */
        public function isInstance():Boolean
        {
            return _class.@base != "Class";
        }
        
        /**
         * Indicates if the specified object is static.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.Reflection ;
         * trace( Reflection.getClassInfo(Math).isStatic() ) ; // true
         * </pre>
         */
        public function isStatic():Boolean
        {
            return _class.@isStatic == "true";
        }
        
        /**
         * Returns the String representation of the object.
         * @return the String representation of the object.
         */
        public override function toString():String
        {
            return "[ClassInfo]" ;
        }
        
        /**
         * Returns the XML representation of the class.
         * @return the XML representation of the class.
         */
        public function toXML():XML
        {
            return _class ;
        }
    }
}
