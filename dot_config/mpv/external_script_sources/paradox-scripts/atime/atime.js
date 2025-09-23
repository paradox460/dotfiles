function touchFile() {
  mp.msg.info("Touching file");
  var filename = mp.get_property("path");
  var opts = {
    name: "subprocess",
    args: ["touch", "-a", filename],
    playback_only: false,
    detach: true
  }
  mp.command_native_async(opts)
}

mp.register_event("file-loaded", touchFile)
