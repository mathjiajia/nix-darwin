{
  config,
  lib,
  pkgs,
  ...
}:
let
  commitWithPi = pkgs.writeShellScript "lazygit-commit-message" ''
    set -euo pipefail

    diff=$(git --no-pager diff --cached --no-color --no-ext-diff)
    if [ -z "$diff" ]; then
      echo 'Stage changes before generating a commit message.' >&2
      exit 1
    fi

    message=$(mktemp)
    trap 'rm -f "$message"' EXIT
    printf '%s\n' "$diff" | ${lib.getExe config.programs.pi-coding-agent.package} \
      -p --no-tools --no-session --provider magpie --model codex/gpt-5.6-luna \
      'Write a Conventional Commit message for the staged diff: an imperative subject under 72 characters and, if needed, a blank line followed by 1-3 bullets describing the changes. Output only the raw message.' >"$message"
    git commit --edit --file "$message"
  '';
in
{
  programs.git = {
    enable = true;
    package = null;
    settings = {
      core.editor = "nvim";
      user = {
        email = "mathjiajia@outlook.com";
        name = "Jia Jia";
      };
      fetch.prune = true;
      github.user = "mathjiajia";
      log.date = "iso";
      merge.conflictstyle = "zdiff3";
      pager.difftool = true;
      push.autoSetupRemote = true;
    };
    ignores = lib.splitString "\n" (builtins.readFile ./global.gitignore);
  };

  programs.lazygit = {
    enable = true;
    settings = {
      customCommands = [
        {
          key = "C";
          context = "files";
          description = "Generate commit message with Pi";
          command = "${commitWithPi}";
          output = "terminal";
        }
      ];
      git.diffRenderers = [ { command = "${lib.getExe pkgs.hunk} pager"; } ];
      gui = {
        nerdFontsVersion = "3";
        sidePanelWidth = 0.25;
        tabWidth = 2;
      };
    };
  };

  programs.fish.shellAbbrs = {
    gd = "git diff";
    gP = "git push";
    gp = "git pull";

    lg = "lazygit";
  };
}
