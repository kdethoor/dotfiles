local success, builtin = pcall(require, "telescope.builtin")

if not success then
	return
end

vim.keymap.set("n", "<C-p>", function() builtin.find_files({ no_ignore = true }) end, {})
vim.keymap.set("n", "<leader>pg", builtin.git_files, {})
vim.keymap.set("n",
	"<leader>ps",
	function()
		builtin.grep_string({ search = vim.fn.input("Grep > ") })
	end)
