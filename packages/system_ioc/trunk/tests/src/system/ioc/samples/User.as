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

package system.ioc.samples
{
    /**
     * The User class to test the LightContainer.
     */
    public class User
    {
        /**
         * Creates a new User instance.
         */
        public function User( pseudo:String = null, name:String =null , address:Address = null )
        {
            this.pseudo  = pseudo ;
            this.name    = name ;
            this.address = address ;
        }
        
        /**
         * The Address reference of this object.
         */
        public var address:Address ;
        
        /**
         * The age of the user.
         */
        public var age:Number ;
        
        /**
         * The fistname of the user.
         */
        public var firstName:String ;
        
        /**
         * The job of this User.
         */
        public var job:Job ;
        
        /**
         * The mail of the user.
         */
        public var mail:String ;
        
        /**
         * The name of the User.
         */
        public var name:String ;
        
        /**
         * The pseudo of the user.
         */
        public var pseudo:String ;
        
        /**
         * The url of the User.
         */
        public var url:String ;
        
        /**
         * Destroy the user.
         */
        public function destroy():void
        {
            trace( this + " destroy.") ;
        }
        
        /**
         * Initialize the User.
         */
        public function initialize():void
        {
            trace( this + " initialize.") ;
        }
        
        /**
         * Sets the mail value of this user.
         */
        public function setMail( sMail:String ):void
        {
            mail = sMail ;
        }
        
        /**
         * Returns the string representation of the object.
         * @return the string representation of the object.
         */
        public function toString():String
        {
            return "[User " + ( pseudo != null ? " " + pseudo : "" ) + "]" ;
        }
    }
}