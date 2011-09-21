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

package system.ioc.evaluators 
{
    import system.Evaluable;
    import system.ioc.ObjectConfig;
    import system.ioc.TypeAliases;
    import system.ioc.TypeExpression;
    import system.ioc.TypePolicy;
    
    import flash.utils.getDefinitionByName;
    
    /**
     * Evaluates a type string expression and return the type Class who corresponding in the application.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.ioc.evaluators.TypeEvaluator ;
     * import system.ioc.ObjectConfig ;
     * import system.ioc.TypePolicy ;
     * 
     * var conf:ObjectConfig = new ObjectConfig() ;
     * 
     * conf.typePolicy       = TypePolicy.ALL ; // TypePolicy.NONE, TypePolicy.ALIAS, TypePolicy.EXPRESSION
     * conf.typeAliases      =
     * [
     *     { alias:"MovieClip" , type:"flash.display.MovieClip" }
     * ] ;
     * 
     * conf.typeExpression   =
     * [
     *     { name:"map"     , value:"system.data.maps" } ,
     *     { name:"HashMap" , value:"{map}.HashMap"  }
     * ] ;
     * 
     * var evaluator:TypeEvaluator = new TypeEvaluator( conf ) ;
     * 
     * trace( evaluator.eval( "MovieClip"   ) ) ; // [class MovieClip]
     * trace( evaluator.eval( "{HashMap}"   ) ) ; // [class HashMap]
     * trace( evaluator.eval( "test"        ) ) ; // null
     * trace( evaluator.eval( "{map}.Test"  ) ) ; // null
     * </pre>
     */
    public class TypeEvaluator implements Evaluable
    {
        /**
         * Creates a new TypeEvaluator instance.
         * @param config The optional ObjectConfig object to filter the type expression to evaluate.
         */
        public function TypeEvaluator( config:ObjectConfig=null )
        {
            this.config = config ;
        }
        
        /**
         * The ObjectConfig reference of this evaluator.
         */
        public var config:ObjectConfig ;
        
        /**
         * Indicates if the eval() method throws errors or return null when an error is throwing.
         */
        public var throwError:Boolean ;
        
        /**
         * Evaluates the specified object.
         */
        public function eval( o:* ):*
        {
            if ( o is Class )
            {
                return o as Class ;
            }
            else if ( o is String )
            {
                var type:String = o as String ;
                if ( config )
                {
                    var policy:String = config.typePolicy ;
                    if ( policy != TypePolicy.NONE )
                    {
                        if ( policy == TypePolicy.ALL || policy == TypePolicy.EXPRESSION )
                        {
                           var exp:TypeExpression = (config.typeExpression as TypeExpression) ;
                           if ( exp != null )
                           {
                               type = exp.format(type) ;
                           }
                        }
                        if ( policy == TypePolicy.ALL || policy == TypePolicy.ALIAS )
                        {
                            var aliases:TypeAliases = config.typeAliases as TypeAliases ;
                            if ( aliases != null && aliases.containsAlias(type) )
                            {
                                type = aliases.getValue(type) ;
                            }
                        }
                    }
                }
                try
                {
                    return getDefinitionByName( type ) as Class ;
                }
                catch( e:Error )
                {
                    if ( throwError )
                    {
                        throw new EvalError(this + " eval failed : " + e.toString() ) ;
                    }
                }
            }
            return null ;
        }
    }
}