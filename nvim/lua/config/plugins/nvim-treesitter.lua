helper = require("config.plugins.helper")

local configure = function()
    local treesitter = require("nvim-treesitter")

    -- Language installation 
    local languages = { "cpp", "lua", "c_sharp" }
    treesitter.install(languages)

    -- Auto enable setup
    vim.api.nvim_create_autocmd("FileType", {
        desc = "Auto-enable Treesitter",
        group = vim.api.nvim_create_augroup("enable_treesitter", {}),
        callback = function(event)
            local bufnr = event.buf
            local lsp_handled_ft = { "cpp" }
            local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
            local start_ts = function()
                vim.treesitter.start(bufnr, parser_name)
                if not vim.tbl_contains(lsp_handled_ft, filetype) then
                    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                    vim.wo.foldmethod = 'expr'
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end
            end

            if filetype == "" then
                return
            end

            local parser_name = vim.treesitter.language.get_lang(filetype)
            if not parser_name then
                vim.bo[bufnr].syntax = "ON"
                return
            end

            local ts_config = require("nvim-treesitter.config")
            if not vim.tbl_contains(ts_config.get_installed("parsers"), parser_name) then
                vim.bo[bufnr].syntax = "ON"
                return
            end

            start_ts()
        end,
    })

    -- Utils
    vim.api.nvim_create_user_command("TSUtilStart"
        , function() vim.treesitter.start() end
        , {}
    )

    vim.api.nvim_create_user_command("TSUtilStop"
        , function() vim.treesitter.stop() end
        , {}
    )

end

return {
    spec = { src = helper.gh('nvim-treesitter/nvim-treesitter'), version = '972f378653c794b0ff82282a844732695064b70f' }
    , configure_fn = configure
}

