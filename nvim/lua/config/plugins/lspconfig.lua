helper = require("config.plugins.helper")

local configure = function()
    -- Key configuration
    vim.keymap.set("n", "<leader>lk", function() vim.diagnostic.open_float() end)
    vim.keymap.set("n", "<leader>l]", function() vim.diagnostic.goto_next() end)
    vim.keymap.set("n", "<leader>l[", function() vim.diagnostic.goto_prev() end)
    vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.references() end)
    vim.keymap.set("n", "<leader>ln", function() vim.lsp.buf.rename() end)
    vim.keymap.set("n", "<leader>lh", function() vim.lsp.buf.signature_help() end)
    vim.keymap.set("n", "<leader>lm", function() vim.lsp.buf.document_symbol() end)

    -- Tweak time for highlights
    vim.opt.updatetime = 250

    -- Enable clangd
    vim.lsp.enable("clangd")
end

return {
    spec = { src = helper.gh("neovim/nvim-lspconfig"), version = "v2.7.0" }
    , configure_fn = configure
}



