// Crop can also be used for delogo, hence filterName
function extractCrop(crop, filterList, filterName) {
  filterList = (typeof filterList !== "undefined") ? filterList : []
  filterName = (typeof filterName !== "undefined") ? filterName : "crop"
  // Some filter scripts do positional crop attributes
  var w = crop.params["@0"] || crop.params.w
  var x = crop.params["@2"] || crop.params.x
  var h = crop.params["@1"] || crop.params.h
  var y = crop.params["@3"] || crop.params.y
  filterList.push(filterName + "=x=" + x + ":y=" + y + ":w=" + w + ":h=" + h)
  return filterList;
}

function extractDelogo(delogo, filterList) {
  return extractCrop(delogo, filterList, "delogo");
}

// Transpose is used instead of rotate, because rotate can lose video information
function processRotation(filterList) {
  filterList = (typeof filterList !== "undefined") ? filterList : []
  var rotateDegrees = mp.get_property_native("video-rotate");

  switch (rotateDegrees) {
    case 90:
      filterList.push("transpose=clock");
      break;
    case 180:
      filterList.push("hflip,vflip");
      break;
    case 270:
      filterList.push("transpose=cclock");
      break;
  }
  return filterList;
}

function processLoopTimes() {
  var loopStart = mp.get_property_native("ab-loop-a");
  if (!loopStart || loopStart === "no") { loopStart = null }
  var loopEnd = mp.get_property_native("ab-loop-b");
  if (!loopEnd || loopEnd === "no") { loopEnd = null}

  return {loopStart: loopStart, loopEnd: loopEnd};
}

function buildFilterList() {
  var filters = mp.get_property_native("vf");

  var filterList = [];

  filters.forEach(function(filter) {
    switch (filter.name) {
      case "crop":
      case "lavfi-crop":
        extractCrop(filter, filterList);
        break;
      case "delogo":
        extractDelogo(filter, filterList);
        break;
      case "hflip":
      case "vflip":
        filterList.push(filter.name)
        break;
    }
  });

  processRotation(filterList);

  return filterList;
}

// Specialized empty check, as we only care about the values
function objectIsEmpty(obj) {
  for (var key in obj) {
    if (obj.hasOwnProperty(key) && obj[key]) {
      return false;
    }
  }
  return true;
}

function cleanup() {
  mp.unregister_event(cleanup);
  mp.set_property("ab-loop-a", "no");
  mp.set_property("ab-loop-b", "no");
  mp.set_property("vf", "");
  mp.set_property("video-rotate", 0);
}

function options() {
  var options = {
    filename: "edits"
  }
  mp.options.read_options(options);
  return options;
}

function writeEdits(filename) {
  if (!filename) {
    filename = options().filename;
  }
  var path = mp.get_property("path");
  var filterList = buildFilterList();
  var loopTimes = processLoopTimes();

  if (filterList.length === 0 && objectIsEmpty(loopTimes)) {
    var message = "No filters, rotations, or loop times set, not writing";
    mp.osd_message(message);
    mp.msg.info(message);
    return;
  }

  var out = {
    path: path,
    filters: filterList,
    start: loopTimes["loopStart"],
    end: loopTimes["loopEnd"],
    newFilename: null
  };

  var line = JSON.stringify(out);

  try {
    var currentFileValue = mp.utils.read_file(filename);
    line = currentFileValue + "\n" + line;
  } catch (e) {
    if (!e.message.match(/cannot open file/)) { throw e }
  }
  mp.utils.write_file("file://" + filename, line);
  mp.osd_message("Wrote edit data to \"" + filename + "\"");
  mp.msg.info("Wrote \"" + path + "\" to \"" + filename + "\"");

  mp.register_event("end-file", cleanup)
}

mp.add_key_binding(null, "write_edits", writeEdits)
