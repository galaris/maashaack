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

package system.evaluators 
{
    import system.Evaluable;
    
    /**
     * This <code class="prettyprint">IEvaluator</code> use a <code class="prettyprint">Array</code> collection of evaluators to evaluate the specified value.
     * <pre class="prettyprint">
     * import system.evaluators.* ;
     * 
     * var e1:EdenEvaluator = new EdenEvaluator(false) ;
     * var e2:DateEvaluator = new DateEvaluator() ;
     * 
     * var result:* ;
     * 
     * var me:MultiEvaluator = new MultiEvaluator( e1, e2 ) ;
     * 
     * result = me.eval( "new Date(2007,5,12,22,10,5)" ) ;
     * trace("evaluate new Date(2007,5,12,22,10,5) : " + result ) ; // evaluate new Date(2007,5,12,22,10,5) :  07.06.2008 09:10:53
     * 
     * me.clear() ;
     * 
     * me.add( e1 , e2 ) ;
     * 
     * result = me.eval("new Date(2007,5,12,22,10,5)") ;
     * 
     * trace("evaluate new Date(2007,5,12,22,10,5) : " + result ) ; // evaluate new Date(2007,5,12,22,10,5) : Tue Jun 12 22:10:05 GMT+0200 2007
     * 
     * me.remove( e2 ) ;
     * 
     * result = me.eval("new Date(2007,5,12,22,10,5)") ;
     * 
     * trace("evaluate new Date(2007,5,12,22,10,5) : " + result ) ; // evaluate new Date(2007,5,12,22,10,5) :  07.06.2008 09:10:53
     * </pre>
     */
    public class MultiEvaluator implements Evaluable
    {
        /**
         * Creates a new MultiEvaluator instance.
         * @param ...evaluators The enumeration list of <code class="prettyprint">Evaluable</code> objets or Arrays of Evaluable objects. Only Array and Evaluable objects are compatible to fill the MultiEvaluator.
         */
        public function MultiEvaluator( ...evaluators:Array )
        {
            _evaluators = [] ;
            if ( evaluators.length > 0 )
            { 
                add.apply( this, evaluators ) ;
            }
        }
        
        /**
         * Indicates if the MultiEvaluator is cleared before insert new <code class="prettyprint">Evaluable</code> objects (in the insert method).
         */
        public var autoClear:Boolean ;
        
        /**
         * Inserts <code class="prettyprint">Evaluable</code> objects in the MultiEvaluator.  
         * @param ...evaluators The enumeration list of Evaluable objets or Arrays of Evaluator. Only Array and Evaluable are compatible to fill the MultiEvaluator.
         */
        public function add( ...evaluators:Array ):void
        {
            if ( autoClear )
            {
                clear( ) ;
            }
            var l:int = evaluators.length ; 
            if ( l > 0 )
            {
                var c:int, i:int, j:int ;
                var e:* ;
                for ( i = 0 ; i < l ; i++ )
                {
                    e = evaluators[i] ;
                    if ( e is Evaluable )
                    {
                        _evaluators.push( e ) ;
                    }
                    else if ( e is Array )
                    {
                        c = (e as Array).length ;
                        for ( j = 0 ; j < c ; j++ )
                        {
                            if ( e[j] is Evaluable )
                            {
                                _evaluators.push( e[j] ) ; 
                            }
                        }
                    }
                    else
                    {
                        // nothing
                    }
                }
            }
        }
        
        /**
         * Clear all the <code class="prettyprint">Evaluable</code> objects.
         */
        public function clear():void
        {
            _evaluators = [] ;
        }
        
        /**
         * Evaluates the specified object.
         */
        public function eval( o:* ):*
        {
            var i:uint ;
            var len:int = _evaluators.length ;
            if ( len > 0 )
            {
                for ( i = 0 ; i < len ; i++ )
                {
                    o = _evaluators[i].eval( o ) ;
                }
            }
            return o ;
        }
        
        /**
         * Removes an <code class="prettyprint">Evaluable</code> objects in the MultiEvaluator if is register.
         * @param evaluator The <code class="prettyprint">Evaluable</code> to find and remove.
         * @return <code class="prettyprint">true</code> if the Evaluable is removed.
         */
        public function remove( evaluator:Evaluable ):Boolean
        {
            var index:int = _evaluators.indexOf( evaluator ) ;
            if( index > - 1 )
            {
                _evaluators.splice( index, 1 ) ;
                return true ;
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * The number of elements in this collection of Evaluable references.
         */
        public function size():Number
        {
            return _evaluators.length ;
        }
        
        /**
         * @private
         */
        private var _evaluators:Array ;
    }
}
