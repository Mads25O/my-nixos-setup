{ ... }: {
  flake.nixosModules.cybersecurity = 
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        dig
        exiftool
        burpsuite
        sqlmap
      ];
      programs.wireshark.enable = true;
      programs.wireshark.package = pkgs.wireshark;
      users.users.mads.extraGroups = [ "wireshark" ];
    };
}
