
-- lua (or something) doesn't support using require(...) on local files so to load
-- the other files when this isn't the cwd, we have to do this
-- which kinda sucks but whatever
-- all it's doing is loading all other .lua files in this directory
for k,v in ipairs(vim.fn.glob("~/.config/nvim/*.lua", false, true)) do
	if v:sub(-#"init.lua") ~= "init.lua" then
		dofile(v)
	end
end

-- delete the lsp log file everytime we start so it doesn't get huge
vim.fn.delete("~/.local/state/nvim/lsp.log");
