local fwatch = require('fwatch')

local theme_file = vim.fn.expand('~/.theme')

function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

-- get all lines from a file, returns an empty 
-- list/table if the file does not exist
function lines_from(file)
  if not file_exists(file) then return {} end
  local lines = {}
  for line in io.lines(file) do 
    lines[#lines + 1] = line
  end
  return lines
end

local setup = function(opts)
  local lines = lines_from(theme_file)
  if(lines[1] == "light") then
    opts.on_light()
  else
    opts.on_dark()
  end
  fwatch.watch(theme_file, {
      on_event = function()
        local lines = lines_from(theme_file)
        if(lines[1] == "light") then
          -- 🚧 we schedule the on_* callback so we have
          -- full access to neovim API withim them
          vim.schedule_wrap(opts.on_light)()

        else
          vim.schedule_wrap(opts.on_dark)()
        end
      end
    })


end

return { setup = setup }
