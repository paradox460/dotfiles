var options = {
  detectionTime: 0.05,
  pictureBlackRatio: 0.98,
  muteWhileSkipping: true,
}

var detecting = false;
var seekPosition;
var pauseAfter;

var filterLabels = [
  "videoDetection",
];

// Polyfills
Array.prototype.includes = function(searchElement, fromIndex) {
  return this.indexOf(searchElement, fromIndex) >= 0;
};

function toggleDetection(pauseAfterDetection) {
  if (detecting) {
    stop();
    return;
  }

  pauseAfter = !!pauseAfterDetection;

  if (mp.get_property_bool("pause")) {
    mp.set_property_bool("pause", false);
  }

  detecting = true;
  mp.osd_message("Seeking forwards to end of segment");
  mp.set_property("speed", 100);
  videoDetect();
}

function removeVideoFilters() {
  var filters = mp.get_property_native("vf").filter(function(filter) {
    return !filterLabels.includes(filter.label);
  });
  mp.set_property_native("vf", filters);
}

function removeObservers() {
  mp.unobserve_property(seekToVideoDetection)
}

function videoDetect() {
  mp.command("vf add @videoDetection:lavfi=[blackdetect=d=" + options.detectionTime + ":pic_th=" + options.pictureBlackRatio + "]");
  if (options.blackWhileSkipping) {
    blackoutVideo();
  }
  mp.observe_property("vf-metadata/videoDetection", "native", seekToVideoDetection);
}

function seekToVideoDetection(_name, value) {
  try {
    if (value["lavfi.black_end"]) {
      seekPosition = value["lavfi.black_end"];
      stop();
    }
  } catch (e) {}
}

function stop() {
  var localPauseAfter = pauseAfter;
  cleanup();
  if (seekPosition) {
    if (localPauseAfter) {
      mp.set_property_bool("pause", true);
    }
    mp.commandv("seek", seekPosition, "absolute", "exact");
    seekPosition = undefined;
    displaySkippedOSD();
  }
}

function cleanup() {
  removeVideoFilters();
  removeObservers();
  detecting = false;
  mp.set_property("speed", 1);
  pauseAfter = false;
}

function displaySkippedOSD() {
  setTimeout(function() {
    mp.osd_message("Skipped to " + mp.get_property_osd("time-pos"));
  }, 50);
}

mp.add_key_binding(null, "skip_segment", toggleDetection);
mp.register_event("end-file", cleanup);
mp.register_event("seek", cleanup);
