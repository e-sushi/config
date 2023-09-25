vim.keymap.set('n', '<c-t>', '<cmd>Telescope<cr>');
vim.keymap.set('n', '<c-e>', '<cmd>Telescope find_files<cr>');

vim.keymap.set('n', '<c-h>', '<cmd>HopAnywhere<cr>');

vim.keymap.set('t', '<esc>', '<c-\\><c-n>');


vim.keymap.set('n', '<F12>', function() vim.lsp.buf.definition({reuse_win=true}) end);
