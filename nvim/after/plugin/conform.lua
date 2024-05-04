local success, conform = pcall(require, "conform")

if not success then
	return
end

conform.setup({
	formatters_by_ft = {
		python = { "black" }
	}
})

local function format()
	conform.format({ lsp_fallback=true })
end

local function format_write()
	conform.format({ lsp_fallback=true }, function(err)
		if not err then
			vim.cmd.write()
		end
	end)
end

vim.keymap.set("n", "<leader>f", format, {})
vim.keymap.set("n", "<leader>F", format_write, {})
