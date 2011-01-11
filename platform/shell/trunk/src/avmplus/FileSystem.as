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
    import C.stdio.*;
    import C.errno.*;
    import C.string.*;

    /**
     * The FileSystem class
     * Provides methods to access and manipulate computer files, directories, paths and data.
     * 
     * vocabulary:
     * - filename : uniquely identify a file or directory stored on the file system
     * 
     * @langversion 3.0
     * @playerversion Flash 9
     * @productversion redtamarin 0.3
     * @since 0.3.0
     * 
     * @see http://code.google.com/p/redtamarin/wiki/FileSystem
     */
    [native(cls="::avmshell::FileSystemClass", methods="auto")]
    public class FileSystem
    {
        private static var _commonDoubleExtensions:Array = [ "gz", "z", "bz2" ];

        // Find the position of the '.' that separates the extension from the rest
        // of the file name. The position is relative to BaseName(), not value().
        // This allows a second extension component of up to 4 characters when the
        // rightmost extension component is a common double extension (gz, bz2, Z).
        // For example, foo.tar.gz or foo.tar.Z would have extension components of
        // '.tar.gz' and '.tar.Z' respectively.
        private static function _getSeparatorPosition( basename:String ):int
        {
            var pos:int = basename.lastIndexOf( extensionSeparator );

            if( pos > -1 )
            {
                var ext:String = basename.substr( pos+1 );
                
                // Special case .<extension1>.<extension2>, but only if the final extension
                // is one of a few common double extensions.
                var hasCommonDoubleExtension:Boolean = false;
                var i:uint;
                for( i=0; i<_commonDoubleExtensions.length; i++ )
                {
                    if( ext.toLowerCase() == _commonDoubleExtensions[i] )
                    {
                        hasCommonDoubleExtension = true;
                    }
                }

                if( !hasCommonDoubleExtension ) { return pos; }

                // Check that <extension1> is 1-4 characters, otherwise fall back to
                // <extension2>.
                var pos2:int = basename.lastIndexOf( extensionSeparator, pos-1 );
                var ext2:String = basename.substring( pos2+1, pos );
                
                if( (ext2.length >= 1) && (ext2.length < 5) )
                {
                    return pos2;
                }
                else
                {
                    return pos;
                }
            }
            
            return pos;
        }

        // apply a regexp and return a filter array function
        private static function _filterWithRegexp( filter:RegExp ):Function
        {
            return function( element:*, index:int, arr:Array ):Boolean { return filter.test( element ); }
        }

        //was: throw new Error( strerror(errno), errno );
        private static function _throwCError( e:int ):void
        {
            /* note:
               don''t know why but importing flash.errors.IOError
               and creating/throwing a new IOError() register as an Error

               so here we cheat a bit, create a normal Error object
               but with the ID being the errno and the message being the strerror()
               and the name "CError"
            */
            var cerr:Error = new Error( strerror(e), e );
                cerr.name  = "CError";
            
            throw cerr;
        }

        
        /**
         * A special path component meaning "this directory".
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static const currentDirectory:String = ".";

        /**
         * A special path component meaning "the parent directory".
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static const parentDirectory:String = "..";

        /**
         * The character used to identify a file extension.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static const extensionSeparator:String = ".";

        
        public static function get drives():Array
        {
            //for Windows
            if( OperatingSystem.name == "Win32" )
            {
                //call native getLogicalDrives();
                return [];
            }
            
            //for POSIX
            //always an empty array as POSIX have no concept of drives letter
            return [];
        }

        /**
         * The line-ending character sequence used by the host operating system.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function get lineEnding():String
        {
            //for Windows
            if( OperatingSystem.name == "Win32" )
            {
                return "\r\n";
            }
            
            //for POSIX
            return "\n";
        }
        
        /**
         * The character separators used by the operating system.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function get separators():Array
        {
            //for Windows
            if( OperatingSystem.name == "Win32" )
            {
                return ["\\","/"];
            }
            
            //for POSIX
            return ["/"];
        }
        
        /**
         * Tests whether a <code>filename</code> exists.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public native static function exists( filename:String ):Boolean;

        /**
         * Reads the file <code>filename</code> into memory and returns it as a String.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public native static function read( filename:String ):String;
        
        /**
         * Writes the text <code>data</code> to the file <code>filename</code>.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public native static function write( filename:String, data:String ):void;

        /**
         * Reads the binary file <code>filename</code> into memory and returns it as a ByteArray.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public native static function readByteArray( filename:String ):ByteArray;

        /**
         * Writes the binary <code>bytes</code> to the file <code>filename</code> and returns true on success.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public native static function writeByteArray( filename:String, bytes:ByteArray ):Boolean;

        /**
         * Returns the <code>filename</code> mode.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public native static function getFileMode( filename:String ):int;

        /**
         * Returns the file <code>filename</code> size in bytes.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public native static function getFileSize( filename:String ):Number;

        /**
         * Returns the directory <code>filename</code> size in byte (adding all its files size)
         * and if <code>recursive</code> add the size of any child directory.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function getDirectorySize( filename:String, recursive:Boolean = true, includeHidden:Boolean = true ):Number
        {
            if( !isDirectory( filename ) )
            {
                if( !exists( filename ) || !canAccess( filename ) )
                {
                    _throwCError(errno);
                }
                
                throw new Error( "filename \"" + filename + "\" is not a directory, you should use getFileSize()." );
            }

            var size:Number = 0;

            if( isEmptyDirectory( filename ) )
            {
                return size;
            }
            else
            {
                var files:Array = listFiles( filename );
                
                var file:String;
                var i:uint;
                for( i=0; i<files.length; i++ )
                {
                    file = filename + separators[0] + files[i];
                    
                    if( includeHidden || !isHidden( files[i] ) )
                    {
                        size += getFileSize( file );
                    }
                }
            }

            if( recursive )
            {
                var directories:Array = listFilesWithFilter( filename, isNotDotOrDotdot, true );

                var directory:String;
                var j:uint;
                for( j=0; j<directories.length; j++ )
                {
                    directory = filename + separators[0] + directories[j];

                    if( includeHidden || !isHidden( directories[j] ) )
                    {
                        size += getDirectorySize( directory, recursive, includeHidden );
                    }
                }
            }
            
            return size;
        }
        
        /**
         * Returns the <code>filename</code> last modified time.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public native static function getLastModifiedTime( filename:String ):Date;
        
        /**
         * Returns a filepath corresponding to the last path component of this
         * <code>filename</code>, either a file or a directory.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function getBasenameFromPath( filename:String ):String
        {
            var path:String = stripTrailingSeparators( filename );

            if( hasDriveLetter( path ) )
            {
                path = path.substr( 2 ); // letter+:
            }

            var last:int = path.lastIndexOf( separators[0] );
            
            // Keep everything after the final separator, but if the pathname is only
            // one character and it's a separator, leave it alone.
            if( (path.length > 1) && (last >= 0) )
            {
                if( !isSeparator(path.charAt(1)) )
                {
                    path = path.substr( last+1 );
                }
            }

            return path;
        }
        
        /**
         * Returns the directory component of a <code>filename</code>
         * without the trailing path separator, or an empty string on error.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function getDirectoryFromPath( filename:String ):String
        {
            var endSeparator:String = "";
            var haveEndSeparator:Boolean = isSeparator( filename.charAt( filename.length-1 ) );

            if( haveEndSeparator )
            {
                endSeparator = filename.charAt( filename.length-1 );
            }
            
            var path:String = stripTrailingSeparators( filename );
            path += endSeparator;

            var start:String;
            var dir:String;
            
            if( hasDriveLetter( path ) )
            {
                start = path.substring( 0, 2 );
                dir   = path.substr( 2 );
            }
            else
            {
                start = path.substring( 0, 1 );
                dir   = path.substr( 1 );
            }

            if( (dir != "") && (dir.length > 1) )
            {
                var last:int = dir.lastIndexOf( separators[0] );
                
                if( (last > 0) && !isSeparator(dir.charAt(0)) )
                {
                    dir = dir.substring( 0, last );
                }
            }
            
            return start+dir;
        }
        
        /**
         * Returns the extension of <code>filename</code> or an empty string if
         * the file has no extension.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function getExtension( filename:String ):String
        {
            // Special case "." and ".."
            if( (filename == currentDirectory) || (filename == parentDirectory) )
            {
                return "";
            }
            
            var basename:String = getBasenameFromPath( filename );
            var pos:int         = _getSeparatorPosition( basename );
            
            if( pos > -1 ) { return basename.substr( pos ); }

            // No extension, or the extension is the whole filename.
            return "";
        }
        
        /**
         * Verify if we can access the <code>filename</code>.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function canAccess( filename:String ):Boolean
        {
            return access( filename, F_OK ) == 0;
        }
        
        /**
         * Verify if we can write to the <code>filename</code>.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function canWrite( filename:String ):Boolean
        {
            return access( filename, W_OK ) == 0;
        }
        
        /**
         * Verify if we can read the <code>filename</code>.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function canRead( filename:String ):Boolean
        {
            return access( filename, R_OK ) == 0;
        }

        /**
         * Tests if the <code>filename</code> contains a drive letter.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function hasDriveLetter( filename:String ):Boolean
        {
            var c:Array = filename.split( "" );
            if( (filename.length >= 2) && (c[1] == ":") &&
                (("A" <= c[0]) && (c[0] <= "Z")) || (("a" <= c[0]) && (c[0] <= "z")) )
            {
                return true;
            }
            
            return false;
        }
        
        /**
         * Test if the <code>filename</code> is a regular file.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public native static function isRegularFile( filename:String ):Boolean;

        /**
         * Tests if the <code>filename</code> is considered <code>hidden</code> by the system.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function isHidden( filename:String ):Boolean
        {
            //for Windows
            if( OperatingSystem.name == "Win32" )
            {
                //need to read hidden flag with GetAtrributes
                return false;
            }
            
            //for POSIX
            if( filename.charAt(0) == "." )
            {
                return true;
            }

            //for OS X need to check a flag ??

            return false;
        }

        /**
         * Tests if the <code>filename</code> is a directory.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public native static function isDirectory( filename:String ):Boolean;

        /**
         * Tests if the <code>filename</code> is an empty directory.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function isEmptyDirectory( filename:String ):Boolean
        {
            if( isDirectory( filename ) )
            {
                var directories:Array = listFilesWithFilter( filename, isNotDotOrDotdot, true );
                if( directories.length > 0 )
                {
                    return false;
                }

                var files:Array = listFilesWithFilter( filename, isNotDotOrDotdot, false );
                if( files.length > 0 )
                {
                    return false;
                }

                return true;
            }

            return false;
        }
        
        /**
         * Test if the <code>filename</code> is a symbolic link.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        //public native static function isSymbolicLink( path:String ):Boolean;

        /**
         * Tests if the character <code>c</code> is a separator.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function isSeparator( c:String ):Boolean
        {
            var i:uint;
            for( i=0; i<separators.length; i++ )
            {
                if( c == separators[i] )
                {
                    return true;
                }
            }

            return false;
        }
        
        /**
         * Utility function to filter out current directory "." and parent directory ".." from a file list.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function isNotDotOrDotdot( element:*, index:int, arr:Array ):Boolean
        {
            if( (element == currentDirectory) || (element == parentDirectory) )
            {
                return false;
            }

            return true;
        }
        
        //public static function absolutePath( filename:String ):String

        /**
         * Returns an array of files or directories from <code>filename</code>.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public native static function listFiles( filename:String, directory:Boolean = false ):Array;

        /**
         * Returns an array of files or directories from <code>filename</code>
         * filtered by a function.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function listFilesWithFilter( filename:String, filter:Function, directory:Boolean = false ):Array
        {
            var list:Array = listFiles(filename, directory);
            return list.filter( filter );
        }

        /**
         * Returns an array of files or directories from <code>filename</code>
         * filtered by a regular expression.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function listFilesWithRegexp( filename:String, filter:RegExp, directory:Boolean = false ):Array
        {
            var list:Array = listFiles(filename, directory);
            return list.filter( _filterWithRegexp( filter ) );
        }

        //public static function normalizePath( filename:String ):String
        
        /**
         * Removes an entry (file or directory) from the file system.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function remove( filename:String, recursive:Boolean = false ):void
        {
            if( !exists( filename ) || !canAccess( filename ) ) { _throwCError(errno); }

            if( isDirectory( filename ) )
            {
                removeDirectory( filename, recursive );
            }
            else
            {
                removeFile( filename );
            }
        }
        
        /**
         * Removes a file entry from the file system.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function removeFile( filename:String ):void
        {
            if( isDirectory( filename ) )
            {
                if( !exists( filename ) || !canAccess( filename ) ) { _throwCError(errno); }
                
                throw new Error( "filename \"" + filename + "\" is not a file, you should use removeDirectory()." );
            }
            
            /* note:
               be careful here
               need to use the full path C.stdio.remove() or we fall in an infinite loop with the static remove()
               we can also use unlink()
               if we face other problems
            */
            if( C.stdio.remove( filename ) != 0 ) { _throwCError(errno); }
        }

        /**
         * Removes a directory entry from the file system,
         * if <code>recursive=true</code> delete all child entries (files and directories) first.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function removeDirectory( filename:String, recursive:Boolean = false ):void
        {
            if( !isDirectory( filename ) )
            {
                if( !exists( filename ) || !canAccess( filename ) )
                {
                    _throwCError(errno);
                }
                
                throw new Error( "filename \"" + filename + "\" is not a directory, you should use removeFile()." );
            }

            //dis is empty
            if( isEmptyDirectory( filename ) )
            {
                if( rmdir( filename ) != 0 ) { _throwCError(errno); }
            }
            //dir is not empty, but remove is recursive
            else if( recursive )
            {
                var files:Array = listFiles( filename );
                
                var file:String;
                var i:uint;
                for( i=0; i<files.length; i++ )
                {
                    file = filename + separators[0] + files[i];
                    removeFile( file );
                }

                var directories:Array = listFilesWithFilter( filename, isNotDotOrDotdot, true );

                var directory:String;
                var j:uint;
                for( j=0; j<directories.length; j++ )
                {
                    directory = filename + separators[0] + directories[j];
                    removeDirectory( directory, recursive );
                }

                if( rmdir( filename ) != 0 ) { _throwCError(errno); }
            }
            //dir is not empty and remove is not recursive
            else
            {
                if( rmdir( filename ) != 0 ) { _throwCError(errno); }
            }
        }
        
        /**
         * Remove trailing separators from the <code>filename</code>.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public static function stripTrailingSeparators( filename:String ):String
        {
            var start:String;
            var path:String;

            if( hasDriveLetter( filename ) )
            {
                start = filename.substring( 0, 2 );
                path  = filename.substr( 2 );
            }
            else
            {
                start = filename.substring( 0, 1 );
                path  = filename.substr( 1 );
            }
            
            // If the string only has two separators and they're at the beginning,
            // don't strip them, unless the string began with more than two separators.
            while( isSeparator( path.charAt( path.length-1 ) ) )
            {
                if( (path.length == 1) && isSeparator( path.charAt(0) ) )
                {
                    break;
                }
                
                path = path.substring( 0, path.length-1 );
            }
            
            return start+path;
        }


        /**
         * Returns the available disk space in bytes on the volume containing <code>filename</code>,
         * or <code>-1</code> on failure.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public native static function getFreeDiskSpace( filename:String ):Number;

        /**
         * Returns the total disk space in bytes on the volume containing <code>filename</code>,
         * or <code>-1</code> on failure.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
         */
        public native static function getTotalDiskSpace( filename:String ):Number;

        /**
         * Returns the used disk space in bytes on the volume containing <code>filename</code>,
         * or <code>-1</code> on failure.
         * 
         * @productversion redtamarin 0.3
         * @since 0.3.0
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
        
    }

}
