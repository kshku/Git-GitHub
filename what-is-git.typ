== What is Git
 Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.
It was developed in 2005 by Linus Torvalds to maintain Linux kernel.

=== Snapshots, Not Differences
Most other systems store information as a set of files and the changes made to each file over time
which is commonly described as delta-based version control.

#figure(
  image("assets/deltas.png"),
  caption: [Storing data as changes to base version of file],
) <deltas>

Git stores snapshot of all files at the time of commit and stores a reference to that snapshot.
To be efficient, if files have not changed, Git just link to previous identiclal file it already stored.

#figure(
  image("assets/snapshots.png"),
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
  image("assets/areas.png"),
  caption: [Working tree, staging area, and Git directory],
) <areas>

- *Working tree:* Single checkout of one version of the project.
- *Staging area (index):* A file (generally contained in Git directory) stores information about what will go into next commit.
- *Git directory:* Where Git stores the metadata and object database for project.
