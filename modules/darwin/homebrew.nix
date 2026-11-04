{
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";

    casks = [
      # AI
      "chatgpt"
      "claude"
      "claude-code"
      "codex"
      "llama-app"
      "magpie"
      # "mlx-serve"

      # Development
      "corretto@11" # for MATLAB
      "markedit"
      # "neovide-app" # depends on nvim
      "orbstack"
      "orchard"
      "visual-studio-code"
      "zed"

      # Fonts
      "font-mozilla-text"
      "font-new-york"
      "font-sf-compact"
      "font-sf-mono"
      "font-sf-pro"

      # Productivity
      "hazel"
      "keyboard-maestro"
      "launchbar"
      "loop"
      # "tinycast" # not in homebrew

      # System and hardware
      # "adguard" # use mini
      "istat-menus"
      "keyboardcleantool"
      # "little-snitch" # beta now
      "mole-app"
      "omniwm"
      "onyx"
      "sandisk"
      "surge"
      "syntax-highlight"
      "tailscale-app"

      # Research
      # "mactex"
      "pdf-expert"
      "sage"
      "skim"
      "zotero"
    ];
  };
}
