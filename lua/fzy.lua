local vim = vim
-- https://github.com/jhawthorn/fzy/pull/116#issuecomment-538708329
local function fzy(a)
    local width = vim.o.columns - 4
    local height = 11
    if (vim.o.columns >= 85) then
        width = 80
    end
    vim.api.nvim_open_win(
        vim.api.nvim_create_buf(false, true),
        true,
        {
            relative = 'editor',
            style = 'minimal',
            border = "rounded",
            noautocmd = true,
            width = width,
            height = height,
            col = math.min((vim.o.columns - width) / 2),
            row = math.min((vim.o.lines - height) / 2 - 1),
        }
    )
    local file = vim.fn.tempname()
    vim.fn.termopen(a.input .. ' | fzy >' .. file, { env = a.env, on_exit = function()
        vim.api.nvim_command('bdelete!')
        local f = io.open(file, 'r')
        local stdout;
        if (f ~= nil) then
          stdout = f:read('*all')
          f:close()
        end

        if (a.action) then
          a.action(stdout)
          os.remove(file)
          return
        end
        os.remove(file)
        vim.api.nvim_command('edit ' .. stdout)
        vim.fn.histadd('cmd', 'e ' .. stdout)
    end })
    vim.cmd('startinsert')
end

local function FindFile()
  fzy { input = 'find . -type f '}
end

local function Search(searchTerm, folder)
  local input = 'ag --silent -l --ignore-dir="log" --ignore-dir=".node_modules" --ignore="tags" ' .. searchTerm

  folder = folder or ''
  if (#folder > 0) then
   input = input .. ' ' .. folder
  end
  print(folder)
  print(searchTerm)
  vim.g.test = folder
  fzy {
    input,
    action = function (stdout)
      vim.api.nvim_command('bdelete!')
      vim.api.nvim_command('edit ' .. stdout)
      vim.fn.search(searchTerm)
      vim.fn.histadd('cmd', 'e ' .. stdout)
    end,
  }
end

-- Mind the double quotes around env vars (do substitute, but without
-- wildcard expansions and word splitting).
local function Buffers ()
  fzy {
    env = { NVIM_BUFFERS = vim.fn.execute('ls') },
    input = 'echo "$NVIM_BUFFERS"',
    action = function (line) vim.cmd('b' .. string.match(line, '%d+')) end,
  }
end

local function History()
  local history = vim.fn.execute('history cmd')
  history = vim.split(history, '\n')

  for i = 1, #history do
    history[i] = history[i]:gsub('>?%s*%S+%s*', '', 1)
  end

  local long_history = {}
  for k,v in ipairs(history) do
    if (string.len(v) > 2) then
      table.insert(long_history, v)
    end
  end

  local recent_history = table.move(vim.fn.reverse(long_history), 1, 200, 1, {})
  history = table.concat(recent_history, '\n')
  fzy {
    env = { NVIM_HISTORY = history },
    input = 'echo "$NVIM_HISTORY"', -- | tac | sed "s/>\\?\\s*\\S\\+\\s*/:/" ',
    action = function (line)
      vim.cmd(line:gsub(':', '', 1))
      vim.fn.histadd('cmd', line:gsub(':', '', 1))
    end,
  }
end

local function Oldfiles ()
  local history = vim.fn.execute('history cmd')
  history = vim.split(history, '\n')


  local oldfiles = {}
  for i = 1, #history do
    history[i] = history[i]:gsub('>?%s*%S+%s*', '', 1)
    local start = string.sub(history[i], 0, 2)
    if (string.find(start, [[e ]])) then
      local file = history[i]:gsub([[e ]], [[]])
      if (string.sub(file, -2) == [[^@]]) then
        file = file:gsub('%^', '')
        file = file:gsub('@', '')
      end

      table.insert(oldfiles, file)
    end
  end

  oldfiles = table.move(vim.fn.reverse(oldfiles), 1, 200, 1, {})

  local good_files = {}
  local parent_folder = vim.fn.getcwd()

  for _,v in ipairs(oldfiles) do
    if (not string.find(v, [[term://]])) then
      local file = v
      if string.find(v, parent_folder) then
        file = v:gsub(parent_folder .. [[/]], [[./]])
      end
      table.insert(good_files, file)
    end
  end

-- /Users/mitchelldrohan/projects/fms
-- /Users/mitchelldrohan/projects/fms/app/assets/javascripts/communityStream.js
--
  local recent_files = table.move(good_files, 1, 150, 1, {})

  fzy {
    env = { NVIM_OLDFILES = table.concat(recent_files, '\n') },
    input = 'echo "$NVIM_OLDFILES"',
  }
end

-- NOTE: getjumplist()
local function jumplist ()
  local prepare_jumplist = function ()
    jumps = vim.split(vim.fn.execute('jumps'), '\n', {trimempty=true})
    -- Find '>'.
    local current_pos = nil
    for n, line in ipairs(jumps) do
      if line:match('^%s*>') then current_pos = n end
    end
    -- Add +/- (newer/older) prefixes to lines (to be able to decide
    -- which key to use - <c-o>/<c-i> - on the selected item).
    for n, line in ipairs(jumps) do
      if n > 1 then
        local prefix = ' '
        if n < current_pos then prefix = '-' end
        if n > current_pos then prefix = '+' end
        jumps[n] = line:gsub('%s', prefix, 1)
      end
    end
    -- Get rid of unneeded content (header, >), and reverse the list.
    local res = {}
    for i= #jumps,1,-1 do
      if not jumps[i]:match('^%s*>') and jumps[i]:match('%d') then
        table.insert(res, jumps[i])
      end
    end
    return table.concat(res, '\n')
  end

  fzy {
    env = { NVIM_JUMPS = prepare_jumplist() },
    input = 'echo "$NVIM_JUMPS"',
    action = function (line)
      local n = line:match('%d+')
      local key = vim.api.nvim_replace_termcodes(
          line:match('^%s*%+') and '<c-i>' or '<c-o>', true, true, true)
      vim.fn.execute('normal! ' .. n .. key)
    end,
  }
end

return {
  fzy = fzy,
  FindFile = FindFile,
  Search = Search,
  Buffers = Buffers,
  History = History,
  Oldfiles = Oldfiles,
  jumplist = jumplist,
}
-- local function fzy(a)
--   local saved_spk = vim.o.splitkeep
--   local src_winid = vim.fn.win_getid()
--   -- lines >= 3 is a hardcoded limit in fzy
--   local fzy_lines = (vim.v.count > 2 and vim.v.count) or 10
--   local tempfile = vim.fn.tempname()
--   local term_cmd = a.input .. ' | fzy -l' .. fzy_lines .. ' > ' .. tempfile
-- 
--   -- FIXME: terminal buffer shows in `:ls!` after exiting.
--   local on_exit = function ()
--     vim.cmd.bwipeout()
--     vim.o.splitkeep = saved_spk
--     vim.fn.win_gotoid(src_winid)
--     if vim.fn.filereadable(tempfile) then
--       local lines = vim.fn.readfile(tempfile)
--       if #lines > 0 then (a.action or vim.cmd.edit)(lines[1]) end
--     end
--     vim.fn.delete(tempfile)
--   end
-- 
--   vim.o.splitkeep = 'screen'
--   vim.cmd('botright' .. (fzy_lines + 1) .. 'new')
--   -- NOTE: `cwd` can also be specified for the job
--   local id = vim.fn.termopen(term_cmd, { on_exit = on_exit, env = a.env, })
--   vim.keymap.set('n', '<esc>', function () vim.fn.jobstop(id) end, {buffer=true})
--   vim.cmd('keepalt file fzy')
--   vim.cmd.startinsert()
-- end
