-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/mortenclaussen/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/mortenclaussen/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/mortenclaussen/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/mortenclaussen/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/mortenclaussen/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  LuaSnip = {
    config = { "\27LJ\2\n√\1\0\0\5\0\t\0\0176\0\0\0'\2\1\0B\0\2\0029\1\2\0'\3\3\0005\4\4\0B\1\3\0019\1\2\0'\3\5\0005\4\6\0B\1\3\0016\1\0\0'\3\a\0B\1\2\0029\1\b\1B\1\1\1K\0\1\0\14lazy_load luasnip/loaders/from_vscode\1\2\0\0\thtml\20typescriptreact\1\2\0\0\thtml\20javascriptreact\20filetype_extend\fluasnip\frequire\0" },
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["bufdelete.nvim"] = {
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/bufdelete.nvim",
    url = "https://github.com/famiu/bufdelete.nvim"
  },
  ["bufferline.nvim"] = {
    config = { "\27LJ\2\n\31\0\4\a\0\2\0\5'\4\0\0\18\5\0\0'\6\1\0&\4\6\4L\4\2\0\6)\6(÷\3\1\0\6\0\f\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\n\0005\3\3\0005\4\4\0=\4\5\0034\4\3\0005\5\6\0>\5\1\4=\4\a\0033\4\b\0=\4\t\3=\3\v\2B\0\2\1K\0\1\0\foptions\1\0\0\26diagnostics_indicator\0\foffsets\1\0\4\15text_align\tleft\rfiletype\rNvimTree\ttext\18File Explorer\14separator\1\14indicator\1\0\1\ticon\b‚ñé\1\0\n!diagnostics_update_in_insert\1\23left_mouse_command\14buffer %d\24right_mouse_command\16bdelete! %d\18close_command\16bdelete! %d\23right_trunc_marker\bÔÇ©\22left_trunc_marker\bÔÇ®\15close_icon\bÔÄç\22buffer_close_icon\bÔÄç\16diagnostics\bcoc\20separator_style\tthin\nsetup\15bufferline\frequire\0" },
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/bufferline.nvim",
    url = "https://github.com/akinsho/bufferline.nvim"
  },
  catppuccin = {
    config = { "\27LJ\2\n∆\4\0\0\a\0!\00036\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0006\4\5\0009\4\6\0049\4\a\4'\6\b\0B\4\2\2'\5\t\0&\4\5\4=\4\n\3=\3\v\0025\3\f\0=\3\r\0025\3\15\0005\4\14\0=\4\16\0035\4\17\0=\4\18\0034\4\0\0=\4\19\0034\4\0\0=\4\20\0034\4\0\0=\4\21\0034\4\0\0=\4\22\0034\4\0\0=\4\23\0034\4\0\0=\4\24\0034\4\0\0=\4\25\0034\4\0\0=\4\26\0034\4\0\0=\4\27\0034\4\0\0=\4\28\3=\3\29\0024\3\0\0=\3\30\0024\3\0\0=\3\31\0024\3\0\0=\3 \2B\0\2\1K\0\1\0\24highlight_overrides\20color_overrides\17integrations\vstyles\14operators\ntypes\15properties\rbooleans\fnumbers\14variables\fstrings\rkeywords\14functions\nloops\17conditionals\1\2\0\0\vitalic\rcomments\1\0\0\1\2\0\0\vitalic\17dim_inactive\1\0\3\nshade\tdark\15percentage\4≥ÊÃô\3≥Êå˛\3\fenabled\1\fcompile\tpath\16/catppuccin\ncache\fstdpath\afn\bvim\1\0\1\fenabled\1\1\0\2\16term_colors\1\27transparent_background\1\nsetup\15catppuccin\frequire\0" },
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/catppuccin",
    url = "https://github.com/catppuccin/nvim"
  },
  ["cellular-automaton.nvim"] = {
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/cellular-automaton.nvim",
    url = "https://github.com/eandrju/cellular-automaton.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["copilot-cmp"] = {
    config = { "\27LJ\2\n=\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\16copilot_cmp\frequire\0" },
    load_after = {
      ["copilot.lua"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/opt/copilot-cmp",
    url = "https://github.com/zbirenbaum/copilot-cmp"
  },
  ["copilot.lua"] = {
    after = { "copilot-cmp" },
    config = { "\27LJ\2\n\127\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\3\0005\4\4\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\15suggestion\1\0\0\vkeymap\1\0\1\vaccept\n<C-e>\1\0\1\17auto_trigger\2\nsetup\fcopilot\frequire-\1\0\4\0\3\0\0066\0\0\0009\0\1\0003\2\2\0)\3d\0B\0\3\1K\0\1\0\0\rdefer_fn\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/opt/copilot.lua",
    url = "https://github.com/zbirenbaum/copilot.lua"
  },
  ["dashboard-nvim"] = {
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/dashboard-nvim",
    url = "https://github.com/glepnir/dashboard-nvim"
  },
  everforest = {
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/everforest",
    url = "https://github.com/sainnhe/everforest"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n⁄\a\0\0\5\0\24\0\0276\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\14\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\0035\4\n\0=\4\v\0035\4\f\0=\4\r\3=\3\15\0025\3\16\0=\3\17\0025\3\18\0=\3\19\0025\3\20\0=\3\21\0025\3\22\0=\3\23\2B\0\2\1K\0\1\0\tyadm\1\0\1\venable\1\19preview_config\1\0\5\vborder\vsingle\bcol\3\1\brow\3\0\rrelative\vcursor\nstyle\fminimal\28current_line_blame_opts\1\0\4\14virt_text\2\ndelay\3–\15\22ignore_whitespace\1\18virt_text_pos\beol\17watch_gitdir\1\0\2\17follow_files\2\rinterval\3Ë\a\nsigns\1\0\n\nnumhl\1\23current_line_blame\2\20max_file_length\3¿∏\2\15signcolumn\2\24attach_to_untracked\2\vlinehl\1\14word_diff\1\20update_debounce\3d\18sign_priority\3\6!current_line_blame_formatter1<author>, <author_time:%Y-%m-%d> - <summary>\17changedelete\1\0\4\ahl\19GitSignsChange\vlinehl\21GitSignsChangeLn\ttext\6~\nnumhl\21GitSignsChangeNr\14topdelete\1\0\4\ahl\19GitSignsDelete\vlinehl\21GitSignsDeleteLn\ttext\b‚Äæ\nnumhl\21GitSignsDeleteNr\vdelete\1\0\4\ahl\19GitSignsDelete\vlinehl\21GitSignsDeleteLn\ttext\6_\nnumhl\21GitSignsDeleteNr\vchange\1\0\4\ahl\19GitSignsChange\vlinehl\21GitSignsChangeLn\ttext\b‚îÇ\nnumhl\21GitSignsChangeNr\badd\1\0\0\1\0\4\ahl\16GitSignsAdd\vlinehl\18GitSignsAddLn\ttext\b‚îÇ\nnumhl\18GitSignsAddNr\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["gruvbox-material"] = {
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/gruvbox-material",
    url = "https://github.com/sainnhe/gruvbox-material"
  },
  ["gruvbox.nvim"] = {
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/gruvbox.nvim",
    url = "https://github.com/ellisonleao/gruvbox.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\n[\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\25show_current_context\2\nsetup\21indent_blankline\frequire\0" },
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["lightspeed.nvim"] = {
    config = { "\27LJ\2\nL\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\16ignore_case\2\nsetup\15lightspeed\frequire\0" },
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/lightspeed.nvim",
    url = "https://github.com/ggandor/lightspeed.nvim"
  },
  ["lspkind.nvim"] = {
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/lspkind.nvim",
    url = "https://github.com/onsails/lspkind.nvim"
  },
  ["lspsaga.nvim"] = {
    config = { "\27LJ\2\n÷\1\0\0\5\0\n\0\r6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\3B\1\2\1K\0\1\0\27definition_action_keys\1\0\1\tedit\t<CR>\23finder_action_keys\1\0\1\topen\t<CR>\26code_action_lightbulb\1\0\1\venable\1\1\0\1\17border_style\frounded\18init_lsp_saga\flspsaga\frequire\0" },
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/lspsaga.nvim",
    url = "https://github.com/glepnir/lspsaga.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\nå\3\0\0\5\0\24\0%6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\16\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\0035\4\n\0=\4\v\0035\4\f\0=\4\r\0035\4\14\0=\4\15\3=\3\17\0025\3\18\0004\4\0\0=\4\5\0034\4\0\0=\4\a\0035\4\19\0=\4\t\0035\4\20\0=\4\v\0034\4\0\0=\4\r\0034\4\0\0=\4\15\3=\3\21\0025\3\22\0=\3\23\2B\0\2\1K\0\1\0\15extensions\1\2\0\0\14nvim-tree\22inactive_sections\1\2\0\0\rlocation\1\2\0\0\rfilename\1\0\0\rsections\1\0\0\14lualine_z\1\2\0\0\rlocation\14lualine_y\1\2\0\0\rprogress\14lualine_x\1\2\0\0\rfiletype\14lualine_c\1\2\0\0\rfilename\14lualine_b\1\2\0\0\vbranch\14lualine_a\1\0\0\1\2\0\0\tmode\nsetup\flualine\frequire\0" },
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["markdown-preview.nvim"] = {
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/markdown-preview.nvim",
    url = "https://github.com/iamcco/markdown-preview.nvim"
  },
  ["mason-lspconfig"] = {
    config = {},
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/mason-lspconfig",
    url = "https://github.com/williamboman/mason-lspconfig"
  },
  ["mason-null-ls.nvim"] = {
    config = {},
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/mason-null-ls.nvim",
    url = "https://github.com/jayp0521/mason-null-ls.nvim"
  },
  ["mason.nvim"] = {
    config = {},
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["noice.nvim"] = {
    config = { "\27LJ\2\n3\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\nnoice\frequire\0" },
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/noice.nvim",
    url = "https://github.com/folke/noice.nvim"
  },
  ["nui.nvim"] = {
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  ["null-ls.nvim"] = {
    config = { "\27LJ\2\n÷\1\0\0\a\0\v\0\0306\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\t\0004\3\4\0006\4\0\0'\6\1\0B\4\2\0029\4\3\0049\4\4\0049\4\5\4>\4\1\0036\4\0\0'\6\1\0B\4\2\0029\4\3\0049\4\4\0049\4\6\4>\4\2\0036\4\0\0'\6\1\0B\4\2\0029\4\3\0049\4\a\0049\4\b\4>\4\3\3=\3\n\2B\0\2\1K\0\1\0\fsources\1\0\0\nspell\15completion\14prettierd\vstylua\15formatting\rbuiltins\nsetup\fnull-ls\frequire\0" },
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\nt\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\21disable_filetype\1\0\0\1\3\0\0\20TelescopePrompt\bvim\nsetup\19nvim-autopairs\frequire\0" },
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-comment"] = {
    config = { "\27LJ\2\n^\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\2K\0\1\0\25update_commentstring&ts_context_commentstring.internal\frequireO\1\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0003\3\3\0=\3\5\2B\0\2\1K\0\1\0\thook\1\0\0\0\nsetup\17nvim_comment\frequire\0" },
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/nvim-comment",
    url = "https://github.com/terrortylor/nvim-comment"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-notify"] = {
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/nvim-notify",
    url = "https://github.com/rcarriga/nvim-notify"
  },
  ["nvim-surround"] = {
    config = { "\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18nvim-surround\frequire\0" },
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/nvim-surround",
    url = "https://github.com/kylechui/nvim-surround"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\n©\2\0\0\a\0\18\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0005\4\6\0004\5\3\0005\6\5\0>\6\1\5=\5\a\4=\4\b\3=\3\t\0025\3\n\0=\3\v\0025\3\f\0=\3\r\0025\3\15\0005\4\14\0=\4\16\3=\3\17\2B\0\2\1K\0\1\0\ffilters\vcustom\1\0\0\1\3\0\0\17node_modules\14.DS_STORE\rrenderer\1\0\1\16group_empty\2\bgit\1\0\1\vignore\1\tview\rmappings\tlist\1\0\0\1\0\2\vaction\vdir_up\bkey\6u\1\0\1\18adaptive_size\2\1\0\1\fsort_by\19case_sensitive\nsetup\14nvim-tree\frequire\0" },
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\ní\5\0\0\a\0\27\0 6\0\0\0'\2\1\0B\0\2\0025\1\3\0=\1\2\0006\0\0\0'\2\4\0B\0\2\0029\0\5\0005\2\a\0005\3\6\0=\3\b\0025\3\t\0=\3\n\0025\3\v\0=\3\f\0025\3\r\0=\3\14\0025\3\24\0005\4\15\0005\5\17\0005\6\16\0=\6\18\5=\5\19\0045\5\21\0005\6\20\0=\6\22\5=\5\23\4=\4\25\3=\3\26\2B\0\2\1K\0\1\0\16textobjects\tswap\1\0\0\18swap_previous\6<\1\0\0\1\3\0\0\21@parameter.inner\20@function.outer\14swap_next\6>\1\0\0\1\3\0\0\21@parameter.inner\20@function.outer\1\0\1\venable\2\14highlight\1\0\2\venable\2&additional_vim_regex_highlighting\1\vindent\1\0\1\venable\2\26context_commentstring\1\0\2\venable\2\19enable_autocmd\1\21ensure_installed\1\0\1\17sync_install\2\1\25\0\0\blua\bvim\ago\trust\15typescript\15javascript\njsdoc\bcss\thttp\tscss\thtml\15dockerfile\ngomod\vgowork\tjson\njson5\tyaml\vkotlin\bphp\vpython\nregex\vsvelte\ttoml\btsx\nsetup\28nvim-treesitter.configs\1\2\0\0\bgcc\14compilers\28nvim-treesitter.install\frequire\0" },
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-context"] = {
    config = { "\27LJ\2\nπ\1\0\0\5\0\t\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\5\0005\4\4\0=\4\6\3=\3\a\0024\3\0\0=\3\b\2B\0\2\1K\0\1\0\19exact_patterns\rpatterns\fdefault\1\0\0\1\4\0\0\nclass\rfunction\vmethod\1\0\3\venable\2\14max_lines\3\0\vzindex\3\20\nsetup\23treesitter-context\frequire\0" },
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/nvim-treesitter-context",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-context"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-ts-autotag"] = {
    config = { "\27LJ\2\n=\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\20nvim-ts-autotag\frequire\0" },
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/nvim-ts-autotag",
    url = "https://github.com/windwp/nvim-ts-autotag"
  },
  ["nvim-ts-context-commentstring"] = {
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/nvim-ts-context-commentstring",
    url = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["stylua-nvim"] = {
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/stylua-nvim",
    url = "https://github.com/ckipp01/stylua-nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\nÛ\1\0\0\5\0\n\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\2B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\b\0'\2\5\0B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\b\0'\2\t\0B\0\2\1K\0\1\0\nnoice\19load_extension\15extensions\1\0\0\bfzf\1\0\0\1\0\4\25override_file_sorter\2\28override_generic_sorter\2\nfuzzy\2\14case_mode\15smart_case\nsetup\14telescope\frequire\0" },
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  ["typescript.nvim"] = {
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/typescript.nvim",
    url = "https://github.com/jose-elias-alvarez/typescript.nvim"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/mortenclaussen/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: LuaSnip
time([[Config for LuaSnip]], true)
try_loadstring("\27LJ\2\n√\1\0\0\5\0\t\0\0176\0\0\0'\2\1\0B\0\2\0029\1\2\0'\3\3\0005\4\4\0B\1\3\0019\1\2\0'\3\5\0005\4\6\0B\1\3\0016\1\0\0'\3\a\0B\1\2\0029\1\b\1B\1\1\1K\0\1\0\14lazy_load luasnip/loaders/from_vscode\1\2\0\0\thtml\20typescriptreact\1\2\0\0\thtml\20javascriptreact\20filetype_extend\fluasnip\frequire\0", "config", "LuaSnip")
time([[Config for LuaSnip]], false)
-- Config for: lspsaga.nvim
time([[Config for lspsaga.nvim]], true)
try_loadstring("\27LJ\2\n÷\1\0\0\5\0\n\0\r6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\3B\1\2\1K\0\1\0\27definition_action_keys\1\0\1\tedit\t<CR>\23finder_action_keys\1\0\1\topen\t<CR>\26code_action_lightbulb\1\0\1\venable\1\1\0\1\17border_style\frounded\18init_lsp_saga\flspsaga\frequire\0", "config", "lspsaga.nvim")
time([[Config for lspsaga.nvim]], false)
-- Config for: mason.nvim
time([[Config for mason.nvim]], true)
time([[Config for mason.nvim]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\nå\3\0\0\5\0\24\0%6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\16\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\0035\4\n\0=\4\v\0035\4\f\0=\4\r\0035\4\14\0=\4\15\3=\3\17\0025\3\18\0004\4\0\0=\4\5\0034\4\0\0=\4\a\0035\4\19\0=\4\t\0035\4\20\0=\4\v\0034\4\0\0=\4\r\0034\4\0\0=\4\15\3=\3\21\0025\3\22\0=\3\23\2B\0\2\1K\0\1\0\15extensions\1\2\0\0\14nvim-tree\22inactive_sections\1\2\0\0\rlocation\1\2\0\0\rfilename\1\0\0\rsections\1\0\0\14lualine_z\1\2\0\0\rlocation\14lualine_y\1\2\0\0\rprogress\14lualine_x\1\2\0\0\rfiletype\14lualine_c\1\2\0\0\rfilename\14lualine_b\1\2\0\0\vbranch\14lualine_a\1\0\0\1\2\0\0\tmode\nsetup\flualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n⁄\a\0\0\5\0\24\0\0276\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\14\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\0035\4\n\0=\4\v\0035\4\f\0=\4\r\3=\3\15\0025\3\16\0=\3\17\0025\3\18\0=\3\19\0025\3\20\0=\3\21\0025\3\22\0=\3\23\2B\0\2\1K\0\1\0\tyadm\1\0\1\venable\1\19preview_config\1\0\5\vborder\vsingle\bcol\3\1\brow\3\0\rrelative\vcursor\nstyle\fminimal\28current_line_blame_opts\1\0\4\14virt_text\2\ndelay\3–\15\22ignore_whitespace\1\18virt_text_pos\beol\17watch_gitdir\1\0\2\17follow_files\2\rinterval\3Ë\a\nsigns\1\0\n\nnumhl\1\23current_line_blame\2\20max_file_length\3¿∏\2\15signcolumn\2\24attach_to_untracked\2\vlinehl\1\14word_diff\1\20update_debounce\3d\18sign_priority\3\6!current_line_blame_formatter1<author>, <author_time:%Y-%m-%d> - <summary>\17changedelete\1\0\4\ahl\19GitSignsChange\vlinehl\21GitSignsChangeLn\ttext\6~\nnumhl\21GitSignsChangeNr\14topdelete\1\0\4\ahl\19GitSignsDelete\vlinehl\21GitSignsDeleteLn\ttext\b‚Äæ\nnumhl\21GitSignsDeleteNr\vdelete\1\0\4\ahl\19GitSignsDelete\vlinehl\21GitSignsDeleteLn\ttext\6_\nnumhl\21GitSignsDeleteNr\vchange\1\0\4\ahl\19GitSignsChange\vlinehl\21GitSignsChangeLn\ttext\b‚îÇ\nnumhl\21GitSignsChangeNr\badd\1\0\0\1\0\4\ahl\16GitSignsAdd\vlinehl\18GitSignsAddLn\ttext\b‚îÇ\nnumhl\18GitSignsAddNr\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: catppuccin
time([[Config for catppuccin]], true)
try_loadstring("\27LJ\2\n∆\4\0\0\a\0!\00036\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0006\4\5\0009\4\6\0049\4\a\4'\6\b\0B\4\2\2'\5\t\0&\4\5\4=\4\n\3=\3\v\0025\3\f\0=\3\r\0025\3\15\0005\4\14\0=\4\16\0035\4\17\0=\4\18\0034\4\0\0=\4\19\0034\4\0\0=\4\20\0034\4\0\0=\4\21\0034\4\0\0=\4\22\0034\4\0\0=\4\23\0034\4\0\0=\4\24\0034\4\0\0=\4\25\0034\4\0\0=\4\26\0034\4\0\0=\4\27\0034\4\0\0=\4\28\3=\3\29\0024\3\0\0=\3\30\0024\3\0\0=\3\31\0024\3\0\0=\3 \2B\0\2\1K\0\1\0\24highlight_overrides\20color_overrides\17integrations\vstyles\14operators\ntypes\15properties\rbooleans\fnumbers\14variables\fstrings\rkeywords\14functions\nloops\17conditionals\1\2\0\0\vitalic\rcomments\1\0\0\1\2\0\0\vitalic\17dim_inactive\1\0\3\nshade\tdark\15percentage\4≥ÊÃô\3≥Êå˛\3\fenabled\1\fcompile\tpath\16/catppuccin\ncache\fstdpath\afn\bvim\1\0\1\fenabled\1\1\0\2\16term_colors\1\27transparent_background\1\nsetup\15catppuccin\frequire\0", "config", "catppuccin")
time([[Config for catppuccin]], false)
-- Config for: mason-null-ls.nvim
time([[Config for mason-null-ls.nvim]], true)
time([[Config for mason-null-ls.nvim]], false)
-- Config for: nvim-surround
time([[Config for nvim-surround]], true)
try_loadstring("\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18nvim-surround\frequire\0", "config", "nvim-surround")
time([[Config for nvim-surround]], false)
-- Config for: lightspeed.nvim
time([[Config for lightspeed.nvim]], true)
try_loadstring("\27LJ\2\nL\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\16ignore_case\2\nsetup\15lightspeed\frequire\0", "config", "lightspeed.nvim")
time([[Config for lightspeed.nvim]], false)
-- Config for: mason-lspconfig
time([[Config for mason-lspconfig]], true)
time([[Config for mason-lspconfig]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\n©\2\0\0\a\0\18\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0005\4\6\0004\5\3\0005\6\5\0>\6\1\5=\5\a\4=\4\b\3=\3\t\0025\3\n\0=\3\v\0025\3\f\0=\3\r\0025\3\15\0005\4\14\0=\4\16\3=\3\17\2B\0\2\1K\0\1\0\ffilters\vcustom\1\0\0\1\3\0\0\17node_modules\14.DS_STORE\rrenderer\1\0\1\16group_empty\2\bgit\1\0\1\vignore\1\tview\rmappings\tlist\1\0\0\1\0\2\vaction\vdir_up\bkey\6u\1\0\1\18adaptive_size\2\1\0\1\fsort_by\19case_sensitive\nsetup\14nvim-tree\frequire\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: noice.nvim
time([[Config for noice.nvim]], true)
try_loadstring("\27LJ\2\n3\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\nnoice\frequire\0", "config", "noice.nvim")
time([[Config for noice.nvim]], false)
-- Config for: nvim-comment
time([[Config for nvim-comment]], true)
try_loadstring("\27LJ\2\n^\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\2K\0\1\0\25update_commentstring&ts_context_commentstring.internal\frequireO\1\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0003\3\3\0=\3\5\2B\0\2\1K\0\1\0\thook\1\0\0\0\nsetup\17nvim_comment\frequire\0", "config", "nvim-comment")
time([[Config for nvim-comment]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\ní\5\0\0\a\0\27\0 6\0\0\0'\2\1\0B\0\2\0025\1\3\0=\1\2\0006\0\0\0'\2\4\0B\0\2\0029\0\5\0005\2\a\0005\3\6\0=\3\b\0025\3\t\0=\3\n\0025\3\v\0=\3\f\0025\3\r\0=\3\14\0025\3\24\0005\4\15\0005\5\17\0005\6\16\0=\6\18\5=\5\19\0045\5\21\0005\6\20\0=\6\22\5=\5\23\4=\4\25\3=\3\26\2B\0\2\1K\0\1\0\16textobjects\tswap\1\0\0\18swap_previous\6<\1\0\0\1\3\0\0\21@parameter.inner\20@function.outer\14swap_next\6>\1\0\0\1\3\0\0\21@parameter.inner\20@function.outer\1\0\1\venable\2\14highlight\1\0\2\venable\2&additional_vim_regex_highlighting\1\vindent\1\0\1\venable\2\26context_commentstring\1\0\2\venable\2\19enable_autocmd\1\21ensure_installed\1\0\1\17sync_install\2\1\25\0\0\blua\bvim\ago\trust\15typescript\15javascript\njsdoc\bcss\thttp\tscss\thtml\15dockerfile\ngomod\vgowork\tjson\njson5\tyaml\vkotlin\bphp\vpython\nregex\vsvelte\ttoml\btsx\nsetup\28nvim-treesitter.configs\1\2\0\0\bgcc\14compilers\28nvim-treesitter.install\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
try_loadstring("\27LJ\2\n[\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\25show_current_context\2\nsetup\21indent_blankline\frequire\0", "config", "indent-blankline.nvim")
time([[Config for indent-blankline.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\nÛ\1\0\0\5\0\n\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\2B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\b\0'\2\5\0B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\b\0'\2\t\0B\0\2\1K\0\1\0\nnoice\19load_extension\15extensions\1\0\0\bfzf\1\0\0\1\0\4\25override_file_sorter\2\28override_generic_sorter\2\nfuzzy\2\14case_mode\15smart_case\nsetup\14telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
try_loadstring("\27LJ\2\nt\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\21disable_filetype\1\0\0\1\3\0\0\20TelescopePrompt\bvim\nsetup\19nvim-autopairs\frequire\0", "config", "nvim-autopairs")
time([[Config for nvim-autopairs]], false)
-- Config for: nvim-treesitter-context
time([[Config for nvim-treesitter-context]], true)
try_loadstring("\27LJ\2\nπ\1\0\0\5\0\t\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\5\0005\4\4\0=\4\6\3=\3\a\0024\3\0\0=\3\b\2B\0\2\1K\0\1\0\19exact_patterns\rpatterns\fdefault\1\0\0\1\4\0\0\nclass\rfunction\vmethod\1\0\3\venable\2\14max_lines\3\0\vzindex\3\20\nsetup\23treesitter-context\frequire\0", "config", "nvim-treesitter-context")
time([[Config for nvim-treesitter-context]], false)
-- Config for: null-ls.nvim
time([[Config for null-ls.nvim]], true)
try_loadstring("\27LJ\2\n÷\1\0\0\a\0\v\0\0306\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\t\0004\3\4\0006\4\0\0'\6\1\0B\4\2\0029\4\3\0049\4\4\0049\4\5\4>\4\1\0036\4\0\0'\6\1\0B\4\2\0029\4\3\0049\4\4\0049\4\6\4>\4\2\0036\4\0\0'\6\1\0B\4\2\0029\4\3\0049\4\a\0049\4\b\4>\4\3\3=\3\n\2B\0\2\1K\0\1\0\fsources\1\0\0\nspell\15completion\14prettierd\vstylua\15formatting\rbuiltins\nsetup\fnull-ls\frequire\0", "config", "null-ls.nvim")
time([[Config for null-ls.nvim]], false)
-- Config for: bufferline.nvim
time([[Config for bufferline.nvim]], true)
try_loadstring("\27LJ\2\n\31\0\4\a\0\2\0\5'\4\0\0\18\5\0\0'\6\1\0&\4\6\4L\4\2\0\6)\6(÷\3\1\0\6\0\f\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\n\0005\3\3\0005\4\4\0=\4\5\0034\4\3\0005\5\6\0>\5\1\4=\4\a\0033\4\b\0=\4\t\3=\3\v\2B\0\2\1K\0\1\0\foptions\1\0\0\26diagnostics_indicator\0\foffsets\1\0\4\15text_align\tleft\rfiletype\rNvimTree\ttext\18File Explorer\14separator\1\14indicator\1\0\1\ticon\b‚ñé\1\0\n!diagnostics_update_in_insert\1\23left_mouse_command\14buffer %d\24right_mouse_command\16bdelete! %d\18close_command\16bdelete! %d\23right_trunc_marker\bÔÇ©\22left_trunc_marker\bÔÇ®\15close_icon\bÔÄç\22buffer_close_icon\bÔÄç\16diagnostics\bcoc\20separator_style\tthin\nsetup\15bufferline\frequire\0", "config", "bufferline.nvim")
time([[Config for bufferline.nvim]], false)
-- Config for: nvim-ts-autotag
time([[Config for nvim-ts-autotag]], true)
try_loadstring("\27LJ\2\n=\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\20nvim-ts-autotag\frequire\0", "config", "nvim-ts-autotag")
time([[Config for nvim-ts-autotag]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'copilot.lua'}, { event = "VimEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
