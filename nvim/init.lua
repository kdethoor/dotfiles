local core = require("core")
local has_override, core_override = pcall(require, "core_override")

local with_packer = false
if (has_override)
then
	with_packer = core_override.with_packer
end

print(with_packer)

core.setup(with_packer)
