function SetColors(color)
	success, result = pcall(vim.cmd.colorscheme, color)
	if not success then
		vim.cmd.colorscheme("evening")
	end
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

SetColors("catpuccin-mocha")
