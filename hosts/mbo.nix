{ lib, pkgs, ... }:
{
  # Settings specific to mbo.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Allow the SSH build account to import build inputs into the Nix store.
  nix.settings.trusted-users = [ "jia" ];

  # Rex's startup-command preference only applies to local terminals.
  # Use fish for jia's Rex login terminals while retaining zsh for SSH.
  programs.zsh.interactiveShellInit = ''
    if [[ -n "$REX_SESSION" && "$USER" == jia && -o login ]]; then
      exec ${lib.getExe pkgs.fish} --login
    fi
  '';
}
