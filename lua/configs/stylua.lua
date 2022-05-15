local lsp_config = require("lspconfig")
lsp_config.sumneko_lua.setup({
    commands = {
      Format = {
        function()
          require("stylua-nvim").format_file()
        end,
      },
    },
    ...
})
