local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }

local servers = {
	"bashls",
	"cue",
	"golangci_lint_ls",
	"gopls",
	"helm_ls",
	"lua_ls",
	"ruff",
	"rust_analyzer",
	"terraformls",
	"tflint",
	"ts_ls",
	"yamlls",
}

-- export on_attach & capabilities for custom lspconfigs
vim.lsp.protocol.CompletionItemKind = {
	" (text)",
	" (method)",
	"󰊕 (function)",
	" (constructor)",
	"ﰠ (field)",
	"󰫧 (variable)",
	" (class)",
	" (interface)",
	" (module)",
	" (property)",
	" (unit)",
	" (value)",
	" (enum)",
	" (key)",
	" (snippet)",
	" (color)",
	" (file)",
	" (reference)",
	" (folder)",
	" (enum member)",
	" (constant)",
	" (struct)",
	" (event)",
	" (operator)",
	" (type)",
}

vim.lsp.enable(servers)

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
