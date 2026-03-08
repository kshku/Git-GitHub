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

#show raw.where(block: false): it => box(
  baseline: 4pt,
  fill: palette.base.rgb,
  inset: 4pt,
  radius: 2pt,
  text(fill: palette.text.rgb)[#it],
)

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
```cmd
winget install --id Git.Git -e --source winget
```

=== Ubuntu
```sh
add-apt-repository ppa:git-core/ppa
apt update; apt install git
```
