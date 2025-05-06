{pkgs, ...}: {
  security.pam.services.sudo_local.touchIdAuth = true;

  system.defaults = {
    # firewall settings
    alf = {
      # 0 = disabled 1 = enabled 2 = blocks all connections except for essential services
      # globalstate = 1;
      # loggingenabled = 0;
      # stealthenabled = 1;
    };

    dock = {
      autohide = true;
      tilesize = 48;
      persistent-apps = [
        "/System/Applications/Launchpad.app"
        "/System/Cryptexes/App/System/Applications/Safari.app"
        "/System/Applications/Mail.app"
        "/System/Applications/Calendar.app"
        "/System/Applications/Reminders.app"
        "/Applications/Things3.app"
        "/Applications/Due.app"
        "/System/Applications/Notes.app"
        "/Applications/Drafts.app"
        "/Applications/MarkEdit.app"
        "/Applications/Goodnotes.app"
        "/Applications/UPDF.app"
        "/Applications/Visual Studio Code.app"
        "/Applications/Ghostty.app"
        "${pkgs.sioyek}/Applications/sioyek.app"
        "/Applications/Zotero.app"
        "/Applications/Publish or Perish.app"
        "/Applications/WeChat.app"
        "/Applications/Dictionaries.app"
        "/Applications/Perplexity.app"
        "/Applications/ChatGPT.app"
        "/Applications/ChatWise.app"
        "/Applications/Cherry Studio.app"
        "/System/Applications/Music.app"
        "/Applications/LaunchBar.app"
        "/System/Applications/App Store.app"
        "/System/Applications/System Settings.app"
        "/System/Applications/iPhone Mirroring.app"
      ];
    };

    finder = {
      # Always show hidden files
      "AppleShowAllFiles" = true;
      # Always show file extensions
      "AppleShowAllExtensions" = true;
      # Show status bar at bottom of finder windows with item/disk space stats
      "ShowStatusBar" = true;
      # Show path breadcrumbs in finder windows
      "ShowPathbar" = true;
      # Show the full POSIX filepath in the window title
      "_FXShowPosixPathInTitle" = false;
      # When performing a search, search the current folder by default
      "FXDefaultSearchScope" = "SCcf";
      # Disable the warning when changing a file extension
      "FXEnableExtensionChangeWarning" = false;
      # Use list view in all Finder windows by default
      "FXPreferredViewStyle" = "Nlsv";
    };

    loginwindow = {
      GuestEnabled = false;
    };

    trackpad = {
      # Enable tap to click
      Clicking = true;
      # Enable three finger drag
      TrackpadThreeFingerDrag = true;
    };

    NSGlobalDomain = {
      # AppleICUForce24HourTime = false;
      # AppleInterfaceStyle = "Dark";
      AppleInterfaceStyleSwitchesAutomatically = true;
      AppleMeasurementUnits = "Centimeters";
      AppleMetricUnits = 1;
      AppleTemperatureUnit = "Celsius";
      # delay before repeating keystrokes
      # InitialKeyRepeat = 10;
      # delay between repeated keystrokes upon holding a key
      # KeyRepeat = 1;
    };

    SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;

    CustomUserPreferences = {
      # "com.apple.mail" = {
      #   DisableInlineAttachmentViewing = true;
      #   AddLinkPreviews = 0;
      #   SwipeAction = 1; # discard mail to archive
      #   NewMessagesSoundName = "Funk";
      #   NSFontSize = 14;
      #   NSFixedPitchFont = "MapleMono-NF-CN-Regular";
      #   NSFixedPitchFontSize = 15;
      # };

      # "com.apple.controlcenter" = {
      #   "NSStatusItem Visible Battery" = 0;
      #   "NSStatusItem Visible BentoBox" = 1;
      #   "NSStatusItem Visible Clock" = 1;
      #   "NSStatusItem Visible FocusModes" = 1;
      #   "NSStatusItem Visible NowPlaying" = 0;
      #   "NSStatusItem Visible Sound" = 1;
      #   "NSStatusItem Visible WiFi" = 1;
      # };

      "com.apple.SoftwareUpdate" = {
        # Enable the automatic update check
        AutomaticCheckEnabled = true;
        # Download newly available updates in background
        AutomaticDownload = 1;
        # Install System data files & security updates
        CriticalUpdateInstall = 1;
      };

      "com.apple.TimeMachine" = {
        # Prevent Time Machine from prompting to use new hard drives as backup volume
        DoNotOfferNewDisksForBackup = true;
      };

      "com.jordanbaird.Ice" = {
        AutoRehide = true;
        CanToggleAlwaysHiddenSection = true;
        EnableAlwaysHiddenSection = true;
        HideApplicationMenus = true;
        RehideInterval = 15;
        RehideStrategy = 0;
        ShowIceIcon = false;
        ShowOnClick = true;
        ShowOnHover = false;
        ShowOnHoverDelay = "0.2";
        ShowOnScroll = false;
        ShowSectionDividers = false;
        UseIceBar = false;
      };
    };
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };
}
