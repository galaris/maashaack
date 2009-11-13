
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

    /* A simple Money.
     */
    public class Money implements IMoney
    {

        private var _amount:int;

        private var _currency:String;

        /* Constructs a money from the given amount and currency.
         */
        public function Money( amount:int, currency:String )
        {
            _amount = amount;
            _currency = currency;
        }

        /* Gets the money amount.
         */
        public function get amount():int
        {
            return _amount;
        }

        /* Gets the money currency.
         */
        public function get currency():String
        {
            return _currency;
        }

        /* See <IMoney.add>.
         */
        public function add( m:IMoney ):IMoney
        {
            return m.addMoney(this);
        }

        /* See <IMoney.addMoney>.
         */
        public function addMoney( m:Money ):IMoney
        {
            if( m.currency == currency )
            {
                return new Money(amount + m.amount, currency);
            }
            return MoneyBag.create(this, m);
        }
        
        /* See <IMoney.addMoneyBag>.
         */
        public function addMoneyBag( mb:MoneyBag ):IMoney
        {
            return mb.addMoney(this);
        }

        /* See <IMoney.appendTo>.
         */
        public function appendTo( mb:MoneyBag ):void
        {
            mb.appendMoney(this);
        }

        /* Checks if the provided money object is equal to this money.
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
            
            if( value is Money )
            {
                var aMoney:Money = value as Money;
                return (aMoney.currency == currency) && (aMoney.amount == amount);
            }
            
            return false;
        }

        /* See <IMoney.isZero>.
         */
        public function isZero():Boolean
        {
            return amount == 0;
        }

        /* See <IMoney.multiply>.
         */
        public function multiply( factor:int ):IMoney
        {
            return new Money(amount * factor, currency);
        }

        /* See <IMoney.negate>.
         */
        public function negate():IMoney
        {
            return new Money(-amount, currency);
        }

        /* See <IMoney.subtract>.
         */
        public function subtract( m:IMoney ):IMoney
        {
            return add(m.negate());
        }

        /* Returns a string representation of a money.
         */
        public function toString():String
        {
            return "[" + amount + currency + "]";
        }
        
        /* Returns the value of a money.
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

