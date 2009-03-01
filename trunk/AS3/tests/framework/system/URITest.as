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
  Portions created by the Initial Developers are Copyright (C) 2006-2009
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

package system
{
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.network.URIScheme;
    
    public class URITest extends TestCase
    {
        public function URITest( name:String = "" )
        {
            super( name );
        }
        
        public function testParse():void
        {
            var s1:String = "http://www.ics.uci.edu/pub/ietf/uri/#Related";
            var s2:String = "http://www.ics.uci.edu/pub/ietf/uri/?a=1&b=2#Related";
            var s3:String = "http://username:password@www.ics.uci.edu:8080/pub/ietf/uri/?a=1&b=2#Related";
            var s4:String = "tel:+1-816-555-1212";
            var s5:String = "mailto:John.Doe@example.com";
            var s6:String = "news:comp.infosystems.www.servers.unix";
            var s7:String = "telnet://192.0.2.16:80/";
            var s8:String = "ldap://[2001:db8::7]/c=GB?objectClass?one";
            var s9:String = "urn:oasis:names:specification:docbook:dtd:xml:4.1.2";
            var s10:String = "//server/my/path/file.txt";
            var s11:String = "file:///some/path/and/file.txt";
            var s12:String = "\\\\server\\my\\path\\file.txt";
            var s13:String = "C:\\directory\\file.txt";
            var s14:String = "file:///C:/Documents%20and%20Settings/bob/Desktop";
            var s15:String = "file:///Users/bob/Desktop";
            var s16:String = "\\\\ComputerName\\SharedFolder\\Resource";
            var s17:String = "hostname:/directorypath/resource";
            var s18:String = "smb://hostname/directorypath/resource";
            var s19:String = "///server/my/path/file.txt";
            var s20:String = "http://www.ics.uci.edu/pub/ietf/uri/?"
            //URI.parse( s1 );
            //var u1:URI = new URI( s1 );
            //var u2:URI = new URI( s2 );
            var u3:URI = new URI( s3 );
            trace( "u3: [" + u3 + "]" );
            
            var uri:URI = u3;
            
            trace( "scheme: " + uri.scheme );
            trace( "authority: " + uri.authority );
            trace( "host: " + uri.host );
            trace( "userinfo: " + uri.userinfo );
            trace( "path: " + uri.path );
            trace( "query: " + uri.query );
            trace( "fragment: " + uri.fragment );
            
            
        }
        
        public function testIsValidScheme():void
        {
            assertTrue( URI.isValidScheme( URIScheme.HTTP.scheme ) );
            assertTrue( URI.isValidScheme( URIScheme.HTTPS.scheme ) );
            assertTrue( URI.isValidScheme( URIScheme.FTP.scheme ) );
            assertTrue( URI.isValidScheme( URIScheme.FILE.scheme ) );
            assertTrue( URI.isValidScheme( URIScheme.MAILTO.scheme ) );
            assertTrue( URI.isValidScheme( URIScheme.NEWS.scheme ) );
            assertTrue( URI.isValidScheme( URIScheme.NNTP.scheme ) );
            assertTrue( URI.isValidScheme( URIScheme.GOPHER.scheme ) );
            assertTrue( URI.isValidScheme( URIScheme.AIRAPPLICATION.scheme ) );
            assertTrue( URI.isValidScheme( URIScheme.AIRSTORAGE.scheme ) );
            
            assertFalse( URI.isValidScheme( "ftp$2" ) );
            assertFalse( URI.isValidScheme( "app:2" ) );
            assertFalse( URI.isValidScheme( "2ftp" ) );
        }
        
        public function testIsValidPort():void
        {
            assertTrue( URI.isValidPort( 0 ) );
            assertTrue( URI.isValidPort( 65535 ) );
            assertTrue( URI.isValidPort( 80 ) );
            assertTrue( URI.isValidPort( 21 ) );
            
            assertFalse( URI.isValidPort( -1 ) );
        }
        
        public function testIsIPv4Address():void
        {
            assertTrue( URI.isIPv4Address( "0.0.0.0" ) );
            assertTrue( URI.isIPv4Address( "127.0.0.1" ) );
            assertTrue( URI.isIPv4Address( "255.255.255.255" ) );
            
            assertFalse( URI.isIPv4Address( "255.1024.255.255" ) );
            assertFalse( URI.isIPv4Address( "255.25.5.25.5.255" ) );
            assertFalse( URI.isIPv4Address( "a.b.c.d" ) );
        }
        
        public function testIsDomainAddress():void
        {
            assertTrue( URI.isDomainAddress( "a_1.google.com" ) );
        }
        
    }
}