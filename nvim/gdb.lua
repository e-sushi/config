local gdbwin = nil;
local gdbbuf = nil;
local gdbpty = nil;

local ptywin = nil;
local ptybuf = nil;
local ptypty = nil;

local srcwin = nil;
local srcbuf = nil;

local compty = nil;

local mi_lines = {''};
function handle_mi(chan_id, data, name)
	for _,s in ipairs(data) do
		-- vim.print(s .. '\n');
		for i=1,#s do
			local c = s:sub(i,i);
			if c == '\r' then
				table.insert(mi_lines, '');
			else
				mi_lines[#mi_lines]	= mi_lines[#mi_lines] .. c;
			end
		end
	end

	vim.print(mi_lines);

	if #mi_lines > 1 then
		for i,l in ipairs(mi_lines) do
			vim.print(l .. '\n');
		end
	end
end

function start_gdb() 
	if gdbwin ~= nil then
		vim.notify("can't open more than one gdb session");
	end


	srcwin = vim.api.nvim_get_current_win();
	srcbuf = vim.api.nvim_win_get_buf(srcwin);

	vim.cmd("vsplit");
	ptywin = vim.api.nvim_get_current_win();
	ptybuf = vim.api.nvim_create_buf(false, false);
	vim.api.nvim_win_set_buf(ptywin, ptybuf);
	vim.api.nvim_set_current_buf(ptybuf);
--	ptypty = vim.fn.termopen('sleep 15d', {
--		detach = true,
--	});


	-- a hidden job that's used to communicate with 
	-- gdb through its MI interface
	compty = vim.fn.termopen('sleep 15d', {
	--	pty = true,
		on_stdout = handle_mi,
	});

	if not compty then
		vim.notify("failed to start compty");
		return;
	end

	local gdbcmd = {
		"gdb",
		"-q", -- dont print greeting cause it'll mess stuff up
		"-iex", "set pagination off", -- paging messes up stuff
		"-iex", "set mi-async-on",
		-- "-tty", "/dev/pts/" .. ptypty,
	};

	vim.cmd('split');
	gdbwin = vim.api.nvim_get_current_win();	
	gdbbuf = vim.api.nvim_create_buf(false, false);
	vim.api.nvim_win_set_buf(gdbwin, gdbbuf);
	gdbpty = vim.fn.termopen(gdbcmd, {
		detach = true,
	});


	-- ask gdb to create a new thing that allows us to interact with it
	-- through its MI interface
	vim.fn.chansend(gdbpty, 'new-ui mi ' .. vim.api.nvim_get_chan_info(compty)['pty'] .. '\r');

	-- ask gdb to load exe (hardcoded for amu for now)
	vim.fn.chansend(gdbpty, 'file build/debug/amu\r');

	-- set arguments
	vim.fn.chansend(gdbpty, 'set args tests/_/main.amu\r');


	-- everything else from now on should be handled through handle_mi
end
