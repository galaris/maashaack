
/* note:
   this is a special version of ASTUce CLI
   to compile within maashaack repository
*/

//libraries
include "../../src/maashaack.as";
include "../../lib/ASTUce/ASTUce.as";

include "src/utils/SWFTags.as";
include "src/utils/SWFRect.as";
include "src/utils/SWF.as";
include "src/AppMetadata.as";
include "src/buRRRn/ASTUce/Application.as";
include "src/buRRRn/ASTUce/Options.as";

//imports
import avmplus.System;
import buRRRn.ASTUce.Application;

//main entry point
var app:Application = new Application();
app.run( System.argv );
