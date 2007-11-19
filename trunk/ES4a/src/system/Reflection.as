
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
    
    //Flash player API
    import flash.system.ApplicationDomain;
    import flash.utils.getQualifiedClassName;
    import flash.utils.describeType;
    
    /* Class: Reflection
       Provide basic reflection mecanisms on the language.
       
       note:
       This is a public API and will need different implementation for different hosts.
     */
    public class Reflection
        {
        
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
        public static function getClassByName( name:String ):Class
            {
            return ApplicationDomain.currentDomain.getDefinition( name ) as Class;
            }
        
        
        /* Method: getDefinitionByName
           Returns the instance of a public definition in the current Domain.
           The definition can be a class, namespace, function or object.
        */
        public static function getDefinitionByName( name:String ):Object
            {
            return ApplicationDomain.currentDomain.getDefinition( name );
            }
        
        /* Method: getClassName
           Returns the class name as string of an object.
        */
        public static function getClassName( o:*, path:Boolean = false ):String
            {
            var str:String = getQualifiedClassName( o );
            
            if( !path && (str.indexOf( "::" ) > -1) )
                {
                str = str.split( "::" )[1];
                }
            
            return str;
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

