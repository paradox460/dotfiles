# Rules for projects using jujitsu-vcs

All projects use jujitsu-vcs. Always use jj for all version control operations — never use git commands, regardless of whether a `.jj` directory is present.

Before modifying any files, either directly or through commands, you should run `jj new` to create a new change. After a change is finished, write a brief, one line description of this change using `jj describe`.

Most JJ commands are highly interactive. Use --message when passing a commit message, and --no-pager to disable the interactive pager. Additionally, set `JJ_EDITOR` to `true` to disable the interactive editor when writing commit messages.
