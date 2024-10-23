{ ... }:
{
  programs.nixvim = {
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

    keymaps =
      {
      };
  };
}
