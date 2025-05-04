-- Base config
require("config.editor")
require("config.remap")

-- Plugins
local use_plugins = true
local has_local_config, local_config = pcall(require, "config.local")
if (has_local_config)
then
	use_plugins = use_plugins and local_config.use_plugins
end
if (use_plugins)
then
	require("config.lazy")
end
