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

local term = nil;
local termbuf = nil;
local job = nil;
local termwin = nil;

function builder()
	if job then return end;

	if termbuf and vim.api.nvim_buf_is_valid(termbuf) then
		vim.api.nvim_buf_delete(termbuf, {});
	end

	termbuf = vim.api.nvim_create_buf(false, false);

	local visible = false;
	if termwin ~= nil then
		for _,w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
			if w == termwin then
				visible = true;
				break;
			end
		end
	end

	if not visible then
		vim.cmd("rightbelow split");
		vim.api.nvim_win_set_buf(0, termbuf);
		vim.api.nvim_win_set_option(0, 'number', false);
		vim.api.nvim_win_set_height(0, 20);
		termwin = vim.api.nvim_get_current_win();
	end

	job = vim.fn.termopen('python build.py --cc --ad', {
		cwd = 'misc/',
		on_exit = function(job_id, exit_code, event_type)
			job = nil;
		end
	});
end

vim.keymap.set('n', '<a-b>', function ()
	builder()
end);

-- places a formatted date at the cursor
vim.api.nvim_create_user_command('Date', function(opts)
	vim.api.nvim_put({os.date()}, "c", true, true);
end,
{ nargs = 0 });


vim.api.nvim_create_user_command('Time', function(opts) 
	vim.api.nvim_put({os.date("%H:%M:%S")}, "c", true, true);
end,
{ nargs = 0});



