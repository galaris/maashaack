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
    import system.evaluators.PropertyEvaluator;
    import system.ioc.ObjectConfig;
    
    /**
     * Evaluates a type string expression and return the value who corresponding in the config of the factory.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.ioc.evaluators.ConfigEvaluator ;
     * import system.ioc.ObjectConfig ;
     * 
     * var init:Object =
     * {
     *     message : "hello world" ,
     *     menu    :
     *     {
     *         title : "my title" ,
     *         count : 10 ,
     *         data  : [ "item1" , "item2", "item3" ]
     *     }
     * }
     * 
     * var configurator:ObjectConfig = new ObjectConfig() ;
     * configurator.config           = init ;
     * 
     * var evaluator:ConfigEvaluator = new ConfigEvaluator( configurator ) ;
     * 
     * trace( evaluator.eval( "test"       ) ) ; // null
     * trace( evaluator.eval( "message"    ) ) ; // hello world
     * trace( evaluator.eval( "menu"       ) ) ; // [object Object]
     * trace( evaluator.eval( "menu.title" ) ) ; // my title
     * trace( evaluator.eval( "menu.count" ) ) ; // 10
     * trace( evaluator.eval( "menu.data"  ) ) ; // item1,item2,item3
     * trace( evaluator.eval( "menu.test"  ) ) ; // null
     * </pre>
     */
    public class ConfigEvaluator extends PropertyEvaluator
    {
        /**
         * Creates a new ConfigEvaluator instance.
         * @param config The optional ObjectConfig object to filter the type expression to evaluate.
         */
        public function ConfigEvaluator( config:ObjectConfig=null )
        {
            this.config = config ;
        }
        
        /**
         * The ObjectConfig reference of this evaluator.
         */
        public var config:ObjectConfig ;
        
        /**
         * The ObjectConfig reference of this evaluator.
         */
        public override function get target():*
        {
            return config != null ? config.config : null ;
        }
    }
}
