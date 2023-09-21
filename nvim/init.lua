
-- lua (or something) doesn't support using require(...) on local files so to load
-- the other files when this isn't the cwd, we have to do this
-- which kinda sucks but whatever
-- all it's doing is loading all other .lua files in this directory
for k,v in ipairs(vim.fn.glob("~/.config/nvim/*.lua", false, true)) do
	if v:sub(-#"init.lua") ~= "init.lua" then
		dofile(v)
	end
end


vim.api.nvim_create_autocmd('BufEnter', {
	callback = function(ev)
		local buffer = vim.api.nvim_get_current_buf();
		if vim.api.nvim_buf_get_option(buffer, 'buftype') == 'terminal' then
			vim.cmd('startinsert');	
		end	
	end
})




