return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "j-hui/fidget.nvim", config = true },
    { "https://codeberg.org/mfussenegger/nvim-jdtls" },
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
        map("<leader>d", vim.diagnostic.setloclist, "Diagnostics")
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

    local jdtls_package_dir = vim.fn.expand("$MASON/packages/jdtls/")
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    local jdtls_workspaces_dir = vim.fn.expand("$HOME/.jdtls_workspaces/")
    vim.lsp.config("jdtls", {
      cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.level=ALL",
        "-Xmx1G",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-jar",
        vim.fn.glob(jdtls_package_dir .. "plugins/org.eclipse.equinox.launcher_*.jar"),
        "-configuration",
        jdtls_package_dir .. "config_linux",
        "-data",
        jdtls_workspaces_dir .. project_name,
      },
    })
    vim.lsp.enable("jdtls")
  end,
}
