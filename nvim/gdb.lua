local gdbwin = nil;
local gdbbuf = nil;
local gdbpty = nil;

local ptywin = nil;
local ptybuf = nil;
local ptypty = nil;

local srcwin = nil;
local srcbuf = nil;

local compty = nil;

-- id used by the CurrentLine sign
local linesign = 101;

function load_highlights_and_things() 
	vim.cmd('highlight GdbCurrentLine guibg=#3e3e3e');
	vim.cmd('sign define GdbCurrentLine linehl=GdbCurrentLine');
end

function string.starts_with(s, start)
	return string.sub(s, 1, #start) == start
end

function get_fullname(s)
	local fullname_start, fullname_end = vim.regex('fullname=".\\{-}"'):match_str(s);
	if fullname_start == nil then
		return nil;
	end
	return s:sub(fullname_start+#'fullname=" ', fullname_end-1);
end

function get_line(s)
	local line_start, line_end = vim.regex('line=".\\{-}"'):match_str(s);
	return s:sub(line_start+#'line=" ', line_end-1);
end

function handle_cursormove(s)
	local path = get_fullname(s);
	if path == nil then
		return;
	end
	
	local buf = vim.fn.bufadd(path);
	vim.fn.bufload(buf);
	vim.api.nvim_win_set_buf(srcwin, buf);
	
	local line = get_line(s);

	vim.cmd('sign unplace '..linesign);
	vim.cmd('sign place '..linesign..' line='..line..' name=GdbCurrentLine file='..path);
	
	vim.api.nvim_set_current_win(srcwin);
	vim.fn.winrestview({lnum = line});
	vim.api.nvim_set_current_win(gdbwin);
end

-- handle the creation of a new breakpoint
function handle_new_breakpoint(s)
	
end

local handler_table = {
	["*stopped"] = handle_cursormove,
	["*running"] = handle_cursormove,
	["=thread-selected"] = handle_cursormove,
}

local mi_lines = {''};
function handle_mi(chan_id, data, name)
	for _,s in ipairs(data) do
		for i=1,#s do
			local c = s:sub(i,i);
			if c == '\r' then
				table.insert(mi_lines, '');
			else
				mi_lines[#mi_lines]	= mi_lines[#mi_lines] .. c;
			end
		end
	end

	if #mi_lines > 1 then
		for i,l in ipairs(mi_lines) do
			if i == #mi_lines then
				break;
			end
			
			-- for debug, but freezes up for some reason
			-- vim.fn.chansend(ptypty, l .. '\n');
			
			if l:sub(1,1) == '*' or l:sub(1,1) == '=' then
				l = l:sub(2, -1);
				vim.print(l);
				if string.starts_with(l, "stopped") or string.starts_with(l, "thread-selected") then
					handle_cursormove(l);
				end
			end
		end
	end
end

-- this assumes that the starting layout is a single window
function start_gdb()
	if gdbwin ~= nil then
		vim.notify("can't open more than one gdb session");
		return
	end

	srcwin = vim.api.nvim_get_current_win();
	srcbuf = vim.api.nvim_win_get_buf(srcwin);
	
	vim.cmd("vnew");
	
	local layout = vim.fn.winlayout();

	vim.api.nvim_set_current_win(layout[2][2][2]);

	vim.cmd("new");

	layout = vim.fn.winlayout();

	local row = layout[2];
	local left = row[1];
	local right = row[2];

	local col = right[2];
	local top = col[1];
	local bot = col[2];

	srcwin = left[2];
	gdbwin = bot[2];
	ptywin = top[2];

	ptybuf = vim.api.nvim_create_buf(false, false);
	vim.api.nvim_set_current_win(ptywin);
	vim.api.nvim_win_set_buf(ptywin, ptybuf);
	vim.api.nvim_set_current_buf(ptybuf);
	ptypty = vim.fn.termopen('sleep 15d', {
		detach = true,
	});

	-- a hidden job that's used to communicate with 
	-- gdb through its MI interface
	compty = vim.fn.jobstart('sleep 15d', {
		pty = true,
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
		"-tty", vim.api.nvim_get_chan_info(ptypty)['pty'],
	};

	vim.print(vim.api.nvim_get_chan_info(ptypty)['pty'])

	gdbbuf = vim.api.nvim_create_buf(false, false);
	vim.api.nvim_win_set_buf(gdbwin, gdbbuf);
	vim.api.nvim_set_current_win(gdbwin);
	vim.api.nvim_set_current_buf(gdbbuf);
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

	load_highlights_and_things();

	-- everything else from now on should be handled through handle_mi
end
