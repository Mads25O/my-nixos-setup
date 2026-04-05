{ pkgs, ... }:
{
  home.username = "mads";
  home.homeDirectory = "/home/mads";
  home.stateVersion = "25.11";

  imports = [ 
    ../../home/_shell.nix
    ../../home/_sway.nix
  ];

  services.cliphist.enable = true;

}
