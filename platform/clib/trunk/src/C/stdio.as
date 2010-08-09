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

package C.stdio
{
    
    [native(cls="::avmshell::StdioClass", methods="auto")]
    internal class __stdio
    {
        public native static function get FILENAME_MAX():int;
        /* note:
           PATH_MAX is normaly defined in <limits.h>
           we moved the definition here (as we don't plan to create a C.limits.* package)
        */
        public native static function get PATH_MAX():int;
        
        public native static function remove( filename:String ):int;                 //int remove ( const char * filename );
        public native static function rename( oldname:String, newname:String ):int;  //int rename ( const char * oldname, const char * newname );
    }

    /** Maximum size in bytes of the longest filename string that the implementation guarantees can be opened. */
    public const FILENAME_MAX:int = __stdio.FILENAME_MAX;
    
    /** Maximum number of bytes in a pathname. */
    public const PATH_MAX:int     = __stdio.PATH_MAX;


    /**
     * Remove a file.
     * 
     * note:
     * under WIN32, you can get a "File Permission Denied" if you try to remove a directory path
     * you should instead use rmdir() in C.unistd
     */
    public function remove( filename:String ):int
    {
        return __stdio.remove( filename );
    }
    
    /**
     * Rename a file.
     */
    public function rename( oldname:String, newname:String ):int
    {
        return __stdio.rename( oldname, newname );
    }
    
    
}
