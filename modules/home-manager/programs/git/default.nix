{
  lib,
  pkgs,
  ...
}:
let
  commitWithMlx = pkgs.writeShellScript "lazygit-commit-message" ''
    set -euo pipefail

    diff=$(git --no-pager diff --cached --no-color --no-ext-diff)
    if [ -z "$diff" ]; then
      echo 'Stage changes before generating a commit message.' >&2
      exit 1
    fi

    commit_dir=$(mktemp -d)
    trap 'rm -rf "$commit_dir"' EXIT
    "$HOME/.local/bin/mlx-serve" \
      --model "$HOME/.mlx-serve/models/LiquidAI/LFM3-Omni-2B-MLX-8bit" \
      --max-tokens 256 --no-vision \
      --prompt "Write a concise Conventional Commit message for this diff. Include a body if needed. Output only the message.

    $diff

    Commit message:" >"$commit_dir/raw"
    awk '/^==========$/ { body = !body; next } body' "$commit_dir/raw" >"$commit_dir/message"
    git commit --edit --file "$commit_dir/message"
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
          description = "Generate commit message with MLX-Serve";
          command = "${commitWithMlx}";
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
