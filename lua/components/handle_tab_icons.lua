local vim = vim
return function()
  local bufinfo = vim.fn.getbufinfo({buflisted = 1})
  if vim.fn.len(bufinfo) >= 3 then
    vim.cmd([[BarbarDisable]])
    vim.cmd([[set showtabline=0]])
    return
  end

  if Barbar == nil then return end

  local function getIcon()
    if vim.fn.bufnr('%') == 1 then
      return ''
    end
    return ''
  end


  local function getInactive()
    bufinfo = vim.fn.getbufinfo({buflisted = 1})

    if vim.fn.len(bufinfo) < 3 then
      -- vim.cmd([[hi StatusLineNC guifg=none guibg=none]])
      return
    else
      -- vim.cmd([[hi StatusLineNC guifg=none guibg=#121212]])
      vim.cmd([[BarbarDisable]])
      vim.cmd([[set showtabline=0]])
    end

    --if vim.fn.len(bufinfo) < 3 and vim.fn.bufnr('%') == 1 then
    --  return ''
    --end


    return ''
  end

  local updated_config =  {
    icons = {

 		  pinned = {
        button = '',
        filename = true
      },
      separator = {left = getIcon(), right = '█' },
 		  alternate = {
        separator = { left = '?', right = '?' },
      },
 		  visible = {
        separator = { left = '$', right = '$' },
      },
 		  inactive = {
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
  for k,v in pairs(updated_config) do barbar_config[k] = v end

  Barbar.setup(barbar_config)
end
