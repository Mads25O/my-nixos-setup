{ ... }: {
  flake.nixosModules.desktopApps = 
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        spotify
        obsidian
        discord
        vscode
      ];
    };
}
