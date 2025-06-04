local vim = vim

local spaces_id = vim.api.nvim_create_namespace('folder_spaces')
local arrow_id = vim.api.nvim_create_namespace('folder_ids')

local function GetIsClosed(lnum)
  local total_lines = vim.fn.line('$')
  if (lnum + 1 >= total_lines) then return false end
  if not (vim.fn.foldclosed(lnum + 1) == -1) then return false end
  return true
end

local function GetNextLineNr(lnum)
  local i = 1
  local nextLineNum = lnum + i
  while (IsEmptyLine(nextLineNum) and i < vim.fn.line('$')) do
    nextLineNum = lnum + i
    i = i + 1
  end

  return nextLineNum
end

function IsEmptyLine(lnum)
  return string.len(string.gsub(vim.fn.getline(lnum), " ", "")) <= 0
end

local function IsMarked(lnum)
  local nextLineNum = GetNextLineNr(lnum)
  local indent = vim.fn.indent(lnum)
  local nextIndent = vim.fn.indent(nextLineNum)

  if IsEmptyLine(lnum) then return false end

  if (nextIndent <= indent) then return false end

  if (IsEmptyLine(nextLineNum)) then return false end
  return true
end

local function ClearVirtualText()
  local bnr = vim.fn.bufnr('%')
  vim.api.nvim_buf_clear_namespace(bnr, spaces_id, 0, vim.fn.line('$'))
  vim.api.nvim_buf_clear_namespace(bnr, spaces_id, 0, vim.fn.line('$'))
  vim.api.nvim_buf_clear_namespace(bnr, arrow_id, 0, vim.fn.line('$'))
  vim.api.nvim_buf_clear_namespace(bnr, arrow_id, 0, vim.fn.line('$'))
end

function MF()
  ClearVirtualText()
  -- local open_marker = ""
  local open_marker = ""
  local closed_marker = ""
  local closed_folds_lnums = {}
  -- Define the fold expression func
  local InsertMarker = require("helpers.insert_marker")

  local function MarkLines(lnum)
    if (lnum == 0) then return end


    if not IsMarked(lnum) then return end

    local is_closed = GetIsClosed(lnum)

    if is_closed then table.insert(closed_folds_lnums, lnum) end
    local mark = is_closed and open_marker or closed_marker
    InsertMarker(lnum - 1, mark, 0, "overlay", arrow_id)
  end

  local function SpaceLines(lnum, position)
    if lnum <= 0 then return end
    if lnum > vim.fn.line('$') then return end

    --if not IsEmptyLine(lnum) then
    return InsertMarker(lnum - 1, "  ", 0, position, spaces_id)
  end

  for lnum = 0,vim.fn.line('$'),1 do
    MarkLines(lnum)
  end

  for lnum = 0,vim.fn.line('$'),1 do
    SpaceLines(lnum, "inline")
    -- AlwaysSpaceLines(lnum, "inline")
  end
end
