
/*
The contents of this file are subject to the Mozilla Public License Version
1.1 (the "License"); you may not use this file except in compliance with
the License. You may obtain a copy of the License at 
http://www.mozilla.org/MPL/ 
  
Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
for the specific language governing rights and limitations under the License. 
  
The Original Code is [ASTUce: ActionScript Test Unit compact edition AS3]. 
  
The Initial Developer of the Original Code is
Zwetan Kjukov <zwetan@gmail.com>.
Portions created by the Initial Developer are Copyright (C) 2006-2008
the Initial Developer. All Rights Reserved.
  
Contributor(s):
 */

package buRRRn.ASTUce.samples.money
{

    /* A MoneyBag is represented as a list of Monies and provides
    different constructors to create a MoneyBag.
       
    For example adding 12 euros to 14 US Dollars is represented
    as a bag containing the two Monies 12€ and 14$.
    Adding another 10 euros gives a bag with 22€ and 14$.
     */
    public class MoneyBag implements IMoney
    {

        private var _monies:Array = [];

        private function _findMoney( currency:String ):Money
        {
            var i:int;
            var m:Money;
            
            for( i = 0;i < _monies.length; i++ )
            {
                m = _monies[i];
                if( m.currency == currency )
                {
                    return m;
                }
            }
            
            return null;
        }

        /* Constructs an empty money bag.
         */
        public function MoneyBag()
        {
            return;
        }

        /* Gets an Array of monies.
         */
        public function get monies():Array
        {
            return _monies;
        }

        /* Constructs a money bag with the provided monies.
           
        note:
        If only one money is provided it returns only a money.
         */
        /*
        static public function create( ...monies ):IMoney
        {
        var i:int;
        var result:MoneyBag = new MoneyBag();
            
        for( i=0; i<monies.length; i++ )
        {
        if( monies[i] is IMoney )
        {
        monies[i].appendTo( result );
        }
        }
            
        return result.simplify();
        }
         */
        static public function create( m1:IMoney, m2:IMoney ):IMoney
        {
            var result:MoneyBag = new MoneyBag();
            
            m1.appendTo(result);
            m2.appendTo(result);
            
            return result.simplify();
        }

        /* See <IMoney.add>.
         */
        public function add( m:IMoney ):IMoney
        {
            return m.addMoneyBag(this);
        }

        /* See <IMoney.addMoney>.
         */
        public function addMoney( m:Money ):IMoney
        {
            return MoneyBag.create(m, this);
        }

        /* See <IMoney.addMoneyBag>.
         */
        public function addMoneyBag( mb:MoneyBag ):IMoney
        {
            return MoneyBag.create(mb, this);
        }

        /* Append a money bag to this money bag.
         */
        public function appendBag( aBag:MoneyBag ):void
        {
            var i:int;
            for( i = 0;i < aBag.monies.length; i++ )
            {
                appendMoney(aBag.monies[i]);
            }
        }

        /* Appends a money to this money bag.
         */
        public function appendMoney( aMoney:Money ):void
        {
            if( aMoney.isZero() )
            {
                return;
            }
            
            var old:IMoney = _findMoney(aMoney.currency);
            
            if( old == null )
            {
                _monies.push(aMoney);
                return;
            }
            
            _monies.splice(_monies.indexOf(old), 1);
            
            var sum:IMoney = old.add(aMoney);
            
            if( sum.isZero() )
            {
                return;
            }
            
            _monies.push(sum);
        }

        /* See <IMoney.appendTo>.
         */
        public function appendTo( mb:MoneyBag ):void
        {
            mb.appendBag(this);
        }

        public function contains( m:Money ):Boolean
        {
            var found:Money = _findMoney(m.currency);
            
            if( found == null )
            {
                return false;
            }
            
            return found.amount == m.amount;
        }

        /* Checks if the provided money object is equal to this money bag.
         */
        public function equals( value:* ):Boolean
        {
            if( isZero() )
            {
                if( value is IMoney )
                {
                    return (value as IMoney).isZero();
                }
            }
            
            if( value is MoneyBag )
            {
                var aMoneyBag:MoneyBag = value as MoneyBag;
                
                if( aMoneyBag.monies.length != _monies.length )
                {
                    return false;
                }
                
                var i:int;
                var m:Money;
                for( i = 0;i < _monies.length; i++ )
                {
                    m = _monies[i];
                    
                    if( !aMoneyBag.contains(m) )
                    {
                        return false;
                    }
                }
                
                return true;
            }
            
            return false;
        }

        /* See <IMoney.isZero>.
         */
        public function isZero():Boolean
        {
            return _monies.length == 0;
        }

        /* See <IMoney.multiply>.
         */
        public function multiply( factor:int ):IMoney
        {
            var result:MoneyBag = new MoneyBag();
            
            if( factor != 0 )
            {
                var i:int;
                var m:Money;
                for( i = 0;i < _monies.length; i++ )
                {
                    m = _monies[i];
                    result.appendMoney(m.multiply(factor) as Money);
                }
            }
            
            return result;
        }

        /* See <IMoney.negate>.
         */
        public function negate():IMoney
        {
            var result:MoneyBag = new MoneyBag();
            
            var i:int;
            var m:Money;
            for( i = 0;i < _monies.length; i++ )
            {
                m = _monies[i];
                result.appendMoney(m.negate() as Money);
            }
            
            return result;
        }

        public function simplify():IMoney
        {
            if( _monies.length == 1 )
            {
                return _monies[0];
            }
            
            return this;
        }

        /* See <IMoney.subtract>.
         */
        public function subtract( m:IMoney ):IMoney
        {
            return add(m.negate());
        }

        /* Returns a string representation of a money bag.
         */
        public function toString():String
        {
            var i:int;
            var str:String = "{" ;
            for( i = 0;i < _monies.length; i++ )
            {
                str += _monies[i].toString();
            }
            return str + "}";
        }
        
        /* Returns the value of a money bag.
           We let that as an exercise for the coders
           to implement exchange rate conversion ;).
        */
        /*
        public function valueOf():int
            {
            
            }
        */
    }
}

