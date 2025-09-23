#! /usr/bin/env -S mise x deno@latest -- deno run --allow-env --allow-read --allow-write

import {
  DeviceIdentifier,
  ModifierParam,
  map as from,
  ifApp,
  ifDevice,
  rule,
  withCondition,
  writeToProfile
} from 'https://deno.land/x/karabinerts@1.31.0/deno.ts';

const footPedal: DeviceIdentifier = { product_id: 45057, vendor_id: 13651 };

writeToProfile('Default', [

  rule("Caps-lock to escape when alone, hyper when used as modifier, caps-lock when used with Option").manipulators([
    from("caps_lock", "left_option").to("caps_lock"),
    from("caps_lock").toHyper().toIfAlone("escape")
  ]),

  rule("Foot Pedals", ifDevice(footPedal)).manipulators([
    withCondition(ifApp({ bundle_identifiers: [/^io\.mpv$/], file_paths: ["^/opt/homebrew/bin/mpv$"] }))([
      from("a").to("rewind"),
      from("b").to("play_or_pause"),
      from("c").to("fastforward")
    ]),
    withCondition(ifApp( { bundle_identifiers: [/^com.microsoft.teams2$/]}))([
      from("c").to("m", ["left_command", "left_shift"])
    ]),
    from("a", "left_option").to("caps_lock"),
    from("a").toHyper().toIfAlone("escape"),
    from("b").to("m", "Hyper"),
    from("c").to("left_command")
  ])
])
