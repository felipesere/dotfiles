mash = {"⌘", "⌥"}

local function toggleApp(name)
  local app = hs.application.find(name)
  if not app or app:isHidden() then
    hs.application.launchOrFocus(name)
  elseif hs.application.frontmostApplication() ~= app then
    app:activate()
  else
    app:hide()
  end
end

-- Global terminal toggle
hs.hotkey.bind(mash, "a", function() toggleApp("alacritty") end)
hs.hotkey.bind(mash, "s", function() toggleApp("Slack") end)
hs.hotkey.bind(mash, "c", function() toggleApp("Arc") end)
hs.hotkey.bind(mash, "n", function() toggleApp("Notion") end)

hs.hotkey.bind(mash, "r", function() hs.reload(); end)
hs.alert("HS config loaded")
