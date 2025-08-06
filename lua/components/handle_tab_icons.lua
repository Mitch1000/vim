local vim = vim
return function()
  local bufinfo = vim.fn.getbufinfo({buflisted = 1})

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
      vim.cmd([[hi StatusLineNC guifg=none guibg=none]])
    else
      vim.cmd([[hi StatusLineNC guifg=none guibg=#181818]])
    end

    if vim.fn.len(bufinfo) < 3 and vim.fn.bufnr('%') == 1 then
      return ''
    end


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
