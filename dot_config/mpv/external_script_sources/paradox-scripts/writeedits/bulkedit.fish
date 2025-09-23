#! /usr/bin/env fish
argparse -i 'i/inplace' 's/strip=' 'm/multiple' 'n/noclean' 'h/help' -- $argv

if set -q _flag_h
  echo "Consume a jsonld edit list of files and apply ffmpeg filters to it


Usage: bulkedit.fish [options]
  -i, --inplace: Uses codec copy on the file, instead of reencoding. May result in offset timestamps
  -s, --strip: Strips supplied pattern from input filenames.
  -m, --multiple: Allows multiple edits to the same source file. Recommend setting output in editfile, else will clobber
                  If this is absent, the first rule in the edit file affecting a
                  particular file will be used, the others discarded
  -n, --noclean: Don't delete editlist when done
  -h, --help: Show this help

  Editlist format is a JSON-LD formatted file, with the following fields available:
    path <string> the path to the file to be edited
    start <float, seconds> the beginning timestamp of the clip to trim
    end <float, seconds> the end (offset from 0 or start) of the clip to trim
    filters <string[]> list of _exact_ ffmpeg filter commands to apply to the video, in order
    newFilename <string> new filename to write output towards. If null, overwrites input file

  All fields apart from path are optional
  "
  exit
end

set -l listfile "edits"
set -l vars filters start_time end_time output_name

set -l dateCmd "date"
set -l touchCmd "touch"

if string match -q "Darwin" (uname)
  set dateCmd "gdate"
  set touchCmd "gtouch"
end

if not test -e $listfile
  exit 0
end

set -l dedupeCmd "group_by(.path) | map(.[0]) | .[]"
if set -q _flag_m
  set dedupeCmd ".[]"
end

set -l filesProcessed 0

for f in (jq --slurp --compact-output --raw-output $dedupeCmd $listfile)
  echo $f | jq --raw-output '
  .path // "",
  (.filters | join(",")),
  .start // "",
  .end // "",
  .newFilename // ""
  ' | read -l -L filename $vars

  if test -n "$_flag_s"
    set filename (string replace $_flag_s "" $filename)
  end

  for i in $vars
    if test -z "$$i"
      set -e $i
    end
  end

  set -q start_time; and set -p start_time "-ss"
  set -q end_time; and set -p end_time "-to"
  set -q filters; and set -p filters "-vf"

  set -l editedname ""
  if set -q output_name
    set editedname $output_name
  else
    set editedname (dirname $filename)/edited-(basename $filename)
  end

  set ogDate ($dateCmd -r $filename --iso-8601=seconds)
  set vCodec "copy"
  if not set -q _flag_i
    set vCodec (ffprobe -v error -select_streams v:0 -show_entries stream=codec_name -of default=noprint_wrappers=1:nokey=1 $filename)
  end

  set -S filters

  ffmpeg -hide_banner -i $filename $start_time $end_time -c copy -c:v $vCodec $filters $editedname

  if not set -q output_name
    mv $editedname $filename
    $touchCmd -d $ogDate $filename
  end
  set filesProcessed (math $filesProcessed + 1)
end
if test $filesProcessed -eq 0
  echo "No files processed, check your file and command line options"
  exit 1
end
set -q _flag_n; or rm -f $listfile
