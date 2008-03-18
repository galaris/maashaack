
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

	- Alcaraz Marc (aka eKameleon) <vegas@ekameleon.net> (2007-2008)
	  Documentation with JAVADOC + proposal methods

*/

package system
    {
    
    //Flash player API
    import flash.system.ApplicationDomain;
    import flash.utils.getQualifiedClassName;
    import flash.utils.describeType;
    
	/**
	 * Provides a basic reflection mecanisms on the language.
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
				a.pop() ;
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
		 * but you have ot provide the full qualified path of the class "Capabilities" alone will not work.
		 * @return the class reference from a string class name.
		 */
        public static function getClassByName( name:String ):Class
            {
            return ApplicationDomain.currentDomain.getDefinition( name ) as Class;
            }

		/**
		 * Returns an array of public methods defined in the class of an object.
		 * @return an array of public methods defined in the class of an object.
		 */
        public static function getClassMethods( o:*, inherited:Boolean = false ):Array
            {
            var type:XML = describeType( o );
            var fullname:String = getClassName( o, true );
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
        /* 
           TODO:
           - add options to return
             - class methods
             - static methods
             - prototype methods
             etc.
        */
        
		/**
		 * Returns the class name as string of an object.
		 * @return the class name as string of an object.
		 */
        public static function getClassName( o:*, path:Boolean = false ):String
            {
            return ( path == true ) ? getQualifiedClassName( o ) : _formatName(  getClassPath( o ) ) ;
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
            if( methods.indexOf( name ) > -1 )
                {
                return o[name] as Function ;
                }
            
            return null;
            }
        
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
    
		// Proposal (ekameleon) or in other class ?
		///**
		// * Indicates if the specified object is dynamic (true).
		// */
		//public static function isDynamic( o:* ):Boolean 
		//{
		//	return describeType( o ).@isDynamic == "true" ;
		//}

		///**
		// * Indicates if the specified object is final (true).
		// */
		//public static function isFinal( o:* ):Boolean 
		//{
		//	return describeType( o ).@isFinal == "true" ;
		//}

		///**
		// * Indicates if the specified object is static (true).
		// */
		//public static function isStatic( o:* ):Boolean 
		//{
		//	return describeType( o ).@isStatic == "true" ;
		//}    
    
    }

