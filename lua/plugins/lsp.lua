return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "j-hui/fidget.nvim", config = true },
  },
  config = function()
    -- Diagnostic Config
    -- See :help vim.diagnostic.Opts
    vim.diagnostic.config({
      severity_sort = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "󰅚 ",
          [vim.diagnostic.severity.WARN] = "󰀪 ",
          [vim.diagnostic.severity.INFO] = "󰋽 ",
          [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
      },
    })
    local lsp_group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true })
    vim.api.nvim_create_autocmd("LspAttach", {
      group = lsp_group,
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method("textDocument/inlayHint", event.buf) then
          vim.lsp.inlay_hint.enable()
        end
        local map = function(keys, func, desc, mode)
          mode = mode or "n"
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end
        map("gd", vim.lsp.buf.definition, "Goto definitions")
        map("gi", vim.lsp.buf.implementation, "Goto implementations")
        map("grn", vim.lsp.buf.rename, "Rename symbol")
        map("gD", vim.lsp.buf.declaration, "Goto declaration")
        map("grr", vim.lsp.buf.references, "Goto references")
        map("gra", vim.lsp.buf.code_action, "Code actions")
      end,
    })
    vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
      group = lsp_group,
      callback = function()
        vim.lsp.codelens.refresh({ bufnr = 0 })
      end,
    })
    vim.lsp.enable("rust_analyzer")
    vim.lsp.enable("lua_ls")
    vim.lsp.enable("ts_ls")
  end,
}
