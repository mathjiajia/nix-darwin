{ pkgs, config, ... }:
{
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search by name, run:
  # # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    emacs
    fish
    starship
    difftastic
    glow
    hugo
    nixfmt-rfc-style
    onefetch
    pandoc
    poppler
    swift-format
    unar
    zoxide
    # tectonic
    vscode
    zed
    raycast
    ollama
    skimpdf
    iina
    loopwm
    ice-bar
    keka
    inkscape
    # github-desktop
    # ghostty
    kitty
    # warp-terminal
    # wezterm
    discord
    texliveFull
    # mathpix-snipping-tool
    # follow
    # microsoft-edge
    # zotero
    # sublime-merge
    # sioyek
    zoom-us
  ];

  homebrew = {
    enable = true;
    brews = [ "mas" ];
    casks = [
      "mathpix-snipping-tool"
      "publish-or-perish"
      "zotero"
      "chatgpt"
      "microsoft-edge"
      "dash"
      "sublime-merge"
      "launchbar"
      "surge"
      "hazeover"
      "hookmark"
      "qlmarkdown"
      "syntax-highlight"
      "istat-menus"
      "adguard"
      "downie"
      "hazel"
      "kekaexternalhelper"
      "keyboardcleantool"
      "keyboard-maestro"
      "permute"
      "prettyclean"
      "soulver"
      "sf-symbols"
      "anythingllm"
      "diffusionbee"
      "codeedit"
      "orbstack"
      "openemu"

      "adobe-acrobat-pro"
      "adobe-creative-cloud"
      "coherence-x"

      "hhkb"
      "font-codicon"
      "font-jetbrains-mono-nerd-font"
      "font-iosevka"
      "font-sf-mono"
      "font-symbols-only-nerd-font"
    ];
    masApps = {
      "GarageBand" = 682658836;
      "iMovie" = 408981434;
      "Playgrounds" = 1496833156;
      "Keynote" = 409183694;
      "Numbers" = 409203825;
      "Pages" = 409201541;
      "SnippetsLab" = 1006087419;
      "VooV" = 1497685373;
      "Friendly Streaming" = 553245401;
      "Infuse" = 1136220934;
      "VidHub" = 1659622164;
      "Microsoft Excel" = 462058435;
      "Microsoft PowerPoint" = 462062816;
      "Microsoft Word" = 462054704;
      "UPDF" = 1619925971;
      "Dictionaries" = 1380563956;
      "Due" = 524373870;
      "Dropover" = 1355679052;
      "FileFillet" = 6443969762;
      "Things" = 904280696;
      "Reeder" = 6475002485;
      "MarkMark" = 6475077023;
      "西窗烛" = 912139104;
      "Telegram" = 747648890;
      "WeChat" = 836500024;
      "‎WhatsApp" = 310633997;
      "Bear" = 1091189122;
      "Craft" = 1487937127;
      "Drafts" = 1435957248;
      "Goodnotes" = 1444383602;
      "Taio" = 1527036273;
      "Ulysses" = 1225570693;
      "Enchanted LLM" = 6474268307;
      "OpenCat" = 6445999201;
      "Xcode" = 497799835;
      "Codye" = 1516894961;
      "DevHub" = 6476452351;
      "HorizonChase2" = 1534920947;
      "Pro Snooker & Pool 2024" = 1586517737;
      "Solitaire" = 1534193824;
      "ScanScan" = 1249901692;
      "TestFlight" = 899247664;
      "Whisper Transcription" = 1668083311;
      "Noto" = 1459055246;
      "Plain Text Editor" = 1572202501;
    };
    onActivation.cleanup = "zap";
  };

  fonts.packages = with pkgs; [
    # maple-mono-NF
    # iosevka
    lxgw-wenkai
    smiley-sans
  ];

  # system.defaults = {
  #   dock.autohide = true;
  #   loginwindow.GuestEnabled = false;
  # };

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
