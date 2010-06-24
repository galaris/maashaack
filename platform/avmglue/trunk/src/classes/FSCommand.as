/* -*- c-basic-offset: 4; indent-tabs-mode: nil; tab-width: 4 -*- */
/* vi: set ts=4 sw=4 expandtab: (add to ~/.vimrc: set modeline modelines=5) */
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is [Open Source Virtual Machine.].
 *
 * The Initial Developer of the Original Code is
 * Adobe System Incorporated.
 * Portions created by the Initial Developer are Copyright (C) 2004-2006
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *   Adobe AS3 Team
 *   Zwetan Kjukov <zwetan@gmail.com>.
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

package flash.system
{
    import avmplus.System;
    
    internal final class FSCommand
    {
        //public static native function _fscommand( command:String, args:String ):void;
        public static function _fscommand( command:String, args:String ):void
        {
            
        }
    }

    /* note:
       Ok here an interesting case, from the documentation
       "The fscommand() function lets a SWF file communicate with a script in a web page.
        However, script access is controlled by the web page's allowScriptAccess setting."

       - we need a way to define this "allowScriptAccess" with our CLI logic

       following with the documentation
       "When allowScriptAccess is set to "sameDomain" (the default), scripting is allowed
        only from SWF files that are in the same domain as the web page."

       - we need a way to define the "domain" of the executable
         sure it can be localhost/127.0.0.1 by default, but for
         mocks we may need to emulate "www.domain.com"

       usage 1:

       command     | parameter   | purpose
       -----------------------------------------------------------------------------------------------------------------
       quit        | None        | Closes the projector.
       fullscreen  | true/false  | Specifying true sets Flash Player to full-screen mode.
                                   Specifying false returns the player to normal menu view.
       allowscale  | true/false  | Specifying false sets the player so that the SWF file is always drawn at its original size and never scaled.
                                   Specifying true forces the SWF file to scale to 100% of the player.
       showmenu    | true/false  | Specifying true enables the full set of context menu items.
                                   Specifying false hides all of the context menu items except About Flash Player and Settings.
       exec        | path to app | Executes an application from within the projector.
       trapallkeys | true/false  | Specifying true sends all key events, including accelerator keys,
                                   to the onClipEvent(keyDown/keyUp) handler in Flash Player.
       -----------------------------------------------------------------------------------------------------------------

       Not all of the commands listed in the table are available in all applications:
        - None of the commands are available in web players.
        - All of the commands are available in stand-alone applications, such as projectors.
        - Only allowscale and exec are available in test-movie players.

       - we need an emulate mode: "flash player", "projector", "test-movie player", etc.

       usage 2/3/4/etc.:
        - use fscommand() to send a message to a scripting language such as JavaScript in a web browser
        - use fscommand() function to send messages to Director
        - In VisualBasic, Visual C++, and other programs that can host ActiveX controls,
          fscommand() sends a VB event with two strings that can be handled in the environment's programming language.

       - basically we need a global config or settings to store those informations
    */

    /**
     * Lets the SWF file communicate with either Flash Player or the program hosting Flash Player,
     * such as a web browser.
     * You can also use the <code>fscommand()</code> function to pass messages to Director or to Visual Basic,
     * Visual C++, and other programs that can host ActiveX controls.
     * 
     * @langversion ActionScript 3.0
     * @playerversion Flash Player 9
     * @playerversion AIR 1.0
     */
    public function fscommand( command:String, args:String = "" ):void
    {
        CFG::dbg{ trace( "fscommand( " + [command,args].join(", ") + " )" ); }

        switch( command )
        {
            case "quit":
            System.exit( 0 );
            break;

            case "fullscreen":
            break;

            case "allowscale":
            break;

            case "showmenu":
            break;

            /* note:
               The exec command can contain only the characters A-Z, a-z, 0-9, period (.), and underscore (_).
               The exec command runs in the subdirectory fscommand only.
               In other words, if you use the exec command to call an application,
               the application must reside in a subdirectory named fscommand.
               The exec command works only from within a Flash projector file.
            */
            case "exec":
            //need to deal with Win / OSX / Linux path etc.
            //System.exec( "fscommand/"+arg );
            System.exec( arg );
            break;

            case "trapallkeys":
            break;
        }
        
    }
    
}
