vim.cmd([[ set number ]])

vim.g.my_color_scheme = 'habamax'

require("globals")
require("components")
require("config.lazy")
require("helpers")
require("options")
require("lspconfigsetup")
require("keymappings")
require("commands")
