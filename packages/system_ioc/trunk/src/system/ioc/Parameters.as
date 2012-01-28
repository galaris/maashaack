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

package system.ioc 
{
    import system.evaluators.MultiEvaluator;
    
    /**
     * This collector register a <code class="prettyprint">parameters</code> object reference, this object can be use to configurate the application with externals values.
     */
    public class Parameters 
    {
        /**
         * Creates a new Parameters instance.
         * @param parameters The object parameters reference.
         */
        public function Parameters( parameters:Object = null ):void
        {
            _evaluators           = new MultiEvaluator() ;
            _evaluators.autoClear = true ;
            this.parameters       = parameters ;
        }
        
        /**
         * Defines the parameters object reference of the application.
         */
        public function get parameters():Object
        {
            return _parameters ;
        }
        
        /**
         * @private
         */
        public function set parameters( o:Object ):void
        {
            _parameters = o ;
        }
        
        /**
         * Indicates if the parameters object contains the specified variable.
         */
        public function contains( name:String ):Boolean
        {
            return ( _parameters != null ) && ( name in _parameters ) && ( _parameters[name] != null ) ;
        }
        
        /**
         * Returns the value of the specified variable in the parameters reference.
         * @param name The name of the variable to resolve in the parameters reference.
         * @param ...rest (optional) All <code class="prettyprint">IEvaluator</code> objects used to evaluate and initialize the value of the specified FlashVars.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.evaluators.DateEvaluator ;
         * import system.evaluators.EdenEvaluator ;
         * 
         * import system.ioc.Parameters ;
         * 
         * var params:Parameters = new Parameters( { date : "new Date(2006,5,12,16,12,24)" } ) ;
         *  
         * var value:String = params.getValue("date", new EdenEvaluator(false), new DateEvaluator()) ;
         * 
         * trace( "result : " + value ) ; // result : "12.06.2006 16:12:24" with the original "date" params value : "new Date(2006,5,12,16,12,24)"
         * </pre>
         * @return the value of the specified variable in the Parameters object.
         */
        public function getValue( name:String , ...rest:Array ):*
        {
            if ( _parameters != null && contains(name) )
            {
                if ( rest.length == 0 )
                {
                    return _parameters[name] ;
                }
                else
                {
                    _evaluators.add( rest ) ;
                    return _evaluators.eval(_parameters[name]) ;
                }
            }
            else
            {
                return null ;
            }
        }
        
        /**
         * @private
         */
        private var _evaluators:MultiEvaluator ;
        
        /**
         * @private
         */
        private var _parameters:Object ;
    }
}
