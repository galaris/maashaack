@project_fullname@
===================
You can find the latest version of the @project_fullname@ on @project_url@

@project_fullname@ is an application framework for ActionScript 3.0
which have the only purpose to provide portable,
cross-platform and standard packages, libraries, etc.

Installation from sources
=========================

from subversion you can do
$svn co @project_url@/trunk maashaack-framework
or
$svn co @project_url@/tags/0.1 maashaack-framework-v0.1


Installation for Flash CS3
==========================
Before you begin to use the @project_fullname@ within Flash CS3,
you first need to add the @project_shortname@ SWC to Flash CS3.

To do so:
1. If you have Flash CS3 currently open, NO NEED to quit the application.

2. Navigate to the location where you unzipped the @project_shortname@ zip
   and find the swc (e.g. lib/maashaack.swc).

3. Copy the SWC file there:
   - (Windows) C:\Program Files\Adobe\ Adobe Flash CS3\language\Configuration\Components
   - (Mac OS X) Macintosh HD/Applications/Adobe Flash CS3/Configuration/Components

4. In the Component panel options click "reload".

Flash CS3 is now set up to support the @project_fullname@.

Installation for Flex Builder 3
===============================
Before you can compile your code, you will need to link it to the @project_shortname@ SWC file.

To do so:
1. select Project->Properties.
   A Properties dialog box will appear for your project.
   Click on Flex Build Path and then select the Library Path tab:

2. Click Add SWC... within the Library Path pane.
   An Add SWC dialog box will appear.
   Navigate to the location where you unzipped the @project_shortname@ zip
   and select lib/maashaack.swc file and click OK.

or

Just drop the maashaack.swc file into your Flex project /libs directory

Documentation
=============
Documentation of the @project_fullname@ is in the /doc directory.
You can also find more informations on the project wiki
@project_wiki@

Problem
=======
Please send any usage questions to @project_group@
Please report issues to @project_maintenance@ (precise the version @release_version@)
