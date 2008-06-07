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
  Marc Alcaraz <ekameleon@gmail.com>

*/
package system.reflection
    {
    import flash.utils.describeType;
    
    import system.Reflection;
    
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
        private var _filter:FilterType;
        
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
         * @private
         */
        private function _normalize( value:String ):String
            {
            return value.replace( "::", "." );
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
        private function _getTraitMemberHelper( member:MemberType ):Array
        	{
        	var members:Array = [];
        	var node:XML;
        	var m:String;
        	var name:String = member.toString();
        	
        	if( isInstance() )
        		{
        		for( m in _class[name] )
        			{
        			node = _class[name][m];
        			
        			if( !filter.showInherited &&
        			    (node.@declaredBy != undefined) &&
        			    !_isDeclaredLocaly(String(node.@declaredBy)) )
        			    {
        			    continue;
        			    }
        		    
        		    members.push( String(node.@name) );
        			}
        		}
        	else
        		{
        		for( m in _class.factory[name] )
        			{
        			node = _class.factory[name][m];
        			
        			if( !filter.showInherited &&
        			    (node.@declaredBy != undefined) &&
        			    !_isDeclaredLocaly(String(node.@declaredBy)) )
        			    {
        			    continue;
        			    }
        		    
        			members.push( String(node.@name) );
        			}
        		}
        	
        	return members;
        	}
        
        public function get filter():FilterType
        	{
        	return _filter;
        	}
        
        public function set filter( value:FilterType ):void
        	{
        	_filter = value;
        	}
        
        /**
         * Returns the name of the class.
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
         * Indicates the Array representation of all members in the class.
         */
        public function get members():Array
            {
            return null;
            }
        

        

        
        /**
        * List all variables in the class.
        */
        public function get variables():Array
        	{
        	return _getTraitMemberHelper( MemberType.variable );
        	}
        
        /**
        * List all constants in the class.
        */
        public function get constants():Array
        	{
        	return _getTraitMemberHelper( MemberType.constant );
        	}
        
        /**
        * List all accessors in the class.
        */
        public function get accessors():Array
        	{
        	return _getTraitMemberHelper( MemberType.accessor );
        	}
        
        public function get properties():Array
            {
            var props:Array = [];
            var p:String;
            
            if( filter.usePrototypeInfo )
            	{
            	if( isInstance() )
            		{
            		for( p in type )
            			{
            			if( typeof type[p] != "function" )
            				{
            				if( !filter.showInherited && 
            				    (!type.hasOwnProperty( p ) && !type.constructor.prototype.hasOwnProperty( p )) )
            				    {
            				    continue;
            				    }
            				
            				props.push( p );
            				} 
            			}
            		}
            	else
            		{
            		for( p in type.prototype )
            			{
            			if( typeof type.prototype[p] != "function" )
            				{
            				if( !filter.showInherited && 
            				    !type.prototype.hasOwnProperty( p ) )
            				    {
            				    continue;
            				    }
            				
            				props.push( p );
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
         * List all methods in the class.
         */
        public function get methods():Array
            {
            var meths:Array = [];
            var m:String;
            
            if( filter.usePrototypeInfo )
            	{
            	if( isInstance() )
            		{
            		for( m in type )
            			{
            			if( typeof type[m] == "function" )
            				{
            				if( !filter.showInherited && 
            				    (!type.hasOwnProperty( m ) && !type.constructor.prototype.hasOwnProperty( m )) )
            				    {
            				    continue;
            				    }
            				
            				meths.push( m );
            				} 
            			}
            		}
            	else
            		{
            		for( m in type.prototype )
            			{
            			if( typeof type.prototype[m] == "function" )
            				{
            				if( !filter.showInherited && 
            				    !type.prototype.hasOwnProperty( m ) )
            				    {
            				    continue;
            				    }
            				
            				meths.push( m );
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
         * Indicates the ClassInfo object of the super class.
         */
        public function get superClass():ClassInfo
            {
            var path:String = "";
            var c:Class;
            
            if( isInstance() &&  _class.hasOwnProperty( "extendsClass" ) )
                {
                path = _class.extendsClass[0].@type;
                }
            else if( !isInstance() && _class.factory.hasOwnProperty( "extendsClass" ) )
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
         * Indicates if the specified object is dynamic.
         */        
        public function isDynamic():Boolean
            {
            return _class.@isDynamic == "true";
            }
        
        /**
         * Indicates if the specified object is final.
         */        
        public function isFinal():Boolean
            {
            return _class.@isFinal == "true";
            }
        
        /**
         * Indicates if the specified object is instance.
         */        
        public function isInstance():Boolean
            {
            return _class.@base != "Class";
            }        
        
        /**
         * Indicates if the specified object is static.
         */
        public function isStatic():Boolean
            {
            return _class.@isStatic == "true";
            }
        
        public function toXML():XML
        	{
        	return _class;
        	}

        }
    }

