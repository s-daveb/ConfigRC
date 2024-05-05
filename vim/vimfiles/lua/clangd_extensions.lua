
local module = {}

function module.enable_inlay_hints()
	require("clangd_extensions.inlay_hints").setup_autocmd()
	require("clangd_extensions.inlay_hints").set_inlay_hints()
end

function module.init()
	module.enable_inlay_hints();
end

return module
