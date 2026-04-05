-- LspAttach
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("clangd", {}),
	callback = function(ev)
		local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
        -- Enable folding
        --vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        if client:supports_method('textDocument/foldingRange') then
            local win = vim.api.nvim_get_current_win()
            vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
            vim.o.foldmethod = 'expr'
        end
		-- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
		if client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
			vim.keymap.set("i", "<c-space>", function() vim.lsp.completion.get() end, { buffer = ev.buf })
			vim.keymap.set({ "i", "s" }, "<Tab>", function()
				if vim.fn.pumvisible() == 1 then
					return "<C-y>"
				elseif vim.snippet.active({ direction = 1 }) then
					return "<cmd>lua vim.snippet.jump(1)<CR>"
				end
				return "<Tab>"
			end, { desc = "Tab auto-completion and snippet nav.", expr = true, silent = true })
		end
		-- Enable on-type formatting and disable treesitter's indent
		vim.lsp.on_type_formatting.enable(true, { client_id = client.id })
		-- Enable inlay hitnts
		vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
        -- Enable document highlights
        if client:supports_method("textDocument/documentHighlight") then
            vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
            vim.api.nvim_clear_autocmds { buffer = bufnr, group = "lsp_document_highlight" }
            vim.api.nvim_create_autocmd("CursorHold", {
                callback = vim.lsp.buf.document_highlight,
                buffer = ev.buf,
                group = "lsp_document_highlight",
                desc = "Document Highlight",
            })
            vim.api.nvim_create_autocmd("CursorMoved", {
                callback = vim.lsp.buf.clear_references,
                buffer = ev.buf,
                group = "lsp_document_highlight",
                desc = "Clear All the References",
            })
        end
		-- Map source-header switch
		vim.keymap.set("n", "<Leader>k", "<cmd>LspClangdSwitchSourceHeader<CR>", { buffer = ev.buf })
	end,
})

-- Config override
return {
	cmd = {
		"clangd"
		, "--completion-style=detailed"
		, "--fallback-style=Microsoft"
	}
}
