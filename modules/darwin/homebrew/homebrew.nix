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

    casks = [
      "adguard"
      # "aerospace"
      "corretto@11"
      "chatgpt"
      "downie"
      "fcitx5"
      "ghostty"
      "hazel"
      "hyprspace"
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
    ];
  };
}
