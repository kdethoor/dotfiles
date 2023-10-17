local success, builtin = pcall(require, "telescope.builtin")

if not success then
	return
end

vim.keymap.set("n", "<C-p>", builtin.find_files, {})
vim.keymap.set("n", "<leader>pg", builtin.git_files, {})
vim.keymap.set("n",
	"<leader>ps",
	function()
		builtin.grep_string({ search = vim.fn.input("Grep > ") })
	end)
