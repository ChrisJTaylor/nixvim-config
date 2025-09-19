{ ... }: {
  plugins.lsp-format = {
    enable = true;
    lspServersToEnable = [
      "omnisharp"
      "gleam"
      "gopls"
      "pylsp"
      "html"
      "yamlls"
      "terraformls"
      "bashls"
      "rust_analyzer"
      "kotlin_language_server"
      "lua_ls"
      "powershell_es"
      "nushell"
      "zls"
    ];
  };
}
