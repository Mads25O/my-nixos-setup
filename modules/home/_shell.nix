{ pkgs, ... }:
{
  programs.bash = {
    enable = true;
      shellAliases = {
        cat = "bat";
        top = "btop";
    };
    initExtra = "fastfetch";
  };

  programs.eza = {
    enable = true;
    icons = "auto";
    git = true;
  };

  programs.btop = {
    enable = true;
    settings.color_theme = "TTY";
  };

  programs.fzf = {
    enable = true;
    enableNushellIntegration = false;
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      format = "$os$directory$git_branch$git_status$python$cmd_duration$line_break$character";
      
      os = {
        disabled = false;
        style = "#89b4fa";
        symbols.NixOS = " ";
      };

      directory = {
        style = "bold #cba6f7";
        truncation_length = 3;
        truncate_to_repo = false;
        read_only = " 󰌾";
      };

      git_branch = {
        symbol = " ";
        style = "#a6e3a1";
        format = "on [$symbol$branch]($style) ";
      };

      git_status = {
        style = "#f9e2af";
      };

      python = {
        format = "[ $virtualenv]($style) ";
        style = "#f9e2af";
        python_binary = "python3";
      };

      cmd_duration = {
        min_time = 2000;
        format = "took [$duration]($style) ";
        style = "#fab387";
      };

      character = {
        success_symbol = "[❯](purple)";
        error_symbol = "[❯](red)";
      };
    };
  };

  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";
    font = {
      name = "JetBrainsMonoNL Nerd Font";
      size = 13;
    };
    settings = {
      background_opacity = "0.90";
      window_padding_width = 14;
      hide_window_decorations = "yes";
      confirm_os_window_close = 0;
      enable_audio_bell = false;
      scrollback_lines = 10000;

      # Cursor
      cursor_shape = "beam";
      cursor_trail = 2;
      cursor_trail_decay = "0.1 0.3";

      # Tabs
      tab_bar_edge = "top";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
    };
  };
}
