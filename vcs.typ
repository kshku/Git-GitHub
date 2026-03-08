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
  image("assets/local.png"),
  caption: [Local Version Control System diagram],
) <local>

=== Centralized VCS
- Central server
- Connect to server to access or modify the files
- Single point of failure
- Similar to Local VCS

#figure(
  image("assets/centralized.png"),
  caption: [Centralized Version Control System diagram],
) <centralized>

=== Distributed VCS
- Every clone is full backup of all the data
- Mirrors the repository
- Collaborate with different groups on same projects
- Server copy can be restored by copying any of client copy if data was lost

#figure(
  image("assets/distributed.png"),
  caption: [Distributed Version Control System diagram],
) <distributed>

== Tools
Local VCS: RCS (Revision Control System)\
Central VCS: CVS, Subversion(SVN), Perforce\
Distributed VCS: BitKeeper, Git, Mercurial, Darcs\
