{ ... }:
{
  programs.nixvim.plugins = {
    lz-n = {
      enable = true;
    };

    lazy = {
      enable = true;
      plugins = [
        # {
        #   pkg = "nvchad/base46";
        #   lazy = true;
        #   build.__raw = ''
        #     function()
        #       require("base46").load_all_highlights()
        #     end'';
        # }
        # {
        #   "nvchad/ui",
        #   config = function()
        #     require("nvchad")
        #   end,
        # }
        # { "nvchad/volt"; lazy = true; }
        # { "nvchad/menu", lazy = true }
        # { "nvchad/minty", cmd = { "Shades", "Huefy" } }
        # { "nvchad/timerly", cmd = "TimerlyToggle" }
        # { "nvchad/showkeys", cmd = "ShowkeysToggle" }
      ];
    };
  };
}
