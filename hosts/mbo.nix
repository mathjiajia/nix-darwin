{ lib, pkgs, ... }:
{
  # Settings specific to mbo.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Rex's startup-command preference only applies to local terminals.
  # Use fish for jia's Rex login terminals while retaining zsh for SSH.
  programs.zsh.interactiveShellInit = ''
    if [[ -n "$REX_SESSION" && "$USER" == jia && -o login ]]; then
      exec ${lib.getExe pkgs.fish} --login
    fi
  '';
}
