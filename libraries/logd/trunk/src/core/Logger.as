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

package core
{
    /**
     * The Logger interface/type
     */
    public interface Logger
    {
        /** SUPPRESS value */
        function get SUPPRESS():int;
        
        /** VERBOSE value */
        function get VERBOSE():int;
        
        /** DEBUG value */
        function get DEBUG():int;
        
        /** INFO value */
        function get INFO():int;
        
        /** WARN value */
        function get WARN():int;
        
        /** ERROR value */
        function get ERROR():int;
        
        /** ASSERT value */
        function get ASSERT():int;
        
        /** Returns the unique ID for the logger */
        function get id():String;
        
        /** Returns the logging level for this logger */
        function get level():int;
        
        /** @private */
        function set level( value:int ):void;
        
        /**
         * Define a log input function.
         * 
         * The input is used to parse the log before sending it,
         * you could use it to support special formating, appending
         * additional informations, etc.
         * 
         * the function HAVE TO respect this signature
         * <code>
         * function input( msg:String, o:* = null ):Object
         * {
         *     
         * }
         * </code>
         * 
         * The returned object must contains 2 properties <code>msg</code> and <code>o</code>.
         * 
         */
        function get input():Function;
        
        /** @private */
        function set input( value:Function ):void;
        
        /**
         * Define a log output function.
         * 
         * The output is used to send the log to a destination,
         * by default we use <code>trace()</code> but you could
         * use Socket, LocalConnection, etc.
         * 
         * the function HAVE TO respect this signature
         * <code>
         * function output( msg:String, o:* = null ):void
         * {
         * 
         * }
         * </code>
         */
        function get output():Function;
        
        /** @private */
        function set output( value:Function ):void;
        
        /**
         * Configure the logger with values/pairs.
         * 
         * <code>
         * cfg = { sep: " ",
         *         mode: "raw", // "clean", "data", "short"
         *         tag: true,
         *         time: false
         *       }
         * 
         * log.config( cfg );
         * </code>
         */
        function config( cfg:Object ):void;
        
        /**
         * Changes the formatting of the passed priority.
         * 
         * <code>
         * log.config( { mode: "clean" } );
         * log.format( log.DEBUG, "D{ ", " }" );
         * log.d( "hello world" ); // D{ hello world }
         * </code>
         */ 
        function format( priority:int, pre:String = "", post:String = "" ):void;
        
        /**
         * Creates a tag and return a new logger object
         * 
         * <code>
         * var mylog:logger = log.tag( "socket" );
         * mylog.d( "client connected" ); // D|socket|client connected
         * </code>
         */
        function tag( name:String, level:int = -1 ):Logger;
        
        /**
         * Send a VERBOSE log message.
         */
        function v( msg:String, o:* = null ):void;
        
        /**
         * Send a DEBUG log message.
         */
        function d( msg:String, o:* = null ):void;
        
        /**
         * Send an INFO log message.
         */
        function i( msg:String, o:* = null ):void;
        
        /**
         * Send a WARN log message.
         */
        function w( msg:String, o:* = null ):void;
        
        /**
         * Send an ERROR log message.
         */
        function e( msg:String, o:* = null ):void;
        
        /**
         * What a Terrible Failure (or What The Fuck).
         * Report a condition that should never happen (eg. send an ASSERT log message).
         */
        function wtf( msg:String, o:* = null ):void;
        
        /**
         * Low-level logging call.
         */ 
        function println( priority:int, tag:String, msg:String, o:* = null ):void;
        
    }
}