require("core.editor")
require("core.remap")

return {
	setup = function(with_packer)
		with_packer = with_packer or false
		if (with_packer) then
			require("core.packer")
		end
	end
}
