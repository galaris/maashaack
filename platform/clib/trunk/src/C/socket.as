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

package C.socket
{
    
    [native(cls="::avmshell::CSocketClass", methods="auto")]
    internal class __socket
    {
        public native static function get SOCK_RAW():int;
        public native static function get SOCK_STREAM():int;
        public native static function get SOCK_DGRAM():int;

        public native static function get SO_ACCEPTCONN():int;
        public native static function get SO_BROADCAST():int;
        public native static function get SO_DONTROUTE():int;
        public native static function get SO_KEEPALIVE():int;
        public native static function get SO_OOBINLINE():int;
        public native static function get SO_RCVBUF():int;
        public native static function get SO_RCVTIMEO():int;
        public native static function get SO_REUSEADDR():int;
        public native static function get SO_SNDBUF():int;
        public native static function get SO_SNDTIMEO():int;
        public native static function get SO_TYPE():int;

        public native static function get SOMAXCONN():int;

        public native static function get MSG_CTRUNC():int;
        public native static function get MSG_DONTROUTE():int;
        public native static function get MSG_OOB():int;
        public native static function get MSG_PEEK():int;
        public native static function get MSG_TRUNC():int;
        public native static function get MSG_WAITALL():int;

        public native static function get AF_INET():int;
        public native static function get AF_INET6():int;
        public native static function get AF_UNSPEC():int;

        public native static function get SHUT_RD():int;
        public native static function get SHUT_RDWR():int;
        public native static function get SHUT_WR():int;

        public native static function get IPPROTO_IP():int;
        public native static function get IPPROTO_IPV6():int;
        public native static function get IPPROTO_ICMP():int;
        public native static function get IPPROTO_RAW():int;
        public native static function get IPPROTO_TCP():int;
        public native static function get IPPROTO_UDP():int;

        public native static function get INADDR_ANY():int;
        public native static function get INADDR_BROADCAST():int;
    }

    /** Raw Protocol Interface. */
    public const SOCK_RAW:int    = __socket.SOCK_RAW;

    /** Byte-stream socket. */
    public const SOCK_STREAM:int = __socket.SOCK_STREAM;

    /** Datagram socket. */
    public const SOCK_DGRAM:int  = __socket.SOCK_DGRAM;


    /** Socket is accepting connections. */
    public const SO_ACCEPTCONN:int = __socket.SO_ACCEPTCONN;

    /** Transmission of broadcast messages is supported. */
    public const SO_BROADCAST:int  = __socket.SO_BROADCAST;

    /** Bypass normal routing. */
    public const SO_DONTROUTE:int  = __socket.SO_DONTROUTE;

    /** Connections are kept alive with periodic messages. */
    public const SO_KEEPALIVE:int  = __socket.SO_KEEPALIVE;

    /** Out-of-band data is transmitted in line. */
    public const SO_OOBINLINE:int  = __socket.SO_OOBINLINE;

    /** Receive buffer size. */
    public const SO_RCVBUF:int     = __socket.SO_RCVBUF;

    /** Receive timeout. */
    public const SO_RCVTIMEO:int   = __socket.SO_RCVTIMEO;

    /** Reuse of local addresses is supported. */
    public const SO_REUSEADDR:int  = __socket.SO_REUSEADDR;

    /** Send buffer size. */
    public const SO_SNDBUF:int     = __socket.SO_SNDBUF;

    /** Send timeout. */
    public const SO_SNDTIMEO:int   = __socket.SO_SNDTIMEO;

    /** Socket type. */
    public const SO_TYPE:int       = __socket.SO_TYPE;
    

    /** The maximum backlog queue length. */
    public const SOMAXCONN:int = __socket.SOMAXCONN;


    /** Control data truncated. */
    public const MSG_CTRUNC:int    = __socket.MSG_CTRUNC;

    /** Send without using routing tables. */
    public const MSG_DONTROUTE:int = __socket.MSG_DONTROUTE;

    /** Out-of-band data. */
    public const MSG_OOB:int       = __socket.MSG_OOB;

    /** Leave received data in queue. */
    public const MSG_PEEK:int      = __socket.MSG_PEEK;

    /** Normal data truncated. */
    public const MSG_TRUNC:int     = __socket.MSG_TRUNC;

    /** Attempt to fill the read buffer. */
    public const MSG_WAITALL:int   = __socket.MSG_WAITALL;


    /** Internet domain sockets for use with IPv4 addresses. */
    public const AF_INET:int   = __socket.AF_INET;

    /** Internet domain sockets for use with IPv6 addresses. */
    public const AF_INET6:int  = __socket.AF_INET6;

    /** Unspecified. */
    public const AF_UNSPEC:int = __socket.AF_UNSPEC;


    /** Disables further receive operations. */
    public const SHUT_RD:int   = __socket.SHUT_RD;

    /** Disables further send and receive operations. */
    public const SHUT_RDWR:int = __socket.SHUT_RDWR;

    /** Disables further send operations. */
    public const SHUT_WR:int   = __socket.SHUT_WR;


    /** Internet protocol. */
    public const IPPROTO_IP:int   = __socket.IPPROTO_IP;

    /** Internet Protocol Version 6. */
    public const IPPROTO_IPV6:int = __socket.IPPROTO_IPV6;

    /** Control message protocol. */
    public const IPPROTO_ICMP:int = __socket.IPPROTO_ICMP;

    /** Raw IP Packets Protocol. */
    public const IPPROTO_RAW:int  = __socket.IPPROTO_RAW;

    /** Transmission control protocol. */
    public const IPPROTO_TCP:int  = __socket.IPPROTO_TCP;

    /** User datagram protocol. */
    public const IPPROTO_UDP:int  = __socket.IPPROTO_UDP;


    /** IPv4 local host address. */
    public const INADDR_ANY:int       = __socket.INADDR_ANY;

    /** IPv4 broadcast address. */
    public const INADDR_BROADCAST:int = __socket.INADDR_BROADCAST;
}
