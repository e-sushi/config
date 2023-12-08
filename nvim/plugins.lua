-- file containing everything to do with aquiring and setting up
-- all plugins that I use
--
-- index:
--     @lazy-setup
--     
--
--
--
--
--

-- @lazy-setup
-- bootstrap lazy.nvim if we need to
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- aquire all the plugins
require("lazy").setup({
	"rebelot/kanagawa.nvim", -- Colortheme

	-- feature-full motions
	"phaazon/hop.nvim",

	-- general fuzzy finder
	{"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},

	-- better command menu
	{"gelguy/wilder.nvim",
		dependencies = {
			-- fuzzy highlighting
			"romgrk/fzy-lua-native",
		}
	},

	-- official (?) treesitter plugin
	"nvim-treesitter/nvim-treesitter",

	-- multicursor support	
	"mg979/vim-visual-multi",

	-- file browser
	"nvim-tree/nvim-tree.lua",

	-- starter lsp config stuff
	{"neovim/nvim-lspconfig"},

	-- lsp, linter, etc. manager
	{"williamboman/mason.nvim"},

	-- supports for working with lsp config
	{"williamboman/mason-lspconfig.nvim"},

	-- completion plugins that accepts external sources
	{"hrsh7th/nvim-cmp"},

	-- path completion 
	{"hrsh7th/cmp-path"},

	-- lsp symbol and other stuff completion
	{"hrsh7th/cmp-nvim-lsp"},

	-- shows signatures in the docs window thing
	{"hrsh7th/cmp-nvim-lsp-signature-help"},

	-- sets up the lua lang server to work with these config files
	{"folke/neodev.nvim"},

	-- automatically create pairs
	"windwp/nvim-autopairs",

	-- tabs 
	{"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim",
			"nvim-tree/nvim-web-devicons",
		}
	},
	
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*"
	},

	-- bind keys to directly move windows around in a sort of i3 fashion
	"sindrets/winshift.nvim",

	-- little pictures in the completion menu
	"onsails/lspkind.nvim",
	
	"akinsho/toggleterm.nvim",	

	"sakhnik/nvim-gdb",

	"nvim-neorg/neorg",

	"NeogitOrg/neogit",

	"folke/which-key.nvim",

	"lewis6991/gitsigns.nvim",

	{"nvim-telescope/telescope-smart-history.nvim",
		dependencies = {
			"kkharji/sqlite.lua"
		}
	},

	"vim-crystal/vim-crystal",

	"tikhomirov/vim-glsl",

	"Jezda1337/nvim-html-css"
});



-- @plugin-setups



-- @hop
local hop = require("hop");
hop.setup({});

-- @winshift
local winshift = require("winshift");
winshift.setup({});

-- @telescope
local telescope = require("telescope");
telescope.setup({
	defaults = {
		-- tries to shorten paths as much as possible
		-- without conflicting with any others
		path_display = "smart",
	},
	pickers = {
		find_files = {
			no_ignore = true,	
		},
	},
});

--require("telescope.builtin").live_grep{
--	attach_mappings = function(_, map) 
--		map("i", "<c-up>", require("telescope.actions").cycle_history_next);
--		map("i", "<c-down>", require("telescope.actions").cycle_history_prev);
--		return true
--	end
--};

-- @wilder
local wilder = require("wilder");
wilder.setup({
	-- shows suggestions in search and cmd modes
	modes = {'/','?',':'}
});


wilder.set_option('renderer', 
	wilder.popupmenu_renderer({
			empty_message = ":(",
			right = {
				wilder.popupmenu_devicons()
			},
			highlighter = wilder.lua_fzy_highlighter({}),
		},
		wilder.popupmenu_border_theme({
			border = {
				'┌','─','',
				'│',    '',
				'', '', ''
			},
		})

	)
);

wilder.set_option('pipeline', {
	wilder.branch(
		wilder.cmdline_pipeline({
			fuzzy = 2,
		}),
		wilder.python_search_pipeline({
			pattern = 'fuzzy',
		})
	),
	
});

-- @treesitter
local treesitter = require("nvim-treesitter.configs");
treesitter.setup({
	-- make sure that these parsers are installed
	ensure_installed = {
		'c', 'cpp', 'lua', 'json'
	},
	
	-- automatically install missing parsers when entering buffers
	auto_install = true,

	highlight = {
		enable = true,
	},
});

-- @vim-visual-multi
-- TODO(sushi)

-- @nvim-tree
-- TODO(sushi)

-- @neodev
local neodev = require("neodev");
neodev.setup({});

-- @mason
local mason = require("mason");
mason.setup({});

local mason_lspconfig = require("mason-lspconfig");
mason_lspconfig.setup({
	ensure_installed = {
		"clangd",
		"lua_ls",
		"jsonls",
	},
});

-- @lspconfig
local lspconfig = require("lspconfig");

lspconfig.lua_ls.setup({});
lspconfig.clangd.setup({
	cmd = {
		"clangd",
		"--log=verbose",
		"-header-insertion=never",
	},


});
lspconfig.jsonls.setup({});
lspconfig.pylsp.setup({
	settings = {
		pylsp = {
			plugins = {
				pycodestyle = {
					enabled = false
				}
			}
		}
	}
});
lspconfig.racket_langserver.setup({});
lspconfig.gopls.setup({});
lspconfig.ruby_ls.setup({
	cmd = {"bundle", "exec", "ruby-lsp"},
	init_options = {
		enabledFeatures = {
			"documentHighlights",
			"documentSymbols",
			"selectionRanges",
			"semanticHighlighting",
			"completion",
		}
	}
});

lspconfig.ocamllsp.setup({});
lspconfig.rust_analyzer.setup({});
lspconfig.phpactor.setup({});
lspconfig.crystalline.setup({
	cmd = {
		"crystalline",
		"--stdio",
		"-v"

	}
})

lspconfig.html.setup({})

-- @lspkind
local lspkind = require("lspkind");

-- @cmp
local cmp = require("cmp");
cmp.setup({
	snippet = {
		-- I HAVE to use a snippet engine because langauge server non-sense whatever man
		expand = function(args)
			require("luasnip").lsp_expand(args.body);
		end
	},
	-- always preselect the first item
	preselect = 'item',
	completion = {
		completeopt = 'menu,menuone,noinsert',
	},
	-- various places to get completion candidates from
	sources = {
		{name = 'nvim_lsp'},
		{name = 'path'},
		{name = 'nvim_lsp_signature_help'},
		{name = 'neorg'},
	},
	mapping = {
		['<s-cr>'] = cmp.mapping.confirm({select = true}),
		['<c-space>'] = cmp.mapping.complete(),
		['<s-up>'] = cmp.mapping.select_prev_item(),
		['<s-down>'] = cmp.mapping.select_next_item(),

	},
	-- put pretty symbols next to candidates
	formatting = {
		format = lspkind.cmp_format({
			mode = 'symbol',
			maxwidth = 50,
			ellipsis_char = '...',
		}),
	},
	-- draw a border around the popups
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
});

-- @autopairs
local autopairs = require("nvim-autopairs");
autopairs.setup({
	enable_check_bracket_line = true,
});

-- @barbar
local barbar = require("barbar");
barbar.setup({
	icons = {
		buffer_number = true,
		-- display various symbols for the git status of a buffer
		gitsigns = {
			added = {enabled = true, icon = '+'},
			changed = {enabled = true, icon = '~'},
			deleted = {enabled = true, icon = '-'},
		},
	},
});

-- @toggleterm
local toggleterm = require("toggleterm");
toggleterm.setup({
	size = 20,
	hide_numbers = true,
});

-- @neorg
local neorg = require("neorg");
neorg.setup({
	load = {
		["core.defaults"] = {},
		["core.concealer"] = {
			config = {
				icons = {
					code_block = {
						conceal = true,
					}
				}
			}
		},
		["core.completion"] = {
			config = {
				engine = "nvim-cmp",
			}
		},
		["core.integrations.nvim-cmp"] = {},
	}
});

-- @neogit
local neogit = require("neogit");
neogit.setup({});

-- @whichkey
local whichkey = require("which-key");
whichkey.setup();

-- @gitsigns
local gitsigns = require("gitsigns");
gitsigns.setup({
	numhl = true,
});

-- @telescope-history


