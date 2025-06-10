local vim = vim
local function color(name)
  return vim.api.nvim_command_output([[ echo backpack#GetColors()[']] .. name .. "']" .. "[0]")
end

local colors = {
  black        = "#262626",
  dark         = "#222222",
  bright_white = color("light1"),
  white        = color("light2"),
  soft_white   = "#f0f0f0",
  softy_white   = "#f1e5f0",
  softer_white = color("light3"),
  red          = color("dark_red"),
  green        = color("green"),
  blue         = color("forest_blue"),
  blue_light   = "#34a9a7",
  purple       = color("bright_purple"),
  yellow       = color("stain_yellow"),
  gray         = color("light5"),
  darkgray     = color("dark_gray"),
  rose         = color("rose"),
  lightgray    = color("light3"),
  inactivegray = color("light4"),
}

local theme = {
  normal = {
    a = {bg = colors.blue, fg = colors.black, gui = 'bold'},
    b = {bg = colors.black, fg = colors.blue},
    c = {bg = colors.dark, fg = colors.softy_white},
    x = {bg = colors.dark, fg = colors.soft_white},
    y = {bg = colors.black, fg = colors.soft_white},
    z = {bg = colors.blue_light, fg = colors.black, gui = 'bold'},
  },
  insert = {
    a = {bg = colors.purple, fg = colors.black, gui = 'bold'},
    b = {bg = colors.black, fg = colors.soft_white},
    c = {bg = colors.dark, fg = colors.white}
  },
  visual = {
    a = {bg = colors.yellow, fg = colors.black, gui = 'bold'},
    b = {bg = colors.dark, fg = colors.white},
    c = {bg = colors.dark, fg = colors.black}
  },
  replace = {
    a = {bg = colors.red, fg = colors.black, gui = 'bold'},
    b = {bg = colors.dark, fg = colors.white},
    c = {bg = colors.dark, fg = colors.black}
  },
  command = {
    a = {bg = colors.white, fg = colors.black, gui = 'bold'},
    b = {bg = colors.dark, fg = colors.white},
    c = {bg = colors.dark, fg = colors.white}
  },
  inactive = {
    a = {bg = colors.darkgray, fg = colors.gray, gui = 'bold'},
    b = {bg = colors.darkgray, fg = colors.gray},
    c = {bg = colors.darkgray, fg = colors.gray}
  }
}

function GetTheme()
  if (vim.g.my_color_scheme == 'backpack') then
    return theme
  end
  return 'auto'
end

return {
  options = {
     icons_enabled = true,
     theme = GetTheme(),
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
     always_show_tabline = true,
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
            error = { fg = color("dark_red") },
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
