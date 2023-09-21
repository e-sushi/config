---------
-- various config to do with how nvim behaves outside
-- of what plugins already change


-- setup a callback that automatically enters insert mode 
-- when i enter a buffer that's a terminal
vim.api.nvim_create_autocmd('BufEnter', {
	callback = function(_)
		local buffer = vim.api.nvim_get_current_buf();
		if vim.api.nvim_buf_get_option(buffer, 'buftype') == 'terminal' then
			vim.cmd('startinsert');
		end
	end
});

-- setup auto saving when leaving a buffer 
-- this doesn't seem to work, just manually implement
-- something later (harder than it seems, though)
-- vim.cmd("set autowriteall");

vim.cmd("highlight GdbCurrentLine guibg=#353535");
vim.cmd("sign define GdbCurrentLine linehl=GdbCurrentLine");
