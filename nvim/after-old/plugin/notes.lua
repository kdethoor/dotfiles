local success, core_override = pcall(require, "core_override")

if not success then
	return
end

if core_override and core_override.notes then
	local open_notes = function()
		local command = "cd " .. core_override.notes
		vim.cmd(command)
		vim.cmd.Ex(core_override.notes)
	end
	vim.keymap.set("n", "<leader>nn", open_notes, {})
end
