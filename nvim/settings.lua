-- enable 24-bit color in the terminal
-- highlights use 'gui' colors instead of 
-- 'tui' now
vim.opt.termguicolors = true;

-- enable line numbers
vim.opt.number = true;

-- don't allow 'signs' in the column left of line numbers
vim.opt.signcolumn = "no";

-- make tabs 4 spaces
vim.o.tabstop = 4;
vim.o.shiftwidth = 4;

-- don't wrap
vim.opt.wrap = false;


-- colors

vim.cmd("colorscheme kanagawa-dragon");
vim.cmd("highlight Normal guibg=#000000")

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
vim.cmd('highlight @lsp.type.function.cpp guifg=#3e83a1')
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


