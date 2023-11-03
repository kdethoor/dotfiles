local success, dap = pcall(require, "dap")

if not success then
	return
end

vim.keymap.set("n", "<leader>mb", function() dap.toggle_breakpoint() end)
vim.keymap.set("n", "<leader>mc", function() dap.continue() end)
vim.keymap.set("n", "<leader>mm", function() dap.step_over() end)
vim.keymap.set("n", "<leader>mn", function() dap.step_into() end)
vim.keymap.set("n", "<leader>mn", function() dap.step_out() end)
vim.keymap.set("n", "<leader>mv", function() dap.repl.toggle() end)


dap.adapters.python = function(cb, config)
	if config.request == 'attach' then
		local port = (config.connect or config).port
		local host = (config.connect or config).host or '127.0.0.1'
		cb({
			type = 'server',
			port = assert(port, '`connect.port` is required for a python `attach` configuration'),
			host = host,
			options = {
				source_filetype = 'python',
			},
		})
	else
		cb({
			type = 'executable',
			command = 'python',
			args = { '-m', 'debugpy.adapter' },
			options = {
				source_filetype = 'python',
			},
		})
	end
end

dap.configurations.python = {
	{
		type = 'python',
		request = 'launch',
		name = "Launch file",

		-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

		program = "${file}", -- This configuration will launch the current file if used.
		pythonPath = function()
			-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
			-- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
			-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
			local cwd = vim.fn.getcwd()
			if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
				return cwd .. '/venv/bin/python'
			elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
				return cwd .. '/.venv/bin/python'
			else
				return '/usr/bin/python'
			end
		end,
	},
}

local dapui = require("dapui")
dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end
