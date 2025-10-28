{ inputs, pkgs, ... }:
let
  blink-indent = pkgs.vimUtils.buildVimPlugin {
    name = "blink.indent";
    src = inputs.blink-indent;
    nvimSkipModules = [
      "blink.indent.static"
      "blink.indent.scope"
      "blink.indent.utils"
    ];
  };
in
{
  programs.nixvim.extraPlugins = [
    blink-indent
    pkgs.vimPlugins.blink-pairs
  ];

  programs.nixvim.extraConfigLua = ''
    require("vim._extui").enable({})
    require("blink.pairs").setup({})
  '';
}
