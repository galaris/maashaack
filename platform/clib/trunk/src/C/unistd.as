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

package C.unistd
{
    
    [native(cls="::avmshell::UnistdClass", methods="auto")]
    internal class __unistd
    {
        public native static function get F_OK():int;
        public native static function get X_OK():int;
        public native static function get W_OK():int;
        public native static function get R_OK():int;

        /* note:
           all those are also normaly defined in <sys/stat.h>
           moved here because of chmod()
        */
        public native static function get S_IFMT():int;
        public native static function get S_IFIFO():int;
        public native static function get S_IFCHR():int;
        public native static function get S_IFDIR():int;
        public native static function get S_IFBLK():int;
        public native static function get S_IFREG():int;
        public native static function get S_IFLNK():int;
        public native static function get S_IFSOCK():int;

        public native static function get S_IRWXU():int;
        public native static function get S_IRUSR():int;
        public native static function get S_IWUSR():int;
        public native static function get S_IXUSR():int;
        
        public native static function get S_IRWXG():int;
        public native static function get S_IRGRP():int;
        public native static function get S_IWGRP():int;
        public native static function get S_IXGRP():int;
        
        public native static function get S_IRWXO():int;
        public native static function get S_IROTH():int;
        public native static function get S_IWOTH():int;
        public native static function get S_IXOTH():int;

        public native static function get S_IREAD():int;
        public native static function get S_IWRITE():int;
        public native static function get S_IEXEC():int;


        public native static function access( path:String, mode:int ):int;  //int access(const char *path, int mode);
        public native static function chmod( path:String, mode:int ):int;  //int chmod(const char *path, mode_t mode);
        public native static function getcwd():String;                      //void abort(void);

        /* note:
           mkdir() is normaly defined in <sys/stat.h> and can define file permission
           eg. int mkdir(const char *path, mode_t mode);
           1. to be in sync with _mkdir() WIN32 which can not define file permission
              we don't allow it in the API, we use those default permissions:
              S_IRWXU = Read, write, execute/search by owner.
              S_IRWXG = Read, write, execute/search by group.
              S_IRWXO = Read, write, execute/search by others.
           2. because unistd define rmdir(), we moved the function here
              instead of having C.sys.stat::mkdir() as it seems cleaner
        */
        public native static function mkdir( path:String ):int;            //int mkdir(const char *path);
        public native static function rmdir( path:String ):int;            //int rmdir(const char *path);
    }

    /** Check for existence. */
    public const F_OK:int = __unistd.F_OK;

    /** Check for execute permission. */
    public const X_OK:int = __unistd.X_OK;

    /** Check for write permission. */
    public const W_OK:int = __unistd.W_OK;

    /** Check for read permission. */
    public const R_OK:int = __unistd.R_OK;

    /** Type of file mask. */
    public const S_IFMT:int   = __unistd.S_IFMT;
    
    /** Named pipe (fifo). */
    public const S_IFIFO:int  = __unistd.S_IFIFO;
    
    /** Character special (device). */
    public const S_IFCHR:int  = __unistd.S_IFCHR;
    
    /** Directory. */
    public const S_IFDIR:int  = __unistd.S_IFDIR;
    
    /** Block special (device). */
    public const S_IFBLK:int  = __unistd.S_IFBLK;
    
    /** Regular file. */
    public const S_IFREG:int  = __unistd.S_IFREG;
    
    /** Symbolic link. */
    public const S_IFLNK:int  = __unistd.S_IFLNK;
    
    /** Socket. */
    public const S_IFSOCK:int = __unistd.S_IFSOCK;

    /** RWX mask for owner. */
    public const S_IRWXU:int = __unistd.S_IRWXU;
    /** R for owner. */
    public const S_IRUSR:int = __unistd.S_IRUSR;
    /** W for owner. */
    public const S_IWUSR:int = __unistd.S_IWUSR;
    /** X for owner. */
    public const S_IXUSR:int = __unistd.S_IXUSR;

    /** RWX mask for group. */
    public const S_IRWXG:int = __unistd.S_IRWXG;
    /** R for group. */
    public const S_IRGRP:int = __unistd.S_IRGRP;
    /** W for group. */
    public const S_IWGRP:int = __unistd.S_IWGRP;
    /** X for group. */
    public const S_IXGRP:int = __unistd.S_IXGRP;

    /** RWX mask for other. */
    public const S_IRWXO:int = __unistd.S_IRWXO;
    /** R for other. */
    public const S_IROTH:int = __unistd.S_IROTH;
    /** W for other. */
    public const S_IWOTH:int = __unistd.S_IWOTH;
    /** X for other. */
    public const S_IXOTH:int = __unistd.S_IXOTH;

    /** R for all (backward compatability). */
    public const S_IREAD:int  = __unistd.S_IREAD;
    /** W for all (backward compatability). */
    public const S_IWRITE:int = __unistd.S_IWRITE;
    /** X for all (backward compatability). */
    public const S_IEXEC:int  = __unistd.R_OK;


    /**
     * Determine accessibility of a file.
     */
    public function access( path:String, mode:int ):int
    {
        return __unistd.access( path, mode );
    }
    
    /**
     * Get the pathname of the current working directory.
     */
    public function getcwd():String
    {
        return __unistd.getcwd();
    }

    /**
     * Make directory.
     */
    public function mkdir( path:String ):int
    {
        return __unistd.mkdir( path );
    }

    /**
     * Remove directory.
     */
    public function rmdir( path:String ):int
    {
        return __unistd.rmdir( path );
    }

    /**
     * Change mode of a file.
     */
    public function chmod( path:String, mode:int ):int
    {
        return __unistd.chmod( path, mode );
    }
}
