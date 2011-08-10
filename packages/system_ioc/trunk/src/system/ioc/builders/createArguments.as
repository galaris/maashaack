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
    import system.ioc.ObjectArgument ;
    import system.ioc.ObjectAttribute ;
    
    /**
     * Creates the Array of all arguments.
     * @return the Array of all arguments.
     */
    public const createArguments:Function = function( a:Array ):Array
    {
        if ( a == null || a.length == 0 )
        {
            return null ;
        }
        else
        {
            var args:Array = [] ;
            
            var o:Object ;
            var i:int ;
            
            var evaluators:Array ;
            
            var conf:String ;
            var i18n:String ;
            var ref:String  ;
            
            var value:* ;
            
            var l:int = a.length ;
            
            for ( i ; i<l ; i++ )
            {
                o = a[i] ;
                if ( o != null )
                {
                    conf       = ( ObjectAttribute.CONFIG in o )     ? o[ ObjectAttribute.CONFIG ] as String    : null ;
                    i18n       = ( ObjectAttribute.LOCALE in o )     ? o[ ObjectAttribute.LOCALE ] as String    : null ;
                    ref        = ( ObjectAttribute.REFERENCE in o )  ? o[ ObjectAttribute.REFERENCE ] as String : null ;
                    value      = ( ObjectAttribute.VALUE in o )      ? o[ ObjectAttribute.VALUE ]               : null ;
                    evaluators = ( ObjectAttribute.EVALUATORS in o ) ? o[ObjectAttribute.EVALUATORS] as Array   : null ;
                    
                    if ( ref != null && ref.length > 0 ) 
                    {
                        args.push( new ObjectArgument( ref , ObjectAttribute.REFERENCE , evaluators ) ) ; // ref argument
                    }
                    else if ( conf != null && conf.length > 0 )
                    {
                        args.push( new ObjectArgument( conf , ObjectAttribute.CONFIG , evaluators ) ) ; // config argument
                    }
                    else if ( i18n != null && i18n.length > 0 )
                    {
                        args.push( new ObjectArgument( i18n , ObjectAttribute.LOCALE , evaluators ) ) ; // locale argument
                    }
                    else
                    {
                        args.push( new ObjectArgument( value , ObjectAttribute.VALUE , evaluators ) ) ; // value argument
                    }
                }
            }
            return args.length > 0 ? args : null ;
        }
    };
}
