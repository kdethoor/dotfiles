local module = {}

function module.gh(url_part)
	return 'https://github.com/' .. url_part
end

return module
