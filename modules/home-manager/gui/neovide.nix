{
  programs.neovide = {
    enable = true;
    package = null;
    settings = {
      neovim_bin = "NVIM_APPNAME=nvim_tex nvim";
      frame = "transparent";
      font = {
        normal = ["Sarasa Term SC" "Symbols Nerd Font"];
        size = 19;
      };
    };
  };
}
