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

package system.ioc.builders
{
    import core.dump ;
    
    import system.ioc.logger;
    import system.ioc.ObjectAttribute ;
    import system.ioc.ObjectListener ;
    import system.ioc.ObjectOrder ;
    
    /**
     * Creates the Array of all listeners defines in the passed-in factory object definition.
     * @return the Array of all listeners defines in the passed-in factory object definition.
     */
    public const createListeners:Function = function( factory:* = null ):Array
    {
        if ( factory == null )
        {
            return null ;
        }
        
        var a:Array = ( factory is Array ) ? factory as Array : factory[ ObjectAttribute.OBJECT_LISTENERS  ] as Array  ;
        
        if ( a == null || a.length == 0 )
        {
            return null ;
        }
        
        var def:Object ;
        var dispatcher:String ;
        var type:String ;
        
        var listeners:Array = [] ;
        
        var id:String = factory[ ObjectAttribute.OBJECT_ID ] as String ;
        var len:int   = a.length ;
        
        for ( var i:int ; i<len ; i++ )
        {
            def = a[i] as Object ;
            if ( def != null && ( ObjectListener.DISPATCHER in def ) && ( ObjectListener.TYPE in def ) )
            { 
                dispatcher = def[ ObjectListener.DISPATCHER ] as String ;
                if ( dispatcher == null || dispatcher.length == 0 )
                {
                    continue ;
                }
                type  = def[ ObjectListener.TYPE ] as String ;
                if ( type == null || type.length == 0 )
                {
                    continue ;
                }
                listeners.push
                ( 
                    new ObjectListener
                    ( 
                        dispatcher , 
                        type , 
                        def[ ObjectListener.METHOD ] as String , 
                        def[ ObjectListener.USE_CAPTURE ] == true , 
                        def[ ObjectListener.PRIORITY ] is int ? def[ ObjectListener.PRIORITY ] as int : 0 , 
                        def[ ObjectListener.USE_WEAK_REFERENCE ] == true ,
                        ( def[ ObjectListener.ORDER ] == ObjectOrder.BEFORE ) ? ObjectOrder.BEFORE : ObjectOrder.AFTER
                    ) 
                ) ;
            }
            else
            {
                logger.warn
                ( 
                    "ObjectBuilder.createListeners failed, a listener definition is invalid in the object definition \"{0}\" at \"{1}\" with the value : {2}" , 
                    id , 
                    i , 
                    dump( def ) 
                ) ; 
            }
        }
        return ( listeners.length > 0 ) ? listeners : null ;
    };
}
