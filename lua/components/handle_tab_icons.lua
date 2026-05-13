local vim = vim
local get_highlight_color = require('helpers/get_highlight_color')

local has_init = false

return function()

  local initial_status_line_color_fg = get_highlight_color("StatusLine", "guifg")
  local initial_status_line_color_bg = get_highlight_color("StatusLine", "guibg")
  local initial_buffer_color_fg = get_highlight_color("BufferCurrent", "guifg")
  local buffer_color_bg = get_highlight_color("Normal", "guibg")
  local initial_buffer_color_bg = string.len(buffer_color_bg) > 0 and buffer_color_bg or "none"
  local solid_buffer_color_bg = get_highlight_color("NotifyBackground", "guibg")
  local bufinfo = vim.fn.getbufinfo({buflisted = 1})

  if not has_init then
    vim.cmd([[hi BufferCurrent guifg=]] .. initial_buffer_color_fg .. [[ guibg=]] .. solid_buffer_color_bg)
  end

  local function init()
    has_init = true
    vim.cmd([[hi BufferCurrent guifg=]] .. initial_buffer_color_fg .. [[ guibg=]] .. initial_buffer_color_bg)
  end

  if not has_init then vim.schedule(init) end

  if Barbar == nil then return end

  bufinfo = vim.fn.getbufinfo({buflisted = 1})
  local function getIcon()
    if vim.fn.bufnr('%') == 1 then
      return ''
    end
    return ''
  end


  local function getInactive()
    if vim.fn.len(bufinfo) < 3 and vim.fn.bufnr('%') == 1 then
      return ''
    end

    return ''
  end

  if has_init then
    if vim.fn.len(bufinfo) < 3 then
      -- vim.cmd([[hi StatusLineNC guifg=none guibg=none]])
      vim.cmd([[hi TabLine guifg=none guibg=none]])
      vim.cmd([[hi BufferCurrent guifg=]] .. initial_buffer_color_fg .. [[ guibg=]] .. initial_buffer_color_bg)
    else
      vim.cmd([[hi TabLine guifg=]] .. initial_status_line_color_fg  .. [[ guibg=]] .. initial_status_line_color_bg)
      vim.cmd([[hi BufferCurrent guifg=]] .. initial_buffer_color_fg .. [[ guibg=]] .. solid_buffer_color_bg)
    end
  end

  local updated_config =  {
    icons = {

 		  pinned = {
        button = '',
        filename = true
      },
      separator = {left = getIcon(), right = '█' },
 		  alternate = {
        separator = { left = '', right = '' },
      },
 		  visible = {
        separator = { left = '', right = '' },
      },
 		  inactive = {
        --separator = {left = '', right = '' },
        separator = { left = '', right = getInactive() },
        -- separator = { left = '', right = '' },
        -- separator = { left = '', right = '' },
        -- separator = { left = '', right = '' },
        filetype = { enabled = false }
      },
      separator_at_end = true
    },
  }
  local barbar_config = require('config.barbarConf')

  for k,v in pairs(updated_config) do
    if type(v) ~= "table" then
      barbar_config[k] = v
    end
  end

  for key,val in pairs(updated_config.icons) do barbar_config.icons[key] = val end

  Barbar.setup(barbar_config)
end
