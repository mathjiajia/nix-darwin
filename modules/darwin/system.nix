{ lib, pkgs, ... }: {
  security.pam.services.sudo_local.enable = false;
  # security.pam.services.sudo_local.touchIdAuth = true;

  launchd.daemons.limit-maxfiles = {
    serviceConfig = {
      Label = "limit.maxfiles";
      ProgramArguments = [
        "/bin/launchctl"
        "limit"
        "maxfiles"
        "8192" # soft limit
        "524288" # hard limit, unlimited by default
      ];
      RunAtLoad = true;
      LaunchOnlyOnce = true;
    };
  };

  # GUI applications are managed by Homebrew.
  system.activationScripts.applications.text = lib.mkForce "";

  system.defaults = {
    dock = {
      autohide = true;
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
        "/Applications/Ghostty.app"
        "/Applications/Neovide.app"
        "${pkgs.sioyek}/Applications/sioyek.app"
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
      "AppleShowAllExtensions" = true;
      # "AppleShowAllFiles" = true;
      "ShowPathbar" = true;
      "ShowStatusBar" = true;
      # "_FXShowPosixPathInTitle" = false;
      "FXDefaultSearchScope" = "SCcf";
      "FXEnableExtensionChangeWarning" = false;
      "FXPreferredViewStyle" = "Nlsv";
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
