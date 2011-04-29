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

package system.terminals
{
    /**
     * An InteractiveConsole can interact with the user and the system using standard streams : 
     * standard input (stdin), standard output (stdout) and standard error (stderr).
     * <p><b>See :</b> <a href="http://en.wikipedia.org/wiki/Standard_streams">http://en.wikipedia.org/wiki/Standard_streams</a>.</p>
     */
    public interface InteractiveConsole extends Console
    {
        /**
         * Standard error is another output stream typically used by programs to output error messages or diagnostics. 
         * It is a stream independent of standard output and can be redirected separately.
         */
        function get stderr():String ;
        
        /**
         * @private
         */
        function set stderr( value:String ):void ;
        
        /**
         * Standard input is data (often text) going into a program. 
         * The program requests data transfers by use of the read operation.
         * Not all programs require input.
         */
        function get stdin():String ;
        
        /**
         * @private
         */
        function set stdin( value:String ):void;
        
        /**
         * Standard output is the stream where a program writes its output data. 
         * The program requests data transfer with the write operation.
         * Not all programs generate output.
         */
        function get stdout():String ;
        
        /**
         * @private
         */
        function set stdout( value:String ):void ;
        
        /**
         * Clear all standard streams.
         */
        function clear():void ;
    }
}

