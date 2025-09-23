Appends the current filename to a file, optionally removing the file from the current playlist, and optionally muting.

# Configuration

Configuration depends on your input.conf bindings. Params follow the script message, and are space separated.

```
<binding>  script-message-to writename write_name <filename> [skip] [mute]
```
| Param      | Type   | Required | Description                                                               |
| ---------- | ------ | -------- | ------------------------------------------------------------------------- |
| `filename` | String | Yes      | The filename to write/append current track to                             |
| `skip`     | Bool   | No       | Skip the current track, and remove from the current playlist.             |
| `mute`     | Bool   | No       | Mute the audio of the current track, and attempt to unmute for next file. |

Default behavior, i.e. with just a filename, is to write the filename and do nothing else.

## Example input conf:

```
# Write to file "watched", removing from current playlist
shift+n  script-message-to writename write_name "watched" true

# Write to file "muted", do not remove from current playlist, but mute audio.
shift+m  script-message-to writename write_name "muted" true true
```
