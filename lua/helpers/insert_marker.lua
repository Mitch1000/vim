local vim = vim

GetHighlightColor = require("helpers.get_highlight_color")
-- 
local background = GetHighlightColor('Normal', 'guibg')

if (string.len(background) <= 0) then
  background = 'NONE'
end

local function InsertMarker(lineNumber, char, col, position, ns_id)
  vim.cmd([[hi AccordianMarker guifg=#5f5f5f guibg=]] .. background)

  local api = vim.api
  local bnr = vim.fn.bufnr('%')
  local line_num = lineNumber
  local col_num = col or 0
  -- local ns_id = api.nvim_create_namespace('demo' .. position .. tostring(mult))

  local opts = {
    end_line = 0,
    id = lineNumber +1,
    virt_text = {{char, "AccordianMarker"}},
    virt_text_pos = position,
  }

  if (position == 'overlay') then
    opts.virt_text_win_col = col_num
  end

  return api.nvim_buf_set_extmark(bnr, ns_id, line_num, col_num, opts)
end

return InsertMarker
