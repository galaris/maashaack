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

package C.errno
{
    
    [native(cls="::avmshell::CErrnoClass", methods="auto")]
    internal class __errno
    {
        public native static function get EDOM():int;
        public native static function get EILSEQ():int;
        public native static function get ERANGE():int;
        
        public native static function get EPERM():int;
        public native static function get ENOENT():int;
        public native static function get ESRCH():int;
        public native static function get EINTR():int;
        public native static function get EIO():int;
        public native static function get ENXIO():int;
        public native static function get E2BIG():int;
        public native static function get ENOEXEC():int;
        public native static function get EBADF():int;
        public native static function get ECHILD():int;
        public native static function get EAGAIN():int;
        public native static function get ENOMEM():int;
        public native static function get EACCES():int;
        public native static function get EFAULT():int;
        public native static function get EBUSY():int;
        public native static function get EEXIST():int;
        public native static function get EXDEV():int;
        public native static function get ENODEV():int;
        public native static function get ENOTDIR():int;
        public native static function get EISDIR():int;
        public native static function get EINVAL():int;
        public native static function get ENFILE():int;
        public native static function get EMFILE():int;
        public native static function get ENOTTY():int;
        public native static function get EFBIG():int;
        public native static function get ENOSPC():int;
        public native static function get ESPIPE():int;
        public native static function get EROFS():int;
        public native static function get EMLINK():int;
        public native static function get EPIPE():int;
        public native static function get EDEADLK():int;
        public native static function get ENAMETOOLONG():int;
        public native static function get ENOLCK():int;
        public native static function get ENOSYS():int;
        public native static function get ENOTEMPTY():int;
        
        
        public native static function get errno():int;
        public native static function set errno( value:int ):void;
    }

    /** Numerical argument out of domain. */
    public const EDOM:int   = __errno.EDOM;

    /** Illegal byte sequence. */
    public const EILSEQ:int = __errno.EILSEQ;

    /** Result too large. */
    public const ERANGE:int = __errno.ERANGE;


    /** Operation not permitted. */
    public const EPERM:int        = __errno.EPERM;

    /** No such file or directory. */
    public const ENOENT:int       = __errno.ENOENT;

    /** No such process. */
    public const ESRCH:int        = __errno.ESRCH;

    /** Interrupted system call. */
    public const EINTR:int        = __errno.EINTR;

    /** Input/output error. */
    public const EIO:int          = __errno.EIO;

    /** Device not configured. */
    public const ENXIO:int        = __errno.ENXIO;

    /** Argument list too long. */
    public const E2BIG:int        = __errno.E2BIG;

    /** Exec format error. */
    public const ENOEXEC:int      = __errno.ENOEXEC;

    /** Bad file descriptor. */
    public const EBADF:int        = __errno.EBADF;

    /** No child processes. */
    public const ECHILD:int       = __errno.ECHILD;

    /** Resource temporarily unavailable. */
    public const EAGAIN:int       = __errno.EAGAIN;

    /** Cannot allocate memory. */
    public const ENOMEM:int       = __errno.ENOMEM;

    /** Permission denied. */
    public const EACCES:int       = __errno.EACCES;

    /** Bad address. */
    public const EFAULT:int       = __errno.EFAULT;

    /** Device / Resource busy. */
    public const EBUSY:int        = __errno.EBUSY;

    /** File exists. */
    public const EEXIST:int       = __errno.EEXIST;

    /** Cross-device link. */
    public const EXDEV:int        = __errno.EXDEV;

    /** Operation not supported by device. */
    public const ENODEV:int       = __errno.ENODEV;

    /** Not a directory. */
    public const ENOTDIR:int      = __errno.ENOTDIR;

    /** Is a directory. */
    public const EISDIR:int       = __errno.EISDIR;

    /** Invalid argument. */
    public const EINVAL:int       = __errno.EINVAL;

    /** Too many open files in system. */
    public const ENFILE:int       = __errno.ENFILE;

    /** Too many open files. */
    public const EMFILE:int       = __errno.EMFILE;

    /** Inappropriate ioctl for device. */
    public const ENOTTY:int       = __errno.ENOTTY;

    /** File too large. */
    public const EFBIG:int        = __errno.EFBIG;

    /** No space left on device. */
    public const ENOSPC:int       = __errno.ENOSPC;

    /** Illegal seek. */
    public const ESPIPE:int       = __errno.ESPIPE;

    /** Read-only file system. */
    public const EROFS:int        = __errno.EROFS;

    /** Too many links. */
    public const EMLINK:int       = __errno.EMLINK;

    /** Broken pipe. */
    public const EPIPE:int        = __errno.EPIPE;

    /** Resource deadlock avoided. */
    public const EDEADLK:int      = __errno.EDEADLK;

    /** File name too long. */
    public const ENAMETOOLONG:int = __errno.ENAMETOOLONG;

    /** No locks available. */
    public const ENOLCK:int       = __errno.ENOLCK;

    /** Function not implemented. */
    public const ENOSYS:int       = __errno.ENOSYS;

    /** Directory not empty. */
    public const ENOTEMPTY:int    = __errno.ENOTEMPTY;
    

    public function get errno():int
    {
        return __errno.errno;
    }

    public function set errno( value:int ):void
    {
        __errno.errno = value;
    }
    
    
}
