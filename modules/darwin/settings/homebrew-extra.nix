{pkgs, ...}: {
  environment.systemPackages = with pkgs; [discord];

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
    "openemu"
    "openra"
    "orbstack"
  ];
}
