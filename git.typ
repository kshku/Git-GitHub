#import "@preview/catppuccin:1.1.0": flavors, set-code-theme

#set document(
  title: "Git and GitHub",
)

#set page(
  paper: "a4",
  background: image(
    "core_logo.opacity.png",
    width: 100%,
    height: 100%,
  ),
)

#set heading(numbering: "1.1.")

#set figure.caption(position: bottom)
#set figure(supplement: [Figure])

#let palette = flavors.mocha.colors

#show raw.where(block: true): it => block(
  fill: palette.base.rgb,
  inset: 10pt,
  radius: 4pt,
  stroke: palette.surface0.rgb,
  text(fill: palette.text.rgb, it),
)
#show raw.where(block: false): box.with(
  fill: luma(240),
  inset: (x:3pt, y: 0pt),
  outset: (y: 3pt),
  radius: 2pt,
)
#show raw.where(block: true): block_it => {
  show raw.line: line_it => {
    box(width: 2em, text(fill: gray, if block_it.lang == "sh" [\$] else [#line_it.number]))
    line_it.body
  }
  block_it
}

#show link: set text(blue)

#align(center)[#title()]

= Version Control System (VCS)
== What is VCS
Version control is a system that records changes to a file or set of files over time so that you can recall specific versions later.
- Keep every version of the file
- Revert to selected version
- Compare changes over time
- See who last modified
- Entire history

#link("https://www.instagram.com/reel/DVWESEtDKDh/")[Reel from s4.codes on Instagram]

== Types of VCS
+ Local Version Control Systems (@local)
+ Centralized Version Control Systems (@centralized)
+ Distributed Version Control Systems (@distributed)

=== Local VCS
- Operates entirely on local system
- All changes and version history are stored in local database
- No internet or server dependency
- Useful for individual projects
- Limited to single use environments

#figure(
  image("local.png"),
  caption: [Local Version Control System diagram],
) <local>

=== Centralized VCS
- Central server
- Connect to server to access or modify the files
- Single point of failure
- Similar to Local VCS

#figure(
  image("centralized.png"),
  caption: [Centralized Version Control System diagram],
) <centralized>

=== Distributed VCS
- Every clone is full backup of all the data
- Mirrors the repository
- Collaborate with different groups on same projects
- Server copy can be restored by copying any of client copy if data was lost

#figure(
  image("distributed.png"),
  caption: [Distributed Version Control System diagram],
) <distributed>

== Tools
Local VCS: RCS (Revision Control System)\
Central VCS: CVS, Subversion(SVN), Perforce\
Distributed VCS: BitKeeper, Git, Mercurial, Darcs\

= Git
== What is Git
 Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency. 
It was developed in 2005 by Linus Torvalds to maintain Linux kernel.

=== Snapshots, Not Differences
Most other systems store information as a set of files and the changes made to each file over time
which is commonly described as delta-based version control.

#figure(
  image("deltas.png"),
  caption: [Storing data as changes to base version of file],
) <deltas>

Git stores snapshot of all files at the time of commit and stores a reference to that snapshot.
To be efficient, if files have not changed, Git just link to previous identiclal file it already stored.

#figure(
  image("snapshots.png"),
  caption: [Storing data as snapshots of the project over time],
) <snapshots>

=== Nearly Every Operation Is Local
Some of VCS depend on internet connection for fetching history and other things, which makes you not be able to work without internet.
But in Git since the entire history of project is cloned to the local disk, generally no information is needed from the external computer.
Operations like checking the changes, commititng changes can be done locally.

=== Git Has Integrity
Everything in Git is checksummed before it is stored and is then referred to by that checksum.

=== Git Generally Only Adds Data
Nearly all the actions in Git only _add_ data to the Git database.
It is hard to get the system to do anything that is not undoable or to make it erase data in any way.
As with any VCS, you can lose or mess up changes you haven’t committed yet,
but after you commit a snapshot into Git, it is very difficult to lose,
especially if you regularly push your database to another repository.

=== The Three States
Git has three main states that your files can reside in: _modified_, _staged_, and _committed_:
- *Modified* means that file have been changed but not committed.
- *Staged* means marked a modified file's current version to go into next commit snapshot.
- *Committed* means that the data is safely stored in local database.

This leads us to the three main sections of a Git project: the *working tree*, the *staging area*, and the *Git directory*.

#figure(
  image("areas.png"),
  caption: [Working tree, staging area, and Git directory],
) <areas>

- *Working tree:* Single checkout of one version of the project.
- *Staging area (index):* A file (generally contained in Git directory) stores information about what will go into next commit.
- *Git directory:* Where Git stores the metadata and object database for project.

== Basic Git workflow
+ Modify files in working tree.
+ Selectively stage changes that should be part of next commit.
+ Commit, which takes the files as they are in staging area and stores that snapshot permanently in Git directory.

== Installing Git
Installation instructions are available on the #link("https://git-scm.com")[official website of Git].

=== Windows
Go to #link("https://git-scm.com/install/windows") and install Git, or use `winget`.
```sh
winget install --id Git.Git -e --source winget
```

=== Ubuntu
```sh
add-apt-repository ppa:git-core/ppa
apt update; apt install git
```

== Configuring Git
To configure Git we can use ```sh git config``` command allows to get and set configuration variables that control all aspects of how Git looks and operates.
These variables can be stored in three different places:
+ `[path]/etc/gitconfig` file: Contains values applied to every user on the system and all their repositories.
  If you pass the option `--system` to `git config`, it reads and writes from this file specifically.
  Because this is a system configuration file, you would need administrative or superuser privilege to make changes to it.
+ `~/.gitconfig` or `~/.config/git/config` file: Values specific personally to the user.
  You can make Git read and write to this file specifically by passing the `--global` option,
  and this affects all of the repositories you work with on your system.
+ `config` file in the Git directory (that is, `.git/config`) of whatever repository you’re currently using: Specific to that single repository.
  You can force Git to read from and write to this file with the `--local` option, but that is in fact the default.

Each level overrides values in the previous level, so values in `.git/config` trump those in `[path]/etc/gitconfig`.

You can view all of your settings and where they are coming from using:
```sh
git config list --show-origin
```

=== Your Identity
The first thing should be done after installing Git is to set user name and email address.
This is important because every Git commit uses this information, and it's immutably backed into the commits.
```sh
git config set --global user.name "user name"
git config set --global user.email "email"
```
If you want to override this with a different name or email address for specific projects, you can run the command without the --global option when you’re in that project.

=== Your Editor
If editor is not configured, Git uses system's default editor or falls back to `vi` or `vim`.
To change the editor:
```sh
git config set --global core.editor "<editor>"
```

If you want to use VS Code as the editor, make sure it is in the `PATH` and set `"code --wait"` as editor:
```sh
git config set --global core.editor "code --wait"
```

=== Setting CRLF
There is difference between how Widows and other OSes handle the line ending.
Git can automatically convert them if configured.\
Recommended configuration:
- On Windows: `true`
- On Linux/MacOS: `input`
```sh
# On Windows
git config set --global core.autocrlf true
# On Linux/MacOS
git config set --global core.autocrlf input
```

== Getting Help
There are three equivalent ways to get the comprehensive manual page (manpage) help for any of the Git commands:
```sh
git help <verb>
git <verb> --help
man git-<verb>
```

In addition, if full-blown manpage help is not required, and just need a quick refresher on available options,
`-h` option can be used instead.
Example:
```sh
git config -h
```
