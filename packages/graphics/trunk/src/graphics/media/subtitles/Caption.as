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

package graphics.media.subtitles
{
    import core.reflect.getClassName;
    
    import system.data.SimpleValueObject;
    
    /**
     * The basic caption entry.
     */
    public class Caption extends SimpleValueObject 
    {
        /**
         * Creates a new Caption instance.
         * @param init A generic object containing properties with which to populate the newly instance. 
         * If this argument is null, it is ignored.
         */
        public function Caption( init:Object = null )
        {
            super( init ) ;
        }
        
        /**
         * Indicates the duration of the caption.
         */
        public function get duration():Number
        {
            return end - start ;
        }
        
        /**
         * The end time of the caption.
         */
        public var end:Number;
        
        /**
         * The start time of the caption.
         */
        public var start:Number;
        
        /**
         * The text of the caption.
         */
        public var text:String = "" ;
        
        /**
         * Returns the Object representation of this object.
         * @return the Object representation of this object.
         */
        public override function toObject():Object
        {
            return { id:id , end:end , start:start , text:text } ;
        }
        
        /**
         * Returns the String representation of this object.
         * @return the String representation of this object.
         */
        public override function toString():String
        {
            return formatToString( getClassName(this) , "id" , "start" , "end" , "text" ) ;
        }
    }
}
