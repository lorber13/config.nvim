return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "j-hui/fidget.nvim", config = true },
  },
  config = function()
    local lsp_group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true })
    vim.api.nvim_create_autocmd("LspAttach", {
      group = lsp_group,
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method("textDocument/inlayHint", event.buf) then
          vim.lsp.inlay_hint.enable()
        end
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
  end,
}
