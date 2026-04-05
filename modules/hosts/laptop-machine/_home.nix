{ pkgs, ... }:
{
  home.username = "mads";
  home.homeDirectory = "/home/mads";
  home.stateVersion = "25.11";

  imports = [ 
    ../../features/_shell.nix
    ../../features/_sway.nix
  ];

  services.cliphist.enable = true;

}
