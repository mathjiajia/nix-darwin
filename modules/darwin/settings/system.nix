{
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
      orientation = "bottom";
      tilesize = 48;

      persistent-apps = [
        "/System/Cryptexes/App/System/Applications/Safari.app"
        "/System/Applications/Mail.app"
        "/System/Applications/Calendar.app"
        "/System/Applications/Reminders.app"
        "/Applications/Things3.app"
        "/Applications/Due.app"
        "/System/Applications/Notes.app"
        "/Applications/Drafts.app"
        "/Applications/Goodnotes.app"
        "/Applications/UPDF.app"
        "/Applications/sioyek.app"
        "/Applications/Ghostty.app"
        "/Applications/Zotero.app"
        "/Applications/Publish or Perish.app"
        "/Applications/WeChat.app"
        "/Applications/Dictionaries.app"
        "/System/Applications/Music.app"
        "/Applications/Surge.app"
        "/Applications/LaunchBar.app"
        "/System/Applications/App Store.app"
        "/System/Applications/System Settings.app"
        "/System/Applications/iPhone Mirroring.app"
      ];
    };

    finder = {
      FXPreferredViewStyle = "Nlsv";
      _FXShowPosixPathInTitle = false;
    };

    loginwindow = {
      GuestEnabled = false;
    };

    trackpad = {
      Clicking = true;
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
      "com.apple.mail" = {
        DisableInlineAttachmentViewing = true;
        AddLinkPreviews = 0;
        SwipeAction = 1; # discard mail to archive
        NewMessagesSoundName = "Funk";
        NSFontSize = 14;
        NSFixedPitchFont = "MapleMono-NF-CN-Regular";
        NSFixedPitchFontSize = 15;
      };

      # "com.apple.controlcenter" = {
      #   "NSStatusItem Visible Battery" = 0;
      #   "NSStatusItem Visible BentoBox" = 1;
      #   "NSStatusItem Visible Clock" = 1;
      #   "NSStatusItem Visible FocusModes" = 1;
      #   "NSStatusItem Visible NowPlaying" = 0;
      #   "NSStatusItem Visible Sound" = 1;
      #   "NSStatusItem Visible WiFi" = 1;
      # };
    };
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };
}
