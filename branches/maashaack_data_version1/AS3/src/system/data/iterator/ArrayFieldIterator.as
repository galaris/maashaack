/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [MaasHaack framework]
  
  The Initial Developer of the Original Code is
  Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  
*/

package system.data.iterator
{

    /**
     * Converts an array to an iterator but this iterator return the value of a specific field if the array is an array of objects.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.iterator.ArrayFieldIterator ;
     * 
     * var ar:Array = 
     * [
     *     { label : "item1", date : new Date(2005, 10, 12) } ,
     *     { label : "item2", date : new Date(2004, 2, 22) } ,
     *     { label : "item3", date : new Date(2005, 4, 3) }
     * ] ;
     * 
     * trace (" --- browse 'label' field") ;
     * 
     * var it:ArrayFieldIterator = new ArrayFieldIterator(ar, "label") ;
     * while (it.hasNext()) 
     * {
     *     trace (it.next() + " : " + it.key()) ;
     * }
     * 
     * trace(" --- browse 'date' field") ;
     * 
     * var it:ArrayFieldIterator = new ArrayFieldIterator(ar, "date") ;
     * while (it.hasNext())
     * {
     *     trace (it.next() + " : " + it.key()) ;
     * }
     * </pre>
     * @author eKameleon
     */
    public class ArrayFieldIterator extends ArrayIterator
    {
    
        /**
         * Creates a new ArrayFieldIterator instance.
         */
        public function ArrayFieldIterator(a:Array, fieldName:String=null)
        {
            super(a) ;
            this.fieldName = fieldName ;
        }

        /**
         * The field used in the next method to return the next value in the array.
         */    
        public var fieldName:String ;
        
        /**
         * The default undefineable value use if the field don't exist in the current object in the iterator. 
         */
        public var undefineable:* = null ;
        
        /**
         * Returns the next field element in the iteration.
         * @return the next field element in the iteration.
         */
        public override function next():* 
        {
            var o:* = _a[++_k] ;
            return ( fieldName != null ) ? ( fieldName in o ? o[fieldName] : null ) : o ;
        }
        

    }
}