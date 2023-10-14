--
-- function for getting the total usage percentage of the CPU
-- as well as the usage of each core
--

local tbl = require("pl.tablex");
local seq = require("pl.seq");

local get = function(interval) 
	local stat = function()	
		local cpus = {};
		for l in io.lines("/proc/stat") do
			if not l:startswith("cpu") then break end;
			table.insert(cpus,
				seq.map(tbl.sub(l:gmatch("%S+"), 2), tonumber));
		end
	end

	local stat0 = stat();
	os.execute("sleep 0.1");
	local stat1 = stat();

	local diffs = seq.map(seq.zip(stat1, stat0),
		function(x)
			return x[1] - x[0];
		end);

	

end
