{ ... }:
{
  system.defaults = {

    # firewall settings
    alf = {
      # 0 = disabled 1 = enabled 2 = blocks all connections except for essential services
      # globalstate = 1;
      # loggingenabled = 0;
      # stealthenabled = 1;
    };

    # dock settings
    dock = {
      autohide = true;
      orientation = "bottom";
      # remove delay for showing dock
      # autohide-delay = 0.0;
      # how fast is the dock showing animation
      # autohide-time-modifier = 1.0;
      # tilesize = 50;
      # static-only = false;
      # showhidden = false;
      # show-recents = false;
      # show-process-indicators = true;
      # mru-spaces = false;
    };

    # file viewer settings
    finder = {
      # AppleShowAllExtensions = true;
      # FXEnableExtensionChangeWarning = true;
      _FXShowPosixPathInTitle = false;
    };

    # login window settings
    loginwindow = {
      # disable guest account
      GuestEnabled = false;
      # show name instead of username
      # SHOWFULLNAME = false;
    };

    # trackpad settings
    trackpad = {
      # silent clicking = 0, default = 1
      # ActuationStrength = 0;
      # enable tap to click
      Clicking = true;
      # firmness level, 0 = lightest, 2 = heaviest
      # FirstClickThreshold = 1;
      # firmness level for force touch
      # SecondClickThreshold = 1;
      # don't allow positional right click
      # TrackpadRightClick = false;
      # three finger drag for space switching
      TrackpadThreeFingerDrag = true;
    };

    NSGlobalDomain = {
      # AppleICUForce24HourTime = false;
      # AppleInterfaceStyle = "Dark";
      AppleInterfaceStyleSwitchesAutomatically = true;
      AppleMeasurementUnits = "Centimeters";
      AppleMetricUnits = 1;
      AppleTemperatureUnit = "Celsius";
      "com.apple.mouse.tapBehavior" = 1;
      # delay before repeating keystrokes
      # InitialKeyRepeat = 10;
      # delay between repeated keystrokes upon holding a key
      # KeyRepeat = 1;
    };
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };
}
