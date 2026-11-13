local utils = require("utils")
local jj_log_template = utils.jj_log_template

local M = {}

function M.register(config)
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
  config.action("copy bookmark", function()
    local out, err = jj("bookmark", "list", "-r", context.change_id(), "-T", "name ++ \"\\n\"", "--color", "never")
    if not out or out == "" then
      flash("No bookmark on this change")
      return
    end
    local bookmarks = split_lines(out)
    if #bookmarks == 1 then
      copy_to_clipboard(bookmarks[1])
    else
      local options = { "All (" .. table.concat(bookmarks, " ") .. ")" }
      for _, b in ipairs(bookmarks) do
        options[#options + 1] = b
      end
      local selected = choose({ options = options, title = "Copy bookmark name" })
      if selected then
        if selected == options[1] then
          copy_to_clipboard(table.concat(bookmarks, " "))
        else
          copy_to_clipboard(selected)
        end
      end
    end
  end, { desc = "copy bookmark name to clipboard", seq = { "ctrl+c", "b" }, scope = "revisions" }
  )
  config.action("copy all", function()
    copy_to_clipboard(jj("show", "--color", "never", "-r", context.change_id()))
  end, { desc = "copy preview to clipboard", seq = { "ctrl+c", "a" }, scope = "revisions" }
  )
end

return M
