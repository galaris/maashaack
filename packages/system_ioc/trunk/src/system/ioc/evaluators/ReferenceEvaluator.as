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
    import system.evaluators.PropertyEvaluator;
    import system.ioc.IObjectFactory;
    import system.ioc.MagicReference;
    
    /**
     * Evaluates a reference string expression and return the property value who corresponding in the target object specified in this evaluator.
     */
    public class ReferenceEvaluator implements Evaluable
    {
        /**
         * Creates a new ReferenceEvaluator instance.
         * @param factory The ObjectFactory use in the evaluator.
         */
        public function ReferenceEvaluator( factory:IObjectFactory = null  )
        {
            this.factory = factory ;
        }
        
        /**
         * The separator of the expression evaluator.
         */
        public var separator:String = "." ;
        
        /**
         * The ObjectFactory use in the evaluator.
         */
        public function get factory():IObjectFactory
        {
            return _factory ;
        }
        
        /**
         * @private
         */
        public function set factory( factory:IObjectFactory ):void
        {
            _factory = factory ;
        }
        
        /**
         * Indicates if the class throws errors or return null when an error is throwing.
         */
        public function get throwError():Boolean
        {
            return _propEvaluator.throwError ;
        }
        
        /**
         * @private
         */
        public function set throwError( b:Boolean ):void
        {
            _propEvaluator.throwError = b ;
        }
        
        /**
         * The undefineable value returns in the eval method if the expression can't be evaluate.
         */
        public var undefineable:* = null ;
        
        /**
         * Evaluates the specified object.
         */
        public function eval( o:* ):*
        {
            if ( o is String && factory != null )
            {
                var exp:String = o as String ;
                var root:* = factory.config.root ;
                if ( exp.length > 0 )
                {
                    switch( exp )
                    {
                        case MagicReference.CONFIG :
                        {
                            return factory.config.config ;
                        }
                        case MagicReference.LOCALE :
                        {
                            return factory.config.locale ;
                        }
                        case MagicReference.PARAMS :
                        {
                            return factory.config.parameters ;
                        }
                        case MagicReference.THIS :
                        {
                            return factory ;
                        }
                        case MagicReference.ROOT :
                        {
                            return root ;
                        }
                        case MagicReference.STAGE :
                        {
                            var stage:* = factory.config.stage ;
                            if ( stage != null )
                            {
                                return stage ;
                            }
                            else if ( ( root != null ) && ( "stage" in root ) && ( root["stage"] != null ) )
                            {
                                 return root.stage ;
                            }
                            else
                            { 
                                return undefineable ;
                            }
                        }
                        default :
                        {
                            var members:Array = exp.split( separator ) ;
                            if ( members.length > 0 )
                            {
                                var ref:String = members.shift() ;
                                var value:*    = factory.getObject( ref ) ;
                                if ( value != null && members.length > 0 )
                                {
                                    _propEvaluator.target = value ;
                                    value = _propEvaluator.eval( members.join(".") ) ;
                                    _propEvaluator.target = null ;
                                }
                                return value ;
                            }
                        }
                    }
                }
            }
            return undefineable ;
        }
        
        /**
         * @private
         */
        private var _factory:IObjectFactory ;
        
        /**
         * @private
         */
        private var _propEvaluator:PropertyEvaluator = new PropertyEvaluator() ;
    }
}
