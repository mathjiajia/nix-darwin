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
      "utftex"
    ];

    casks = [
      "adguard"
      "adobe-acrobat-pro"
      "adobe-creative-cloud"
      "alma"
      "chatgpt-atlas"
      "chatgpt"
      "chatwise"
      "cherry-studio"
      "codeedit"
      "corretto@11"
      "dash"
      "discord"
      "downie"
      "filo"
      "font-mozilla-text"
      "ghostty"
      "hazel"
      "hazeover"
      "hookmark"
      "iina"
      "inkscape"
      "istat-menus"
      "jordanbaird-ice"
      "keka"
      "kekaexternalhelper"
      "keyboard-maestro"
      "keyboardcleantool"
      "launchbar"
      "llamabarn"
      "lm-studio"
      "lobehub"
      "loop"
      "markedit"
      "mathpix-snipping-tool"
      "miaoyan"
      # "neovide"
      "neteasemusic"
      "ollama-app"
      "omniwm"
      "onyx"
      "openra"
      "orbstack"
      "osaurus"
      "permute"
      "prettyclean"
      "publish-or-perish"
      "qlmarkdown"
      "quarto"
      "quickrecorder"
      "raycast"
      "sage"
      "sf-symbols"
      "skim"
      "soulver"
      "squirrel-app"
      "surge"
      "syntax-highlight"
      "visual-studio-code"
      "warp"
      "zed"
      "zoom"
      "zotero@beta"
    ];
  };
}
