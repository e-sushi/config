vim.keymap.set('n', '<c-t>', '<cmd>Telescope<cr>');
vim.keymap.set('n', '<c-e>', '<cmd>Telescope find_files<cr>');

vim.keymap.set('n', '<c-h>', '<cmd>HopChar1<cr>');

vim.keymap.set('t', '<esc>', '<c-\\><c-n>');

vim.keymap.set('n', '<a-w>', '<cmd>w<cr>');

vim.keymap.set('n', '<c-s>', '<cmd>Telescope lsp_document_symbols<cr>');
vim.keymap.set('n', '<a-s>', '<cmd>Telescope lsp_workspace_symbols<cr>');

vim.keymap.set('n', '<F12>', function() vim.lsp.buf.definition({reuse_win=true}) end);

vim.keymap.set('n', '<Up>', "gk");
vim.keymap.set('n', '<Down>', "gj");

vim.keymap.set('n', '<a-h>', vim.lsp.buf.hover);
