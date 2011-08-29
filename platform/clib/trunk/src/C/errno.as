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
 * The Original Code is [clib - C more or less standard Libraries].
 *
 * The Initial Developer of the Original Code is
 * Zwetan Kjukov <zwetan@gmail.com>.
 * Portions created by the Initial Developer are Copyright (C) 2010
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *   
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
    
    /**
     * System error numbers.
     * @internal
     * 
     * @langversion 3.0
     * @playerversion Flash 9
     * @productversion redtamarin 0.3
     * @since 0.3.0
     * 
     * @see http://code.google.com/p/redtamarin/wiki/C_errno
     */
    [native(cls="::avmshell::CErrnoClass", methods="auto")]
    [Inspectable(environment="none")]
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

        public native static function get EWOULDBLOCK():int;
        public native static function get EINPROGRESS():int;
        public native static function get EALREADY():int;
        public native static function get EDESTADDRREQ():int;
        public native static function get EMSGSIZE():int;
        public native static function get EPROTOTYPE():int;
        public native static function get ENOPROTOOPT():int;
        public native static function get EADDRINUSE():int;
        public native static function get EADDRNOTAVAIL():int;
        public native static function get ENETDOWN():int;
        public native static function get ENETUNREACH():int;
        public native static function get ENETRESET():int;
        public native static function get ECONNABORTED():int;
        public native static function get ECONNRESET():int;
        public native static function get ENOBUFS():int;
        public native static function get EISCONN():int;
        public native static function get ENOTCONN():int;
        public native static function get ESHUTDOWN():int;
        public native static function get ETOOMANYREFS():int;
        public native static function get ETIMEDOUT():int;
        public native static function get ECONNREFUSED():int;
        public native static function get ELOOP():int;
        public native static function get EHOSTDOWN():int;
        public native static function get EHOSTUNREACH():int;
        
        
        public native static function GetErrno():int;
        public native static function SetErrno( value:int ):void;
    }

    /** Numerical argument out of domain.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const EDOM:int   = __errno.EDOM;

    /** Illegal byte sequence.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const EILSEQ:int = __errno.EILSEQ;

    /** Result too large.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const ERANGE:int = __errno.ERANGE;


    /** Operation not permitted.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const EPERM:int        = __errno.EPERM;

    /** No such file or directory.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const ENOENT:int       = __errno.ENOENT;

    /** No such process.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const ESRCH:int        = __errno.ESRCH;

    /** Interrupted system call.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const EINTR:int        = __errno.EINTR;

    /** Input/output error.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const EIO:int          = __errno.EIO;

    /** Device not configured.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const ENXIO:int        = __errno.ENXIO;

    /** Argument list too long.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const E2BIG:int        = __errno.E2BIG;

    /** Exec format error.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const ENOEXEC:int      = __errno.ENOEXEC;

    /** Bad file descriptor.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const EBADF:int        = __errno.EBADF;

    /** No child processes.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const ECHILD:int       = __errno.ECHILD;

    /** Resource temporarily unavailable.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const EAGAIN:int       = __errno.EAGAIN;

    /** Cannot allocate memory.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const ENOMEM:int       = __errno.ENOMEM;

    /** Permission denied.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const EACCES:int       = __errno.EACCES;

    /** Bad address.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const EFAULT:int       = __errno.EFAULT;

    /** Device / Resource busy.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const EBUSY:int        = __errno.EBUSY;

    /** File exists.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const EEXIST:int       = __errno.EEXIST;

    /** Cross-device link.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const EXDEV:int        = __errno.EXDEV;

    /** Operation not supported by device.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const ENODEV:int       = __errno.ENODEV;

    /** Not a directory.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const ENOTDIR:int      = __errno.ENOTDIR;

    /** Is a directory.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const EISDIR:int       = __errno.EISDIR;

    /** Invalid argument.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const EINVAL:int       = __errno.EINVAL;

    /** Too many open files in system.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const ENFILE:int       = __errno.ENFILE;

    /** Too many open files.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const EMFILE:int       = __errno.EMFILE;

    /** Inappropriate ioctl for device.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const ENOTTY:int       = __errno.ENOTTY;

    /** File too large.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const EFBIG:int        = __errno.EFBIG;

    /** No space left on device.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const ENOSPC:int       = __errno.ENOSPC;

    /** Illegal seek.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const ESPIPE:int       = __errno.ESPIPE;

    /** Read-only file system.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const EROFS:int        = __errno.EROFS;

    /** Too many links.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const EMLINK:int       = __errno.EMLINK;

    /** Broken pipe.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const EPIPE:int        = __errno.EPIPE;

    /** Resource deadlock avoided.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const EDEADLK:int      = __errno.EDEADLK;

    /** File name too long.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const ENAMETOOLONG:int = __errno.ENAMETOOLONG;

    /** No locks available.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const ENOLCK:int       = __errno.ENOLCK;

    /** Function not implemented.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const ENOSYS:int       = __errno.ENOSYS;

    /** Directory not empty.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const ENOTEMPTY:int    = __errno.ENOTEMPTY;



    /** Operation would block.
     * @productversion redtamarin 0.3
     * @since 0.3.2
     */
    public const EWOULDBLOCK:int = __errno.EWOULDBLOCK;

    /** Operation now in progress.
     * @productversion redtamarin 0.3
     * @since 0.3.2
     */
    public const EINPROGRESS:int = __errno.EINPROGRESS;

    /** Operation already in progress.
     * @productversion redtamarin 0.3
     * @since 0.3.2
     */
    public const EALREADY:int = __errno.EALREADY;

    /** Destination address required.
     * @productversion redtamarin 0.3
     * @since 0.3.2
     */
    public const EDESTADDRREQ:int = __errno.EDESTADDRREQ;

    /** Message too long.
     * @productversion redtamarin 0.3
     * @since 0.3.2
     */
    public const EMSGSIZE:int = __errno.EMSGSIZE;

    /** Protocol wrong type for socket.
     * @productversion redtamarin 0.3
     * @since 0.3.2
     */
    public const EPROTOTYPE:int = __errno.EPROTOTYPE;

    /** Bad protocol option.
     * @productversion redtamarin 0.3
     * @since 0.3.2
     */
    public const ENOPROTOOPT:int = __errno.ENOPROTOOPT;

    /** Address already in use.
     * @productversion redtamarin 0.3
     * @since 0.3.2
     */
    public const EADDRINUSE:int = __errno.EADDRINUSE;

    /** Can't assign requested address.
     * @productversion redtamarin 0.3
     * @since 0.3.2
     */
    public const EADDRNOTAVAIL:int = __errno.EADDRNOTAVAIL;

    /** Network is down.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const ENETDOWN:int     = __errno.ENETDOWN;

    /** Network is unreachable.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const ENETUNREACH:int  = __errno.ENETUNREACH;

    /** Network dropped connection on reset.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const ENETRESET:int    = __errno.ENETRESET;

    /** Software caused connection abort.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const ECONNABORTED:int = __errno.ECONNABORTED;

    /** Connection reset by peer.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const ECONNRESET:int   = __errno.ECONNRESET;

    /** No buffer space available.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const ENOBUFS:int      = __errno.ENOBUFS;

    /** Socket is already connected.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const EISCONN:int      = __errno.EISCONN;

    /** Socket is not connected.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const ENOTCONN:int     = __errno.ENOTCONN;

    /** Can't send after socket shutdown.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const ESHUTDOWN:int    = __errno.ESHUTDOWN;

    /** Too many references: can't splice.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const ETOOMANYREFS:int = __errno.ETOOMANYREFS;

    /** Operation timed out.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const ETIMEDOUT:int    = __errno.ETIMEDOUT;

    /** Connection refused.
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public const ECONNREFUSED:int = __errno.ECONNREFUSED;

    /** Too many levels of symbolic links.
     * @productversion redtamarin 0.3
     * @since 0.3.2
     */
    public const ELOOP:int = __errno.ELOOP;

    /** Host is down.
     * @productversion redtamarin 0.3
     * @since 0.3.2
     */
    public const EHOSTDOWN:int = __errno.EHOSTDOWN;

    /** No Route to Host.
     * @productversion redtamarin 0.3
     * @since 0.3.2
     */
    public const EHOSTUNREACH:int = __errno.EHOSTUNREACH;



    /**
     * Error return value.
     * 
     * <p>
     * Designates an object that is assigned a value greater than zero on certain library errors.
     * </p>
     * 
     * 
     * @example basic usage
     * <listing version="3.0">
     *  import C.errno.&#42;;
     *  import C.string.&#42;;
     *  import avmplus.FileSystem;
     *  
     *  var filename:String = "dummy_file";
     *  
     *  if( !FileSystem.exists( filename ) )
     *  {
     *      trace( "errno = " + errno ); //errno = 2
     *      trace( strerror( errno ) );  //No such file or directory
     *  }
     * </listing>
     * 
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    
    /**
     * @private
     * 
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public function get errno():int
    {
        return __errno.GetErrno();
    }

    /**
     * Function to get the Error value.
     * 
     * @productversion redtamarin 0.3
     * @since 0.3.2
     */
    public function getErrno():int
    {
        return __errno.GetErrno();
    }

    /**
     * @private
     * 
     * @productversion redtamarin 0.3
     * @since 0.3.0
     */
    public function set errno( value:int ):void
    {
        __errno.SetErrno( value );
    }

    /**
     * Function to set the Error value.
     * 
     * @productversion redtamarin 0.3
     * @since 0.3.2
     */
    public function setErrno( value:int ):void
    {
        __errno.SetErrno( value );
    }
    
}
