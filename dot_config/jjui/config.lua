local function choose_bookmark(title)
  local out, err = jj("bookmark", "list", "-T", "name ++ \"\\n\"", "--color", "never")
  if not out or out == "" then
    flash("No bookmarks found")
    return nil
  end
  local bookmarks = split_lines(out)
  if #bookmarks == 0 then
    flash("No bookmarks found")
    return nil
  end
  return choose({ options = bookmarks, title = title })
end

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

  config.action("new jira bookmark", function()
    local ticketId = input({ title = "JIRA Ticket ID" })
    exec_shell("jjnb", ticketId)
    revisions.refresh()
  end, { desc = "new branch from jira ticket", seq = { "x", "j" }, scope = "revisions" })

  config.action("new pr (bookmark)", function()
    exec_shell("jjpr", "-r", context.change_id())
    revisions.refresh()
  end, { desc = "new pr from bookmark", seq = { "x", "p" }, scope = "revisions" })

  config.action("new pr (change)", function()
    exec_shell("jjpr", "-c", context.change_id())
    revisions.refresh()
  end, { desc = "new pr from bookmark", seq = { "x", "P" }, scope = "revisions" })

  config.action("new on bookmark", function()
    local selected = choose_bookmark("New change on bookmark")
    if selected then
      jj("new", selected)
      revisions.refresh()
    end
  end, { desc = "new change on bookmark", seq = { "x", "b", "n" }, scope = "revisions" })

  config.action("rebase onto bookmark", function()
    local selected = choose_bookmark("Rebase onto bookmark")
    if selected then
      jj("rebase", "-b", context.change_id(), "-d", selected)
      revisions.refresh()
    end
  end, { desc = "rebase change onto bookmark", seq = { "x", "b", "r" }, scope = "revisions" })
end
