{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    discord
  ];

  homebrew.casks = [
    # "adguard"
    "adobe-acrobat-pro"
    "adobe-creative-cloud"
    "anythingllm"
    "codeedit"
    "coherence-x"
    "diffusionbee"
    "hhkb"
  ];

  homebrew.masApps = {
    "Codye" = 1516894961;
    "DevHub" = 6476452351;
    "Enchanted LLM" = 6474268307;
    "Friendly Streaming" = 553245401;
    "HorizonChase2" = 1534920947;
    "Noto" = 1459055246;
    "Plain Text Editor" = 1572202501;
    "Pro Snooker & Pool 2024" = 1586517737;
    "ScanScan" = 1249901692;
    "Solitaire" = 1534193824;
    "Xcode" = 497799835;
    "西窗烛" = 912139104;
  };
}
