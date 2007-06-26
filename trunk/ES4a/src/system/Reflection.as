
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
    import system.Arrays;
    /* Class: Reflection
       Provide basic reflection mecanisms on the language.
     */
    public class Reflection extends Ghost
        {
        
        private static var _buildins:Array = [ "Array", "String", "Number" ];
        
        private static function _isBuildIn( name:String ):Boolean
            {
            if( _buildins.indexOf( name ) > -1 )
                {
                return true;
                }
            
            return false;
            }
        
        /* Method: hasClassByName
           Returns a boolean telling if the class exists from a string name.
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
        
        /* Method: getClassBytName
           Returns the class reference from a string class name.
           
           note:
           the string name notation can be either
           "flash.system::Capabilities"
           or
           "flash.system.Capabilities"
           
           but you have ot provide the full qualified path of the class
           "Capabilities" alone will not work
        */
        
        unknown static function getClassByName( name:String ):Class
            {
            return Object;
            }
        
        flash static function getClassByName( name:String ):Class
            {
            import flash.system.ApplicationDomain;
            return ApplicationDomain.currentDomain.getDefinition( name ) as Class;
            }
        
        redtamarin static function getClassByName( name:String ):Class
            {
            import avmplus.Domain;
            return Domain.currentDomain.getClass( name );
            }
        
    	public static function getClassByName( name:String ):Class
    	    {
    		return __::getClassByName( name );
    	    }
        
        
        /* Method: getClassName
           Returns the class name as string of an object.
        */
        
        unknown static function getClassName( o:*, path:Boolean = false ):String
            {
            return "";
            }
        
        flash static function getClassName( o:*, path:Boolean = false ):String
            {
            import flash.utils.getQualifiedClassName;
            var str:String = getQualifiedClassName( o );
            
            if( !path && (str.indexOf( "::" ) > -1) )
                {
                str = str.split( "::" )[1];
                }
            
            return str;
            }
        
        redtamarin static function getClassName( o:*, path:Boolean = false ):String
            {
            import avmplus.Reflection;
            var R:* = avmplus.Reflection;
            if( !path )
                {
                return R.findClassName( o );
                }
            
            return R.findQualifiedClassName( o );
            }
        
        public static function getClassName( o:*, path:Boolean = false ):String
            {
            return __::getClassName( o, path );
            }
        
        /* Method: getClassMethods
           Returns an array of public methods defined in the class of an object.
           
           TODO:
           - add options to return
             - class methods
             - static methods
             - prototype methods
             etc.
        */
        
        unknown static function getClassMethods( o:*, inherited:Boolean = false ):Array
            {
            return [];
            }
        
        flash static function getClassMethods( o:*, inherited:Boolean = false ):Array
            {
            import flash.utils.describeType;
            
            var type:XML = describeType( o );
            //trace( type );
            var fullname:String = getClassName( o, true );
            //trace( "fullname: " + fullname );
            var member:XML;
            var members:Array = [];
            
            for each( member in type.method )
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
        
        redtamarin static function getClassMethods( o:*, inherited:Boolean = false ):Array
            {
            import avmplus.Reflection;
            var R:* = avmplus.Reflection;
            
            var methods:Array   = R._findQualifiedMethodsName( o );
            var fullname:String = R.findQualifiedClassName( o );
            var found:Array     = [];
            
            var startswith:Function = function( src:String, head:String ):Boolean
                {
                src = src.substring( 0, head.length );
                if( src == head )
                    {
                    return true;
                    }
                
                return false;
                }
            
            var parse:Function = function( meth:String ):String
                {
                var base:int = meth.indexOf( "/" );
                if( base > -1 )
                    {
                    meth = meth.substr( base + 1 );
                    }
                
                var pos:int = meth.lastIndexOf( "::" );
                if( pos > -1 )
                    {
                    meth = meth.substr( pos + 2 );
                    }
                
                return meth;
                }
            
            var m:String;
            var i:int;
            for( i=0; i< methods.length; i++ )
                {
                if( inherited ) 
                    {
                    m = parse( methods[i] );
                    if( !startswith( m, "get" ) && !startswith( m, "set" ) )
                        {
                        found.push( m );
                        }
                    }
                else
                    {
                    if( startswith( methods[i], fullname ) )
                        {
                        m = parse( methods[i] );
                        if( !startswith( m, "get" ) && !startswith( m, "set" ) )
                            {
                            found.push( m );
                            }
                        }
                    
                    }
                }
            
            return found;
            }
        
        public static function getClassMethods( o:*, inherited:Boolean = false  ):Array
            {
            return __::getClassMethods( o, inherited );
            }
        
        public static function getMethodByName( o:*, name:String ):Function
            {
            var methods:Array = getClassMethods( o );
            if( methods.indexOf( name ) > -1 )
                {
                return o[name];
                }
            
            return null;
            }
        
        }
    
    }

