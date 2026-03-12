-- lua/config/plugins/lsp.lua (новая версия без deprecated)

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Общий on_attach
local on_attach = function(client, bufnr)
	local opts = { buffer = bufnr, noremap = true, silent = true }

	vim.keymap.set("n", "gl", vim.diagnostic.open_float, { buffer = bufnr, desc = "Показать диагностику (error/warning)" })

	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>f", function()
		vim.lsp.buf.format({ async = true })
	end, opts)
end

-- C/C++ (clangd)
vim.lsp.config("clangd", {
	cmd = { "clangd", "--background-index" },
	capabilities = capabilities,
	on_attach = on_attach,
})

-- Lua
vim.lsp.config("lua_ls", {
	cmd = { "lua-language-server" },
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = "vim" },
			workspace = { library = vim.api.nvim_get_runtime_file("", true) },
			telemetry = { enable = false },
		},
	},
	capabilities = capabilities,
	on_attach = on_attach,
})

-- Bash
vim.lsp.config("bashls", {
	cmd = { "bash-language-server", "start" },
	capabilities = capabilities,
	on_attach = on_attach,
})

-- Python
vim.lsp.config("pyright", {
	cmd = { "pyright-langserver", "--stdio" },
	capabilities = capabilities,
	on_attach = on_attach,
})

-- Автоматический запуск LSP при открытии файлов нужных типов
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"c", "cpp", "objc", "objcpp", -- C/C++
		"lua",                        -- Lua
		"sh", "bash", "zsh",          -- Bash
		"python",                     -- Python
	},
	callback = function(args)
		vim.lsp.enable({ bufnr = args.buf })
	end,
})


--[[
bufmap('n', 'K',  vim.lsp.buf.hover)
bufmap('n', 'gd', vim.lsp.buf.definition)
bufmap('n', 'gD', vim.lsp.buf.declaration)
bufmap('n', 'gi', vim.lsp.buf.implementation)
bufmap('n', 'go', vim.lsp.buf.type_definition)
bufmap('n', 'gr', vim.lsp.buf.references)
bufmap('n', 'gs', vim.lsp.buf.signature_help)
bufmap('n', '<F2>', vim.lsp.buf.rename)
bufmap('n', '<F4>', vim.lsp.buf.code_action)
bufmap('n', 'gl', vim.diagnostic.open_float)

bufmap('n', '[d', vim.diagnostic.goto_prev)
bufmap('n', ']d', vim.diagnostic.goto_next)
  end,
})
--]]
