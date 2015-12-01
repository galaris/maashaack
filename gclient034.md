## Introduction ##

gclient (or google client) is a set of wrapper scripts for checking out and updating source code from multiple SCM repository locations.

The project started here [http://code.google.com/p/gclient/](http://code.google.com/p/gclient/)<br>
but is now integrated in the Chromium <a href='http://dev.chromium.org/developers/how-tos/depottools'>depot_tools</a>.<br>
<br>
On the <a href='http://www.chromium.org/developers/how-tos/depottools/gclient'>depot_tools/gclient</a> page you can find more informations.<br>
<br>
<pre><code>    gclient was originally developed for internal use by the Google Chrome team,<br>
    to coordinate pieces of code from different SCM repositories during the development process.<br>
    The sources are included inside depot_tools.  <br>
</code></pre>

<h2>informations</h2>

We use <b>gclient</b> on top of <b>svn</b> for all of our projects.<br>
<br>
See <a href='Organization#if_you_are_a_Committer.md'>Organization#if_you_are_a_Committer</a> for the greedy details.<br>
<br>
In short, we replace all the <code>svn:externals</code> by <code>DEPS</code> file and use gclient to sync and update, for the commits we simply navigate into each project directory and do a <code>svn commit</code> there.<br>
<br>
<b>Why are we doing that ?</b><br>
It is easier for us to maintain different small projects that get assembled in a big directory structure than to maintain a huge monolithic project.<br>
<br>
<b>What are the advantages of <code>DEPS</code> files ?</b><br>
<ul><li>It is really like a <code>svn:externals</code> but with the difference that it is a file instead of a svn property, so for us it is clearer to see the mapping of directories in those <code>DEPS</code> files.<br>
</li><li>it allow us from the same sources to assemble different structure of projects, see <a href='http://code.google.com/p/maashaack/source/browse/#svn/configs/maashaack'>maashaack</a> and <a href='http://code.google.com/p/maashaack/source/browse/#svn/configs/maashaackSA'>maashaackSA</a>.<br>
</li><li>it allows to have a parent/child relationship between projects.</li></ul>


<h2>installation</h2>

<ul><li>download the archive <a href='http://code.google.com/p/maashaack/downloads/detail?name=gclient-0.3.4.zip'>gclient-0.3.4</a>
</li><li>unzip in a folder<br>
</li><li>create a symlink</li></ul>

note: under Windows, we support only <a href='http://www.cygwin.com/'>cygwin</a>

<pre><code>$ cd ~<br>
$ unzip gclient-0.3.4.zip<br>
$ ln -s gclient-0.3.4/gclient.py gclient<br>
</code></pre>

<h2>usage</h2>
<pre><code><br>
Usage: gclient &lt;subcommand&gt; [options] [--] [SCM options/args...]<br>
a wrapper for managing a set of svn client modules and/or git repositories.<br>
Version 0.3.4<br>
<br>
subcommands:<br>
   cleanup<br>
   config<br>
   diff<br>
   export<br>
   pack<br>
   revert<br>
   status<br>
   sync<br>
   update<br>
   runhooks<br>
   revinfo<br>
<br>
Options and extra arguments can be passed to invoked SCM commands by<br>
appending them to the command line.  Note that if the first such<br>
appended option starts with a dash (-) then the options must be<br>
preceded by -- to distinguish them from gclient options.<br>
<br>
For additional help on a subcommand or examples of usage, try<br>
   gclient help &lt;subcommand&gt;<br>
   gclient help files<br>
<br>
<br>
Options:<br>
  --version             show program's version number and exit<br>
  -h, --help            show this help message and exit<br>
  --force               (update/sync only) force update even for modules which<br>
                        haven't changed<br>
  --nohooks             (update/sync/revert only) prevent the hooks from<br>
                        running<br>
  --revision=REV        (update/sync only) sync to a specific revision, can be<br>
                        used multiple times for each solution, e.g.<br>
                        --revision=src@123, --revision=internal@32<br>
  --deps=OS_LIST        (update/sync only) sync deps for the specified (comma-<br>
                        separated) platform(s); 'all' will sync all platforms<br>
  --spec=SPEC           (config only) create a gclient file containing the<br>
                        provided string<br>
  -v, --verbose         produce additional output for diagnostics<br>
  --manually_grab_svn_rev<br>
                        Skip svn up whenever possible by requesting actual<br>
                        HEAD revision from the repository<br>
  --head                skips any safesync_urls specified in configured<br>
                        solutions<br>
  --delete_unversioned_trees<br>
                        on update, delete any unexpected unversioned trees<br>
                        that are in the checkout<br>
</code></pre>