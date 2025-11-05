{ pkgs, ... }:
{
  security.pam.services.sudo_local.touchIdAuth = true;

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
        "/Applications/Neovide.app"
        "/Applications/Zotero.app"
        "/Applications/WeChat.app"
        "/Applications/Dictionaries.app"
        "/Applications/ChatGPT.app"
        "/Applications/FlowDown.app"
        "/Applications/ChatWise.app"
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
      TrackpadThreeFingerDrag = true;
    };

    NSGlobalDomain = {
      # AppleICUDateFormatStrings = {
      #   "1" = "yyyy-MM-dd HH:mm";
      #   "2" = "yyyy-MM-dd HH:mm:ss";
      #   "3" = "yyyy-MM-dd HH:mm:ss";
      #   "4" = "yyyy-MM-dd HH:mm:ss";
      # };
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
      # "com.apple.controlcenter" = {
      #   "NSStatusItem Visible Battery" = 0;
      #   "NSStatusItem Visible BentoBox" = 1;
      #   "NSStatusItem Visible Clock" = 1;
      #   "NSStatusItem Visible FocusModes" = 1;
      #   "NSStatusItem Visible NowPlaying" = 0;
      #   "NSStatusItem Visible Sound" = 1;
      #   "NSStatusItem Visible WiFi" = 1;
      # };

      "com.apple.desktopservices" = {
        DSDontWriteNetworkStores = true;
        DSDontWriteUSBStores = true;
      };

      "com.apple.finder" = {
        RelativeDates = false;
      };

      # "com.apple.mail" = {
      #   DisableInlineAttachmentViewing = true;
      #   AddLinkPreviews = 0;
      #   SwipeAction = 1; # discard mail to archive
      #   NewMessagesSoundName = "Funk";
      #   NSFontSize = 14;
      #   NSFixedPitchFont = "MapleMono-NF-CN-Regular";
      #   NSFixedPitchFontSize = 15;
      # };

      "com.apple.SoftwareUpdate" = {
        AutomaticCheckEnabled = true;
        AutomaticDownload = 1;
        CriticalUpdateInstall = 1;
      };

      "com.apple.TimeMachine".DoNotOfferNewDisksForBackup = true;

      "com.jordanbaird.Ice" = {
        AutoRehide = true;
        CanToggleAlwaysHiddenSection = true;
        EnableAlwaysHiddenSection = true;
        HideApplicationMenus = true;
        RehideInterval = 15;
        RehideStrategy = 0;
        ShowIceIcon = true;
        ShowOnClick = true;
        ShowOnHover = false;
        ShowOnHoverDelay = "0.2";
        ShowOnScroll = false;
        ShowSectionDividers = false;
        UseIceBar = false;
      };
    };

    SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };
}
