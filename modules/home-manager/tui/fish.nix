{
  programs.fish = {
    enable = true;
    interactiveShellInit = # fish
      ''
        set fish_greeting

        function _update_git_info --on-event fish_prompt
            # Kill any existing background job
            if set -q _async_git_job_pid
                kill $_async_git_job_pid 2>/dev/null
            end

            # Run git prompt in background and update when ready
            fish -c 'fish_git_prompt " %s"' >/tmp/fish_git_info_$fish_pid 2>/dev/null &
            set -g _async_git_job_pid $last_pid

            # Monitor the background job and update when ready
            function _async_git_update_watcher --on-process-exit $_async_git_job_pid
                if test -f /tmp/fish_git_info_$fish_pid
                    set -g _async_git_info (cat /tmp/fish_git_info_$fish_pid)
                    rm -f /tmp/fish_git_info_$fish_pid
                else
                    set -e _async_git_info
                end
                set -e _async_git_job_pid
                commandline -f repaint 2>/dev/null
                functions -e _async_git_update_watcher
            end
        end
      '';
    functions = {
      fish_prompt.body =
        # fish
        ''
          set -l last_status $status

          if not set -q __fish_prompt_char
              switch (id -u)
                  case 0
                      set -g __fish_prompt_char '󰽭'
                  case '*'
                      set -g __fish_prompt_char '󰅂'
              end
          end

          # Use cached colors
          echo -n -s $_prompt_cwd_color (prompt_pwd) $_prompt_normal

          if test $last_status -eq 0
              echo -n -s $_prompt_success_color ' 󰅂 ' $_prompt_normal
          else
              echo -n -s $_prompt_status_color ' 󰅂 ' $_prompt_normal
          end
        '';
      fish_right_prompt.body =
        # fish
        ''
          # Display cached git info (updated asynchronously)
          if set -q _async_git_info
              echo -n -s $_async_git_info
          end
        '';
    };
    shellInit =
      # fish
      ''
        set -g __fish_git_prompt_char_stateseparator ' '
        set -g __fish_git_prompt_use_informative_chars yes
        set -g __fish_git_prompt_color_dirtystate yellow
        set -g __fish_git_prompt_color $fish_color_normal
        set -g __fish_git_prompt_color_flags $fish_color_status
        set -g __fish_git_prompt_color_branch $fish_color_cwd
        set -g __fish_git_prompt_char_dirtystate '~'
        set -g __fish_git_prompt_char_untrackedfiles '+'
        set -g __fish_git_prompt_showuntrackedfiles yes
        set -g __fish_git_prompt_showupstream no
        set -g __fish_git_prompt_show_informative_status no

        set -g _prompt_success_color (set_color cyan)
        set -g _prompt_status_color (set_color $fish_color_status 2>/dev/null; or set_color red --bold)
        set -g _prompt_user_color (set_color $fish_color_user 2>/dev/null; or set_color cyan)
        set -g _prompt_cwd_color (set_color $fish_color_cwd 2>/dev/null; or set_color green)
        set -g _prompt_normal (set_color normal)
      '';
    shellAbbrs = {
      mkdir = "mkdir -p";

      # Git
      gd = "git diff";
      gP = "git push";
      gp = "git pull";
      gl = "git log";
      glp = "git log --patch";

      # LazyGit
      lg = "lazygit";

      # Nvim
      nv = "nvim";
    };
  };

}
