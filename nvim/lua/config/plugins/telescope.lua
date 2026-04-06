helper = require("config.plugins.helper")

local configure = function()
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<C-p>", function() builtin.find_files({ hidden = true }) end, {})
    vim.keymap.set("n", "<leader>pg", builtin.git_files, {})
    vim.keymap.set("n", "<leader>ps", function()
        builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end)
end

return {
    spec = { src = helper.gh('nvim-telescope/telescope.nvim') , version = 'v0.2.1' }
    , configure_fn = configure
}

