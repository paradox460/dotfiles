local M = {}

local function description_of(rev)
  local desc = jj("log", "--no-graph", "-r", rev, "-T", "description.first_line()", "--color", "never")
  return desc or ""
end

function M.register(config)
  config.action("inject evolog", function()
    local commit_id = context.commit_id()
    if not commit_id or commit_id == "" then
      flash("No evolog entry selected")
      return
    end
    local short = commit_id:sub(1, 8)
    jj("duplicate", "@", "--insert-after", "@")
    jj("restore", "--from", commit_id, "--into", "@", "--restore-descendants")
    flash("Injected evolog " .. short .. " before @: " .. description_of("@"))
    revisions.refresh()
  end, { desc = "inject evolog entry before @", key = "alt+j", scope = "revisions.evolog" })

  config.action("inject oplog", function()
    local op_id = context.operation_id()
    if not op_id or op_id == "" then
      flash("No operation selected")
      return
    end
    local short_op = op_id:sub(1, 12)
    local commit_id = jj("--at-op", op_id, "log", "--no-graph", "-r", "@", "-T", "commit_id", "--color", "never")
    if not commit_id or commit_id == "" then
      flash("Could not resolve @ at operation " .. short_op)
      return
    end
    jj("duplicate", "@", "--insert-after", "@")
    jj("restore", "--from", commit_id, "--into", "@", "--restore-descendants")
    flash("Injected op " .. short_op .. " before @: " .. description_of("@"))
    revisions.refresh()
  end, { desc = "inject oplog entry before @", key = "alt+j", scope = "oplog" })
end

return M
