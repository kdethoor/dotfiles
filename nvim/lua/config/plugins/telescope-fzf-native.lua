helper = require("config.plugins.helper")

local function pack_changed_on_exit(res)
    print("[PackChanged][telescope-fzf-native.nvim][Build error] " .. res.code)
    print("[PackChanged][telescope-fzf-native.nvim][Build stdout] " .. res.stdout)
    print("[PackChanged][telescope-fzf-native.nvim][Build stderr] " .. res.stderr)
end
vim.api.nvim_create_autocmd("PackChanged", {
    group = vim.api.nvim_create_augroup("telescope-fzf-native-nvim-build", { clear = true }),
    callback = function(ev)
        local name = ev.data.spec.name
        local kind = ev.data.kind
        if (name == "telescope-fzf-native.nvim") and (kind == "install" or kind == "update") then
            vim.system({ "powershell.exe"
                , "(cmake -S. -Bbuild)"
                , "-And"
                , "(cmake --build build --config Release --target install)"
            }, { cwd = ev.data.path }, pack_changed_on_exit)
        end
    end,
})

local configure = function()
    require("telescope").load_extension("fzf")
end

return {
    spec = {
        src = helper.gh("nvim-telescope/telescope-fzf-native.nvim")
        , version = "6fea601bd2b694c6f2ae08a6c6fab14930c60e2c"
    }
    , configure_fn = configure
}

