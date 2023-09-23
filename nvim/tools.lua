--------
-- tools to help do things
--
--

function inspect_color()
	local inspect = vim.inspect_pos();
	--vim.notify(vim.inspect(inspect));
	local i = string.byte("a");
	if inspect.semantic_tokens then
		-- vim.print(inspect.semantic_tokens);
		for _,t in ipairs(inspect.semantic_tokens) do
			local opts = t.opts;
			local cmd = opts.hl_group;
			vim.cmd.let('@' .. string.char(i) .. ' = "' .. opts.hl_group .. '"');
			i = i + 1;
		end	
	end
	if inspect.treesitter then
		for _,t in ipairs(inspect.treesitter) do
			vim.cmd.let('@' .. string.char(i) .. ' = "' .. t.hl_group .. '"');
			i = i + 1;
		end
	end
end


function builder()
	local Terminal = require("toggleterm.terminal").Terminal;
	local term = Terminal:new({
		display_name = "amu_build",
		dir = "misc/",
		cmd = "python build.py -notcurses /usr/include/notcurses/ --cc",
		close_on_exit = false,
		direction = "vertical",
	});
	term:open(50);
end

vim.keymap.set('n', '<a-b>', function ()
	builder()
end);



