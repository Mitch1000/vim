local vim = vim

local status, result = pcall(require, vim.g.my_color_scheme .. [[.colors]])

local function color(string)
  if status and vim.g.my_color_scheme == "backpack" then
    return result.setup({ theme = vim.o.background }).palette[string]
  end
end

return {
  options = {
     icons_enabled = true,
     theme = 'auto',
     component_separators = { left = '', right = ''},
     -- section_separators = { left = '', right = ''},
     section_separators = { left = '', right = ''},
     -- section_separators = { left = '', right = ''},
     disabled_filetypes = {
       statusline = {},
       winbar = {},
     },
     ignore_focus = {},
     always_divide_middle = true,
     always_show_tabline = false,
     globalstatus = false,
     refresh = {
       statusline = 100,
       tabline = 100,
       winbar = 100,
     }
   },
   sections = {
     lualine_a = {'mode'},
     lualine_b = {
       {
        'branch',
        icon="󰘬"
       },
       {
          'diagnostics',
          colored = true,
          symbols = { error = " ", warn = " ", info = "󱜺 ", hint = "󰺕 " },
          diagnostics_color = {
            error = { fg = color("Error") },
            warn = { fg = color("stain_yellow") },
            info = { fg = color("light3") },
            hint = { fg = color("terminal_blue") },
          },
       },
     },
     lualine_c = {
      'filename'
     },
     lualine_x = {
        'fileformat',
     },
     lualine_y = {
       {
         'diff',
         symbols = { added = " ", modified = "󰻃 ", removed = " " },
         diff_color = {
           added = { fg = color("green") },
           modified = { fg = color("forest_blue") },
           removed = { fg = color("bright_red") },
         }
       },
      'progress',
     },
     lualine_z = {'location'}
   },
   inactive_sections = {
     lualine_a = {},
     lualine_b = {},
     lualine_c = {'filename'},
     lualine_x = {'location'},
     lualine_y = {},
     lualine_z = {}
   },
   tabline = {},
   winbar = {},
   inactive_winbar = {},
   extensions = {}
}
