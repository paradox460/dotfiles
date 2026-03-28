-- Keyboard bindings (revisions scope)
--
-- t           advance closest bookmark forwards
-- ctrl+k      open revision in ksdiff
--
-- ctrl+c c    copy short change id
-- ctrl+c C    copy long change id
-- ctrl+c g    copy short commit id
-- ctrl+c G    copy long commit id
-- ctrl+c d    copy description
-- ctrl+c a    copy preview
--
-- x j         new branch from jira ticket
-- x p         new pr from bookmark
-- x P         new pr from change
-- x g         open pr in browser
-- x s         sign checked or current change(s)
-- x b n       new change on bookmark
-- x b r       rebase change onto bookmark

local function jj_log_template(template)
  return jj("log", "--no-graph", "-r", context.change_id(), "-T", template, "--color", "never")
end

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
    jj_async("bookmark", "advance", "--to", context.change_id())
    revisions.refresh()
  end, { desc = "advance closest bookmark forwards", key = "t", scope = "revisions" }
  )
  config.action("ksdiff", function()
    jj("diff", "--tool", "ksdiff", "-r", context.change_id())
  end, { desc = "open revision in ksdiff", key = "ctrl+k", scope = "revisions" }
  )

  -- Clipboard actions
  config.action("copy short change id", function()
    copy_to_clipboard(jj_log_template("change_id.short(8)"))
  end, { desc = "copy short change id to clipboard", seq = { "ctrl+c", "c" }, scope = "revisions" }
  )
  config.action("copy long change id", function()
    copy_to_clipboard(jj_log_template("change_id"))
  end, { desc = "copy long change id to clipboard", seq = { "ctrl+c", "C" }, scope = "revisions" }
  )
  config.action("copy short commit id", function()
    copy_to_clipboard(jj_log_template("commit_id.short(8)"))
  end, { desc = "copy short commit id to clipboard", seq = { "ctrl+c", "g" }, scope = "revisions" }
  )
  config.action("copy long commit id", function()
    copy_to_clipboard(jj_log_template("commit_id"))
  end, { desc = "copy long commit id to clipboard", seq = { "ctrl+c", "G" }, scope = "revisions" }
  )
  config.action("copy description", function()
    copy_to_clipboard(jj_log_template("description"))
  end, { desc = "copy description to clipboard", seq = { "ctrl+c", "d" }, scope = "revisions" }
  )
  config.action("copy all", function()
    copy_to_clipboard(jj("show", "--color", "never", "-r", context.change_id()))
  end, { desc = "copy preview to clipboard", seq = { "ctrl+c", "a" }, scope = "revisions" }
  )

  config.action("new jira bookmark", function()
    local desc = jj_log_template("description")
    local ticket = desc and desc:match("%w+-%d+")
    if not ticket then
      ticket = input({ title = "JIRA Ticket ID" })
    end
    exec_shell("jjnb " .. ticket)
    revisions.refresh()
  end, { desc = "new branch from jira ticket", seq = { "x", "j" }, scope = "revisions" })

  config.action("new pr (bookmark)", function()
    exec_shell("jjpr -r " .. context.change_id())
    revisions.refresh()
  end, { desc = "new pr from bookmark", seq = { "x", "p" }, scope = "revisions" })

  config.action("new pr (change)", function()
    exec_shell("jjpr -c " .. context.change_id())
    revisions.refresh()
  end, { desc = "new pr from change", seq = { "x", "P" }, scope = "revisions" })

  config.action("sign", function()
    local checked = context.checked_change_ids()
    local args = { "sign" }
    if #checked > 0 then
      for _, change_id in ipairs(checked) do
        args[#args + 1] = "-r"
        args[#args + 1] = change_id
      end
    else
      args[#args + 1] = "-r"
      args[#args + 1] = context.change_id()
    end
    jj(args)
    revisions.refresh()
  end, { desc = "sign checked or current change(s)", seq = { "x", "s" }, scope = "revisions" })

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

  config.action("open pr in browser", function()
    local out, err = jj("bookmark", "list", "-r", context.change_id(), "-T", "name ++ \"\\n\"", "--color", "never")
    if not out or out == "" then
      flash("No bookmark on this change")
      return
    end
    local bookmarks = split_lines(out)
    local bookmark = bookmarks[1]
    if #bookmarks > 1 then
      bookmark = choose({options = bookmarks, title = "Open PR for bookmark" })
    end
    if bookmark then
      exec_shell("gh pr view --web " .. bookmark)
    end
  end, { desc = "open pr in browser", seq = { "x", "g" }, scope = "revisions" })

  -- Rebinds
  config.bind({ key = "s", action = "revisions.open_squash", scope = "revisions", desc = "squash" })
  config.bind({ key = "shift+s", action = "revisions.split", scope = "revisions", desc = "split" })
  config.bind({ key = "s", action = "revisions.details.squash", scope = "revisions.details", desc = "squash" })
  config.bind({ key = "shift+s", action = "revisions.details.split", scope = "revisions.details", desc = "split" })
end
