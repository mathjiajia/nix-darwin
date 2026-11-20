{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  files = [
    "floats.lua"
    "agents.lua"
    # "ui_bridge.lua"
    "types.lua"
    ".emmyrc.json"
  ];
  rexProjects = pkgs.fetchFromGitHub {
    owner = "almonk";
    repo = "rex-projects";
    rev = "0838ed4579afa30048c5efdde2171f6a43d637de";
    hash = "sha256-cm4fUpIu5HSuA230iIVL+TTRX3rL49guJhfBaiakp4E=";
  };

  # Rex.app installs the CLI here and keeps it up to date.
  rex = "${config.home.homeDirectory}/Library/Application Support/com.superlogical.rex/RexServer/Versions/Current/Rex Server.app/Contents/MacOS/rex";

  edit = lib.getExe (
    pkgs.writeShellApplication {
      name = "rex-edit";
      runtimeInputs = [ pkgs.jq ];
      text = builtins.readFile ./edit.sh;
    }
  );
in
{
  imports = [ inputs.rex.homeManagerModules.default ];

  programs.rex = {
    enable = true;
    package = null;
    config = ./init.lua;
  };

  xdg.configFile = {
    "rex/projects.lua".source = "${rexProjects}/projects.lua";
    "fish/completions/rex.fish".text = # fish
      ''
        rex completion fish | source
      '';
  }
  // lib.listToAttrs (map (f: lib.nameValuePair "rex/${f}" { source = ./. + "/${f}"; }) files);

  # When a yazi float closes, float_cd in floats.lua leaves the directory in a
  # file and sends this shell SIGWINCH. The handler changes directory and
  # redraws the prompt, keeping whatever is half-typed there. An event handler
  # can't be an autoloaded function, so it's defined at startup.
  programs.fish.interactiveShellInit =
    # fish
    ''
      function __rex_float_cd --on-signal SIGWINCH
        set -l file $HOME/.cache/rex/float-cd.$fish_pid
        test -r $file; or return
        read --null --local dir <$file
        rm -f $file
        test -n "$dir"; and builtin cd -- $dir; and commandline -f repaint
      end
    '';

  # Files that lazygit and Yazi open go to the Neovim in the same Rex tab,
  # through edit.sh and float_edit in floats.lua. Without one, or outside Rex,
  # Neovim starts in their terminal as before. Commit messages still open
  # there, since Git waits for its editor to exit.
  programs.lazygit.settings.os = {
    edit = "${edit} -- {{filename}}";
    editAtLine = "${edit} +{{line}} -- {{filename}}";
    openDirInEditor = "${edit} -- {{dir}}";
    editInTerminal = true;
  };
  programs.yazi.settings.opener.edit = [
    {
      run = "${edit} %s";
      desc = "Neovim";
      block = true;
      for = "unix";
    }
  ];

  # Rex doesn't notice when a file that init.lua requires changes, so tell a
  # running server to read its config again.
  home.activation.rexReload =
    lib.hm.dag.entryAfter [ "linkGeneration" ]
      # sh
      ''
        rex=${lib.escapeShellArg rex}
        if [[ -x $rex ]] && "$rex" --autostart=false server status >/dev/null 2>&1; then
          run "$rex" --autostart=false config reload
        fi
      '';
}
