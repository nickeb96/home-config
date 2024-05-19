if arg[0] == "lua" and arg[-1] == nil then
  _PROMPT = "> "
  _PROMPT2 = "- "
  _G["exit"] = {}
  setmetatable(_G["exit"], {
    __tostring = function() os.exit() end,
    __call = function(exit_code) os.exit(exit_code) end,
  })
  _G["tprint"] = function(t)
    for k, v in pairs(t) do
      print(k, v)
    end
  end
end
