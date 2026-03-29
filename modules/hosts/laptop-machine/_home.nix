{ pkgs, ... }:
{
  home.username = "mads";
  home.homeDirectory = "/home/mads";
  home.stateVersion = "25.11";

  programs.bash = {
    enable = true;
    initExtra = ''
      eval "$(starship init bash)"
    '';
  };

  programs.starship = {
    enable = true;
    settings = {
      format = "$directory$git_branch$git_status$character";
      character = {
        success_symbol = "[❯](purple)";
        error_symbol = "[❯](red)";
      };
      directory = {
        style = "blue";
        truncation_length = 3;
        truncate_to_repo = false;
      };
      git_branch = {
        symbol = " ";
        style = "green";
      };
      git_status = {
        style = "yellow";
      };
    };
  };

  programs.kitty = {
    enable = true;
    settings = {
      font_family = "JetBrainsMonoNL Nerd Font";
      font_size = "13.0";
      hide_window_decoration = "yes";
      background_opacity = "0.95";
      enable_audio_bell = false;
      cursor_shape = "beam";
      scrollback_lines = 10000;
      background = "#1e1e2e";
      foreground = "#cdd6f4";
      color0 = "#45475a";
      color1 = "#f38ba8";
      color2 = "#a6e3a1";
      color3 = "#f9e2af";
      color4 = "#89b4fa";
      color5 = "#f5c2e7";
      color6 = "#94e2d5";
      color7 = "#bac2de";
    };
  };

  programs.swaylock = {
    enable = true;
    settings = {
      color = "000000";
      font-size = 24;
      indicator-radius = 100;
      indicator-thickness = 7;
      inside-color = "00000000";
      key-hl-color = "ffffff";
      show-failed-attempts = true;
      ignore-empty-password = true;
    };
  };

  services.swayidle = {
    enable = true;
    events = {
      before-sleep = "${pkgs.swaylock}/bin/swaylock -f";
      lock = "${pkgs.swaylock}/bin/swaylock -f";
    };
  };

  services.kanshi = {
    enable = true;
    settings = [
      {
        profile.name = "laptop";
        profile.outputs = [
          { criteria = "eDP-1"; }
        ];
      }
      {
        profile.name = "work";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "DP-3";
            mode = "1920x1080";
            position = "0,0";
          }
          {
            criteria = "DP-4";
            mode = "1920x1080";
            position = "1920,0";
          }
          {
            criteria = "Third Monitor";
            mode = "1920x1080";
            position = "3840,0";
          }
        ];
      }
    ];
  };
}
