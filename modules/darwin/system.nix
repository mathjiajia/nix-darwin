{
  security.pam.services.sudo_local.touchIdAuth = true;

  system.defaults = {
    dock = {
      autohide = true;
      mru-spaces = false; # Keep desktops in a fixed order.
      tilesize = 48;
      persistent-apps = [
        "/System/Applications/Apps.app"
        "/System/Cryptexes/App/System/Applications/Safari.app"
        "/System/Applications/Mail.app"
        "/System/Applications/Calendar.app"
        "/System/Applications/Reminders.app"
        "/System/Applications/Notes.app"
        "/Applications/Drafts.app"
        "/Applications/Due.app"
        "/Applications/Things3.app"
        "/Applications/Visual Studio Code.app"
        "/Applications/Rex Beta.app"
        "/Applications/sioyek.app"
        "/Applications/Zotero.app"
        "/Applications/PDF Expert.app"
        "/Applications/ChatGPT.app"
        "/Applications/Claude.app"
        "/Applications/WeChat.app"
        "/Applications/WhatsApp.app"
        "/System/Applications/Music.app"
        "/Applications/LaunchBar.app"
        "/System/Applications/App Store.app"
        "/System/Applications/System Settings.app"
        "/System/Applications/iPhone Mirroring.app"
      ];
    };

    finder = {
      AppleShowAllExtensions = true;
      # AppleShowAllFiles = true;
      ShowPathbar = true;
      ShowStatusBar = true;
      # _FXShowPosixPathInTitle = false;
      FXDefaultSearchScope = "SCcf";
      FXEnableExtensionChangeWarning = false;
      FXPreferredViewStyle = "Nlsv";
      _FXSortFoldersFirst = true;
      NewWindowTarget = "Home";
    };

    loginwindow.GuestEnabled = false;

    trackpad = {
      Clicking = true;
      TrackpadRightClick = true;
      TrackpadThreeFingerDrag = true;
    };

    NSGlobalDomain = {
      # AppleICUForce24HourTime = false;
      # AppleInterfaceStyle = "Dark";
      AppleInterfaceStyleSwitchesAutomatically = true;
      AppleMeasurementUnits = "Centimeters";
      AppleMetricUnits = 1;
      AppleTemperatureUnit = "Celsius";
      # InitialKeyRepeat = 10;
      # KeyRepeat = 1;
    };

    CustomUserPreferences = {
      "com.apple.desktopservices" = {
        DSDontWriteNetworkStores = true;
        DSDontWriteUSBStores = true;
      };
      "com.apple.finder" = {
        RelativeDates = false;
      };
      "com.apple.SoftwareUpdate" = {
        AutomaticCheckEnabled = false;
        AutomaticDownload = 0;
        CriticalUpdateInstall = 1;
      };
      "com.apple.TimeMachine".DoNotOfferNewDisksForBackup = true;
    };
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };
}
