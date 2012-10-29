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

include "cgilib.as";

import library.cgi.*;

trace( "==== Meta Variables ====" );
trace( "        AUTH_TYPE = " + AUTH_TYPE );
trace( "   CONTENT_LENGTH = " + CONTENT_LENGTH );
trace( "     CONTENT_TYPE = " + CONTENT_TYPE );
trace( "GATEWAY_INTERFACE = " + GATEWAY_INTERFACE );
trace( "        PATH_INFO = " + PATH_INFO );
trace( "  PATH_TRANSLATED = " + PATH_TRANSLATED );
trace( "     QUERY_STRING = " + QUERY_STRING );
trace( "      REMOTE_ADDR = " + REMOTE_ADDR );
trace( "      REMOTE_HOST = " + REMOTE_HOST );
trace( "     REMOTE_IDENT = " + REMOTE_IDENT );
trace( "      REMOTE_USER = " + REMOTE_USER );
trace( "   REQUEST_METHOD = " + REQUEST_METHOD );
trace( "      SCRIPT_NAME = " + SCRIPT_NAME );
trace( "      SERVER_NAME = " + SERVER_NAME );
trace( "      SERVER_PORT = " + SERVER_PORT );
trace( "  SERVER_PROTOCOL = " + SERVER_PROTOCOL );
trace( "  SERVER_SOFTWARE = " + SERVER_SOFTWARE );
trace( "" );
trace( "" );

trace( "==== Extended Meta Variables ====" );
trace( "         HTTP_ACCEPT = " + HTTP_ACCEPT );
trace( " HTTP_ACCEPT_CHARSET = " + HTTP_ACCEPT_CHARSET );
trace( "HTTP_ACCEPT_ENCODING = " + HTTP_ACCEPT_ENCODING );
trace( "HTTP_ACCEPT_LANGUAGE = " + HTTP_ACCEPT_LANGUAGE );
trace( "     HTTP_CONNECTION = " + HTTP_CONNECTION );
trace( "         HTTP_COOKIE = " + HTTP_COOKIE );
trace( "           HTTP_HOST = " + HTTP_HOST );
trace( "     HTTP_USER_AGENT = " + HTTP_USER_AGENT );
trace( "" );
trace( "             COMSPEC = " + COMSPEC );
trace( "       DOCUMENT_ROOT = " + DOCUMENT_ROOT );
trace( "                HOME = " + HOME );
trace( "                PATH = " + PATH );
trace( "             PATHEXT = " + PATHEXT );
trace( "                TERM = " + TERM );
trace( "              WINDIR = " + WINDIR );
trace( "          SYSTEMROOT = " + SYSTEMROOT );
trace( "" );
trace( "         REMOTE_PORT = " + REMOTE_PORT );
trace( "         REQUEST_URI = " + REQUEST_URI );
trace( "     SCRIPT_FILENAME = " + SCRIPT_FILENAME );
trace( "         SERVER_ADDR = " + SERVER_ADDR );
trace( "        SERVER_ADMIN = " + SERVER_ADMIN );
trace( "    SERVER_SIGNATURE = " + SERVER_SIGNATURE );


