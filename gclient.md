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

if you add a previous gclient installed<br>
<pre><code>$ cd ~<br>
$ mv gclient gclient.old<br>
</code></pre>

<ul><li>download the archive <a href='http://code.google.com/p/maashaack/downloads/detail?name=gclient-0.6.4.zip'>gclient-0.6.4</a>
</li><li>unzip in a folder<br>
</li><li>create a symlink</li></ul>

note: under Windows, we support only <a href='http://www.cygwin.com/'>cygwin</a>

<pre><code>$ cd ~<br>
$ unzip gclient-0.6.4.zip<br>
$ ln -s gclient-0.6.4/gclient.py gclient<br>
</code></pre>

<h2>usage</h2>
<pre><code>Usage: gclient &lt;command&gt; [options] <br>
<br>
Commands are:<br>
  cleanup    Cleans up all working copies.<br>
  config     Create a .gclient file in the current directory.<br>
  diff       Displays local diff for every dependencies.<br>
  fetch      Fetches upstream commits for all modules.<br>
  grep       Greps through git repos managed by gclient.<br>
  help       Prints list of commands or help for a specific command.<br>
  hookinfo   Output the hooks that would be run by `gclient runhooks`<br>
  pack       Generate a patch which can be applied at the root of the tree.<br>
  recurse    Operates on all the entries.<br>
  revert     Revert all modifications in every dependencies.<br>
  revinfo    Output revision info mapping for the client and its dependencies.<br>
  runhooks   Runs hooks for files that have been modified in the local working copy.<br>
  status     Show modification status for every dependencies.<br>
  sync       Checkout/update all modules.<br>
  update     Alias for the sync command. Deprecated.<br>
<br>
Prints list of commands or help for a specific command.<br>
<br>
Options:<br>
  --version             show program's version number and exit<br>
  -h, --help            show this help message and exit<br>
  -j JOBS, --jobs=JOBS  Specify how many SCM commands can run in parallel;<br>
                        defaults to number of cpu cores (8)<br>
  -v, --verbose         Produces additional output for diagnostics. Can be<br>
                        used up to three times for more logging info.<br>
  --gclientfile=CONFIG_FILENAME<br>
                        Specify an alternate .gclient file<br>
  --spec=SPEC           create a gclient file containing the provided string.<br>
                        Due to Cygwin/Python brokenness, it probably can't<br>
                        contain any newlines.<br>
</code></pre>