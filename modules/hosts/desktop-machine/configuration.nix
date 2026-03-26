{ self, inputs, config, ... }: {
  flake.nixosModules.desktopMachineConfiguration =
    { config, pkgs, ... }:
    {
      imports = [
        self.nixosModules.desktopMachineHardware
        self.nixosModules.desktopNiri
        self.nixosModules.common
      ];

      home-manager.users.mads = import ./_home.nix;

      networking.hostName = "desktop-nixos";

      # NVIDIA
      services.xserver.videoDrivers = [ "nvidia" ];
      hardware.nvidia = {
        modesetting.enable = true;
        open = true;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
      };
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [ nvidia-vaapi-driver ];
      };
      environment.sessionVariables.NIXOS_OZONE_WL = "1";

      system.stateVersion = "25.11";
    };
}
