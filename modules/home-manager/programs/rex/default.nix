{ inputs, ... }: {
  imports = [ inputs.rex.homeManagerModules.default ];

  programs.rex = {
    enable = true;
    package = null;
    config = ./init.lua;
  };

  xdg.configFile."fish/completions/rex.fish".text = ''
    rex completion fish | source
  '';

  xdg.configFile."rex/types.lua".source = ./types.lua;
  xdg.configFile."rex/.emmyrc.json".source = ./.emmyrc.json;
}
