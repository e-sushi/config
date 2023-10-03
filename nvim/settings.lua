-- enable 24-bit color in the terminal
-- highlights use 'gui' colors instead of 
-- 'tui' now
vim.opt.termguicolors = true;

-- enable line numbers
vim.opt.number = true;

-- don't allow 'signs' in the column left of line numbers
-- for whatever reason vim makes the gutter appear when there
-- are signs in it and disappear when there aren't, which is really
-- annoying.
vim.opt.signcolumn = "no";

-- make tabs 4 spaces
vim.o.tabstop = 4;
vim.o.shiftwidth = 4;

-- don't wrap
vim.opt.wrap = false;

-- sets auto c indentation to indent according to the statement after a
-- case rather than whatever stupid thing it does by default
vim.cmd("set cinoptions=l1");

-- disable swapfiles so i stop getting that silly message when i edit
-- files in different instances of nvim
-- this might be a bad idea.
vim.cmd("set noswapfile");

-- colors

vim.cmd("colorscheme kanagawa-dragon");
vim.cmd("highlight Normal guibg=#000000")

-- setup diagnostic colors
vim.cmd("highlight DiagnosticSignError guifg=#e82424 guibg=#000000");
vim.cmd("highlight DiagnosticSignWarn guifg=#ff9e3b guibg=#000000");
vim.cmd("highlight DiagnosticSignInfo guifg=#658594 guibg=#000000");
vim.cmd("highlight DiagnosticSignHint guifg=#6a9589 guibg=#000000");

-- highlight line numbers to match diagnostics
vim.cmd("sign define DiagnosticSignError numhl=DiagnosticSignError")
vim.cmd("sign define DiagnosticSignWarn numhl=DiagnosticSignWarn")
vim.cmd("sign define DiagnosticsSignInfo numhl=DiagnosticsSignInfo")
vim.cmd("sign define DiagnosticSignHint numhl=DiagnosticSignHint")

-- color theme
-- for cpp
-- the pallete im using is BLK NEO
vim.cmd('highlight @lsp.type.class.cpp guifg=#ffcb68');
vim.cmd('highlight @lsp.type.type.cpp guifg=#ffcb68');
vim.cmd('highlight @lsp.typemod.function.classScope.cpp guifg=#3e83a1');
vim.cmd('highlight @lsp.type.function.cpp guifg=#3e83a1');
vim.cmd('highlight @keyword.return.cpp guifg=#14665b');
vim.cmd('highlight @conditional.cpp guifg=#14665b');
vim.cmd('highlight @repeat.cpp guifg=#14665b');
vim.cmd('highlight @boolean.cpp guifg=#52dc90');
vim.cmd('highlight @lsp.type.macro.cpp guifg=#ff0000');
vim.cmd('highlight @namespace.cpp guifg=#50b9eb');
vim.cmd('highlight @lsp.typemod.enumMember.globalScope.cpp guifg=#22896e');
vim.cmd('highlight @define.cpp guifg=#5c5c5c');
vim.cmd('highlight @include.cpp guifg=#5c5c5c');
vim.cmd('highlight @lsp.type.method.cpp guifg=#3e83a1');
vim.cmd('highlight @string.cpp guifg=#c3e88d');
vim.cmd('highlight @lsp.type.variable.cpp guifg=#8cdd9b');
vim.cmd('highlight @lsp.type.property.cpp guifg=#008782');
vim.cmd('highlight @string.escape.cpp guifg=#78fae6');
vim.cmd('highlight @number.cpp guifg=#ff695a');
vim.cmd('highlight @comment.cpp guifg=#666666');
vim.cmd('highlight @lsp.typemod.function.globalScope.cpp guifg=#3e83a1')
vim.cmd('highlight @keyword.cpp guifg=#14665b');
vim.cmd('highlight @lsp.type.enumMember.cpp guifg=#22896e');

-- ui colors
vim.cmd('highlight LineNr guifg=#aaaaaa guibg=#000000');

-- git signs colors
vim.cmd('highlight GitSignsAdd guibg=#000000');
vim.cmd('highlight GitSignsChange guibg=#000000');
vim.cmd('highlight GitSignsDelete guibg=#000000');


