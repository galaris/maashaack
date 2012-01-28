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

package system.ioc.builders
{
    import core.dump ;
    
    import system.ioc.logger;
    import system.ioc.ObjectAttribute ;
    import system.ioc.ObjectProperty ;
    
    /**
     * Creates the Array of all properties defines in the passed-in factory object definition.
     * @return the Array of all properties defines in the passed-in factory object definition.
     */
    public const createProperties:Function = function(factory:* = null ):Array
    {
        if ( factory == null )
        {
            return null ;
        }
        
        var a:Array   = factory[ ObjectAttribute.OBJECT_PROPERTIES ] as Array ;
        
        if ( a == null || a.length == 0 )
        {
            return null ;
        }
        
        var properties:Array = [] ;
        
        var args:Array  ;
        var conf:String ;
        var i18n:String ;
        var prop:Object ;
        var name:String ;
        var ref:String  ;
        var value:* ; 
        
        var evaluators:Array ;
        
        var id:String = factory[ ObjectAttribute.OBJECT_ID ] as String ;
        var len:int   = a.length ;
        
        for ( var i:int ; i<len ; i++ )
        {
            prop = a[i] as Object ;
            
            if ( prop != null && ( ObjectAttribute.NAME in prop ) )
            { 
                name  = prop[ ObjectAttribute.NAME ] as String ;
                
                if ( name == null || name.length == 0 )
                {
                    continue ;
                }
                
                args       = prop[ ObjectAttribute.ARGUMENTS  ] as Array  ;
                evaluators = prop[ ObjectAttribute.EVALUATORS ] as Array  ;
                conf       = prop[ ObjectAttribute.CONFIG     ] as String ;
                i18n       = prop[ ObjectAttribute.LOCALE     ] as String ;
                ref        = prop[ ObjectAttribute.REFERENCE  ] as String ;
                value      = prop[ ObjectAttribute.VALUE      ] ;
                
                if ( args != null )
                {
                    properties.push( new ObjectProperty( name , createArguments( args ) , ObjectAttribute.ARGUMENTS ) ) ; // arguments property
                }
                else if ( ref != null ) 
                {
                    properties.push( new ObjectProperty( name , ref , ObjectAttribute.REFERENCE , evaluators ) ) ; // ref property
                }
                else if ( conf != null && conf.length > 0 )
                {
                    properties.push( new ObjectProperty( name, conf , ObjectAttribute.CONFIG , evaluators ) ) ; // config property
                }
                else if ( i18n != null && i18n.length > 0 )
                {
                    properties.push( new ObjectProperty( name, i18n , ObjectAttribute.LOCALE , evaluators ) ) ; // locale property
                }
                else 
                {
                    properties.push( new ObjectProperty( name , value , ObjectAttribute.VALUE , evaluators ) ) ; // value property
                }
            }
            else
            {
                logger.warn
                ( 
                    "ObjectBuilder.createProperties failed, a property definition is invalid in the object definition \"{0}\" at \"{1}\" with the value : {2}" , 
                    id , 
                    i , 
                    dump( prop ) 
                ) ; 
            }
        }
        return ( properties.length > 0 ) ? properties : null ;
    };
}
