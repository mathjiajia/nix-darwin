{ ... }:
{
  programs.nixvim.plugins = {
    fzf-lua = {
      enable = true;
      settings = {
        grep.RIPGREP_CONFIG_PATH.__raw = ''vim.env.RIPGREP_CONFIG_PATH'';
        defaults = {
          file_icons = "mini";
          formatter = "path.dirname_first";
        };
      };
    };
    neo-tree = {
      enable = true;
      # open_files_do_not_replace_types = { "aerial"; "qf"; "terminal"; };
      defaultComponentConfigs.indent.withExpanders = true;
      filesystem = {
        bindToCwd = false;
        followCurrentFile.enabled = true;
        useLibuvFileWatcher = true;
        filteredItems = {
          hideDotfiles = false;
          hideGitignored = true;
          hideByName = [ ".git" ];
        };
      };
    };

    nvim-surround.enable = true;
    flash.enable = true;
  };
}
