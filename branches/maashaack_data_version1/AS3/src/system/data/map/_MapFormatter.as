/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package system.data.map
{
    import system.data.Map;
    import system.data.iterator.ArrayIterator;
    import system.data.iterator.Iterator;
    import system.formatters.Formattable;    

    [ExcludeClass]
    
    /**
     * Converts a Map to a custom string representation.
     */
    public class _MapFormatter implements Formattable 
    {
            
        /**
         * Creates a new MapFormatter instance.
         */
        public function _MapFormatter()
        {
            //  
        }
            
        /**
         * Formats the specified value.
         * @return the string representation of the formatted value. 
         */
        public function format( value:* = null ):String
        {
            var m:Map = value as Map ;
            if ( m == null ) 
            {
                return "" ;
            }
            var r:String = "{";
            var vIterator:Iterator = new ArrayIterator( m.getValues() ) ;
            var kIterator:Iterator = new ArrayIterator( m.getKeys()   ) ;
            while( kIterator.hasNext() ) 
            {
                var k:* = kIterator.next() ;
                var v:* = vIterator.next() ;
                r += k + ":" + v ;
                if ( kIterator.hasNext() ) 
                {
                    r += "," ;
                }
            }
            r += "}" ;
            return r ;
        }
    }
}


