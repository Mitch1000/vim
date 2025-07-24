local vim = vim
return function(color_scheme_opt)
  local colorscheme = color_scheme_opt or vim.g.my_color_scheme or ""
  pcall(vim.cmd, 'colorscheme ' .. colorscheme)

  if os.getenv("TERM_PROGRAM") == 'ghostty' then
    local get_initial_bg_color = [[ghostty +show-config | awk -F'= ' '/^background/ {print $2}' | grep "#"]]
    local initial_bg_color = vim.fn.system(get_initial_bg_color)
    function ResetColorScheme()
      os.execute([[printf '\e]11;]] .. initial_bg_color .. [[\a']])
    end

    vim.cmd([[autocmd VimLeavePre * execute "lua ResetColorScheme()"]])

    local GetHighlightColor = require('helpers.get_highlight_color')
    local bg_color = GetHighlightColor("Normal", "guibg")
    if string.find(bg_color, "#") == nil then
      bg_color = GetHighlightColor("TelescopeBorder", "guibg")
    end
    os.execute([[printf '\e]11;]] .. bg_color .. [[\a']])
  end

end
