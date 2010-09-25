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

package avmplus
{
    import flash.utils.ByteArray;
    import C.unistd.*;

    /**
     * The FileSystem API
     * provides methods to access and manipulate computer files, directories and data.
     * 
     * vocabulary:
     * - filename : uniquely identify a file or directory stored on the file system
     */
    [native(cls="::avmshell::FileSystemClass", methods="auto")]
    public class FileSystem
    {
        /**
         * Tests whether a "filename" exists.
         */
        public native static function exists( filename:String ):Boolean;

        /**
         * Reads the file "filename" into memory and returns it as a String.
         */
        public native static function read( filename:String ):String;

        /**
         * Writes the text "data" to the file "filename".
         */
        public native static function write( filename:String, data:String ):void;

        /**
         * Returns the "filename" mode.
         * 
         * note:
         * will not work exactly the same between POSIX and WIN32
         * with POSIX you will want to get the file mode and then apply an additional mode,
         * it's more granular as you can choose from USR, GRP and OTH
         * for ex:
         * var mode:int = FileSystem.getFileMode( "myfile.txt" ); // -r--r--r--
         * chmod( "myfile.txt", (mode | S_IWUSR ) );              // -rw-r--r--
         * 
         * with WIN32, you have only read or write access, and write imply read
         * (you can not have a file write-only) and so by default we map
         * the USR access to GRP and OTH
         * var mode:int = FileSystem.getFileMode( "myfile.txt" ); // -r--r--r--
         * chmod( "myfile.txt", (mode | S_IWUSR ) );              // -rw-rw-rw-
         */
        public native static function getFileMode( filename:String ):int;
        
        /**
         * Verify if we can access the "filename".
         */
        public static function canAccess( filename:String ):Boolean
        {
            return access( filename, F_OK ) == 0;
        }
        
        /**
         * Verify if we can write to the "filename".
         */
        public static function canWrite( filename:String ):Boolean
        {
            return access( filename, W_OK ) == 0;
        }
        
        /**
         * Verify if we can read the "filename".
         */
        public static function canRead( filename:String ):Boolean
        {
            return access( filename, R_OK ) == 0;
        }
        
        /**
         * Test if the "filename" is a regular file.
         */
        public native static function isRegularFile( filename:String ):Boolean;

        /**
         * Test if the "filename" is a directory.
         */
        public native static function isDirectory( filename:String ):Boolean;
        
        //public native static function isSymbolicLink( path:String ):Boolean;

        /**
         * Returns an array of files or directories from "filename".
         */
        public native static function listFiles( filename:String, directory:Boolean = false ):Array;

        /**
         * Returns the available disk space in bytes on the volume containing "filename",
         * or -1 on failure.
         */
        public native static function getFreeDiskSpace( filename:String ):Number;

        /**
         * Returns the total disk space in bytes on the volume containing "filename",
         * or -1 on failure.
         */
        public native static function getTotalDiskSpace( filename:String ):Number;

        /**
         * Returns the used disk space in bytes on the volume containing "filename",
         * or -1 on failure.
         */
        public static function getUsedDiskSpace( filename:String ):Number
        {
            var free:Number  = getFreeDiskSpace( filename );
            var total:Number = getTotalDiskSpace( filename );

            if( (free != -1) && (total != -1) )
            {
                return total-free;
            }

            return -1;
        }
        

        /**
         * Reads the file "filename" into memory and returns it as a ByteArray.
         */
        public static function fileToByteArray( filename:String ):ByteArray
        {
            return ByteArray.readFile( filename );
        }

        /**
         * Writes the binary "bytes" to the file "filename".
         */
        public static function writeByteArray( filename:String, bytes:ByteArray ):void
        {
            bytes.writeFile( filename );
        }
    }

}
