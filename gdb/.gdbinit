set auto-load safe-path /
set debuginfod enabled off
set confirm off
set pagination off
set print array on
set print elements 0

set tui tab-width 2
tui enable

tui window height src 20
focus cmd

define hook-stop
	refresh
end



