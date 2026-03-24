function setup(config)
  config.action("tug", function()
    local cid = context.change_id()
    jj_async("bookmark", "advance")
    revisions.refresh()
  end, { desc = "advance closest bookmark forwards", key = "t", scope = "revisions" }
  )
  config.action("ksdiff", function()
    jj("diff", "--tool", "ksdiff", "-r", context.change_id())
  end, { desc = "open revision in ksdiff", key = "ctrl+k", scope = "revisions" }
  )

  -- Clipboard actions
  config.action("copy short change id", function()
    copy_to_clipboard(jj("log", "--no-graph", "-r", context.change_id(), "-T", "change_id.short(8)", "--color", "never"))
  end, { desc = "copy short change id to clipboard", seq = { "ctrl+c", "c" }, scope = "revisions" }
  )
  config.action("copy long change id", function()
    copy_to_clipboard(jj("log", "--no-graph", "-r", context.change_id(), "-T", "change_id", "--color", "never"))
  end, { desc = "copy long change id to clipboard", seq = { "ctrl+c", "C" }, scope = "revisions" }
  )
  config.action("copy short commit id", function()
    copy_to_clipboard(jj("log", "--no-graph", "-r", context.change_id(), "-T", "commit_id.short(8)", "--color", "never"))
  end, { desc = "copy short commit id to clipboard", seq = { "ctrl+c", "g" }, scope = "revisions" }
  )
  config.action("copy long commit id", function()
    copy_to_clipboard(jj("log", "--no-graph", "-r", context.change_id(), "-T", "commit_id", "--color", "never"))
  end, { desc = "copy long commit id to clipboard", seq = { "ctrl+c", "G" }, scope = "revisions" }
  )
  config.action("copy description", function()
    copy_to_clipboard(jj("log", "--no-graph", "-r", context.change_id(), "-T", "description", "--color", "never"))
  end, { desc = "copy description to clipboard", seq = { "ctrl+c", "d" }, scope = "revisions" }
  )
  config.action("copy all", function()
    copy_to_clipboard(jj("show", "--color", "never", "-r", context.change_id()))
  end, { desc = "copy preview to clipboard", seq = { "ctrl+c", "a" }, scope = "revisions" }
  )
end
