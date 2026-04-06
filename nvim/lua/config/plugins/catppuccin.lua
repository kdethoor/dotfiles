helper = require("config.plugins.helper")

local configure = function()
    require("catppuccin").setup({
        integrations = {
            telescope = {
                enabled = true
            }
        }
    })
    vim.cmd.colorscheme("catppuccin-mocha")
end

return {
	spec = { src = helper.gh("catppuccin/nvim"), name = "catppuccin", version = "v2.0.0" }
    , configure_fn = configure
}
