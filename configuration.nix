{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    discord
    # follow
    # github-desktop
    # ghostty
    ice-bar
    iina
    inkscape
    # jujutsu
    keka
    # lazyjj
    ollama
    loopwm
    # mathpix-snipping-tool
    # microsoft-edge
    skimpdf
    # sublime-merge
    raycast
    # warp-terminal
    # zed-editor
    zoom-us
    # zotero
  ];

  fonts.packages = with pkgs; [
    # maple-mono-NF
    # iosevka
    lxgw-wenkai
    smiley-sans
  ];

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
  };

  homebrew.casks = [
    # "adguard"
    "adobe-acrobat-pro"
    "adobe-creative-cloud"
    "anythingllm"
    "chatgpt"
    "codeedit"
    "coherence-x"
    "dash"
    "diffusionbee"
    "downie"
    "font-codicon"
    "font-iosevka"
    "font-jetbrains-mono-nerd-font"
    "font-sf-mono"
    "font-symbols-only-nerd-font"
    "hazel"
    "hazeover"
    "hhkb"
    "hookmark"
    "istat-menus"
    "kekaexternalhelper"
    "keyboard-maestro"
    "keyboardcleantool"
    "launchbar"
    "mathpix-snipping-tool"
    "microsoft-edge"
    "openemu"
    "orbstack"
    "permute"
    "prettyclean"
    "publish-or-perish"
    "qlmarkdown"
    "sf-symbols"
    "soulver"
    "sublime-merge"
    "surge"
    "syntax-highlight"
    "zed"
    "zotero"
  ];

  homebrew.masApps = {
    "Bear" = 1091189122;
    "Codye" = 1516894961;
    "Craft" = 1487937127;
    "DevHub" = 6476452351;
    "Dictionaries" = 1380563956;
    "Drafts" = 1435957248;
    "Dropover" = 1355679052;
    "Due" = 524373870;
    "Enchanted LLM" = 6474268307;
    "FileFillet" = 6443969762;
    "Friendly Streaming" = 553245401;
    "GarageBand" = 682658836;
    "Goodnotes" = 1444383602;
    "HorizonChase2" = 1534920947;
    "iMovie" = 408981434;
    "Infuse" = 1136220934;
    "Keynote" = 409183694;
    "MarkMark" = 6475077023;
    "Microsoft Excel" = 462058435;
    "Microsoft PowerPoint" = 462062816;
    "Microsoft Word" = 462054704;
    "Noto" = 1459055246;
    "Numbers" = 409203825;
    "OpenCat" = 6445999201;
    "Pages" = 409201541;
    "Plain Text Editor" = 1572202501;
    "Playgrounds" = 1496833156;
    "Pro Snooker & Pool 2024" = 1586517737;
    "Reeder" = 6475002485;
    "ScanScan" = 1249901692;
    "SnippetsLab" = 1006087419;
    "Solitaire" = 1534193824;
    "Taio" = 1527036273;
    "Telegram" = 747648890;
    "TestFlight" = 899247664;
    "Things" = 904280696;
    "uBlacklist for Safari" = 1547912640;
    "Ulysses" = 1225570693;
    "UPDF" = 1619925971;
    "VidHub" = 1659622164;
    "VooV" = 1497685373;
    "WeChat" = 836500024;
    "WhatsApp" = 310633997;
    "Whisper Transcription" = 1668083311;
    "Xcode" = 497799835;
    "西窗烛" = 912139104;
  };

  users.users.jia.home = "/Users/jia";
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Create /etc/zshrc that loads the nix-darwin environment.
  # programs.zsh.enable = true;  # default shell on catalina
  programs.fish.enable = true;

  # Set Git commit hash for darwin-version.
  # system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
