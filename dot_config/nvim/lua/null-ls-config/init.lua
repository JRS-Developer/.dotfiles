local null_ls = require("null-ls")
local builtins = null_ls.builtins

local sources = {
	-- Formatters
	builtins.formatting.stylua,
	builtins.formatting.black,
	builtins.formatting.gofmt,
	builtins.formatting.prettierd.with({
		prefer_local = "node_modules/.bin",
	}),
	builtins.formatting.phpcsfixer,
}

null_ls.setup({
	sources = sources,
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 10000)
            augroup END
            ]])
		end
	end,
	debug = true,
})