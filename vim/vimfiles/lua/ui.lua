local ui_module = {}

function ui_module.load()
	vim.diagnostic.config({
  		virtual_text = {
    			-- source = "always",  -- Or "if_many"
    			prefix = '🞊 :', -- Could be '■', '▎', 'x'
  		},
  		severity_sort = true,
  		float = {
    			source = "always",  -- Or "if_many"
  		},
	})
end

return ui_module

-- vim: ts=2 sw=2 sts=2 noet :
