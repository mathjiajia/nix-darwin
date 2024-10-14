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

    dock = {
      autohide = true;
      orientation = "bottom";
      tilesize = 48;
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
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };
}
