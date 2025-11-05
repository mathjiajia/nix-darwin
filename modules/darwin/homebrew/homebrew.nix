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

    brews = [ "rift" ];
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
    ];
  };
}
