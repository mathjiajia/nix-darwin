{ pkgs, ... }: {
  programs.yazi.plugins = {
    chmod = pkgs.yaziPlugins.chmod;
    full-border = pkgs.yaziPlugins.full-border;
    git = pkgs.yaziPlugins.git;
    lazygit = pkgs.writeTextDir "main.lua" ''
      --- @sync entry
      return {
        entry = function()
          local in_rex = os.getenv("REX_SESSION") and os.getenv("REX_BLOCK")
          ya.emit("shell", {
            in_rex and [[rex do float 'command=["lazygit"]' cwd="$PWD"]] or "lazygit",
            block = not in_rex,
          })
        end,
      }
    '';
  };
}
