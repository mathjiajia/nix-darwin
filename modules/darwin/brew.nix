{ config, ... }:
{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    greedyCasks = true;

    taps = builtins.attrNames config.nix-homebrew.taps;

    brews = [
      "mole"
      "rift"
      "utftex"
    ];

    casks = [
      "adguard"
      "corretto@11"
      "chatgpt"
      "downie"
      "fcitx5"
      "filo"
      "ghostty"
      "hazel"
      "iina"
      "istat-menus"
      "jordanbaird-ice"
      "keka"
      "kekaexternalhelper"
      "keyboard-maestro"
      "keyboardcleantool"
      "launchbar"
      "loop"
      "markedit"
      "mathpix-snipping-tool"
      # "neovide"
      "ollama-app"
      "onyx"
      "permute"
      "prettyclean"
      "qlmarkdown"
      "raycast"
      "skim"
      "surge"
      "syntax-highlight"
      "visual-studio-code"
      "zoom"
      "zotero"

      "adobe-acrobat-pro"
      "adobe-creative-cloud"
      "ayugram"
      "chatgpt-atlas"
      "chatwise"
      "cherry-studio"
      "claude"
      "codeedit"
      "dash"
      "discord"
      # "flashspace"
      "font-mozilla-text"
      "hazeover"
      "hookmark"
      "inkscape"
      "llamabarn"
      "lm-studio"
      "miaoyan"
      "neteasemusic"
      "openra"
      "orbstack"
      "osaurus"
      "publish-or-perish"
      "quarto"
      "quickrecorder"
      "sage"
      "sf-symbols"
      # "sfm"
      "soulver"
      "warp"
      "zed"
    ];
  };
}
