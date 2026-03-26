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
  
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Standard-Mauve-Dark";
      package = pkgs.catppuccin-gtk;
    };
    cursorTheme = {
      name = "Catppuccin-Mocha-Dark-Cursors";
      package = pkgs.catppuccin-cursors.mochaDark;
    };
    gtk4.theme = null;
  };
  
  home.sessionVariables = {
    GTK_THEME = "Catppuccin-Mocha-Standard-Mauve-Dark";
  };

}
