var files = [];

function addToCollection() {
  var path = mp.get_property("path");
  mp.osd_message("Adding to collection");
  mp.msg.info("Added \"" + path + "\" to collection");
  files.push(path);
}

function callExitCommand() {
  if (files.length === 0) return
  files = files.filter(function(value, index, self) {
    return self.indexOf(value) === index;
  })
  var args = ["open", "-a", "Yoink"].concat(files);
  var opts = {
    name: "subprocess",
    args: args,
    playback_only: false,
    detach: true,
  }

  mp.command_native_async(opts)
}

mp.register_event("shutdown", callExitCommand)
mp.add_key_binding(null, "collect", addToCollection);
