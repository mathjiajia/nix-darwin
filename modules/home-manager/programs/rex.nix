{ inputs, ... }: {
  imports = [ inputs.rex.homeManagerModules.default ];

  programs.rex = {
    enable = true;
    package = null; # Use Rex from the macOS app.
  };
}
