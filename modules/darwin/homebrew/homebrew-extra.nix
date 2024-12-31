{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    discord
    # dotnet-sdk_6
  ];

  homebrew.casks = [
    "adobe-acrobat-pro"
    "adobe-creative-cloud"
    "anythingllm"
    "claude"
    "codeedit"
    "coherence-x"
    "diffusionbee"
    "github"
    "github-copilot-for-xcode"
    "hhkb"
    "neohtop"
    "openemu"
    # "openra"
    "openra-playtest"
    "orbstack"
    # "steam"
  ];
}
