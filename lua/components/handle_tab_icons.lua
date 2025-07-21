local vim = vim
return function()
  if Barbar == nil then return end

  local function getIcon()
    if vim.fn.bufnr('%') == 1 then
      return ''
    end
    return ''
  end

  local function getInactive()
    local bufinfo = vim.fn.getbufinfo({buflisted = 1})

    if vim.fn.len(bufinfo) < 3 then
      vim.cmd([[hi StatusLineNC guifg=none guibg=none]])
    else
      vim.cmd([[hi StatusLineNC guifg=none guibg=#121212]])
    end

    if vim.fn.len(bufinfo) < 3 and vim.fn.bufnr('%') == 1 then
      return ''
    end


    return ''
  end

  Barbar.setup({
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
  })
end
