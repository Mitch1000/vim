local vim = vim

function OpenWin(file_name)
  local width = vim.o.columns - 4
  local height = 32
  if (vim.o.columns >= 85) then
      width = 110
  end
  vim.api.nvim_open_win(
      vim.api.nvim_create_buf(false, true),
      true,
      {
          relative = 'editor',
          style = 'minimal',
          border = "none",
          noautocmd = true,
          width = width,
          height = height,
          col = math.min((vim.o.columns - width) / 2),
          row = math.min((vim.o.lines - height) / 2 - 1),
      }
  )
  vim.cmd("edit " .. file_name)
end

function TrailerTrim()
  vim.cmd([[%s/\s\+$//e]])
end

function Close()
  vim.cmd([[q]])
end

-- Define custom functions
-- Print a console.log() for each variable stored in g register
function PrintJavascriptConsoleLogs()
  local variables_for_logging = vim.split(vim.fn.getreg('a'), " ,, ")
  for _, variable in ipairs(variables_for_logging) do
    if string.len(variable) > 0 then
      vim.cmd("execute \"normal! ccconsole.log('" .. variable .. "\\', " .. variable .. ")\\n\"")
    end
  end
  vim.fn.setreg("a", '')
end

-- Open the Tig Git terminal
function GitLoad()
  vim.cmd("terminal tig")
  vim.cmd('starti')
  vim.fn.feedkeys('s')
end

-- Open the Tig Git terminal
function GitBlame()
  vim.cmd("Git blame")
end
vim.cmd("let g:syntastic_java_checkers = []")

function WaitThenOpenFile(open_clipboard)
  local file_to_open = ""
  if open_clipboard then
    vim.cmd('sleep 30m')  -- 15 milliseconds
    file_to_open = vim.fn.system("pbpaste")
  else
    file_to_open = vim.api.nvim_get_current_line()
  end

  local i,j = string.find(file_to_open, "M ")

  if i == 1 then
    file_to_open = string.sub(file_to_open, j, string.len(file_to_open))
  end
  vim.cmd('sleep 15m')  -- 15 milliseconds

  vim.cmd("edit " .. file_to_open)
end

-- Reset Git with Tig
function TigReset()
  vim.cmd("Git reset")
  vim.cmd("call feedkeys('R')")
end

function SetPaste()
  vim.cmd([[set paste]])
  -- Make sure press Ctrl-R
  -- They it would without the remap to allow use paste from the register
  vim.cmd([[call feedkeys("\<C-r>")]])
  -- Return to no paste after the register has been pasted
  vim.cmd([[autocmd TextChangedI * ++once set nopaste]])
end

function CloseWindow()
  vim.cmd([[silent! close]])
end

function ReloadConfig()
  local luacache = (_G.__luacache or {}).cache
  -- TODO unload commands, mappings + ?symbols?
  for pkg, _ in pairs(package.loaded) do
    if pkg:match '^my_.+'
    then
      print(pkg)
      package.loaded[pkg] = nil
      if luacache then
        lucache[pkg] = nil
      end
    end
  end
  dofile(vim.env.MYVIMRC)
  vim.notify('Config reloaded!', vim.log.levels.INFO)
end

function BufferOrderByBufferNumberSafe()
  if vim.fn.exists(":BufferOrderByBufferNumber") > 0 then
     vim.cmd([[BufferOrderByBufferNumber]])
  end
end

-- Autocomplete
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use K to show documentation in preview window
function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        pcall(vim.fn.CocActionAsync, "doHover")
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end

function CocActionAsyncSafe(action)
  if vim.fn.exists(":CocList") > 0 then
    vim.fn.CocActionAsync(action)
  end
end

