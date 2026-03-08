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
