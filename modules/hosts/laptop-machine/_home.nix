{ pkgs, ... }:
{
  home.username = "mads";
  home.homeDirectory = "/home/mads";
  home.stateVersion = "25.11";

  imports = [ ../../features/_shell.nix ];

  services.cliphist.enable = true;

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
#          {
#            criteria = "eDP-1";
#            status = "disable";
#          }
          {
            criteria = "Samsung Electric Company LS27A600U H4ZT404345";
            mode = "2560x1440";
            position = "0,0";
          }
          {
            criteria = "Samsung Electric Company LS27A600U H4ZT404299";
            mode = "2560x1440";
            position = "2560,0";
          }
          {
            criteria = "HDMI-A-2";
            mode = "2560x1440";
            position = "5120,0";
          }
        ];
      }
    ];
  };
}
