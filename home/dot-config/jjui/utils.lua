local M = {}

function M.jj_log_template(template)
  return jj("log", "--no-graph", "-r", context.change_id(), "-T", template, "--color", "never")
end

function M.choose_bookmark(title)
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

return M
