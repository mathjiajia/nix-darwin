{ inputs, pkgs, ... }: {
  imports = [ inputs.nixvim.homeModules.nixvim ];

  programs.nixvim = {
    enable = true;
    # Match plugin dependencies to the cached nightly Neovim package.
    nixpkgs.source = inputs.neovim-nightly-overlay.inputs.nixpkgs;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
    defaultEditor = true;
    imports = [ ../../nixvim ];
  };
}
