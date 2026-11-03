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

  xdg.configFile."rex/.emmyrc.json".text = builtins.toJSON {
    diagnostics.globals = [ "rex" ];
  };
}
