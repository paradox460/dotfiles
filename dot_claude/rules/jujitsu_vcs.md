# Rules for projects using jujitsu-vcs

Generally, all projects will use jujitsu-vcs. If a project directory has a `.jj` directory in its root, you should use jujitsu-vcs for all version control, _not_ git, unless jujitsu does not support a particular git feature.

Before modifying any files, either directly or through commands, you should run `jj new` to create a new change. After a change is finished, write a brief, one line description of this change using `jj describe`.

Most JJ commands are highly interactive. Use --message when passing a commit message, and --no-pager to disable the interactive pager. Additionally, set `JJ_EDITOR` to `true` to disable the interactive editor when writing commit messages.
