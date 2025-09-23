Writes a list of "edits" made to the current video file to a file in your current working directory. Edits can be used later as params for ffmpeg, for bulk video cropping, resizing, etc.

# Usage
As you're watching your video, you may crop, flip, delogo, and set loop start and end times. Once you have the video how you want it, press your selected keybinding, and the changes will be written to the file you configured, in a JSON-LD formatted file.

Getting the edits into ffmpeg is trivial, an example [fish shell](https://fishshell.com/) script for doing so is included, at `bulkedit.fish`. It has some convenience utilities around MacOS issues as well; I recommend you have `gdate` and `gtouch` installed, as the BSD versions Apple includes lack many features. You can install them with `brew install coreutils`.


## JSON-LD format
An edit file is a fairly simple JSON document, the keys are standardized across each line, and so should be relatively self documenting. Fields are always present, if they are unused they are encoded to `null`.

An example such line is below, formatted for readability:
```json
{
  "end": 12.084,
  "filters": [
    "crop=x=468:y=300:w=297:h=175",
    "hflip"
  ],
  "newFilename": null,
  "path": "video.mp4",
  "start": 1.204
}
```

## Supported filters/edits
The following filters and "edits" are extracted:
+ **crop**: Any video crops, and any number of video crops. Supports both regular `crop` and `lavif-crop`
+ **delogo**: Same as crop, any number of delogos are supported.
+ **loop start**, **loop end**: Sets edit start and end times. Useful for cropping out intros, outros, etc.
+ **flip**: Both `hflip` and `vflip` are supported.
+ **rotation**: Supports video rotations, BUT only in 90º increments. Outputs as `transpose` _or_ `hflip,vflip` filters.

Note that filters are stored in the editlist in the order MPV keeps them internally. Generally this is the order in which you apply them, but not always.

## Example input.conf
```
shift+Alt+c script-message-to writeedits write_edits
```
No default keybindings are provided. Replace `"edits"` with the name of the file you want to write to.

You may specify the filename to write edits to in two ways (the default filename is `edits`):

1. Add the following to your `mpv.conf` or profile configuration:
   ```
    writeedits-filename = "yourfilename"
   ```
2. Add the filename to your input conf binding:
   ```
   shift+Alt+c script-message-to writeedits write_edits "edits"
   ```


# Recommended other scripts and input configurations
I recommend adding the following to your input.conf, for ease in applying filters/edits for use with this script:
```
# Rotate video
Meta+r cycle-values video-rotate "90" "180" "270" "0"
Meta+Alt+r cycle-values video-rotate "270" "180" "90" "0"
Meta+Shift+r set video-rotate "0"
# Flip video
h vf toggle hflip
v vf toggle vflip
# Remove previous filter
d vf del -1
# Clear filters and rotations
D vf clr ""; set video-rotate "0"

# show current filterchain
shift+i print-text "${vf}"
```

Additionally, the following scripts are useful in conjunction with this one:
+ **[autocrop](https://github.com/mpv-player/mpv/blob/master/TOOLS/lua/autocrop.lua)** Automatically crop black boxes off the sides of your video.
+ **[crop](https://github.com/occivink/mpv-scripts#croplua)** Lets you visually crop the video, recursively. Also supports delogo.
+ **[skipscene](https://github.com/paradox460/mpv-scripts/tree/master/skipsegment)** Skips to the beginning of the next scene.
+ **[live-filters](https://github.com/hdb/mpv-live-filters)** Allows real time editing of applied filters. Note the list of supported filters above.
